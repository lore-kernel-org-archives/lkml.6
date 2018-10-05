Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD8DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F034E21473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F034E21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbeJEQlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:41:17 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:10815 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727581AbeJEQlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:41:15 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w959dH2r000447;
        Fri, 5 Oct 2018 11:42:39 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2msxh72a07-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 05 Oct 2018 11:42:39 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3936D3F;
        Fri,  5 Oct 2018 09:42:38 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EF93C2665;
        Fri,  5 Oct 2018 09:42:37 +0000 (GMT)
Received: from localhost (10.75.127.48) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 5 Oct 2018 11:42:37
 +0200
From:   <christophe.kerello@st.com>
To:     <boris.brezillon@bootlin.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: [PATCH v2 3/3] mtd: rawnand: stm32_fmc2: add manual mode
Date:   Fri, 5 Oct 2018 11:42:00 +0200
Message-ID: <1538732520-2800-4-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538732520-2800-1-git-send-email-christophe.kerello@st.com>
References: <1538732520-2800-1-git-send-email-christophe.kerello@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-05_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Kerello <christophe.kerello@st.com>

This patch adds the manual mode, a basic mode that do not need
any DMA channels. This mode is also useful for debug purpose.

Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 325 +++++++++++++++++++++++++++++----
 1 file changed, 293 insertions(+), 32 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index a695bf9..09e026d 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -207,6 +207,12 @@ enum stm32_fmc2_ecc {
 	FMC2_ECC_BCH8 = 8
 };
 
+enum stm32_fmc2_irq_state {
+	FMC2_IRQ_UNKNOWN = 0,
+	FMC2_IRQ_BCH,
+	FMC2_IRQ_SEQ
+};
+
 struct stm32_fmc2_timings {
 	u8 tclr;
 	u8 tar;
@@ -240,6 +246,7 @@ struct stm32_fmc2 {
 	phys_addr_t io_phys_addr;
 	phys_addr_t data_phys_addr[FMC2_MAX_CE];
 	struct clk *clk;
+	u8 irq_state;
 
 	struct dma_chan *dma_tx_ch;
 	struct dma_chan *dma_rx_ch;
@@ -264,6 +271,8 @@ static inline void stm32_fmc2_enable_seq_irq(struct stm32_fmc2 *fmc2)
 
 	csqier |= FMC2_CSQIER_TCIE;
 
+	fmc2->irq_state = FMC2_IRQ_SEQ;
+
 	writel_relaxed(csqier, fmc2->io_base + FMC2_CSQIER);
 }
 
@@ -275,6 +284,8 @@ static inline void stm32_fmc2_disable_seq_irq(struct stm32_fmc2 *fmc2)
 	csqier &= ~FMC2_CSQIER_TCIE;
 
 	writel_relaxed(csqier, fmc2->io_base + FMC2_CSQIER);
+
+	fmc2->irq_state = FMC2_IRQ_UNKNOWN;
 }
 
 /* Clear irq sources in case of the sequencer is used */
@@ -283,6 +294,69 @@ static inline void stm32_fmc2_clear_seq_irq(struct stm32_fmc2 *fmc2)
 	writel_relaxed(FMC2_CSQICR_CLEAR_IRQ, fmc2->io_base + FMC2_CSQICR);
 }
 
