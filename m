Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48DDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7E0217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392470AbfBRSW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:22:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:46976 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392402AbfBRSWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:22:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50DFDAFD4;
        Mon, 18 Feb 2019 18:22:50 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 00831E0122; Mon, 18 Feb 2019 19:22:49 +0100 (CET)
Message-Id: <3e11d2901feca6a4aa8460a63537f5e59204a14a.1550513384.git.mkubecek@suse.cz>
In-Reply-To: <cover.1550513384.git.mkubecek@suse.cz>
References: <cover.1550513384.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH net-next v3 17/21] ethtool: provide message level in
 GET_SETTINGS request
To:     netdev@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Date:   Mon, 18 Feb 2019 19:22:49 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add information about supported and enabled message levels to the
GET_SETTINGS reply when ETH_SETTINGS_IM_MSGLEVEL flag is set in the
request.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 Documentation/networking/ethtool-netlink.txt |  7 ++++++-
 include/linux/netdevice.h                    |  2 ++
 include/uapi/linux/ethtool_netlink.h         |  4 +++-
 net/ethtool/settings.c                       | 16 ++++++++++++++++
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.txt b/Documentation/networking/ethtool-netlink.txt
index 913df35cb762..057eb3213cfe 100644
--- a/Documentation/networking/ethtool-netlink.txt
+++ b/Documentation/networking/ethtool-netlink.txt
@@ -284,6 +284,7 @@ Info mask bits meaning:
     ETH_SETTINGS_IM_LINKINFO		link_ksettings except link modes
     ETH_SETTINGS_IM_LINKMODES		link modes from link_ksettings
     ETH_SETTINGS_IM_WOLINFO		struct ethtool_wolinfo
+    ETH_SETTINGS_IM_MSGLEVEL		msglevel
 
 Response contents:
 
@@ -302,6 +303,7 @@ Response contents:
     ETHA_SETTINGS_WOL		(nested)	wake on LAN settings
         ETHA_WOL_MODES			(bitfield32)	wake on LAN modes
         ETHA_WOL_SOPASS			(binary)	SecureOn(tm) password
+    ETHA_SETTINGS_MSGLEVEL	(bitfield32)	debug level
 
 Most of the attributes and their values have the same meaning as matching
 members of the corresponding ioctl structures. For ETHA_SETTINGS_LINK_MODES,
@@ -311,6 +313,9 @@ ETHA_SETTINGS_PEER_MODES in the reply is a bit list.
 For ETHA_WOL_MODES, selector reports wake on LAN modes supported by the
 device and value enabled modes.
 
+For ETHA_SETTINGS_MSGLEVEL, selector reports all flags supported by kernel and
+value flags enabled for the device.
+
 GET_SETTINGS request is allowed for unprivileged user but ETHA_SETTINGS_SOPASS
 is only provided by kernel in response to privileged (netns CAP_NET_ADMIN)
 requests.
@@ -335,7 +340,7 @@ ETHTOOL_GDRVINFO		ETHNL_CMD_GET_INFO
 ETHTOOL_GREGS			n/a
 ETHTOOL_GWOL			ETHNL_CMD_GET_SETTINGS
 ETHTOOL_SWOL			n/a
