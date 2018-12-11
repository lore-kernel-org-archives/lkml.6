Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C71CC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E002084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544881;
	bh=Q/B1S5sulD15eSwXBg3Lm6RoyAYxMqZf0tQK5AEJIo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PcswSY3AdWXlRTrS1Kn4CAgxcxO0bR9Z42D3OSU7ryqYZ/5b/i9Oc7iMxVdB7LcDE
	 TSSz71aAbub/d1GY0FTAcRMLN/ilIdo5/wLfAErHvWAXr9CZ63HZFpdYU7HiepLkMQ
	 I2eH6PK0XdhVzPGDYrQPgWYSaH47Hm7tooOWmQko=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E002084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbeLKPtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:49:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:37380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbeLKPtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:49:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8961B20870;
        Tue, 11 Dec 2018 15:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543342;
        bh=Q/B1S5sulD15eSwXBg3Lm6RoyAYxMqZf0tQK5AEJIo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NeOtHmMirXwWuGlYQOEIp7vMONpI+InnXk08/xEi8v85nTuBYdRXnmpxxpbb0lScf
         eNtZSRVpRM+TR1gZuXQNQE28EGFB7+H8PEZjwEI9ej2bTLuCOwIDg8nKdwar0yEMjJ
         YPcS8K+jLzwWZ/VV+ktfZ477hHCf0tUgvi1Psm5U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 14/51] mtd: rawnand: qcom: Namespace prefix some commands
Date:   Tue, 11 Dec 2018 16:41:22 +0100
Message-Id: <20181211151614.075095303@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
References: <20181211151612.328911565@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 33bf5519ae5dd356b182a94e3622f42860274a38 ]

PAGE_READ is used by RISC-V arch code included through mm headers,
and it makes sense to bring in a prefix on these in the driver.

drivers/mtd/nand/raw/qcom_nandc.c:153: warning: "PAGE_READ" redefined
 #define PAGE_READ   0x2
In file included from include/linux/memremap.h:7,
                 from include/linux/mm.h:27,
                 from include/linux/scatterlist.h:8,
                 from include/linux/dma-mapping.h:11,
                 from drivers/mtd/nand/raw/qcom_nandc.c:17:
arch/riscv/include/asm/pgtable.h:48: note: this is the location of the previous definition

Caught by riscv allmodconfig.

Signed-off-by: Olof Johansson <olof@lixom.net>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/qcom_nandc.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/qcom_nandc.c b/drivers/mtd/nand/qcom_nandc.c
index dc4943134649..9f6c9a34b9eb 100644
--- a/drivers/mtd/nand/qcom_nandc.c
+++ b/drivers/mtd/nand/qcom_nandc.c
@@ -142,15 +142,15 @@
 #define	NAND_VERSION_MINOR_SHIFT	16
 
 /* NAND OP_CMDs */
-#define	PAGE_READ			0x2
-#define	PAGE_READ_WITH_ECC		0x3
-#define	PAGE_READ_WITH_ECC_SPARE	0x4
-#define	PROGRAM_PAGE			0x6
-#define	PAGE_PROGRAM_WITH_ECC		0x7
-#define	PROGRAM_PAGE_SPARE		0x9
-#define	BLOCK_ERASE			0xa
-#define	FETCH_ID			0xb
-#define	RESET_DEVICE			0xd
+#define	OP_PAGE_READ			0x2
+#define	OP_PAGE_READ_WITH_ECC		0x3
+#define	OP_PAGE_READ_WITH_ECC_SPARE	0x4
+#define	OP_PROGRAM_PAGE			0x6
+#define	OP_PAGE_PROGRAM_WITH_ECC	0x7
+#define	OP_PROGRAM_PAGE_SPARE		0x9
+#define	OP_BLOCK_ERASE			0xa
+#define	OP_FETCH_ID			0xb
+#define	OP_RESET_DEVICE			0xd
 
 /* Default Value for NAND_DEV_CMD_VLD */
 #define NAND_DEV_CMD_VLD_VAL		(READ_START_VLD | WRITE_START_VLD | \
@@ -425,11 +425,11 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read)
 
 	if (read) {
 		if (host->use_ecc)
-			cmd = PAGE_READ_WITH_ECC | PAGE_ACC | LAST_PAGE;
+			cmd = OP_PAGE_READ_WITH_ECC | PAGE_ACC | LAST_PAGE;
 		else
-			cmd = PAGE_READ | PAGE_ACC | LAST_PAGE;
+			cmd = OP_PAGE_READ | PAGE_ACC | LAST_PAGE;
 	} else {
-			cmd = PROGRAM_PAGE | PAGE_ACC | LAST_PAGE;
+		cmd = OP_PROGRAM_PAGE | PAGE_ACC | LAST_PAGE;
 	}
 
 	if (host->use_ecc) {
@@ -662,7 +662,7 @@ static int nandc_param(struct qcom_nand_host *host)
 	 * in use. we configure the controller to perform a raw read of 512
 	 * bytes to read onfi params
 	 */
-	nandc_set_reg(nandc, NAND_FLASH_CMD, PAGE_READ | PAGE_ACC | LAST_PAGE);
+	nandc_set_reg(nandc, NAND_FLASH_CMD, OP_PAGE_READ | PAGE_ACC | LAST_PAGE);
 	nandc_set_reg(nandc, NAND_ADDR0, 0);
 	nandc_set_reg(nandc, NAND_ADDR1, 0);
 	nandc_set_reg(nandc, NAND_DEV0_CFG0, 0 << CW_PER_PAGE
@@ -715,7 +715,7 @@ static int erase_block(struct qcom_nand_host *host, int page_addr)
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 
 	nandc_set_reg(nandc, NAND_FLASH_CMD,
-		      BLOCK_ERASE | PAGE_ACC | LAST_PAGE);
+		      OP_BLOCK_ERASE | PAGE_ACC | LAST_PAGE);
 	nandc_set_reg(nandc, NAND_ADDR0, page_addr);
 	nandc_set_reg(nandc, NAND_ADDR1, 0);
 	nandc_set_reg(nandc, NAND_DEV0_CFG0,
@@ -746,7 +746,7 @@ static int read_id(struct qcom_nand_host *host, int column)
 	if (column == -1)
 		return 0;
 
-	nandc_set_reg(nandc, NAND_FLASH_CMD, FETCH_ID);
+	nandc_set_reg(nandc, NAND_FLASH_CMD, OP_FETCH_ID);
 	nandc_set_reg(nandc, NAND_ADDR0, column);
 	nandc_set_reg(nandc, NAND_ADDR1, 0);
 	nandc_set_reg(nandc, NAND_FLASH_CHIP_SELECT, DM_EN);
@@ -766,7 +766,7 @@ static int reset(struct qcom_nand_host *host)
 	struct nand_chip *chip = &host->chip;
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 
-	nandc_set_reg(nandc, NAND_FLASH_CMD, RESET_DEVICE);
+	nandc_set_reg(nandc, NAND_FLASH_CMD, OP_RESET_DEVICE);
 	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
 
 	write_reg_dma(nandc, NAND_FLASH_CMD, 1);
-- 
2.19.1