+/* Enable irq sources in case of bch is used */
+static inline void stm32_fmc2_enable_bch_irq(struct stm32_fmc2 *fmc2, int mode)
+{
+	u32 bchier = readl_relaxed(fmc2->io_base + FMC2_BCHIER);
+
+	if (mode == NAND_ECC_WRITE)
+		bchier |= FMC2_BCHIER_EPBRIE;
+	else
+		bchier |= FMC2_BCHIER_DERIE;
+
+	fmc2->irq_state = FMC2_IRQ_BCH;
+
+	writel_relaxed(bchier, fmc2->io_base + FMC2_BCHIER);
+}
+
+/* Disable irq sources in case of bch is used */
+static inline void stm32_fmc2_disable_bch_irq(struct stm32_fmc2 *fmc2)
+{
+	u32 bchier = readl_relaxed(fmc2->io_base + FMC2_BCHIER);
+
+	bchier &= ~FMC2_BCHIER_DERIE;
+	bchier &= ~FMC2_BCHIER_EPBRIE;
+
+	writel_relaxed(bchier, fmc2->io_base + FMC2_BCHIER);
+
+	fmc2->irq_state = FMC2_IRQ_UNKNOWN;
+}
+
+/* Clear irq sources in case of bch is used */
+static inline void stm32_fmc2_clear_bch_irq(struct stm32_fmc2 *fmc2)
+{
+	writel_relaxed(FMC2_BCHICR_CLEAR_IRQ, fmc2->io_base + FMC2_BCHICR);
+}
+
+/*
+ * Enable ecc logic and reset syndrome/parity bits previously calculated
+ * Syndrome/parity bits is cleared by setting the ECCEN bit to 0
+ */
+static void stm32_fmc2_hwctl(struct nand_chip *chip, int mode)
+{
+	struct stm32_fmc2 *fmc2 = nand_get_controller_data(chip);
+	u32 pcr = readl_relaxed(fmc2->io_base + FMC2_PCR);
+
+	pcr &= ~FMC2_PCR_ECCEN;
+	writel_relaxed(pcr, fmc2->io_base + FMC2_PCR);
+
+	if (chip->ecc.strength != FMC2_ECC_HAM) {
+		if (mode == NAND_ECC_WRITE)
+			pcr |= FMC2_PCR_WEN;
+		else
+			pcr &= ~FMC2_PCR_WEN;
+		writel_relaxed(pcr, fmc2->io_base + FMC2_PCR);
+
+		reinit_completion(&fmc2->complete);
+		stm32_fmc2_clear_bch_irq(fmc2);
+		stm32_fmc2_enable_bch_irq(fmc2, mode);
+	}
+
+	pcr = readl_relaxed(fmc2->io_base + FMC2_PCR);
+	pcr |= FMC2_PCR_ECCEN;
+	writel_relaxed(pcr, fmc2->io_base + FMC2_PCR);
+}
+
 /*
  * ECC Hamming calculation
  * ECC is 3 bytes for 512 bytes of data (supports error correction up to
@@ -295,6 +369,32 @@ static inline void stm32_fmc2_ham_set_ecc(const u32 ecc_sta, u8 *ecc)
 	ecc[2] = ecc_sta >> 16;
 }
 
+static int stm32_fmc2_ham_calculate(struct nand_chip *chip, const uint8_t *data,
+				    uint8_t *ecc)
+{
+	struct stm32_fmc2 *fmc2 = nand_get_controller_data(chip);
+	u32 sr, heccr, pcr;
+	int ret;
+
+	ret = readl_relaxed_poll_timeout(fmc2->io_base + FMC2_SR,
+					 sr, sr & FMC2_SR_NWRF, 10, 1000);
+	if (ret) {
+		dev_err(fmc2->dev, "ham timeout\n");
+		return ret;
+	}
+
+	heccr = readl_relaxed(fmc2->io_base + FMC2_HECCR);
+
+	stm32_fmc2_ham_set_ecc(heccr, ecc);
+
+	/* Disable ecc */
+	pcr = readl_relaxed(fmc2->io_base + FMC2_PCR);
+	pcr &= ~FMC2_PCR_ECCEN;
+	writel_relaxed(pcr, fmc2->io_base + FMC2_PCR);
+
+	return 0;
+}
+
 static int stm32_fmc2_ham_correct(struct nand_chip *chip, uint8_t *dat,
 				  uint8_t *read_ecc, uint8_t *calc_ecc)
 {
@@ -347,6 +447,58 @@ static int stm32_fmc2_ham_correct(struct nand_chip *chip, uint8_t *dat,
 	return 1;
 }
 
+/*
+ * ECC BCH calculation and correction
+ * ECC is 7/13 bytes for 512 bytes of data (supports error correction up to
+ * max of 4-bit/8-bit)
+ */
+static int stm32_fmc2_bch_calculate(struct nand_chip *chip, const uint8_t *data,
+				    uint8_t *ecc)
+{
+	struct stm32_fmc2 *fmc2 = nand_get_controller_data(chip);
+	u32 bchpbr, pcr;
+
+	/* Wait until the BCH code is ready */
+	if (!wait_for_completion_timeout(&fmc2->complete,
+					 msecs_to_jiffies(1000))) {
+		dev_err(fmc2->dev, "bch timeout\n");
+		stm32_fmc2_disable_bch_irq(fmc2);
+		return -ETIMEDOUT;
+	}
+
+	/* Read parity bits */
+	bchpbr = readl_relaxed(fmc2->io_base + FMC2_BCHPBR1);
+	ecc[0] = bchpbr;
+	ecc[1] = bchpbr >> 8;
+	ecc[2] = bchpbr >> 16;
+	ecc[3] = bchpbr >> 24;
+
+	bchpbr = readl_relaxed(fmc2->io_base + FMC2_BCHPBR2);
+	ecc[4] = bchpbr;
+	ecc[5] = bchpbr >> 8;
+	ecc[6] = bchpbr >> 16;
+
+	if (chip->ecc.strength == FMC2_ECC_BCH8) {
+		ecc[7] = bchpbr >> 24;
+
+		bchpbr = readl_relaxed(fmc2->io_base + FMC2_BCHPBR3);
+		ecc[8] = bchpbr;
+		ecc[9] = bchpbr >> 8;
+		ecc[10] = bchpbr >> 16;
+		ecc[11] = bchpbr >> 24;
+
+		bchpbr = readl_relaxed(fmc2->io_base + FMC2_BCHPBR4);
+		ecc[12] = bchpbr;
+	}
+
+	/* Disable ecc */
+	pcr = readl_relaxed(fmc2->io_base + FMC2_PCR);
+	pcr &= ~FMC2_PCR_ECCEN;
+	writel_relaxed(pcr, fmc2->io_base + FMC2_PCR);
+
+	return 0;
+}
+
 /* BCH algorithm correction */
 static int stm32_fmc2_bch_decode(int eccsize, u8 *dat, u32 *ecc_sta)
 {
@@ -387,6 +539,96 @@ static int stm32_fmc2_bch_decode(int eccsize, u8 *dat, u32 *ecc_sta)
 	return nb_errs;
 }
 
+static int stm32_fmc2_bch_correct(struct nand_chip *chip, uint8_t *dat,
+				  uint8_t *read_ecc, uint8_t *calc_ecc)
+{
+	struct stm32_fmc2 *fmc2 = nand_get_controller_data(chip);
+	u32 ecc_sta[5], pcr;
+
+	/* Wait until the decoding error is ready */
+	if (!wait_for_completion_timeout(&fmc2->complete,
+					 msecs_to_jiffies(1000))) {
+		dev_err(fmc2->dev, "bch timeout\n");
+		stm32_fmc2_disable_bch_irq(fmc2);
+		return -ETIMEDOUT;
+	}
+
+	ecc_sta[0] = readl_relaxed(fmc2->io_base + FMC2_BCHDSR0);
+	ecc_sta[1] = readl_relaxed(fmc2->io_base + FMC2_BCHDSR1);
+	ecc_sta[2] = readl_relaxed(fmc2->io_base + FMC2_BCHDSR2);
+	ecc_sta[3] = readl_relaxed(fmc2->io_base + FMC2_BCHDSR3);
+	ecc_sta[4] = readl_relaxed(fmc2->io_base + FMC2_BCHDSR4);
+
+	/* Disable ecc */
+	pcr = readl_relaxed(fmc2->io_base + FMC2_PCR);
+	pcr &= ~FMC2_PCR_ECCEN;
+	writel_relaxed(pcr, fmc2->io_base + FMC2_PCR);
+
+	return stm32_fmc2_bch_decode(chip->ecc.size, dat, ecc_sta);
+}
+
+static int stm32_fmc2_read_page(struct nand_chip *chip, uint8_t *buf,
+				int oob_required, int page)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	int ret, i, s, stat, eccsize = chip->ecc.size;
+	int eccbytes = chip->ecc.bytes;
+	int eccsteps = chip->ecc.steps;
+	int eccstrength = chip->ecc.strength;
+	u8 *p = buf;
+	u8 *ecc_calc = chip->ecc.calc_buf;
+	u8 *ecc_code = chip->ecc.code_buf;
+	unsigned int max_bitflips = 0;
+
+	ret = nand_read_page_op(chip, page, 0, NULL, 0);
+	if (ret)
+		return ret;
+
+	for (i = mtd->writesize + FMC2_BBM_LEN, s = 0; s < eccsteps;
+	     s++, i += eccbytes, p += eccsize) {
+		chip->ecc.hwctl(chip, NAND_ECC_READ);
+
+		/* Read the nand page sector (512 bytes) */
+		ret = nand_change_read_column_op(chip, s * eccsize, p,
+						 eccsize, false);
+		if (ret)
+			return ret;
+
+		/* Read the corresponding ecc bytes */
+		ret = nand_change_read_column_op(chip, i, ecc_code,
+						 eccbytes, false);
+		if (ret)
+			return ret;
+
+		/* Correct the data */
+		stat = chip->ecc.correct(chip, p, ecc_code, ecc_calc);
+		if (stat == -EBADMSG)
+			/* Check for empty pages with bitflips */
+			stat = nand_check_erased_ecc_chunk(p, eccsize,
+							   ecc_code, eccbytes,
+							   NULL, 0,
+							   eccstrength);
+
+		if (stat < 0) {
+			mtd->ecc_stats.failed++;
+		} else {
+			mtd->ecc_stats.corrected += stat;
+			max_bitflips = max_t(unsigned int, max_bitflips, stat);
+		}
+	}
+
+	/* Read oob */
+	if (oob_required) {
+		ret = nand_change_read_column_op(chip, mtd->writesize,
+						 chip->oob_poi, mtd->oobsize,
+						 false);
+		if (ret)
+			return ret;
+	}
+
+	return max_bitflips;
+}
+
 /* Sequencer read/write configuration */
 static void stm32_fmc2_rw_page_init(struct nand_chip *chip, int page,
 				    int raw, bool write_data)
