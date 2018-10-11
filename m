Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CC2C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5855420644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pJc0/Mi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5855420644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeJLGfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 02:35:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35460 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725824AbeJLGfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 02:35:01 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BMwRt9000397
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 16:05:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=DYVFWLDdHRu6aW8ozKKvvosDi5wMtCjpft/GgAOoDWE=;
 b=pJc0/Mi4WkP7GE4ocNqufLpybdqnVGhB7T6HZiigFTNxRPUcTBOjIFxgosZJ2trBdBN9
 Bqzk9GghB3WDvA5XZGbVE4lqrJTtBROFquxIl10pYRbzfjC+ltjgMpYV7JOHfochLfmi
 dIsnVC8zgE5MqJLjiv+pMrHrBMpwuK0xQyk= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2n2efy88t3-13
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 16:05:33 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.16) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 11 Oct
 2018 16:05:30 -0700
Received: by devvm4117.prn2.facebook.com (Postfix, from userid 167582)  id
 3A4D526306B0; Thu, 11 Oct 2018 16:05:28 -0700 (PDT)
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
Subject: [PATCH net-next v3 2/2] net/ncsi: Add NCSI Mellanox OEM command
Date:   Thu, 11 Oct 2018 16:05:18 -0700
Message-ID: <20181011230518.3204700-2-vijaykhemka@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011230518.3204700-1-vijaykhemka@fb.com>
References: <20181011230518.3204700-1-vijaykhemka@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_11:,,
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
 net/ncsi/ncsi-manage.c | 24 +++++++++++++++++++++++-
 net/ncsi/ncsi-pkt.h    |  9 +++++++++
 net/ncsi/ncsi-rsp.c    | 41 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 45883b32790e..d4558628a991 100644
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
index 75504ccd1b95..9306fa464190 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -658,12 +658,34 @@ static void ncsi_oem_gma_handler_bcm(struct ncsi_cmd_arg *nca)
 			   nca->type);
 }
 
+static void ncsi_oem_gma_handler_mlx(struct ncsi_cmd_arg *nca)
+{
+	int ret = 0;
+	unsigned char data[NCSI_OEM_MLX_CMD_GMA_LEN];
+
+	nca->payload = NCSI_OEM_MLX_CMD_GMA_LEN;
+
+	memset(data, 0, NCSI_OEM_MLX_CMD_GMA_LEN);
+	*(unsigned int *)data = ntohl(NCSI_OEM_MFR_MLX_ID);
+	data[5] = NCSI_OEM_MLX_CMD_GMA;
+	data[6] = NCSI_OEM_MLX_CMD_GMA_PARAM;
+
+	nca->data = data;
+
+	ret = ncsi_xmit_cmd(nca);
+	if (ret)
+		netdev_err(nca->ndp->ndev.dev,
+			   "NCSI: Failed to transmit cmd 0x%x during configure\n",
+			   nca->type);
+}
+
 /* OEM Command handlers initialization */
 static struct ncsi_oem_gma_handler {
 	unsigned int	mfr_id;
 	void		(*handler)(struct ncsi_cmd_arg *nca);
 } ncsi_oem_gma_handlers[] = {
-	{ NCSI_OEM_MFR_BCM_ID, ncsi_oem_gma_handler_bcm }
+	{ NCSI_OEM_MFR_BCM_ID, ncsi_oem_gma_handler_bcm },
+	{ NCSI_OEM_MFR_MLX_ID, ncsi_oem_gma_handler_mlx }
 };
 
 #endif /* CONFIG_NCSI_OEM_CMD_GET_MAC */
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
index 31672e967db2..5158836796ce 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -596,6 +596,45 @@ static int ncsi_rsp_handler_snfc(struct ncsi_request *nr)
 	return 0;
 }
 
+/* Response handler for Mellanox command Get Mac Address */
+static int ncsi_rsp_handler_oem_mlx_gma(struct ncsi_request *nr)
+{
+	struct ncsi_rsp_oem_pkt *rsp;
+	struct ncsi_dev_priv *ndp = nr->ndp;
+	struct net_device *ndev = ndp->ndev.dev;
+	int ret = 0;
+	const struct net_device_ops *ops = ndev->netdev_ops;
+	struct sockaddr saddr;
+
+	/* Get the response header */
+	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
+
+	saddr.sa_family = ndev->type;
+	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+	memcpy(saddr.sa_data, &rsp->data[MLX_MAC_ADDR_OFFSET], ETH_ALEN);
+	ret = ops->ndo_set_mac_address(ndev, &saddr);
+	if (ret < 0)
+		netdev_warn(ndev, "NCSI: Writing mac address to device failed\n");
+
+	return ret;
+}
+
+/* Response handler for Mellanox card */
+static int ncsi_rsp_handler_oem_mlx(struct ncsi_request *nr)
+{
+	struct ncsi_rsp_oem_pkt *rsp;
+	struct ncsi_rsp_oem_mlx_pkt *mlx;
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
@@ -638,7 +677,7 @@ static struct ncsi_rsp_oem_handler {
 	unsigned int	mfr_id;
 	int		(*handler)(struct ncsi_request *nr);
 } ncsi_rsp_oem_handlers[] = {
-	{ NCSI_OEM_MFR_MLX_ID, NULL },
+	{ NCSI_OEM_MFR_MLX_ID, ncsi_rsp_handler_oem_mlx },
 	{ NCSI_OEM_MFR_BCM_ID, ncsi_rsp_handler_oem_bcm }
 };
 
-- 
2.17.1

