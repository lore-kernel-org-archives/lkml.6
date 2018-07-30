Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246A6FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D085820892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D085820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbeG3O14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:27:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:49036 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730592AbeG3O1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:27:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C38EBAF56;
        Mon, 30 Jul 2018 12:53:02 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 7278EA0BE8; Mon, 30 Jul 2018 14:53:02 +0200 (CEST)
Message-Id: <f7a8c8bfc69deae25669aaf4a42feedcfce58209.1532953989.git.mkubecek@suse.cz>
In-Reply-To: <cover.1532953989.git.mkubecek@suse.cz>
References: <cover.1532953989.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH net-next v2 04/17] ethtool: helper functions for netlink
 interface
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Jakub Kicinski <kubakici@wp.pl>,
        "John W. Linville" <linville@tuxdriver.com>
Date:   Mon, 30 Jul 2018 14:53:02 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Misc helpers used by ethtool netlink code.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 include/uapi/linux/ethtool_netlink.h |  11 ++
 net/ethtool/netlink.c                | 163 +++++++++++++++++++++++++++
 net/ethtool/netlink.h                | 124 ++++++++++++++++++++
 3 files changed, 298 insertions(+)

diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 3c0c5c70692b..1df263d9feb7 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -12,6 +12,17 @@ enum {
 	ETHNL_CMD_MAX = (__ETHNL_CMD_MAX - 1)
 };
 
+/* device specification */
+
+enum {
+	ETHA_DEV_UNSPEC,
+	ETHA_DEV_INDEX,				/* u32 */
+	ETHA_DEV_NAME,				/* string */
+
+	__ETHA_DEV_MAX,
+	ETHA_DEV_MAX = (__ETHA_DEV_MAX - 1)
+};
+
 /* generic netlink info */
 #define ETHTOOL_GENL_NAME "ethtool"
 #define ETHTOOL_GENL_VERSION 1
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 1c6efb9b2eae..bf234e5bc660 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -1,9 +1,172 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 
 #include <linux/module.h>
+#include <net/sock.h>
 #include <linux/ethtool_netlink.h>
 #include "netlink.h"
 
