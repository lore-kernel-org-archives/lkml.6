Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753027AbeBFNUQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 08:20:16 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42396 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbeBFNTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 08:19:49 -0500
X-Google-Smtp-Source: AH8x224fZK4NhwFalHq4B8++gReSBBaXwJfTLxBtEoWkwiNvgWQnucAbILeC03dC5rUYScQijr07Uw==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: netdev@vger.kernel.org
Cc: ktkhai@virtuozzo.com, stephen@networkplumber.org,
        w.bumiller@proxmox.com, ebiederm@xmission.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, davem@davemloft.net,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH net 1/1 v3] rtnetlink: require unique netns identifier
Date: Tue,  6 Feb 2018 14:19:02 +0100
Message-Id: <20180206131902.31937-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180206131902.31937-1-christian.brauner@ubuntu.com>
References: <20180206131902.31937-1-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we've added support for IFLA_IF_NETNSID for RTM_{DEL,GET,SET,NEW}LINK
it is possible for userspace to send us requests with three different
properties to identify a target network namespace. This affects at least
RTM_{NEW,SET}LINK. Each of them could potentially refer to a different
network namespace which is confusing and a potential security liability
given that pids might be recycled while the netlink request is served or
the process might do a setns. It also lets us indicate that network
namespace ids are the preferred way of interacting with network namespaces
in rtnetlink requests. The regression potential is quite minimal since the
rtnetlink requests in question either won't allow IFLA_IF_NETNSID requests
before 4.16 is out (RTM_{NEW,SET}LINK) or don't support
IFLA_NET_NS_{PID,FD} (RTM_{DEL,GET}LINK) in the first place.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
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
 net/core/rtnetlink.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 56af8e41abfc..d7c3c8e266a3 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1951,6 +1951,28 @@ static struct net *rtnl_link_get_net_capable(const struct sk_buff *skb,
 	return net;
 }
 
+/* Verify that rtnetlink requests supporting network namespace ids
+ * do not pass additional properties potentially referring to different
+ * network namespaces.
+ */
+static int rtnl_ensure_unique_netns(struct nlattr *tb[],
+				    struct netlink_ext_ack *extack)
+{
+	/* Requests without network namespace ids have been able to specify
+	 * multiple properties referring to different network namespaces so
+	 * don't regress them.
+	 */
+	if (!tb[IFLA_IF_NETNSID])
+		return 0;
+
+	/* Caller operates on the current network namespace. */
+	if (!tb[IFLA_NET_NS_PID] && !tb[IFLA_NET_NS_FD])
+		return 0;
+
+	NL_SET_ERR_MSG(extack, "multiple netns identifying attributes specified");
+	return -EINVAL;
+}
+
 static int validate_linkmsg(struct net_device *dev, struct nlattr *tb[])
 {
 	if (dev) {
@@ -2553,6 +2575,10 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto errout;
 
+	err = rtnl_ensure_unique_netns(tb, extack);
+	if (err < 0)
+		goto errout;
+
 	if (tb[IFLA_IFNAME])
 		nla_strlcpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
 	else
@@ -2649,6 +2675,10 @@ static int rtnl_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
+	err = rtnl_ensure_unique_netns(tb, extack);
+	if (err < 0)
+		return err;
+
 	if (tb[IFLA_IFNAME])
 		nla_strlcpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
 
@@ -2802,6 +2832,10 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
+	err = rtnl_ensure_unique_netns(tb, extack);
+	if (err < 0)
+		return err;
+
 	if (tb[IFLA_IFNAME])
 		nla_strlcpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
 	else
@@ -3045,6 +3079,10 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
+	err = rtnl_ensure_unique_netns(tb, extack);
+	if (err < 0)
+		return err;
+
 	if (tb[IFLA_IF_NETNSID]) {
 		netnsid = nla_get_s32(tb[IFLA_IF_NETNSID]);
 		tgt_net = get_target_net(NETLINK_CB(skb).sk, netnsid);
-- 
2.14.1
