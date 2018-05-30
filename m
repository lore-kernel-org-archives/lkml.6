Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932563AbeE3WU5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 18:20:57 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46682 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932409AbeE3WUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 18:20:54 -0400
X-Google-Smtp-Source: ADUXVKL3g8INMiauXcTi+sjCA01L7mSjcKVnkr4HU3vPKeE9tWAMHSzSaiRMqCd0b92dG3cPPUIhlQ==
Date: Wed, 30 May 2018 15:20:52 -0700
From: Kees Cook <keescook@chromium.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Florian Westphal <fw@strlen.de>, David Ahern <dsahern@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtnetlink: Remove VLA usage
Message-ID: <20180530222052.GA30622@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
allocates the maximum size expected for all possible types and adds
sanity-checks at both registration and usage to make sure nothing gets
out of sync. This matches the proposed VLA solution for nfnetlink[2]. The
values chosen here were based on finding assignments for .maxtype and
.slave_maxtype and manually counting the enums:

slave_maxtype (max 33):
	IFLA_BRPORT_MAX     33
	IFLA_BOND_SLAVE_MAX  9

maxtype (max 45):
	IFLA_BOND_MAX       28
	IFLA_BR_MAX         45
	__IFLA_CAIF_HSI_MAX  8
	IFLA_CAIF_MAX        4
	IFLA_CAN_MAX        16
	IFLA_GENEVE_MAX     12
	IFLA_GRE_MAX        25
	IFLA_GTP_MAX         5
	IFLA_HSR_MAX         7
	IFLA_IPOIB_MAX       4
	IFLA_IPTUN_MAX      21
	IFLA_IPVLAN_MAX      3
	IFLA_MACSEC_MAX     15
	IFLA_MACVLAN_MAX     7
	IFLA_PPP_MAX         2
	__IFLA_RMNET_MAX     4
	IFLA_VLAN_MAX        6
	IFLA_VRF_MAX         2
	IFLA_VTI_MAX         7
	IFLA_VXLAN_MAX      28
	VETH_INFO_MAX        2
	VXCAN_INFO_MAX       2

This additionally changes maxtype and slave_maxtype fields to unsigned,
since they're only ever using positive values.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
[2] https://patchwork.kernel.org/patch/10439647/

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/rtnetlink.h |  4 ++--
 net/core/rtnetlink.c    | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index 14b6b3af8918..0bbaa5488423 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -64,7 +64,7 @@ struct rtnl_link_ops {
 	size_t			priv_size;
 	void			(*setup)(struct net_device *dev);
 
-	int			maxtype;
+	unsigned int		maxtype;
 	const struct nla_policy	*policy;
 	int			(*validate)(struct nlattr *tb[],
 					    struct nlattr *data[],
@@ -92,7 +92,7 @@ struct rtnl_link_ops {
 	unsigned int		(*get_num_tx_queues)(void);
 	unsigned int		(*get_num_rx_queues)(void);
 
-	int			slave_maxtype;
+	unsigned int		slave_maxtype;
 	const struct nla_policy	*slave_policy;
 	int			(*slave_changelink)(struct net_device *dev,
 						    struct net_device *slave_dev,
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 45936922d7e2..4ede33719ca9 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -59,6 +59,9 @@
 #include <net/rtnetlink.h>
 #include <net/net_namespace.h>
 
+#define RTNL_MAX_TYPE		48
+#define RTNL_SLAVE_MAX_TYPE	36
+
 struct rtnl_link {
 	rtnl_doit_func		doit;
 	rtnl_dumpit_func	dumpit;
@@ -389,6 +392,11 @@ int rtnl_link_register(struct rtnl_link_ops *ops)
 {
 	int err;
 
+	/* Sanity-check max sizes to avoid stack buffer overflow. */
+	if (WARN_ON(ops->maxtype > RTNL_MAX_TYPE ||
+		    ops->slave_maxtype > RTNL_SLAVE_MAX_TYPE))
+		return -EINVAL;
+
 	rtnl_lock();
 	err = __rtnl_link_register(ops);
 	rtnl_unlock();
@@ -2900,13 +2908,16 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	if (1) {
-		struct nlattr *attr[ops ? ops->maxtype + 1 : 1];
-		struct nlattr *slave_attr[m_ops ? m_ops->slave_maxtype + 1 : 1];
+		struct nlattr *attr[RTNL_MAX_TYPE + 1];
+		struct nlattr *slave_attr[RTNL_SLAVE_MAX_TYPE + 1];
 		struct nlattr **data = NULL;
 		struct nlattr **slave_data = NULL;
 		struct net *dest_net, *link_net = NULL;
 
 		if (ops) {
+			if (ops->maxtype > RTNL_MAX_TYPE)
+				return -EINVAL;
+
 			if (ops->maxtype && linkinfo[IFLA_INFO_DATA]) {
 				err = nla_parse_nested(attr, ops->maxtype,
 						       linkinfo[IFLA_INFO_DATA],
@@ -2923,6 +2934,9 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 
 		if (m_ops) {
+			if (ops->slave_maxtype > RTNL_SLAVE_MAX_TYPE)
+				return -EINVAL;
+
 			if (m_ops->slave_maxtype &&
 			    linkinfo[IFLA_INFO_SLAVE_DATA]) {
 				err = nla_parse_nested(slave_attr,
-- 
2.17.0


-- 
Kees Cook
Pixel Security