+static const struct nla_policy dev_policy[ETHA_DEV_MAX + 1] = {
+	[ETHA_DEV_UNSPEC]	= { .type = NLA_UNSPEC },
+	[ETHA_DEV_INDEX]	= { .type = NLA_U32 },
+	[ETHA_DEV_NAME]		= { .type = NLA_STRING, .len = IFNAMSIZ - 1 },
+};
+
+struct net_device *ethnl_dev_get(struct genl_info *info, struct nlattr *nest)
+{
+	struct net *net = genl_info_net(info);
+	struct nlattr *tb[ETHA_DEV_MAX + 1];
+	struct net_device *dev;
+	int ret;
+
+	ret = nla_parse_nested(tb, ETHA_DEV_MAX, nest, dev_policy,
+			       info->extack);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	if (tb[ETHA_DEV_INDEX]) {
+		dev = dev_get_by_index(net, nla_get_u32(tb[ETHA_BIT_INDEX]));
+		if (!dev)
+			return ERR_PTR(-ENODEV);
+		/* if both ifindex and ifname are passed, they must match */
+		if (tb[ETHA_DEV_NAME]) {
+			const char *nl_name = nla_data(tb[ETHA_DEV_NAME]);
+
+			if (strncmp(dev->name, nl_name, IFNAMSIZ)) {
+				ETHNL_SET_ERRMSG(info,
+						 "ifindex and ifname do not match");
+				return ERR_PTR(-ENODEV);
+			}
+		}
+		return dev;
+	} else if (tb[ETHA_DEV_NAME]) {
+		dev = dev_get_by_name(net, nla_data(tb[ETHA_DEV_NAME]));
+		return dev ?: ERR_PTR(-ENODEV);
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
+int ethnl_fill_dev(struct sk_buff *msg, struct net_device *dev, u16 attrtype)
+{
+	struct nlattr *nest;
+	int ret = -EMSGSIZE;
+
+	nest = ethnl_nest_start(msg, attrtype);
+	if (!nest)
+		return -EMSGSIZE;
+
+	if (nla_put_u32(msg, ETHA_DEV_INDEX, (u32)dev->ifindex))
+		goto err;
+	if (nla_put_string(msg, ETHA_DEV_NAME, dev->name))
+		goto err;
+
+	nla_nest_end(msg, nest);
+	return 0;
+err:
+	nla_nest_cancel(msg, nest);
+	return ret;
+}
+
+/* create skb for a reply
+ * payload: payload length (without netlink, genetlink and ethnl headers)
+ * dev:     device the reply is about
+ * cmd:     ETHNL_CMD_* command for reply
+ * info:    info for the received packet we respond to
+ * ehdrp:   place to store payload pointer returned by genlmsg_new()
+ * returns: skb or null on error
+ */
+struct sk_buff *ethnl_reply_init(size_t payload, struct net_device *dev, u8 cmd,
+				 u16 dev_attrtype, struct genl_info *info,
+				 void **ehdrp)
+{
+	void *ehdr;
+	struct sk_buff *rskb;
+
+	if (dev)
+		payload += nla_total_size(nla_total_size(sizeof(u32)) +
+					  nla_total_size(IFNAMSIZ));
+	rskb = genlmsg_new(payload, GFP_KERNEL);
+	if (!rskb) {
+		ETHNL_SET_ERRMSG(info,
+				 "failed to allocate reply message");
+		return NULL;
+	}
+
+	ehdr = genlmsg_put_reply(rskb, info, &ethtool_genl_family, 0, cmd);
+	if (!ehdr)
+		goto err;
+	if (ehdrp)
+		*ehdrp = ehdr;
+	if (dev) {
+		int ret = ethnl_fill_dev(rskb, dev, dev_attrtype);
+
+		if (ret < 0)
+			goto err;
+	}
+
+	return rskb;
+err:
+	nlmsg_free(rskb);
+	return NULL;
+}
+
+/* device iteration copied from rtnl_dump_ifinfo()
+ * cb->args[0]: command specific dump function
+ * cb->args[1]: ethnl command to use in reply
+ * cb->args[2]: position - hashbucket
+ * cb->args[3]: position - ifindex
+ */
+int ethnl_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	int (*dumpfn)(struct sk_buff *skb, struct netlink_callback *cb,
+		      struct net_device *dev);
+	struct net *net = sock_net(skb->sk);
+	struct hlist_head *head;
+	struct net_device *dev;
+	int h, s_h, idx = 0, s_idx;
+	int ret = 0;
+	void *ehdr;
+	u8 rcmd;
+
+	dumpfn = (void *)cb->args[0];
+	rcmd = cb->args[1];
+	s_h = cb->args[2];
+	s_idx = cb->args[3];
+
+	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
+		idx = 0;
+		head = &net->dev_index_head[h];
+		hlist_for_each_entry(dev, head, index_hlist) {
+			if (idx < s_idx)
+				goto cont;
+			ehdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+					   cb->nlh->nlmsg_seq,
+					   &ethtool_genl_family, 0, rcmd);
+			ret = dumpfn(skb, cb, dev);
+			if (ret < 0) {
+				genlmsg_cancel(skb, ehdr);
+				if (ret == -EOPNOTSUPP)
+					goto cont;
+				if (likely(skb->len))
+					goto out;
+				goto out_err;
+			}
+			genlmsg_end(skb, ehdr);
+cont:
+			idx++;
+		}
+	}
+out:
+	ret = skb->len;
+out_err:
+	cb->args[2] = h;
+	cb->args[3] = idx;
+	cb->seq = net->dev_base_seq;
+	nl_dump_check_consistent(cb, nlmsg_hdr(skb));
+
+	return ret;
+}
+
 /* genetlink setup */
 
 static const struct genl_ops ethtool_genl_ops[] = {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 63063b582ca2..acfed5ba6b54 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -6,7 +6,131 @@
 #include <linux/ethtool_netlink.h>
 #include <linux/netdevice.h>
 #include <net/genetlink.h>
+#include <net/sock.h>
+
+#define ETHNL_SET_ERRMSG(info, msg) \
+	do { if (info) GENL_SET_ERR_MSG(info, msg); } while (0)
 
 extern struct genl_family ethtool_genl_family;
 
+struct net_device *ethnl_dev_get(struct genl_info *info, struct nlattr *nest);
+int ethnl_fill_dev(struct sk_buff *msg, struct net_device *dev, u16 attrtype);
+
+struct sk_buff *ethnl_reply_init(size_t payload, struct net_device *dev, u8 cmd,
+				 u16 dev_attrtype, struct genl_info *info,
+				 void **ehdrp);
+
+static inline int ethnl_str_size(const char *s)
+{
+	return nla_total_size(strlen(s) + 1);
+}
+
+static inline int ethnl_str_ifne_size(const char *s)
+{
+	return s[0] ? ethnl_str_size(s) : 0;
+}
+
+static inline int ethnl_put_str_ifne(struct sk_buff *skb, int attrtype,
+				     const char *s)
+{
+	if (!s[0])
+		return 0;
+	return nla_put_string(skb, attrtype, s);
+}
+
+static inline struct nlattr *ethnl_nest_start(struct sk_buff *skb,
+					      int attrtype)
+{
+	return nla_nest_start(skb, attrtype | NLA_F_NESTED);
+}
+
+/* ethnl_update_* return true if the value is changed */
+static inline bool ethnl_update_u32(u32 *dst, struct nlattr *attr)
+{
+	u32 val;
+
+	if (!attr)
+		return false;
+	val = nla_get_u32(attr);
+	if (*dst == val)
+		return false;
+
+	*dst = val;
+	return true;
+}
+
+static inline bool ethnl_update_u8(u8 *dst, struct nlattr *attr)
+{
+	u8 val;
+
+	if (!attr)
+		return false;
+	val = nla_get_u8(attr);
+	if (*dst == val)
+		return false;
+
+	*dst = val;
+	return true;
+}
+
+/* update u32 value used as bool from NLA_U8 */
+static inline bool ethnl_update_bool32(u32 *dst, struct nlattr *attr)
+{
+	u8 val;
+
+	if (!attr)
+		return false;
+	val = !!nla_get_u8(attr);
+	if (!!*dst == val)
+		return false;
+
+	*dst = val;
+	return true;
+}
+
+static inline bool ethnl_update_binary(u8 *dst, unsigned int len, struct nlattr *attr)
+{
+	if (!attr)
+		return false;
+	if (nla_len(attr) < len)
+		len = nla_len(attr);
+	if (!memcmp(dst, nla_data(attr), len))
+		return false;
+
+	memcpy(dst, nla_data(attr), len);
+	return true;
+}
+
+static inline bool ethnl_update_bitfield32(u32 *dst, struct nlattr *attr)
+{
+	struct nla_bitfield32 change;
+	u32 newval;
+
+	if (!attr)
+		return false;
+	change = nla_get_bitfield32(attr);
+	newval = (*dst & ~change.selector) | (change.value & change.selector);
+	if (*dst == newval)
+		return false;
+
+	*dst = newval;
+	return true;
+}
+
+static inline void warn_partial_info(struct genl_info *info)
+{
+	ETHNL_SET_ERRMSG(info, "not all requested data could be retrieved");
+}
+
+/* Check user privileges explicitly to allow finer access control based on
+ * context of the request or hiding part of the information from unprivileged
+ * users
+ */
+static inline bool ethnl_is_privileged(struct sk_buff *skb)
+{
+	struct net *net = sock_net(skb->sk);
+
+	return netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN);
+}
+
 #endif /* _NET_ETHTOOL_NETLINK_H */
-- 
2.18.0