@@ -804,7 +1046,12 @@ static irqreturn_t stm32_fmc2_irq(int irq, void *dev_id)
 {
 	struct stm32_fmc2 *fmc2 = (struct stm32_fmc2 *)dev_id;
 
-	stm32_fmc2_disable_seq_irq(fmc2);
+	if (fmc2->irq_state == FMC2_IRQ_SEQ)
+		/* Sequencer is used */
+		stm32_fmc2_disable_seq_irq(fmc2);
+	else if (fmc2->irq_state == FMC2_IRQ_BCH)
+		/* BCH is used */
+		stm32_fmc2_disable_bch_irq(fmc2);
 
 	complete(&fmc2->complete);
 
@@ -1280,35 +1527,27 @@ static int stm32_fmc2_dma_setup(struct stm32_fmc2 *fmc2)
 	fmc2->dma_rx_ch = dma_request_slave_channel(fmc2->dev, "rx");
 	fmc2->dma_ecc_ch = dma_request_slave_channel(fmc2->dev, "ecc");
 
-	if (fmc2->dma_ecc_ch) {
-		ret = sg_alloc_table(&fmc2->dma_ecc_sg, FMC2_MAX_SG,
-				     GFP_KERNEL);
-		if (ret)
-			return ret;
-
-		/* Allocate a buffer to store ecc status registers */
-		fmc2->ecc_buf = devm_kzalloc(fmc2->dev,
-					     FMC2_MAX_ECC_BUF_LEN,
-					     GFP_KERNEL);
-		if (!fmc2->ecc_buf)
-			return -ENOMEM;
-	} else {
-		dev_err(fmc2->dev, "ecc DMA not defined in the device tree\n");
-		return -ENOENT;
+	if (!fmc2->dma_tx_ch || !fmc2->dma_rx_ch || !fmc2->dma_ecc_ch) {
+		dev_warn(fmc2->dev, "DMAs not defined in the device tree, manual mode is used\n");
+		return 0;
 	}
 
-	if (fmc2->dma_tx_ch && fmc2->dma_rx_ch) {
-		ret = sg_alloc_table(&fmc2->dma_data_sg, FMC2_MAX_SG,
+	ret = sg_alloc_table(&fmc2->dma_ecc_sg, FMC2_MAX_SG, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	/* Allocate a buffer to store ecc status registers */
+	fmc2->ecc_buf = devm_kzalloc(fmc2->dev, FMC2_MAX_ECC_BUF_LEN,
 				     GFP_KERNEL);
-		if (ret)
-			return ret;
+	if (!fmc2->ecc_buf)
+		return -ENOMEM;
 
-		init_completion(&fmc2->dma_data_complete);
-		init_completion(&fmc2->dma_ecc_complete);
-	} else {
-		dev_err(fmc2->dev, "rx/tx DMA not defined in the device tree\n");
-		return -ENOENT;
-	}
+	ret = sg_alloc_table(&fmc2->dma_data_sg, FMC2_MAX_SG, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	init_completion(&fmc2->dma_data_complete);
+	init_completion(&fmc2->dma_ecc_complete);
 
 	return 0;
 }
@@ -1316,12 +1555,34 @@ static int stm32_fmc2_dma_setup(struct stm32_fmc2 *fmc2)
 /* NAND callbacks setup */
 static void stm32_fmc2_nand_callbacks_setup(struct nand_chip *chip)
 {
-	/* Specific callbacks to read/write a page */
-	chip->ecc.correct = stm32_fmc2_sequencer_correct;
-	chip->ecc.write_page = stm32_fmc2_sequencer_write_page;
-	chip->ecc.read_page = stm32_fmc2_sequencer_read_page;
-	chip->ecc.write_page_raw = stm32_fmc2_sequencer_write_page_raw;
-	chip->ecc.read_page_raw = stm32_fmc2_sequencer_read_page_raw;
+	struct stm32_fmc2 *fmc2 = nand_get_controller_data(chip);
+
+	/*
+	 * Specific callbacks to read/write a page depending on
+	 * the mode (manual/sequencer) and the algo used (Hamming, BCH).
+	 */
+	if (fmc2->dma_tx_ch && fmc2->dma_rx_ch && fmc2->dma_ecc_ch) {
+		/* DMA => use sequencer mode callbacks */
+		chip->ecc.correct = stm32_fmc2_sequencer_correct;
+		chip->ecc.write_page = stm32_fmc2_sequencer_write_page;
+		chip->ecc.read_page = stm32_fmc2_sequencer_read_page;
+		chip->ecc.write_page_raw = stm32_fmc2_sequencer_write_page_raw;
+		chip->ecc.read_page_raw = stm32_fmc2_sequencer_read_page_raw;
+	} else {
+		/* No DMA => use manual mode callbacks */
+		chip->ecc.hwctl = stm32_fmc2_hwctl;
+		if (chip->ecc.strength == FMC2_ECC_HAM) {
+			/* Hamming is used */
+			chip->ecc.calculate = stm32_fmc2_ham_calculate;
+			chip->ecc.correct = stm32_fmc2_ham_correct;
+			chip->ecc.options |= NAND_ECC_GENERIC_ERASED_CHECK;
+		} else {
+			/* BCH is used */
+			chip->ecc.calculate = stm32_fmc2_bch_calculate;
+			chip->ecc.correct = stm32_fmc2_bch_correct;
+			chip->ecc.read_page = stm32_fmc2_read_page;
+		}
+	}
 
 	/* Specific configurations depending on the algo used */
 	if (chip->ecc.strength == FMC2_ECC_HAM)
-- 
1.9.1

