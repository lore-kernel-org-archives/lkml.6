Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754071AbeBGMxp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 07:53:45 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35331 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753630AbeBGMx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 07:53:26 -0500
X-Google-Smtp-Source: AH8x227JmU00XUgv1LPRuEQ4zJYmJBxn16vrWvKePKhG29Z5Wsmmhl4QBbFX1BGUd9gWmBD7/Pvaog==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: netdev@vger.kernel.org
Cc: ktkhai@virtuozzo.com, stephen@networkplumber.org,
        w.bumiller@proxmox.com, ebiederm@xmission.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, davem@davemloft.net,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH net 1/1 v4] rtnetlink: require unique netns identifier
Date: Wed,  7 Feb 2018 13:53:20 +0100
Message-Id: <20180207125320.9103-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180207125320.9103-1-christian.brauner@ubuntu.com>
References: <20180207125320.9103-1-christian.brauner@ubuntu.com>
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
ChangeLog v3->v4:
* Based on discussions with Eric and Jiri: disallow passing multiple network
  namespace identifying properties for all requests, i.e. always enforce
  uniqueness.
* disable passing IFLA_NET_NS_{FD,PID} for RTM_{DEL,GET}LINK completely since
  they never supported it
ChangeLog v2->v3:
* Specifying target network namespaces with pids or fds seems racy since the
  process might die and the pid get recycled or the process does a setns() in
  which case the tests would be invalid. So only check whether multiple
  properties are specified and report a helpful error in this case.
ChangeLog v1->v2:
* return errno when the specified network namespace id is invalid
* fill in struct netlink_ext_ack if the network namespace id is invalid
* rename rtnl_ensure_unique_netns_attr() to rtnl_ensure_unique_netns() to
  indicate that a request without any network namespace identifying attributes
  is also considered valid.
ChangeLog v0->v1:
* report a descriptive error to userspace via struct netlink_ext_ack
* do not fail when multiple properties specifiy the same network namespace
---
 net/core/rtnetlink.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 56af8e41abfc..bc290413a49d 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1951,6 +1951,38 @@ static struct net *rtnl_link_get_net_capable(const struct sk_buff *skb,
 	return net;
 }
 
+/* Verify that rtnetlink requests do not pass additional properties
+ * potentially referring to different network namespaces.
+ */
+static int rtnl_ensure_unique_netns(struct nlattr *tb[],
+				    struct netlink_ext_ack *extack,
+				    bool netns_id_only)
+{
+
+	if (netns_id_only) {
+		if (!tb[IFLA_NET_NS_PID] && !tb[IFLA_NET_NS_FD])
+			return 0;
+
+		NL_SET_ERR_MSG(extack, "specified netns attribute not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (tb[IFLA_IF_NETNSID] && (tb[IFLA_NET_NS_PID] || tb[IFLA_NET_NS_FD]))
+		goto invalid_attr;
+
+	if (tb[IFLA_NET_NS_PID] && (tb[IFLA_IF_NETNSID] || tb[IFLA_NET_NS_FD]))
+		goto invalid_attr;
+
+	if (tb[IFLA_NET_NS_FD] && (tb[IFLA_IF_NETNSID] || tb[IFLA_NET_NS_PID]))
+		goto invalid_attr;
+
+	return 0;
+
+invalid_attr:
+	NL_SET_ERR_MSG(extack, "multiple netns identifying attributes specified");
+	return -EINVAL;
+}
+
 static int validate_linkmsg(struct net_device *dev, struct nlattr *tb[])
 {
 	if (dev) {
@@ -2553,6 +2585,10 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto errout;
 
+	err = rtnl_ensure_unique_netns(tb, extack, false);
+	if (err < 0)
+		goto errout;
+
 	if (tb[IFLA_IFNAME])
 		nla_strlcpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
 	else
@@ -2649,6 +2685,10 @@ static int rtnl_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
+	err = rtnl_ensure_unique_netns(tb, extack, true);
+	if (err < 0)
+		return err;
+
 	if (tb[IFLA_IFNAME])
 		nla_strlcpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
 
@@ -2802,6 +2842,10 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
+	err = rtnl_ensure_unique_netns(tb, extack, false);
+	if (err < 0)
+		return err;
+
 	if (tb[IFLA_IFNAME])
 		nla_strlcpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
 	else
@@ -3045,6 +3089,10 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
+	err = rtnl_ensure_unique_netns(tb, extack, true);
+	if (err < 0)
+		return err;
+
 	if (tb[IFLA_IF_NETNSID]) {
 		netnsid = nla_get_s32(tb[IFLA_IF_NETNSID]);
 		tgt_net = get_target_net(NETLINK_CB(skb).sk, netnsid);
-- 
2.14.1
