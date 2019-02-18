Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7D5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99E62146E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392355AbfBRSW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:22:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:46784 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391476AbfBRSW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:22:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F7D6AFD4;
        Mon, 18 Feb 2019 18:22:25 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id D265FE0122; Mon, 18 Feb 2019 19:22:24 +0100 (CET)
Message-Id: <4e5879e36289c526dc79db37e55e5fc7d89d15fe.1550513384.git.mkubecek@suse.cz>
In-Reply-To: <cover.1550513384.git.mkubecek@suse.cz>
References: <cover.1550513384.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH net-next v3 12/21] ethtool: provide permanent hardware
 address in GET_INFO request
To:     netdev@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Date:   Mon, 18 Feb 2019 19:22:24 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add information about permanent hadware address of a device (as provided by
ETHTOOL_GPERMADDR ioctl command) in GET_INFO reply if ETH_INFO_IM_PERMADDR
flag is set in the request.

There is no separate attribute for hardware address length as nla_len gives
this information. The reply also provides address type (net_device::type).

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 Documentation/networking/ethtool-netlink.txt |  9 ++++-
 include/uapi/linux/ethtool_netlink.h         | 12 +++++-
 net/ethtool/info.c                           | 39 ++++++++++++++++++++
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.txt b/Documentation/networking/ethtool-netlink.txt
index b6999a2167e8..1e615e111262 100644
--- a/Documentation/networking/ethtool-netlink.txt
+++ b/Documentation/networking/ethtool-netlink.txt
@@ -239,6 +239,9 @@ Kernel response contents:
         ETHA_DRVINFO_FWVERSION		(string)	firmware version
         ETHA_DRVINFO_BUSINFO		(string)	device bus address
         ETHA_DRVINFO_EROM_VER		(string)	expansion ROM version
+    ETHA_INFO_PERMADDR		(nested)
+        ETHA_PERMADDR_ADDRESS		(binary)	permanent HW address
+        ETHA_PERMADDR_TYPE		(u16)		dev->type
 
 The meaning of DRVINFO attributes follows the corresponding fields of
 ETHTOOL_GDRVINFO response. Second part with various counts and sizes is
@@ -246,6 +249,10 @@ omitted as these are not really needed (and if they are, they can be easily
 found by different means). Driver version is also omitted as it is rather
 misleading in most cases.
 
+There is no separate attribute for permanent address length as the length can
+be determined from attribute length (nla_len()). ETHA_PERMADDR_TYPE provides
+net_device::type value to give a hint about what kind of address device has.
+
 GET_INFO requests allow dumps.
 
 
@@ -288,7 +295,7 @@ ETHTOOL_PHYS_ID			n/a
 ETHTOOL_GSTATS			n/a
 ETHTOOL_GTSO			n/a
 ETHTOOL_STSO			n/a
-ETHTOOL_GPERMADDR		n/a
+ETHTOOL_GPERMADDR		ETHNL_CMD_GET_INFO
 ETHTOOL_GUFO			n/a
 ETHTOOL_SUFO			n/a
 ETHTOOL_GGSO			n/a
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index fdae12b6c6b6..fb756b6a8592 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -153,8 +153,9 @@ enum {
 };
 
 #define ETH_INFO_IM_DRVINFO			0x01
+#define ETH_INFO_IM_PERMADDR			0x02
 
-#define ETH_INFO_IM_ALL				0x01
+#define ETH_INFO_IM_ALL				0x03
 
 enum {
 	ETHA_DRVINFO_UNSPEC,
@@ -167,6 +168,15 @@ enum {
 	ETHA_DRVINFO_MAX = (__ETHA_DRVINFO_CNT - 1)
 };
 
+enum {
+	ETHA_PERMADDR_UNSPEC,
+	ETHA_PERMADDR_ADDRESS,			/* binary */
+	ETHA_PERMADDR_TYPE,			/* u16 */
+
+	__ETHA_PERMADDR_CNT,
+	ETHA_PERMADDR_MAX = (__ETHA_PERMADDR_CNT - 1)
+};
+
 /* generic netlink info */
 #define ETHTOOL_GENL_NAME "ethtool"
 #define ETHTOOL_GENL_VERSION 1
diff --git a/net/ethtool/info.c b/net/ethtool/info.c
index 1a2e78d238e3..05dbd87ebc41 100644
--- a/net/ethtool/info.c
+++ b/net/ethtool/info.c
@@ -18,6 +18,7 @@ static const struct nla_policy get_info_policy[ETHA_INFO_MAX + 1] = {
 	[ETHA_INFO_INFOMASK]		= { .type = NLA_U32 },
 	[ETHA_INFO_COMPACT]		= { .type = NLA_FLAG },
 	[ETHA_INFO_DRVINFO]		= { .type = NLA_REJECT },
+	[ETHA_INFO_PERMADDR]		= { .type = NLA_REJECT },
 };
 
 static int parse_info(struct common_req_info *req_info, struct sk_buff *skb,
@@ -86,16 +87,29 @@ static int drvinfo_size(const struct ethtool_drvinfo *drvinfo)
 	return nla_total_size(len);
 }
 
+static int permaddr_size(const struct net_device *dev)
+{
+	int len = 0;
+
+	len += nla_total_size(dev->addr_len);
+	len += nla_total_size(sizeof(u16));
+
+	return nla_total_size(len);
+}
+
 static int info_size(const struct common_req_info *req_info)
 {
 	const struct info_data *data =
 		container_of(req_info, struct info_data, reqinfo_base);
+	const struct net_device *dev = data->repdata_base.dev;
 	u32 info_mask = data->repdata_base.info_mask;
 	int len = 0;
 
 	len += dev_ident_size();
 	if (info_mask & ETH_INFO_IM_DRVINFO)
 		len += drvinfo_size(&data->drvinfo);
+	if (info_mask & ETH_INFO_IM_PERMADDR)
+		len += permaddr_size(dev);
 
 	return len;
 }
@@ -124,6 +138,26 @@ static int fill_drvinfo(struct sk_buff *skb,
 	return ret;
 }
 
+static int fill_permaddr(struct sk_buff *skb, const struct net_device *dev)
+{
+	struct nlattr *nest = ethnl_nest_start(skb, ETHA_INFO_PERMADDR);
+	int ret;
+
+	if (!nest)
+		return -EMSGSIZE;
+	ret = -EMSGSIZE;
+	if (nla_put(skb, ETHA_PERMADDR_ADDRESS, dev->addr_len, dev->perm_addr))
+		goto err;
+	if (nla_put_u16(skb, ETHA_PERMADDR_TYPE, dev->type))
+		goto err;
+
+	nla_nest_end(skb, nest);
+	return 0;
+err:
+	nla_nest_cancel(skb, nest);
+	return ret;
+}
+
 static int fill_info(struct sk_buff *skb,
 		     const struct common_req_info *req_info)
 {
@@ -137,6 +171,11 @@ static int fill_info(struct sk_buff *skb,
 		if (ret < 0)
 			return ret;
 	}
+	if (info_mask & ETH_INFO_IM_PERMADDR) {
+		ret = fill_permaddr(skb, data->repdata_base.dev);
+		if (ret < 0)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.20.1

