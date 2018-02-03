Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeBCNaB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 08:30:01 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40914 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbeBCN3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 08:29:35 -0500
X-Google-Smtp-Source: AH8x2266CF8HeoqWuHOBSgB5ofi6sJGYB7vVDrzwn79ZrVbG0ipeLLpa3SsX7O4cXwD+e2fc07H2vg==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: netdev@vger.kernel.org
Cc: ebiederm@xmission.com, jbenc@redhat.com, nicolas.dichtel@6wind.com,
        linux-kernel@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH net 1/1 v1] rtnetlink: require unique netns identifier
Date: Sat,  3 Feb 2018 14:29:04 +0100
Message-Id: <20180203132904.11972-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180203132904.11972-1-christian.brauner@ubuntu.com>
References: <20180203132904.11972-1-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we've added support for IFLA_IF_NETNSID for RTM_{DEL,GET,SET,NEW}LINK
it is possible for userspace to send us requests with three different
properties to identify a target network namespace. This affects at least
RTM_{NEW,SET}LINK. Each of them could potentially refer to a different
network namespace which is confusing. For legacy reasons the kernel will
pick the IFLA_NET_NS_PID property first and then look for the
IFLA_NET_NS_FD property but there is no reason to extend this type of
behavior to network namespace ids. The regression potential is quite
minimal since the rtnetlink requests in question either won't allow
IFLA_IF_NETNSID requests before 4.16 is out (RTM_{NEW,SET}LINK) or don't
support IFLA_NET_NS_{PID,FD} (RTM_{DEL,GET}LINK) in the first place.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
ChangeLog v0->v1:
* report a descriptive error to userspace via struct netlink_ext_ack
* do not fail when multiple properties specifiy the same network namespace
---
 net/core/rtnetlink.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 56af8e41abfc..df2363f28574 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1951,6 +1951,57 @@ static struct net *rtnl_link_get_net_capable(const struct sk_buff *skb,
 	return net;
 }
 
+/* Verify that rtnetlink requests supporting network namespace ids
+ * do not pass additional properties referring to different network
+ * namespaces.
+ */
+static int rtnl_ensure_unique_netns_attr(const struct sock *sk,
+					 struct nlattr *tb[],
+					 struct netlink_ext_ack *extack)
+{
+	int ret = -EINVAL;
+	struct net *net = NULL, *unique_net = NULL;
+
+	/* Requests without network namespace ids have been able to specify
+	 * multiple properties referring to different network namespaces so
+	 * don't regress them.
+	 */
+	if (!tb[IFLA_IF_NETNSID])
+		return 0;
+
+	if (!tb[IFLA_NET_NS_PID] && !tb[IFLA_NET_NS_FD])
+		return 0;
+
+	unique_net = get_net_ns_by_id(sock_net(sk), nla_get_s32(tb[IFLA_IF_NETNSID]));
+	if (!unique_net)
+		return -1;
+
+	if (tb[IFLA_NET_NS_PID]) {
+		net = get_net_ns_by_pid(nla_get_u32(tb[IFLA_NET_NS_PID]));
+		if (net != unique_net)
+			goto on_error;
+	}
+
+	if (tb[IFLA_NET_NS_FD]) {
+		net = get_net_ns_by_fd(nla_get_u32(tb[IFLA_NET_NS_FD]));
+		if (net != unique_net)
+			goto on_error;
+	}
+
+	ret = 0;
+
+on_error:
+	put_net(unique_net);
+
+	if (net && !IS_ERR(net))
+		put_net(net);
+
+	if (ret != 0)
+		NL_SET_ERR_MSG(extack, "multiple network namespaces specified");
+
+	return ret;
+}
+
 static int validate_linkmsg(struct net_device *dev, struct nlattr *tb[])
 {
 	if (dev) {
@@ -2553,6 +2604,10 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto errout;
 
+	err = rtnl_ensure_unique_netns_attr(NETLINK_CB(skb).sk, tb, extack);
+	if (err < 0)
+		goto errout;
+
 	if (tb[IFLA_IFNAME])
 		nla_strlcpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
 	else
@@ -2649,6 +2704,10 @@ static int rtnl_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
+	err = rtnl_ensure_unique_netns_attr(NETLINK_CB(skb).sk, tb, extack);
+	if (err < 0)
+		return err;
+
 	if (tb[IFLA_IFNAME])
 		nla_strlcpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
 
@@ -2802,6 +2861,10 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
+	err = rtnl_ensure_unique_netns_attr(NETLINK_CB(skb).sk, tb, extack);
+	if (err < 0)
+		return err;
+
 	if (tb[IFLA_IFNAME])
 		nla_strlcpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
 	else
@@ -3045,6 +3108,10 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
+	err = rtnl_ensure_unique_netns_attr(NETLINK_CB(skb).sk, tb, extack);
+	if (err < 0)
+		return err;
+
 	if (tb[IFLA_IF_NETNSID]) {
 		netnsid = nla_get_s32(tb[IFLA_IF_NETNSID]);
 		tgt_net = get_target_net(NETLINK_CB(skb).sk, netnsid);
-- 
2.14.1
