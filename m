Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F244C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1220E245E7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1220E245E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933872AbeGDHjQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:39:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38520 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932346AbeGDHjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:39:14 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1facNc-0002yM-M2; Wed, 04 Jul 2018 07:39:12 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cnic: remove redundant pointer req and variable func
Date:   Wed,  4 Jul 2018 08:39:12 +0100
Message-Id: <20180704073912.15598-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer req and variable func are being assigned but are never used
hence they are redundant and can be removed.

Cleans up clang warnings:
warning: variable 'req' set but not used [-Wunused-but-set-variable]
warning: variable 'func' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/broadcom/cnic.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/cnic.c b/drivers/net/ethernet/broadcom/cnic.c
index 4fd829b5e65d..2369b2f0d95a 100644
--- a/drivers/net/ethernet/broadcom/cnic.c
+++ b/drivers/net/ethernet/broadcom/cnic.c
@@ -2562,7 +2562,6 @@ static void cnic_bnx2x_delete_wait(struct cnic_dev *dev, u32 start_cid)
 
 static int cnic_bnx2x_fcoe_fw_destroy(struct cnic_dev *dev, struct kwqe *kwqe)
 {
-	struct fcoe_kwqe_destroy *req;
 	union l5cm_specific_data l5_data;
 	struct cnic_local *cp = dev->cnic_priv;
 	struct bnx2x *bp = netdev_priv(dev->netdev);
@@ -2571,7 +2570,6 @@ static int cnic_bnx2x_fcoe_fw_destroy(struct cnic_dev *dev, struct kwqe *kwqe)
 
 	cnic_bnx2x_delete_wait(dev, MAX_ISCSI_TBL_SZ);
 
-	req = (struct fcoe_kwqe_destroy *) kwqe;
 	cid = BNX2X_HW_CID(bp, cp->fcoe_init_cid);
 
 	memset(&l5_data, 0, sizeof(l5_data));
@@ -5091,13 +5089,12 @@ static int cnic_start_bnx2x_hw(struct cnic_dev *dev)
 	struct cnic_local *cp = dev->cnic_priv;
 	struct bnx2x *bp = netdev_priv(dev->netdev);
 	struct cnic_eth_dev *ethdev = cp->ethdev;
-	int func, ret;
+	int ret;
 	u32 pfid;
 
 	dev->stats_addr = ethdev->addr_drv_info_to_mcp;
 	cp->func = bp->pf_num;
 
-	func = CNIC_FUNC(cp);
 	pfid = bp->pfid;
 
 	ret = cnic_init_id_tbl(&cp->cid_tbl, MAX_ISCSI_TBL_SZ,
-- 
2.17.1

