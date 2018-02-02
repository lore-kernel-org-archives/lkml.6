Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeBBIvn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 03:51:43 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55932 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeBBIvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 03:51:32 -0500
X-Google-Smtp-Source: AH8x225EaRpPfK4/as9vZxDfSMGYbjnLejG2Q2GzTS3IFkmNcxbrTafPvz8hpt4KwZ6+oGknp9R7VQ==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: netdev@vger.kernel.org
Cc: ebiederm@xmission.com, jbenc@redhat.com, nicolas.dichtel@6wind.com,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [RFC net 1/1] rtnetlink: require unique netns identifier
Date: Fri,  2 Feb 2018 09:51:15 +0100
Message-Id: <20180202085115.17229-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180202085115.17229-1-christian.brauner@ubuntu.com>
References: <20180202085115.17229-1-christian.brauner@ubuntu.com>
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
 net/core/rtnetlink.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 56af8e41abfc..d0b7ab22eff4 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1951,6 +1951,18 @@ static struct net *rtnl_link_get_net_capable(const struct sk_buff *skb,
 	return net;
 }
 
+/* Verify that rtnetlink requests that support network namespace ids do not pass
+ * additional properties that allow to identify a network namespace as they
+ * might conflict.
+ */
+static int rtnl_ensure_unique_netns_attr(struct nlattr *tb[])
+{
+	if (tb[IFLA_IF_NETNSID] && (tb[IFLA_NET_NS_PID] || tb[IFLA_NET_NS_FD]))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int validate_linkmsg(struct net_device *dev, struct nlattr *tb[])
 {
 	if (dev) {
@@ -2553,6 +2565,10 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto errout;
 
+	err = rtnl_ensure_unique_netns_attr(tb);
+	if (err < 0)
+		goto errout;
+
 	if (tb[IFLA_IFNAME])
 		nla_strlcpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
 	else
@@ -2649,6 +2665,10 @@ static int rtnl_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
+	err = rtnl_ensure_unique_netns_attr(tb);
+	if (err < 0)
+		return err;
+
 	if (tb[IFLA_IFNAME])
 		nla_strlcpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
 
@@ -2802,6 +2822,10 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
+	err = rtnl_ensure_unique_netns_attr(tb);
+	if (err < 0)
+		return err;
+
 	if (tb[IFLA_IFNAME])
 		nla_strlcpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
 	else
@@ -3045,6 +3069,10 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
+	err = rtnl_ensure_unique_netns_attr(tb);
+	if (err < 0)
+		return err;
+
 	if (tb[IFLA_IF_NETNSID]) {
 		netnsid = nla_get_s32(tb[IFLA_IF_NETNSID]);
 		tgt_net = get_target_net(NETLINK_CB(skb).sk, netnsid);
-- 
2.14.1