-ETHTOOL_GMSGLVL			n/a
+ETHTOOL_GMSGLVL			ETHNL_CMD_GET_SETTINGS
 ETHTOOL_SMSGLVL			n/a
 ETHTOOL_NWAY_RST		n/a
 ETHTOOL_GLINK			n/a
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9a50a67f328f..a2ddfeb381bb 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3846,6 +3846,8 @@ enum {
 	NETIF_MSG_PKTDATA	= 0x1000,
 	NETIF_MSG_HW		= 0x2000,
 	NETIF_MSG_WOL		= 0x4000,
+
+	NETIF_MSG_ALL		= 0x7fff,
 };
 
 #define netif_msg_drv(p)	((p)->msg_enable & NETIF_MSG_DRV)
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index ce9d6b48f814..360e20a73f19 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -202,6 +202,7 @@ enum {
 	ETHA_SETTINGS_LINK_MODES,		/* bitset */
 	ETHA_SETTINGS_PEER_MODES,		/* bitset */
 	ETHA_SETTINGS_WOL,			/* nested */
+	ETHA_SETTINGS_MSGLEVEL,			/* bitfield32 */
 
 	__ETHA_SETTINGS_CNT,
 	ETHA_SETTINGS_MAX = (__ETHA_SETTINGS_CNT - 1)
@@ -210,8 +211,9 @@ enum {
 #define ETH_SETTINGS_IM_LINKINFO		0x01
 #define ETH_SETTINGS_IM_LINKMODES		0x02
 #define ETH_SETTINGS_IM_WOLINFO			0x04
+#define ETH_SETTINGS_IM_MSGLEVEL		0x08
 
-#define ETH_SETTINGS_IM_ALL			0x07
+#define ETH_SETTINGS_IM_ALL			0x0f
 
 enum {
 	ETHA_LINKINFO_UNSPEC,
diff --git a/net/ethtool/settings.c b/net/ethtool/settings.c
index d296625edb2b..58cd2d19a75d 100644
--- a/net/ethtool/settings.c
+++ b/net/ethtool/settings.c
@@ -13,6 +13,7 @@ struct settings_data {
 	struct ethtool_link_ksettings	ksettings;
 	struct ethtool_link_settings	*lsettings;
 	struct ethtool_wolinfo		wolinfo;
+	u32				msglevel;
 	bool				lpm_empty;
 };
 
@@ -25,6 +26,7 @@ static const struct nla_policy get_settings_policy[ETHA_SETTINGS_MAX + 1] = {
 	[ETHA_SETTINGS_LINK_MODES]	= { .type = NLA_REJECT },
 	[ETHA_SETTINGS_PEER_MODES]	= { .type = NLA_REJECT },
 	[ETHA_SETTINGS_WOL]		= { .type = NLA_REJECT },
+	[ETHA_SETTINGS_MSGLEVEL]	= { .type = NLA_REJECT },
 };
 
 static int parse_settings(struct common_req_info *req_info,
@@ -91,6 +93,7 @@ static int prepare_settings(struct common_req_info *req_info,
 	struct settings_data *data =
 		container_of(req_info, struct settings_data, reqinfo_base);
 	struct net_device *dev = data->repdata_base.dev;
+	const struct ethtool_ops *eops = dev->ethtool_ops;
 	u32 req_mask = req_info->req_mask;
 	int ret;
 
@@ -122,6 +125,12 @@ static int prepare_settings(struct common_req_info *req_info,
 		if (ret < 0)
 			req_mask &= ~ETH_SETTINGS_IM_WOLINFO;
 	}
+	if (req_mask & ETH_SETTINGS_IM_MSGLEVEL) {
+		if (eops->get_msglevel)
+			data->msglevel = eops->get_msglevel(dev);
+		else
+			req_mask &= ~ETH_SETTINGS_IM_MSGLEVEL;
+	}
 	ethnl_after_ops(dev);
 
 	data->repdata_base.info_mask = req_mask;
@@ -198,6 +207,8 @@ static int settings_size(const struct common_req_info *req_info)
 	}
 	if (info_mask & ETH_SETTINGS_IM_WOLINFO)
 		len += wol_size();
+	if (info_mask & ETH_SETTINGS_IM_MSGLEVEL)
+		len += nla_total_size(sizeof(struct nla_bitfield32));
 
 	return len;
 }
@@ -308,6 +319,11 @@ static int fill_settings(struct sk_buff *skb,
 		if (ret < 0)
 			return ret;
 	}
+	if (info_mask & ETH_SETTINGS_IM_MSGLEVEL) {
+		if (nla_put_bitfield32(skb, ETHA_SETTINGS_MSGLEVEL,
+				       data->msglevel, NETIF_MSG_ALL))
+			return -EMSGSIZE;
+	}
 
 	return 0;
 }
-- 
2.20.1

