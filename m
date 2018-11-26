Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3783CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A93208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mbmKeJj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A93208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbeK0IpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:45:15 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33494 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726414AbeK0IpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:45:14 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAQLibiW008608
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 13:49:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=7Hk0L83+6Exc6u71ZlB9Tkuy907TY6bcTVc/2wuRpSk=;
 b=mbmKeJj9UkvjZs7s/2llcEH0UcA+qxsBcllUuxjM3nGNmRyrZWgQqyo5H81XQiTY5J6x
 psNtcx+/ZmcKqFWb6gzg9soLsTgoLmd3YuYql3BvIsQyvX1JH4sVjLhYLolZDh3i8U/u
 KkBGJHBKWUSCkMjVT7xmXwLGVT7Sw6AWXYs= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p0qfkrbwm-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 13:49:43 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Mon, 26 Nov 2018 13:49:12 -0800
Received: by devvm4117.prn2.facebook.com (Postfix, from userid 167582)
        id 3AF29433B303; Mon, 26 Nov 2018 13:49:07 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Vijay Khemka <vijaykhemka@fb.com>
Smtp-Origin-Hostname: devvm4117.prn2.facebook.com
To:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <vijaykhemka@fb.com>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
        <Justin.Lee1@Dell.com>, <joel@jms.id.au>,
        <linux-aspeed@lists.ozlabs.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH net-next v2] net/ncsi: Add NCSI Mellanox OEM command
Date:   Mon, 26 Nov 2018 13:49:04 -0800
Message-ID: <20181126214905.3703229-1-vijaykhemka@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-26_17:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds OEM Mellanox commands and response handling. It also
defines OEM Get MAC Address handler to get and configure the device.

