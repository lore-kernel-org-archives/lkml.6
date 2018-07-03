Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462B2C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD83624CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD83624CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933653AbeGCIMg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:12:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46283 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932441AbeGCIMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:12:34 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1faGQ2-0003Yd-HX; Tue, 03 Jul 2018 08:12:14 +0000
From:   Colin King <colin.king@canonical.com>
To:     Han Xu <han.xu@nxp.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: gpmi: remove redundant variable payload_virt
Date:   Tue,  3 Jul 2018 09:12:14 +0100
Message-Id: <20180703081214.32754-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable payload_virt is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'payload_virt' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index f6aa358a3452..58d4e4a93a93 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -957,7 +957,6 @@ static int gpmi_ecc_read_page_data(struct nand_chip *chip,
 	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 	struct bch_geometry *nfc_geo = &this->bch_geometry;
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	void          *payload_virt;
 	dma_addr_t    payload_phys;
 	unsigned int  i;
 	unsigned char *status;
@@ -967,7 +966,6 @@ static int gpmi_ecc_read_page_data(struct nand_chip *chip,
 
 	dev_dbg(this->dev, "page number is : %d\n", page);
 
-	payload_virt = this->payload_virt;
 	payload_phys = this->payload_phys;
 
 	if (virt_addr_valid(buf)) {
@@ -976,7 +974,6 @@ static int gpmi_ecc_read_page_data(struct nand_chip *chip,
 		dest_phys = dma_map_single(this->dev, buf, nfc_geo->payload_size,
 					   DMA_FROM_DEVICE);
 		if (!dma_mapping_error(this->dev, dest_phys)) {
-			payload_virt = buf;
 			payload_phys = dest_phys;
 			direct = true;
 		}
-- 
2.17.1