ncsi_oem_gma_handler_mlx: This handler send NCSI mellanox command for
getting mac address.
ncsi_rsp_handler_oem_mlx: This handles response received for all
mellanox OEM commands.
ncsi_rsp_handler_oem_mlx_gma: This handles get mac address response and
set it to device.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 net/ncsi/internal.h    |  5 +++++
 net/ncsi/ncsi-manage.c | 28 +++++++++++++++++++++++++++-
 net/ncsi/ncsi-pkt.h    |  9 +++++++++
 net/ncsi/ncsi-rsp.c    | 41 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 1dae77c54009..7f3eb1360b9b 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -73,10 +73,15 @@ enum {
 #define NCSI_OEM_MFR_BCM_ID             0x113d
 /* Broadcom specific OEM Command */
 #define NCSI_OEM_BCM_CMD_GMA            0x01   /* CMD ID for Get MAC */
+/* Mellanox specific OEM Command */
+#define NCSI_OEM_MLX_CMD_GMA            0x00   /* CMD ID for Get MAC */
+#define NCSI_OEM_MLX_CMD_GMA_PARAM      0x1b   /* Parameter for GMA  */
 /* OEM Command payload lengths*/
 #define NCSI_OEM_BCM_CMD_GMA_LEN        12
+#define NCSI_OEM_MLX_CMD_GMA_LEN        8
 /* Mac address offset in OEM response */
 #define BCM_MAC_ADDR_OFFSET             28
+#define MLX_MAC_ADDR_OFFSET             8
 
 
 struct ncsi_channel_version {
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index bfc43b28c7a6..2c9bcb705460 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -675,12 +675,38 @@ static int ncsi_oem_gma_handler_bcm(struct ncsi_cmd_arg *nca)
 	return ret;
 }
 
+static int ncsi_oem_gma_handler_mlx(struct ncsi_cmd_arg *nca)
+{
+	union {
+		u8 data_u8[NCSI_OEM_MLX_CMD_GMA_LEN];
+		u32 data_u32[NCSI_OEM_MLX_CMD_GMA_LEN / sizeof(u32)];
+	} u;
+	int ret = 0;
+
+	nca->payload = NCSI_OEM_MLX_CMD_GMA_LEN;
+
+	memset(&u, 0, sizeof(u));
+	u.data_u32[0] = ntohl(NCSI_OEM_MFR_MLX_ID);
+	u.data_u8[5] = NCSI_OEM_MLX_CMD_GMA;
+	u.data_u8[6] = NCSI_OEM_MLX_CMD_GMA_PARAM;
+
+	nca->data = u.data_u8;
+
+	ret = ncsi_xmit_cmd(nca);
+	if (ret)
+		netdev_err(nca->ndp->ndev.dev,
+			   "NCSI: Failed to transmit cmd 0x%x during configure\n",
+			   nca->type);
+	return ret;
+}
+
 /* OEM Command handlers initialization */
 static struct ncsi_oem_gma_handler {
 	unsigned int	mfr_id;
 	int		(*handler)(struct ncsi_cmd_arg *nca);
 } ncsi_oem_gma_handlers[] = {
-	{ NCSI_OEM_MFR_BCM_ID, ncsi_oem_gma_handler_bcm }
+	{ NCSI_OEM_MFR_BCM_ID, ncsi_oem_gma_handler_bcm },
+	{ NCSI_OEM_MFR_MLX_ID, ncsi_oem_gma_handler_mlx }
 };
 
 static int ncsi_gma_handler(struct ncsi_cmd_arg *nca, unsigned int mf_id)
diff --git a/net/ncsi/ncsi-pkt.h b/net/ncsi/ncsi-pkt.h
index 4d3f06be38bd..2a6d83a596c9 100644
--- a/net/ncsi/ncsi-pkt.h
+++ b/net/ncsi/ncsi-pkt.h
@@ -165,6 +165,15 @@ struct ncsi_rsp_oem_pkt {
 	unsigned char           data[];      /* Payload data      */
 };
 
+/* Mellanox Response Data */
+struct ncsi_rsp_oem_mlx_pkt {
+	unsigned char           cmd_rev;     /* Command Revision  */
+	unsigned char           cmd;         /* Command ID        */
+	unsigned char           param;       /* Parameter         */
+	unsigned char           optional;    /* Optional data     */
+	unsigned char           data[];      /* Data              */
+};
+
 /* Broadcom Response Data */
 struct ncsi_rsp_oem_bcm_pkt {
 	unsigned char           ver;         /* Payload Version   */
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 77e07ba3f493..ba9a4ba97c64 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -611,6 +611,45 @@ static int ncsi_rsp_handler_snfc(struct ncsi_request *nr)
 	return 0;
 }
 
+/* Response handler for Mellanox command Get Mac Address */
+static int ncsi_rsp_handler_oem_mlx_gma(struct ncsi_request *nr)
+{
+	struct ncsi_dev_priv *ndp = nr->ndp;
+	struct net_device *ndev = ndp->ndev.dev;
+	const struct net_device_ops *ops = ndev->netdev_ops;
+	struct ncsi_rsp_oem_pkt *rsp;
+	struct sockaddr saddr;
+	int ret = 0;
+
+	/* Get the response header */
+	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
+
+	saddr.sa_family = ndev->type;
+	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+	memcpy(saddr.sa_data, &rsp->data[MLX_MAC_ADDR_OFFSET], ETH_ALEN);
+	ret = ops->ndo_set_mac_address(ndev, &saddr);
+	if (ret < 0)
+		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");
+
+	return ret;
+}
+
+/* Response handler for Mellanox card */
+static int ncsi_rsp_handler_oem_mlx(struct ncsi_request *nr)
+{
+	struct ncsi_rsp_oem_mlx_pkt *mlx;
+	struct ncsi_rsp_oem_pkt *rsp;
+
+	/* Get the response header */
+	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
+	mlx = (struct ncsi_rsp_oem_mlx_pkt *)(rsp->data);
+
+	if (mlx->cmd == NCSI_OEM_MLX_CMD_GMA &&
+	    mlx->param == NCSI_OEM_MLX_CMD_GMA_PARAM)
+		return ncsi_rsp_handler_oem_mlx_gma(nr);
+	return 0;
+}
+
 /* Response handler for Broadcom command Get Mac Address */
 static int ncsi_rsp_handler_oem_bcm_gma(struct ncsi_request *nr)
 {
@@ -655,7 +694,7 @@ static struct ncsi_rsp_oem_handler {
 	unsigned int	mfr_id;
 	int		(*handler)(struct ncsi_request *nr);
 } ncsi_rsp_oem_handlers[] = {
-	{ NCSI_OEM_MFR_MLX_ID, NULL },
+	{ NCSI_OEM_MFR_MLX_ID, ncsi_rsp_handler_oem_mlx },
 	{ NCSI_OEM_MFR_BCM_ID, ncsi_rsp_handler_oem_bcm }
 };
 
-- 
2.17.1

