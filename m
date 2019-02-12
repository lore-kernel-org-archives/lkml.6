Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E25C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3E62186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="p7WLI738"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfBLHPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:15:06 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:38279 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBLHPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:15:04 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x1C7DPdW019269;
        Tue, 12 Feb 2019 16:13:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x1C7DPdW019269
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549955613;
        bh=ATDUB4CCbbUxonof29OSwvyuYnv94PssJs+AQLLfess=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p7WLI738sVSbfgHC/3MFU4aN/sqP1h2OsnLTghCHIyLRWRoWeSkD8yjGrrfkvcPfo
         C5wTp3ZCPQCr1DC9W4P/a5S9OzUWgVcWpAjmLDVmSovOnHaomtdoXM7JOND97aqdNS
         5GqvCHo2EvAsjORmBQWjSPA1S9H9ZoyG430gFgCaCcpYO8Yfok2jHHsRnUtsfxFEp8
         Q5GPuY96iGAHKOfhM2IuTxhbRDrzfC42+dBVth+6u+cdt2wQQyhk0KjR27YmRlS2T6
         YtXfIZfe4PfHd7COj+McxhcJcls311nWlkGbn1iFUF7EU+TR4gtc8ltLWPRpfcjf4H
         WtW1MJdc26RYQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 08/10] mtd: rawnand: denali: decouple controller and NAND chips
Date:   Tue, 12 Feb 2019 16:13:00 +0900
Message-Id: <1549955582-30346-9-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549955582-30346-1-git-send-email-yamada.masahiro@socionext.com>
References: <1549955582-30346-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, this driver sticks to the legacy NAND model because it was
upstreamed before commit 2d472aba15ff ("mtd: nand: document the NAND
controller/NAND chip DT representation"). However, relying on the
dummy_controller is already deprecated.

Switch over to the new controller/chip representation.

The struct denali_nand_info has been split into denali_controller
and denali_chip, to contain the controller data, per-chip data,
respectively.

One problem is, this commit changes the DT binding. So, as always,
the backward compatibility must be taken into consideration.

In the new binding, the controller node expects

  #address-cells = <1>;
  #size-cells = <0>;

... since the child nodes represent NAND chips.

In the old binding, the controller node may have subnodes, but they
are MTD partitions.

The denali_dt_is_legacy_binding() exploits it to distinguish old/new
platforms.

Going forward, the old binding is only allowed for existing DT files.
I updated the binding document.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 .../devicetree/bindings/mtd/denali-nand.txt        |  39 +-
 drivers/mtd/nand/raw/denali.c                      | 453 ++++++++++++---------
 drivers/mtd/nand/raw/denali.h                      | 117 +++++-
 drivers/mtd/nand/raw/denali_dt.c                   |  98 ++++-
 drivers/mtd/nand/raw/denali_pci.c                  |  30 +-
 5 files changed, 500 insertions(+), 237 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/denali-nand.txt b/Documentation/devicetree/bindings/mtd/denali-nand.txt
index f33da87..de4ddff 100644
--- a/Documentation/devicetree/bindings/mtd/denali-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/denali-nand.txt
@@ -7,34 +7,47 @@ Required properties:
       "socionext,uniphier-denali-nand-v5b"  - for Socionext UniPhier (v5b)
   - reg : should contain registers location and length for data and reg.
   - reg-names: Should contain the reg names "nand_data" and "denali_reg"
+  - #address-cells: should be 1. The cell encodes the chip select connection.
+  - #size-cells : should be 0.
   - interrupts : The interrupt number.
   - clocks: should contain phandle of the controller core clock, the bus
     interface clock, and the ECC circuit clock.
   - clock-names: should contain "nand", "nand_x", "ecc"
 
-Optional properties:
-  - nand-ecc-step-size: see nand.txt for details.  If present, the value must be
-      512        for "altr,socfpga-denali-nand"
-      1024       for "socionext,uniphier-denali-nand-v5a"
-      1024       for "socionext,uniphier-denali-nand-v5b"
-  - nand-ecc-strength: see nand.txt for details.  Valid values are:
-      8, 15      for "altr,socfpga-denali-nand"
-      8, 16, 24  for "socionext,uniphier-denali-nand-v5a"
-      8, 16      for "socionext,uniphier-denali-nand-v5b"
-  - nand-ecc-maximize: see nand.txt for details
-
-The device tree may optionally contain sub-nodes describing partitions of the
+Sub-nodes:
+  Sub-nodes represent available NAND chips.
+
+  Required properties:
+    - reg: should contain the bank ID of the controller to which each chip
+      select is connected.
+
+  Optional properties:
+    - nand-ecc-step-size: see nand.txt for details.  If present, the value must be
+        512        for "altr,socfpga-denali-nand"
+        1024       for "socionext,uniphier-denali-nand-v5a"
+        1024       for "socionext,uniphier-denali-nand-v5b"
+    - nand-ecc-strength: see nand.txt for details.  Valid values are:
+        8, 15      for "altr,socfpga-denali-nand"
+        8, 16, 24  for "socionext,uniphier-denali-nand-v5a"
+        8, 16      for "socionext,uniphier-denali-nand-v5b"
+    - nand-ecc-maximize: see nand.txt for details
+
+The chip nodes may optionally contain sub-nodes describing partitions of the
 address space. See partition.txt for more detail.
 
 Examples:
 
 nand: nand@ff900000 {
 	#address-cells = <1>;
-	#size-cells = <1>;
+	#size-cells = <0>;
 	compatible = "altr,socfpga-denali-nand";
 	reg = <0xff900000 0x20>, <0xffb80000 0x1000>;
 	reg-names = "nand_data", "denali_reg";
 	clocks = <&nand_clk>, <&nand_x_clk>, <&nand_ecc_clk>;
 	clock-names = "nand", "nand_x", "ecc";
 	interrupts = <0 144 4>;
+
+	nand@0 {
+		reg = <0>;
+	}
 };
diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index f539731..a162bd1 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -3,7 +3,7 @@
  * NAND Flash Controller Device Driver
  * Copyright © 2009-2010, Intel Corporation and its suppliers.
  *
- * Copyright (c) 2017 Socionext Inc.
+ * Copyright (c) 2017-2019 Socionext Inc.
  *   Reworked by Masahiro Yamada <yamada.masahiro@socionext.com>
  */
 
@@ -42,14 +42,15 @@
 #define DENALI_INVALID_BANK	-1
 #define DENALI_NR_BANKS		4
 
-static inline struct denali_nand_info *mtd_to_denali(struct mtd_info *mtd)
+static struct denali_chip *to_denali_chip(struct nand_chip *chip)
 {
-	return container_of(mtd_to_nand(mtd), struct denali_nand_info, nand);
+	return container_of(chip, struct denali_chip, chip);
 }
 
-static struct denali_nand_info *to_denali(struct nand_chip *chip)
+static struct denali_controller *to_denali_controller(struct nand_chip *chip)
 {
-	return container_of(chip, struct denali_nand_info, nand);
+	return container_of(chip->controller, struct denali_controller,
+			    controller);
 }
 
 /*
@@ -57,12 +58,12 @@ static struct denali_nand_info *to_denali(struct nand_chip *chip)
  * type, bank, block, and page address).  The slave data is the actual data to
  * be transferred.  This mode requires 28 bits of address region allocated.
  */
-static u32 denali_direct_read(struct denali_nand_info *denali, u32 addr)
+static u32 denali_direct_read(struct denali_controller *denali, u32 addr)
 {
 	return ioread32(denali->host + addr);
 }
 
-static void denali_direct_write(struct denali_nand_info *denali, u32 addr,
+static void denali_direct_write(struct denali_controller *denali, u32 addr,
 				u32 data)
 {
 	iowrite32(data, denali->host + addr);
@@ -74,35 +75,20 @@ static void denali_direct_write(struct denali_nand_info *denali, u32 addr,
  * control information and transferred data are latched by the registers in
  * the translation module.
  */
-static u32 denali_indexed_read(struct denali_nand_info *denali, u32 addr)
+static u32 denali_indexed_read(struct denali_controller *denali, u32 addr)
 {
 	iowrite32(addr, denali->host + DENALI_INDEXED_CTRL);
 	return ioread32(denali->host + DENALI_INDEXED_DATA);
 }
 
-static void denali_indexed_write(struct denali_nand_info *denali, u32 addr,
+static void denali_indexed_write(struct denali_controller *denali, u32 addr,
 				 u32 data)
 {
 	iowrite32(addr, denali->host + DENALI_INDEXED_CTRL);
 	iowrite32(data, denali->host + DENALI_INDEXED_DATA);
 }
 
-/*
- * Use the configuration feature register to determine the maximum number of
- * banks that the hardware supports.
- */
-static void denali_detect_max_banks(struct denali_nand_info *denali)
-{
-	uint32_t features = ioread32(denali->reg + FEATURES);
-
-	denali->max_banks = 1 << FIELD_GET(FEATURES__N_BANKS, features);
-
-	/* the encoding changed from rev 5.0 to 5.1 */
-	if (denali->revision < 0x0501)
-		denali->max_banks <<= 1;
-}
-
-static void denali_enable_irq(struct denali_nand_info *denali)
+static void denali_enable_irq(struct denali_controller *denali)
 {
 	int i;
 
@@ -111,7 +97,7 @@ static void denali_enable_irq(struct denali_nand_info *denali)
 	iowrite32(GLOBAL_INT_EN_FLAG, denali->reg + GLOBAL_INT_ENABLE);
 }
 
-static void denali_disable_irq(struct denali_nand_info *denali)
+static void denali_disable_irq(struct denali_controller *denali)
 {
 	int i;
 
@@ -120,14 +106,14 @@ static void denali_disable_irq(struct denali_nand_info *denali)
 	iowrite32(0, denali->reg + GLOBAL_INT_ENABLE);
 }
 
-static void denali_clear_irq(struct denali_nand_info *denali,
+static void denali_clear_irq(struct denali_controller *denali,
 			     int bank, uint32_t irq_status)
 {
 	/* write one to clear bits */
 	iowrite32(irq_status, denali->reg + INTR_STATUS(bank));
 }
 
-static void denali_clear_irq_all(struct denali_nand_info *denali)
+static void denali_clear_irq_all(struct denali_controller *denali)
 {
 	int i;
 
@@ -137,7 +123,7 @@ static void denali_clear_irq_all(struct denali_nand_info *denali)
 
 static irqreturn_t denali_isr(int irq, void *dev_id)
 {
-	struct denali_nand_info *denali = dev_id;
+	struct denali_controller *denali = dev_id;
 	irqreturn_t ret = IRQ_NONE;
 	uint32_t irq_status;
 	int i;
@@ -165,7 +151,7 @@ static irqreturn_t denali_isr(int irq, void *dev_id)
 	return ret;
 }
 
-static void denali_reset_irq(struct denali_nand_info *denali)
+static void denali_reset_irq(struct denali_controller *denali)
 {
 	unsigned long flags;
 
@@ -175,8 +161,8 @@ static void denali_reset_irq(struct denali_nand_info *denali)
 	spin_unlock_irqrestore(&denali->irq_lock, flags);
 }
 
-static uint32_t denali_wait_for_irq(struct denali_nand_info *denali,
-				    u32 irq_mask, unsigned int timeout_ms)
+static u32 denali_wait_for_irq(struct denali_controller *denali, u32 irq_mask,
+			       unsigned int timeout_ms)
 {
 	unsigned long time_left, flags;
 	uint32_t irq_status;
@@ -211,13 +197,45 @@ static uint32_t denali_wait_for_irq(struct denali_nand_info *denali,
 
 static void denali_select_target(struct nand_chip *chip, int cs)
 {
-	struct denali_nand_info *denali = to_denali(chip);
+	struct denali_controller *denali = to_denali_controller(chip);
+	struct denali_chip_sel *sel = &to_denali_chip(chip)->sels[cs];
+	struct mtd_info *mtd = nand_to_mtd(chip);
 
-	denali->active_bank = cs;
+	denali->active_bank = sel->bank;
+
+	iowrite32(1 << (chip->phys_erase_shift - chip->page_shift),
+		  denali->reg + PAGES_PER_BLOCK);
+	iowrite32(chip->options & NAND_BUSWIDTH_16 ? 1 : 0,
+		  denali->reg + DEVICE_WIDTH);
+	iowrite32(mtd->writesize, denali->reg + DEVICE_MAIN_AREA_SIZE);
+	iowrite32(mtd->oobsize, denali->reg + DEVICE_SPARE_AREA_SIZE);
+	iowrite32(chip->options & NAND_ROW_ADDR_3 ?
+		  0 : TWO_ROW_ADDR_CYCLES__FLAG,
+		  denali->reg + TWO_ROW_ADDR_CYCLES);
+	iowrite32(FIELD_PREP(ECC_CORRECTION__ERASE_THRESHOLD, 1) |
+		  FIELD_PREP(ECC_CORRECTION__VALUE, chip->ecc.strength),
+		  denali->reg + ECC_CORRECTION);
+	iowrite32(chip->ecc.size, denali->reg + CFG_DATA_BLOCK_SIZE);
+	iowrite32(chip->ecc.size, denali->reg + CFG_LAST_DATA_BLOCK_SIZE);
+	iowrite32(chip->ecc.steps, denali->reg + CFG_NUM_DATA_BLOCKS);
+
+	if (chip->options & NAND_KEEP_TIMINGS)
+		return;
+
+	/* update timing registers unless NAND_KEEP_TIMINGS is set */
+	iowrite32(sel->hwhr2_and_we_2_re, denali->reg + TWHR2_AND_WE_2_RE);
+	iowrite32(sel->tcwaw_and_addr_2_data,
+		  denali->reg + TCWAW_AND_ADDR_2_DATA);
+	iowrite32(sel->re_2_we, denali->reg + RE_2_WE);
+	iowrite32(sel->acc_clks, denali->reg + ACC_CLKS);
+	iowrite32(sel->rdwr_en_lo_cnt, denali->reg + RDWR_EN_LO_CNT);
+	iowrite32(sel->rdwr_en_hi_cnt, denali->reg + RDWR_EN_HI_CNT);
+	iowrite32(sel->cs_setup_cnt, denali->reg + CS_SETUP_CNT);
+	iowrite32(sel->re_2_re, denali->reg + RE_2_RE);
 }
 
 static int denali_check_erased_page(struct nand_chip *chip,
-				    struct denali_nand_info *denali, u8 *buf,
+				    struct denali_controller *denali, u8 *buf,
 				    unsigned long uncor_ecc_flags,
 				    unsigned int max_bitflips)
 {
@@ -251,7 +269,7 @@ static int denali_check_erased_page(struct nand_chip *chip,
 }
 
 static int denali_hw_ecc_fixup(struct nand_chip *chip,
-			       struct denali_nand_info *denali,
+			       struct denali_controller *denali,
 			       unsigned long *uncor_ecc_flags)
 {
 	struct mtd_ecc_stats *ecc_stats = &nand_to_mtd(chip)->ecc_stats;
@@ -286,7 +304,7 @@ static int denali_hw_ecc_fixup(struct nand_chip *chip,
 }
 
 static int denali_sw_ecc_fixup(struct nand_chip *chip,
-			       struct denali_nand_info *denali,
+			       struct denali_controller *denali,
 			       unsigned long *uncor_ecc_flags, uint8_t *buf)
 {
 	struct mtd_ecc_stats *ecc_stats = &nand_to_mtd(chip)->ecc_stats;
@@ -359,7 +377,7 @@ static int denali_sw_ecc_fixup(struct nand_chip *chip,
 	return max_bitflips;
 }
 
-static void denali_setup_dma64(struct denali_nand_info *denali,
+static void denali_setup_dma64(struct denali_controller *denali,
 			       dma_addr_t dma_addr, int page, bool write)
 {
 	uint32_t mode;
@@ -384,7 +402,7 @@ static void denali_setup_dma64(struct denali_nand_info *denali,
 	denali->host_write(denali, mode, upper_32_bits(dma_addr));
 }
 
-static void denali_setup_dma32(struct denali_nand_info *denali,
+static void denali_setup_dma32(struct denali_controller *denali,
 			       dma_addr_t dma_addr, int page, bool write)
 {
 	uint32_t mode;
@@ -408,7 +426,7 @@ static void denali_setup_dma32(struct denali_nand_info *denali,
 	denali->host_write(denali, mode | 0x14000, 0x2400);
 }
 
-static int denali_pio_read(struct denali_nand_info *denali, u32 *buf,
+static int denali_pio_read(struct denali_controller *denali, u32 *buf,
 			   size_t size, int page)
 {
 	u32 addr = DENALI_MAP01 | DENALI_BANK(denali) | page;
@@ -435,7 +453,7 @@ static int denali_pio_read(struct denali_nand_info *denali, u32 *buf,
 	return irq_status & ecc_err_mask ? -EBADMSG : 0;
 }
 
-static int denali_pio_write(struct denali_nand_info *denali, const u32 *buf,
+static int denali_pio_write(struct denali_controller *denali, const u32 *buf,
 			    size_t size, int page)
 {
 	u32 addr = DENALI_MAP01 | DENALI_BANK(denali) | page;
@@ -457,7 +475,7 @@ static int denali_pio_write(struct denali_nand_info *denali, const u32 *buf,
 	return 0;
 }
 
-static int denali_pio_xfer(struct denali_nand_info *denali, void *buf,
+static int denali_pio_xfer(struct denali_controller *denali, void *buf,
 			   size_t size, int page, bool write)
 {
 	if (write)
@@ -466,7 +484,7 @@ static int denali_pio_xfer(struct denali_nand_info *denali, void *buf,
 		return denali_pio_read(denali, buf, size, page);
 }
 
-static int denali_dma_xfer(struct denali_nand_info *denali, void *buf,
+static int denali_dma_xfer(struct denali_controller *denali, void *buf,
 			   size_t size, int page, bool write)
 {
 	dma_addr_t dma_addr;
@@ -526,7 +544,7 @@ static int denali_dma_xfer(struct denali_nand_info *denali, void *buf,
 static int denali_data_xfer(struct nand_chip *chip, void *buf, size_t size,
 			    int page, bool raw, bool write)
 {
-	struct denali_nand_info *denali = to_denali(chip);
+	struct denali_controller *denali = to_denali_controller(chip);
 
 	denali_select_target(chip, chip->cur_cs);
 
@@ -546,7 +564,7 @@ typedef int denali_change_column_callback(void *buf, unsigned int offset,
 static int denali_raw_payload_op(struct nand_chip *chip, void *buf,
 				 denali_change_column_callback *cb, void *priv)
 {
-	struct denali_nand_info *denali = to_denali(chip);
+	struct denali_controller *denali = to_denali_controller(chip);
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int writesize = mtd->writesize;
@@ -583,7 +601,7 @@ static int denali_raw_payload_op(struct nand_chip *chip, void *buf,
 static int denali_raw_oob_op(struct nand_chip *chip, void *buf,
 			     denali_change_column_callback *cb, void *priv)
 {
-	struct denali_nand_info *denali = to_denali(chip);
+	struct denali_controller *denali = to_denali_controller(chip);
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int writesize = mtd->writesize;
@@ -640,9 +658,9 @@ static int denali_memcpy_in(void *buf, unsigned int offset, unsigned int len,
 static int denali_read_page_raw(struct nand_chip *chip, uint8_t *buf,
 				int oob_required, int page)
 {
-	struct denali_nand_info *denali = to_denali(chip);
+	struct denali_chip *dchip = to_denali_chip(chip);
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	void *tmp_buf = denali->buf;
+	void *tmp_buf = dchip->buf;
 	size_t size = mtd->writesize + mtd->oobsize;
 	int ret;
 
@@ -677,9 +695,9 @@ static int denali_memcpy_out(void *buf, unsigned int offset, unsigned int len,
 static int denali_write_page_raw(struct nand_chip *chip, const uint8_t *buf,
 				 int oob_required, int page)
 {
-	struct denali_nand_info *denali = to_denali(chip);
+	struct denali_chip *dchip = to_denali_chip(chip);
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	void *tmp_buf = denali->buf;
+	void *tmp_buf = dchip->buf;
 	size_t size = mtd->writesize + mtd->oobsize;
 	int ret;
 
@@ -751,8 +769,8 @@ static int denali_write_oob(struct nand_chip *chip, int page)
 static int denali_read_page(struct nand_chip *chip, uint8_t *buf,
 			    int oob_required, int page)
 {
+	struct denali_controller *denali = to_denali_controller(chip);
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
 	unsigned long uncor_ecc_flags = 0;
 	int stat = 0;
 	int ret;
@@ -793,7 +811,8 @@ static int denali_write_page(struct nand_chip *chip, const uint8_t *buf,
 static int denali_setup_data_interface(struct nand_chip *chip, int chipnr,
 				       const struct nand_data_interface *conf)
 {
-	struct denali_nand_info *denali = mtd_to_denali(nand_to_mtd(chip));
+	struct denali_controller *denali = to_denali_controller(chip);
+	struct denali_chip_sel *sel;
 	const struct nand_sdr_timings *timings;
 	unsigned long t_x, mult_x;
 	int acc_clks, re_2_we, re_2_re, we_2_re, addr_2_data;
@@ -822,6 +841,8 @@ static int denali_setup_data_interface(struct nand_chip *chip, int chipnr,
 	if (chipnr == NAND_DATA_IFACE_CHECK_ONLY)
 		return 0;
 
+	sel = &to_denali_chip(chip)->sels[chipnr];
+
 	/* tREA -> ACC_CLKS */
 	acc_clks = DIV_ROUND_UP(timings->tREA_max, t_x);
 	acc_clks = min_t(int, acc_clks, ACC_CLKS__VALUE);
@@ -829,7 +850,7 @@ static int denali_setup_data_interface(struct nand_chip *chip, int chipnr,
 	tmp = ioread32(denali->reg + ACC_CLKS);
 	tmp &= ~ACC_CLKS__VALUE;
 	tmp |= FIELD_PREP(ACC_CLKS__VALUE, acc_clks);
-	iowrite32(tmp, denali->reg + ACC_CLKS);
+	sel->acc_clks = tmp;
 
 	/* tRWH -> RE_2_WE */
 	re_2_we = DIV_ROUND_UP(timings->tRHW_min, t_x);
@@ -838,7 +859,7 @@ static int denali_setup_data_interface(struct nand_chip *chip, int chipnr,
 	tmp = ioread32(denali->reg + RE_2_WE);
 	tmp &= ~RE_2_WE__VALUE;
 	tmp |= FIELD_PREP(RE_2_WE__VALUE, re_2_we);
-	iowrite32(tmp, denali->reg + RE_2_WE);
+	sel->re_2_we = tmp;
 
 	/* tRHZ -> RE_2_RE */
 	re_2_re = DIV_ROUND_UP(timings->tRHZ_max, t_x);
@@ -847,7 +868,7 @@ static int denali_setup_data_interface(struct nand_chip *chip, int chipnr,
 	tmp = ioread32(denali->reg + RE_2_RE);
 	tmp &= ~RE_2_RE__VALUE;
 	tmp |= FIELD_PREP(RE_2_RE__VALUE, re_2_re);
-	iowrite32(tmp, denali->reg + RE_2_RE);
+	sel->re_2_re = tmp;
 
 	/*
 	 * tCCS, tWHR -> WE_2_RE
@@ -861,7 +882,7 @@ static int denali_setup_data_interface(struct nand_chip *chip, int chipnr,
 	tmp = ioread32(denali->reg + TWHR2_AND_WE_2_RE);
 	tmp &= ~TWHR2_AND_WE_2_RE__WE_2_RE;
 	tmp |= FIELD_PREP(TWHR2_AND_WE_2_RE__WE_2_RE, we_2_re);
-	iowrite32(tmp, denali->reg + TWHR2_AND_WE_2_RE);
+	sel->hwhr2_and_we_2_re = tmp;
 
 	/* tADL -> ADDR_2_DATA */
 
@@ -876,7 +897,7 @@ static int denali_setup_data_interface(struct nand_chip *chip, int chipnr,
 	tmp = ioread32(denali->reg + TCWAW_AND_ADDR_2_DATA);
 	tmp &= ~TCWAW_AND_ADDR_2_DATA__ADDR_2_DATA;
 	tmp |= FIELD_PREP(TCWAW_AND_ADDR_2_DATA__ADDR_2_DATA, addr_2_data);
-	iowrite32(tmp, denali->reg + TCWAW_AND_ADDR_2_DATA);
+	sel->tcwaw_and_addr_2_data = tmp;
 
 	/* tREH, tWH -> RDWR_EN_HI_CNT */
 	rdwr_en_hi = DIV_ROUND_UP(max(timings->tREH_min, timings->tWH_min),
@@ -886,7 +907,7 @@ static int denali_setup_data_interface(struct nand_chip *chip, int chipnr,
 	tmp = ioread32(denali->reg + RDWR_EN_HI_CNT);
 	tmp &= ~RDWR_EN_HI_CNT__VALUE;
 	tmp |= FIELD_PREP(RDWR_EN_HI_CNT__VALUE, rdwr_en_hi);
-	iowrite32(tmp, denali->reg + RDWR_EN_HI_CNT);
+	sel->rdwr_en_hi_cnt = tmp;
 
 	/* tRP, tWP -> RDWR_EN_LO_CNT */
 	rdwr_en_lo = DIV_ROUND_UP(max(timings->tRP_min, timings->tWP_min), t_x);
@@ -899,7 +920,7 @@ static int denali_setup_data_interface(struct nand_chip *chip, int chipnr,
 	tmp = ioread32(denali->reg + RDWR_EN_LO_CNT);
 	tmp &= ~RDWR_EN_LO_CNT__VALUE;
 	tmp |= FIELD_PREP(RDWR_EN_LO_CNT__VALUE, rdwr_en_lo);
-	iowrite32(tmp, denali->reg + RDWR_EN_LO_CNT);
+	sel->rdwr_en_lo_cnt = tmp;
 
 	/* tCS, tCEA -> CS_SETUP_CNT */
 	cs_setup = max3((int)DIV_ROUND_UP(timings->tCS_min, t_x) - rdwr_en_lo,
@@ -910,39 +931,11 @@ static int denali_setup_data_interface(struct nand_chip *chip, int chipnr,
 	tmp = ioread32(denali->reg + CS_SETUP_CNT);
 	tmp &= ~CS_SETUP_CNT__VALUE;
 	tmp |= FIELD_PREP(CS_SETUP_CNT__VALUE, cs_setup);
-	iowrite32(tmp, denali->reg + CS_SETUP_CNT);
+	sel->cs_setup_cnt = tmp;
 
 	return 0;
 }
 
-static void denali_hw_init(struct denali_nand_info *denali)
-{
-	/*
-	 * The REVISION register may not be reliable.  Platforms are allowed to
-	 * override it.
-	 */
-	if (!denali->revision)
-		denali->revision = swab16(ioread32(denali->reg + REVISION));
-
-	/*
-	 * Set how many bytes should be skipped before writing data in OOB.
-	 * If a non-zero value has already been set (by firmware or something),
-	 * just use it.  Otherwise, set the driver default.
-	 */
-	denali->oob_skip_bytes = ioread32(denali->reg + SPARE_AREA_SKIP_BYTES);
-	if (!denali->oob_skip_bytes) {
-		denali->oob_skip_bytes = DENALI_DEFAULT_OOB_SKIP_BYTES;
-		iowrite32(denali->oob_skip_bytes,
-			  denali->reg + SPARE_AREA_SKIP_BYTES);
-	}
-
-	denali_detect_max_banks(denali);
-	iowrite32(0x0F, denali->reg + RB_PIN_ENABLED);
-	iowrite32(CHIP_EN_DONT_CARE__FLAG, denali->reg + CHIP_ENABLE_DONT_CARE);
-
-	iowrite32(0xffff, denali->reg + SPARE_AREA_MARKER);
-}
-
 int denali_calc_ecc_bytes(int step_size, int strength)
 {
 	/* BCH code.  Denali requires ecc.bytes to be multiple of 2 */
@@ -953,10 +946,10 @@ EXPORT_SYMBOL(denali_calc_ecc_bytes);
 static int denali_ooblayout_ecc(struct mtd_info *mtd, int section,
 				struct mtd_oob_region *oobregion)
 {
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
 	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct denali_controller *denali = to_denali_controller(chip);
 
-	if (section)
+	if (section > 0)
 		return -ERANGE;
 
 	oobregion->offset = denali->oob_skip_bytes;
@@ -968,10 +961,10 @@ static int denali_ooblayout_ecc(struct mtd_info *mtd, int section,
 static int denali_ooblayout_free(struct mtd_info *mtd, int section,
 				 struct mtd_oob_region *oobregion)
 {
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
 	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct denali_controller *denali = to_denali_controller(chip);
 
-	if (section)
+	if (section > 0)
 		return -ERANGE;
 
 	oobregion->offset = chip->ecc.total + denali->oob_skip_bytes;
@@ -987,7 +980,7 @@ static const struct mtd_ooblayout_ops denali_ooblayout_ops = {
 
 static int denali_multidev_fixup(struct nand_chip *chip)
 {
-	struct denali_nand_info *denali = to_denali(chip);
+	struct denali_controller *denali = to_denali_controller(chip);
 	struct mtd_info *mtd = nand_to_mtd(chip);
 
 	/*
@@ -1038,38 +1031,11 @@ static int denali_multidev_fixup(struct nand_chip *chip)
 
 static int denali_attach_chip(struct nand_chip *chip)
 {
+	struct denali_controller *denali = to_denali_controller(chip);
+	struct denali_chip *dchip = to_denali_chip(chip);
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
 	int ret;
 
-	if (ioread32(denali->reg + FEATURES) & FEATURES__DMA)
-		denali->dma_avail = true;
-
-	if (denali->dma_avail) {
-		int dma_bit = denali->caps & DENALI_CAP_DMA_64BIT ? 64 : 32;
-
-		ret = dma_set_mask(denali->dev, DMA_BIT_MASK(dma_bit));
-		if (ret) {
-			dev_info(denali->dev,
-				 "Failed to set DMA mask. Disabling DMA.\n");
-			denali->dma_avail = false;
-		}
-	}
-
-	if (denali->dma_avail) {
-		chip->options |= NAND_USE_BOUNCE_BUFFER;
-		chip->buf_align = 16;
-		if (denali->caps & DENALI_CAP_DMA_64BIT)
-			denali->setup_dma = denali_setup_dma64;
-		else
-			denali->setup_dma = denali_setup_dma32;
-	}
-
-	chip->bbt_options |= NAND_BBT_USE_FLASH;
-	chip->bbt_options |= NAND_BBT_NO_OOB;
-	chip->ecc.mode = NAND_ECC_HW_SYNDROME;
-	chip->options |= NAND_NO_SUBPAGE_WRITE;
-
 	ret = nand_ecc_choose_conf(chip, denali->ecc_caps,
 				   mtd->oobsize - denali->oob_skip_bytes);
 	if (ret) {
@@ -1081,33 +1047,6 @@ static int denali_attach_chip(struct nand_chip *chip)
 		"chosen ECC settings: step=%d, strength=%d, bytes=%d\n",
 		chip->ecc.size, chip->ecc.strength, chip->ecc.bytes);
 
-	iowrite32(FIELD_PREP(ECC_CORRECTION__ERASE_THRESHOLD, 1) |
-		  FIELD_PREP(ECC_CORRECTION__VALUE, chip->ecc.strength),
-		  denali->reg + ECC_CORRECTION);
-	iowrite32(mtd->erasesize / mtd->writesize,
-		  denali->reg + PAGES_PER_BLOCK);
-	iowrite32(chip->options & NAND_BUSWIDTH_16 ? 1 : 0,
-		  denali->reg + DEVICE_WIDTH);
-	iowrite32(chip->options & NAND_ROW_ADDR_3 ? 0 : TWO_ROW_ADDR_CYCLES__FLAG,
-		  denali->reg + TWO_ROW_ADDR_CYCLES);
-	iowrite32(mtd->writesize, denali->reg + DEVICE_MAIN_AREA_SIZE);
-	iowrite32(mtd->oobsize, denali->reg + DEVICE_SPARE_AREA_SIZE);
-
-	iowrite32(chip->ecc.size, denali->reg + CFG_DATA_BLOCK_SIZE);
-	iowrite32(chip->ecc.size, denali->reg + CFG_LAST_DATA_BLOCK_SIZE);
-	/* chip->ecc.steps is set by nand_scan_tail(); not available here */
-	iowrite32(mtd->writesize / chip->ecc.size,
-		  denali->reg + CFG_NUM_DATA_BLOCKS);
-
-	mtd_set_ooblayout(mtd, &denali_ooblayout_ops);
-
-	chip->ecc.read_page = denali_read_page;
-	chip->ecc.read_page_raw = denali_read_page_raw;
-	chip->ecc.write_page = denali_write_page;
-	chip->ecc.write_page_raw = denali_write_page_raw;
-	chip->ecc.read_oob = denali_read_oob;
-	chip->ecc.write_oob = denali_write_oob;
-
 	ret = denali_multidev_fixup(chip);
 	if (ret)
 		return ret;
@@ -1117,8 +1056,8 @@ static int denali_attach_chip(struct nand_chip *chip)
 	 * use devm_kmalloc() because the memory allocated by devm_ does not
 	 * guarantee DMA-safe alignment.
 	 */
-	denali->buf = kmalloc(mtd->writesize + mtd->oobsize, GFP_KERNEL);
-	if (!denali->buf)
+	dchip->buf = kmalloc(mtd->writesize + mtd->oobsize, GFP_KERNEL);
+	if (!dchip->buf)
 		return -ENOMEM;
 
 	return 0;
@@ -1126,13 +1065,12 @@ static int denali_attach_chip(struct nand_chip *chip)
 
 static void denali_detach_chip(struct nand_chip *chip)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
+	struct denali_chip *dchip = to_denali_chip(chip);
 
-	kfree(denali->buf);
+	kfree(dchip->buf);
 }
 
-static void denali_exec_in8(struct denali_nand_info *denali, u32 type,
+static void denali_exec_in8(struct denali_controller *denali, u32 type,
 			    u8 *buf, unsigned int len)
 {
 	int i;
@@ -1141,7 +1079,7 @@ static void denali_exec_in8(struct denali_nand_info *denali, u32 type,
 		buf[i] = denali->host_read(denali, type | DENALI_BANK(denali));
 }
 
-static void denali_exec_in16(struct denali_nand_info *denali, u32 type,
+static void denali_exec_in16(struct denali_controller *denali, u32 type,
 			     u8 *buf, unsigned int len)
 {
 	u32 data;
@@ -1155,7 +1093,7 @@ static void denali_exec_in16(struct denali_nand_info *denali, u32 type,
 	}
 }
 
-static void denali_exec_out8(struct denali_nand_info *denali, u32 type,
+static void denali_exec_out8(struct denali_controller *denali, u32 type,
 			     const u8 *buf, unsigned int len)
 {
 	int i;
@@ -1164,7 +1102,7 @@ static void denali_exec_out8(struct denali_nand_info *denali, u32 type,
 		denali->host_write(denali, type | DENALI_BANK(denali), buf[i]);
 }
 
-static void denali_exec_out16(struct denali_nand_info *denali, u32 type,
+static void denali_exec_out16(struct denali_controller *denali, u32 type,
 			      const u8 *buf, unsigned int len)
 {
 	int i;
@@ -1174,7 +1112,7 @@ static void denali_exec_out16(struct denali_nand_info *denali, u32 type,
 				   buf[i + 1] << 16 | buf[i]);
 }
 
-static int denali_exec_waitrdy(struct denali_nand_info *denali,
+static int denali_exec_waitrdy(struct denali_controller *denali,
 			       unsigned int timeout_ms)
 {
 	u32 irq_stat;
@@ -1191,7 +1129,7 @@ static int denali_exec_waitrdy(struct denali_nand_info *denali,
 static int denali_exec_instr(struct nand_chip *chip,
 			     const struct nand_op_instr *instr)
 {
-	struct denali_nand_info *denali = to_denali(chip);
+	struct denali_controller *denali = to_denali_controller(chip);
 	bool width16 = chip->options & NAND_BUSWIDTH_16;
 
 	switch (instr->type) {
@@ -1243,7 +1181,7 @@ static int denali_exec_op(struct nand_chip *chip,
 	 * Some commands contain NAND_OP_WAITRDY_INSTR.
 	 * irq must be cleared here to catch the R/B# interrupt there.
 	 */
-	denali_reset_irq(to_denali(chip));
+	denali_reset_irq(to_denali_controller(chip));
 
 	for (i = 0; i < op->ninstrs; i++) {
 		ret = denali_exec_instr(chip, &op->instrs[i]);
@@ -1261,53 +1199,91 @@ static const struct nand_controller_ops denali_controller_ops = {
 	.setup_data_interface = denali_setup_data_interface,
 };
 
-int denali_init(struct denali_nand_info *denali)
+int denali_chip_init(struct denali_controller *denali,
+		     struct denali_chip *dchip)
 {
-	struct nand_chip *chip = &denali->nand;
+	struct nand_chip *chip = &dchip->chip;
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	u32 features = ioread32(denali->reg + FEATURES);
-	int ret;
+	struct denali_chip *dchip2;
+	unsigned int chip_cnt = 0;
+	int i, j, ret;
 
-	mtd->dev.parent = denali->dev;
-	denali_hw_init(denali);
+	chip->controller = &denali->controller;
 
-	init_completion(&denali->complete);
-	spin_lock_init(&denali->irq_lock);
+	/* sanity checks for bank numbers */
+	for (i = 0; i < dchip->nsels; i++) {
+		unsigned int bank = dchip->sels[i].bank;
 
-	denali_clear_irq_all(denali);
+		if (bank >= denali->nbanks) {
+			dev_err(denali->dev, "unsupported bank %d\n", bank);
+			return -EINVAL;
+		}
 
-	ret = devm_request_irq(denali->dev, denali->irq, denali_isr,
-			       IRQF_SHARED, DENALI_NAND_NAME, denali);
-	if (ret) {
-		dev_err(denali->dev, "Unable to request IRQ\n");
-		return ret;
-	}
+		for (j = 0; j < i; j++) {
+			if (bank == dchip->sels[j].bank) {
+				dev_err(denali->dev,
+					"bank %d is assigned twice in the same chip\n",
+					bank);
+				return -EINVAL;
+			}
+		}
 
-	denali_enable_irq(denali);
+		list_for_each_entry(dchip2, &denali->chips, node) {
+			chip_cnt++;
+			for (j = 0; j < dchip2->nsels; j++) {
+				if (bank == dchip2->sels[j].bank) {
+					dev_err(denali->dev,
+						"bank %d is already used\n",
+						bank);
+					return -EINVAL;
+				}
+			}
+		}
+	}
 
-	denali->active_bank = DENALI_INVALID_BANK;
+	mtd->dev.parent = denali->dev;
 
-	nand_set_flash_node(chip, denali->dev->of_node);
 	/* Fallback to the default name if DT did not give "label" property */
-	if (!mtd->name)
-		mtd->name = "denali-nand";
+	if (!mtd->name) {
+		if (chip_cnt) {
+			mtd->name = devm_kasprintf(denali->dev, GFP_KERNEL,
+						   "denali-nand%d", chip_cnt);
+			if (!mtd->name)
+				return -ENOMEM;
+		} else {
+			/*
+			 * "denali-nand" instead of "denali-nand0"
+			 * for backward compatibility
+			 */
+			mtd->name = "denali-nand";
+		}
+	}
 
-	if (features & FEATURES__INDEX_ADDR) {
-		denali->host_read = denali_indexed_read;
-		denali->host_write = denali_indexed_write;
-	} else {
-		denali->host_read = denali_direct_read;
-		denali->host_write = denali_direct_write;
+	if (denali->dma_avail) {
+		chip->options |= NAND_USE_BOUNCE_BUFFER;
+		chip->buf_align = 16;
 	}
 
 	/* clk rate info is needed for setup_data_interface */
 	if (!denali->clk_rate || !denali->clk_x_rate)
 		chip->options |= NAND_KEEP_TIMINGS;
 
-	chip->legacy.dummy_controller.ops = &denali_controller_ops;
-	ret = nand_scan(chip, denali->max_banks);
+	chip->bbt_options |= NAND_BBT_USE_FLASH;
+	chip->bbt_options |= NAND_BBT_NO_OOB;
+	chip->options |= NAND_NO_SUBPAGE_WRITE;
+	chip->ecc.mode = NAND_ECC_HW_SYNDROME;
+	chip->ecc.read_page = denali_read_page;
+	chip->ecc.write_page = denali_write_page;
+	chip->ecc.read_page_raw = denali_read_page_raw;
+	chip->ecc.write_page_raw = denali_write_page_raw;
+	chip->ecc.read_oob = denali_read_oob;
+	chip->ecc.write_oob = denali_write_oob;
+
+	mtd_set_ooblayout(mtd, &denali_ooblayout_ops);
+
+	ret = nand_scan(chip, dchip->nsels);
 	if (ret)
-		goto disable_irq;
+		return ret;
 
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret) {
@@ -1315,20 +1291,109 @@ int denali_init(struct denali_nand_info *denali)
 		goto cleanup_nand;
 	}
 
+	list_add_tail(&dchip->node, &denali->chips);
+
 	return 0;
 
 cleanup_nand:
 	nand_cleanup(chip);
-disable_irq:
-	denali_disable_irq(denali);
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(denali_chip_init);
+
+int denali_init(struct denali_controller *denali)
+{
+	u32 features = ioread32(denali->reg + FEATURES);
+	int ret;
+
+	nand_controller_init(&denali->controller);
+	denali->controller.ops = &denali_controller_ops;
+	init_completion(&denali->complete);
+	spin_lock_init(&denali->irq_lock);
+	INIT_LIST_HEAD(&denali->chips);
+	denali->active_bank = DENALI_INVALID_BANK;
+
+	/*
+	 * The REVISION register may not be reliable. Platforms are allowed to
+	 * override it.
+	 */
+	if (!denali->revision)
+		denali->revision = swab16(ioread32(denali->reg + REVISION));
+
+	denali->nbanks = 1 << FIELD_GET(FEATURES__N_BANKS, features);
+
+	/* the encoding changed from rev 5.0 to 5.1 */
+	if (denali->revision < 0x0501)
+		denali->nbanks <<= 1;
+
+	if (features & FEATURES__DMA)
+		denali->dma_avail = true;
+
+	if (denali->dma_avail) {
+		int dma_bit = denali->caps & DENALI_CAP_DMA_64BIT ? 64 : 32;
+
+		ret = dma_set_mask(denali->dev, DMA_BIT_MASK(dma_bit));
+		if (ret) {
+			dev_info(denali->dev,
+				 "Failed to set DMA mask. Disabling DMA.\n");
+			denali->dma_avail = false;
+		}
+	}
+
+	if (denali->dma_avail) {
+		if (denali->caps & DENALI_CAP_DMA_64BIT)
+			denali->setup_dma = denali_setup_dma64;
+		else
+			denali->setup_dma = denali_setup_dma32;
+	}
+
+	if (features & FEATURES__INDEX_ADDR) {
+		denali->host_read = denali_indexed_read;
+		denali->host_write = denali_indexed_write;
+	} else {
+		denali->host_read = denali_direct_read;
+		denali->host_write = denali_direct_write;
+	}
+
+	/*
+	 * Set how many bytes should be skipped before writing data in OOB.
+	 * If a non-zero value has already been set (by firmware or something),
+	 * just use it. Otherwise, set the driver's default.
+	 */
+	denali->oob_skip_bytes = ioread32(denali->reg + SPARE_AREA_SKIP_BYTES);
+	if (!denali->oob_skip_bytes) {
+		denali->oob_skip_bytes = DENALI_DEFAULT_OOB_SKIP_BYTES;
+		iowrite32(denali->oob_skip_bytes,
+			  denali->reg + SPARE_AREA_SKIP_BYTES);
+	}
+
+	iowrite32(GENMASK(denali->nbanks - 1, 0), denali->reg + RB_PIN_ENABLED);
+	iowrite32(CHIP_EN_DONT_CARE__FLAG, denali->reg + CHIP_ENABLE_DONT_CARE);
+	iowrite32(0xffff, denali->reg + SPARE_AREA_MARKER);
+
+	denali_clear_irq_all(denali);
+
+	ret = devm_request_irq(denali->dev, denali->irq, denali_isr,
+			       IRQF_SHARED, DENALI_NAND_NAME, denali);
+	if (ret) {
+		dev_err(denali->dev, "Unable to request IRQ\n");
+		return ret;
+	}
+
+	denali_enable_irq(denali);
+
+	return 0;
+}
 EXPORT_SYMBOL(denali_init);
 
-void denali_remove(struct denali_nand_info *denali)
+void denali_remove(struct denali_controller *denali)
 {
-	nand_release(&denali->nand);
+	struct denali_chip *dchip;
+
+	list_for_each_entry(dchip, &denali->chips, node)
+		nand_release(&dchip->chip);
+
 	denali_disable_irq(denali);
 }
 EXPORT_SYMBOL(denali_remove);
diff --git a/drivers/mtd/nand/raw/denali.h b/drivers/mtd/nand/raw/denali.h
index 8552b3f..138b239 100644
--- a/drivers/mtd/nand/raw/denali.h
+++ b/drivers/mtd/nand/raw/denali.h
@@ -9,6 +9,7 @@
 
 #include <linux/bits.h>
 #include <linux/completion.h>
+#include <linux/list.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/spinlock_types.h>
 #include <linux/types.h>
@@ -290,30 +291,100 @@
 #define     CHNL_ACTIVE__CHANNEL2			BIT(2)
 #define     CHNL_ACTIVE__CHANNEL3			BIT(3)
 
-struct denali_nand_info {
-	struct nand_chip nand;
-	unsigned long clk_rate;		/* core clock rate */
-	unsigned long clk_x_rate;	/* bus interface clock rate */
-	int active_bank;		/* currently selected bank */
+/**
+ * struct denali_chip_sel - per-CS data of Denali NAND
+ *
+ * @bank:                  bank id of the controller this CS is connected to
+ * @hwhr2_and_we_2_re:     value of timing register HWHR2_AND_WE_2_RE
+ * @tcwaw_and_addr_2_data: value of timing register TCWAW_AND_ADDR_2_DATA
+ * @re_2_we:               value of timing register RE_2_WE
+ * @acc_clks:              value of timing register ACC_CLKS
+ * @rdwr_en_lo_cnt:        value of timing register RDWR_EN_LO_CNT
+ * @rdwr_en_hi_cnt:        value of timing register RDWR_EN_HI_CNT
+ * @cs_setup_cnt:          value of timing register CS_SETUP_CNT
+ * @re_2_re:               value of timing register RE_2_RE
+ */
+struct denali_chip_sel {
+	int bank;
+	u32 hwhr2_and_we_2_re;
+	u32 tcwaw_and_addr_2_data;
+	u32 re_2_we;
+	u32 acc_clks;
+	u32 rdwr_en_lo_cnt;
+	u32 rdwr_en_hi_cnt;
+	u32 cs_setup_cnt;
+	u32 re_2_re;
+};
+
+/**
+ * struct denali_chip - per-chip data of Denali NAND
+ *
+ * @chip:  base NAND chip structure
+ * @buf:   internal buffer for syndrome layout conversion
+ * @node:  node to be used to associate this chip with the controller
+ * @nsels: the number of CS lines of this chip
+ * @sels:  the array of per-cs data
+ */
+struct denali_chip {
+	struct nand_chip chip;
+	void *buf;
+	struct list_head node;
+	unsigned int nsels;
+	struct denali_chip_sel sels[0];
+};
+
+/**
+ * struct denali_controller - Denali NAND controller data
+ *
+ * @controller:     base NAND controller structure
+ * @dev:            device
+ * @chips:          the list of chips attached to this controller
+ * @clk_rate:       frequency of core clock
+ * @clk_x_rate:     frequency of bus interface clock
+ * @reg:            base of Register Interface
+ * @host:           base of Host Data/Command interface
+ * @complete:       completion used to wait for interrupts
+ * @irq:            interrupt number
+ * @irq_mask:       interrupt bits the controller is waiting for
+ * @irq_status:     interrupt bits of events that have happened
+ * @irq_lock:       lock to protect @irq_mask and @irq_status
+ * @dma_avail:      set if DMA engine is available
+ * @devs_per_cs:    number of devices connected in parallel
+ * @oob_skip_bytes: number of bytes in OOB skipped by the ECC engine
+ * @active_bank:    active bank id
+ * @nbanks:         the number of banks supported by this controller
+ * @revision:       IP revision
+ * @caps:           controller capabilities that cannot be detected run-time
+ * @ecc_caps:       ECC engine capabilities
+ * @host_read:      callback for read access of Host Data/Command Interface
+ * @host_write:     callback for write access of Host Data/Command Interface
+ * @setup_dma:      callback for setup of the Data DMA
+ */
+struct denali_controller {
+	struct nand_controller controller;
 	struct device *dev;
-	void __iomem *reg;		/* Register Interface */
-	void __iomem *host;		/* Host Data/Command Interface */
+	struct list_head chips;
+	unsigned long clk_rate;
+	unsigned long clk_x_rate;
+	void __iomem *reg;
+	void __iomem *host;
 	struct completion complete;
-	spinlock_t irq_lock;		/* protect irq_mask and irq_status */
-	u32 irq_mask;			/* interrupts we are waiting for */
-	u32 irq_status;			/* interrupts that have happened */
 	int irq;
-	void *buf;			/* for syndrome layout conversion */
-	bool dma_avail;			/* can support DMA? */
-	int devs_per_cs;		/* devices connected in parallel */
-	int oob_skip_bytes;		/* number of bytes reserved for BBM */
-	int max_banks;
-	unsigned int revision;		/* IP revision */
-	unsigned int caps;		/* IP capability (or quirk) */
+	u32 irq_mask;
+	u32 irq_status;
+	spinlock_t irq_lock;
+	bool dma_avail;
+	int devs_per_cs;
+	int oob_skip_bytes;
+	int active_bank;
+	int nbanks;
+	unsigned int revision;
+	unsigned int caps;
 	const struct nand_ecc_caps *ecc_caps;
-	u32 (*host_read)(struct denali_nand_info *denali, u32 addr);
-	void (*host_write)(struct denali_nand_info *denali, u32 addr, u32 data);
-	void (*setup_dma)(struct denali_nand_info *denali, dma_addr_t dma_addr,
+	u32 (*host_read)(struct denali_controller *denali, u32 addr);
+	void (*host_write)(struct denali_controller *denali, u32 addr,
+			   u32 data);
+	void (*setup_dma)(struct denali_controller *denali, dma_addr_t dma_addr,
 			  int page, bool write);
 };
 
@@ -321,7 +392,9 @@ struct denali_nand_info {
 #define DENALI_CAP_DMA_64BIT			BIT(1)
 
 int denali_calc_ecc_bytes(int step_size, int strength);
-int denali_init(struct denali_nand_info *denali);
-void denali_remove(struct denali_nand_info *denali);
+int denali_chip_init(struct denali_controller *denali,
+		     struct denali_chip *dchip);
+int denali_init(struct denali_controller *denali);
+void denali_remove(struct denali_controller *denali);
 
 #endif /* __DENALI_H__ */
diff --git a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
index 0b5ae24..5e14836 100644
--- a/drivers/mtd/nand/raw/denali_dt.c
+++ b/drivers/mtd/nand/raw/denali_dt.c
@@ -18,7 +18,7 @@
 #include "denali.h"
 
 struct denali_dt {
-	struct denali_nand_info	denali;
+	struct denali_controller controller;
 	struct clk *clk;	/* core clock */
 	struct clk *clk_x;	/* bus interface clock */
 	struct clk *clk_ecc;	/* ECC circuit clock */
@@ -71,19 +71,92 @@ static const struct of_device_id denali_nand_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, denali_nand_dt_ids);
 
+static int denali_dt_chip_init(struct denali_controller *denali,
+			       struct device_node *chip_np)
+{
+	struct denali_chip *dchip;
+	u32 bank;
+	int nsels, i, ret;
+
+	nsels = of_property_count_u32_elems(chip_np, "reg");
+	if (nsels < 0)
+		return nsels;
+
+	dchip = devm_kzalloc(denali->dev, struct_size(dchip, sels, nsels),
+			     GFP_KERNEL);
+	if (!dchip)
+		return -ENOMEM;
+
+	dchip->nsels = nsels;
+
+	for (i = 0; i < nsels; i++) {
+		ret = of_property_read_u32_index(chip_np, "reg", i, &bank);
+		if (ret)
+			return ret;
+
+		dchip->sels[i].bank = bank;
+
+		nand_set_flash_node(&dchip->chip, chip_np);
+	}
+
+	return denali_chip_init(denali, dchip);
+}
+
+/* Backward compatibility for old platforms */
+static int denali_dt_legacy_chip_init(struct denali_controller *denali)
+{
+	struct denali_chip *dchip;
+	int nsels, i;
+
+	nsels = denali->nbanks;
+
+	dchip = devm_kzalloc(denali->dev, struct_size(dchip, sels, nsels),
+			     GFP_KERNEL);
+	if (!dchip)
+		return -ENOMEM;
+
+	dchip->nsels = nsels;
+
+	for (i = 0; i < nsels; i++)
+		dchip->sels[i].bank = i;
+
+	nand_set_flash_node(&dchip->chip, denali->dev->of_node);
+
+	return denali_chip_init(denali, dchip);
+}
+
+/*
+ * Check the DT binding.
+ * The new binding expects chip subnodes in the controller node.
+ * So, #address-cells = <1>; #size-cells = <0>; are required.
+ * Check the #size-cells to distinguish the binding.
+ */
+static bool denali_dt_is_legacy_binding(struct device_node *np)
+{
+	u32 cells;
+	int ret;
+
+	ret = of_property_read_u32(np, "#size-cells", &cells);
+	if (ret)
+		return true;
+
+	return cells != 0;
+}
+
 static int denali_dt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct denali_dt *dt;
 	const struct denali_dt_data *data;
-	struct denali_nand_info *denali;
+	struct denali_controller *denali;
+	struct device_node *np;
 	int ret;
 
 	dt = devm_kzalloc(dev, sizeof(*dt), GFP_KERNEL);
 	if (!dt)
 		return -ENOMEM;
-	denali = &dt->denali;
+	denali = &dt->controller;
 
 	data = of_device_get_match_data(dev);
 	if (data) {
@@ -140,9 +213,26 @@ static int denali_dt_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_disable_clk_ecc;
 
+	if (denali_dt_is_legacy_binding(dev->of_node)) {
+		ret = denali_dt_legacy_chip_init(denali);
+		if (ret)
+			goto out_remove_denali;
+	} else {
+		for_each_child_of_node(dev->of_node, np) {
+			ret = denali_dt_chip_init(denali, np);
+			if (ret) {
+				of_node_put(np);
+				goto out_remove_denali;
+			}
+		}
+	}
+
 	platform_set_drvdata(pdev, dt);
+
 	return 0;
 
+out_remove_denali:
+	denali_remove(denali);
 out_disable_clk_ecc:
 	clk_disable_unprepare(dt->clk_ecc);
 out_disable_clk_x:
@@ -157,7 +247,7 @@ static int denali_dt_remove(struct platform_device *pdev)
 {
 	struct denali_dt *dt = platform_get_drvdata(pdev);
 
-	denali_remove(&dt->denali);
+	denali_remove(&dt->controller);
 	clk_disable_unprepare(dt->clk_ecc);
 	clk_disable_unprepare(dt->clk_x);
 	clk_disable_unprepare(dt->clk);
diff --git a/drivers/mtd/nand/raw/denali_pci.c b/drivers/mtd/nand/raw/denali_pci.c
index 02eb599..d62aa52 100644
--- a/drivers/mtd/nand/raw/denali_pci.c
+++ b/drivers/mtd/nand/raw/denali_pci.c
@@ -29,10 +29,11 @@ NAND_ECC_CAPS_SINGLE(denali_pci_ecc_caps, denali_calc_ecc_bytes, 512, 8, 15);
 
 static int denali_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	int ret;
 	resource_size_t csr_base, mem_base;
 	unsigned long csr_len, mem_len;
-	struct denali_nand_info *denali;
+	struct denali_controller *denali;
+	struct denali_chip *dchip;
+	int nsels, ret, i;
 
 	denali = devm_kzalloc(&dev->dev, sizeof(*denali), GFP_KERNEL);
 	if (!denali)
@@ -64,7 +65,6 @@ static int denali_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	denali->dev = &dev->dev;
 	denali->irq = dev->irq;
 	denali->ecc_caps = &denali_pci_ecc_caps;
-	denali->nand.ecc.options |= NAND_ECC_MAXIMIZE;
 	denali->clk_rate = 50000000;		/* 50 MHz */
 	denali->clk_x_rate = 200000000;		/* 200 MHz */
 
@@ -91,10 +91,32 @@ static int denali_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (ret)
 		goto out_unmap_host;
 
+	nsels = denali->nbanks;
+
+	dchip = devm_kzalloc(denali->dev, struct_size(dchip, sels, nsels),
+			     GFP_KERNEL);
+	if (!dchip) {
+		ret = -ENOMEM;
+		goto out_remove_denali;
+	}
+
+	dchip->chip.ecc.options |= NAND_ECC_MAXIMIZE;
+
+	dchip->nsels = nsels;
+
+	for (i = 0; i < nsels; i++)
+		dchip->sels[i].bank = i;
+
+	ret = denali_chip_init(denali, dchip);
+	if (ret)
+		goto out_remove_denali;
+
 	pci_set_drvdata(dev, denali);
 
 	return 0;
 
+out_remove_denali:
+	denali_remove(denali);
 out_unmap_host:
 	iounmap(denali->host);
 out_unmap_reg:
@@ -104,7 +126,7 @@ static int denali_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 static void denali_pci_remove(struct pci_dev *dev)
 {
-	struct denali_nand_info *denali = pci_get_drvdata(dev);
+	struct denali_controller *denali = pci_get_drvdata(dev);
 
 	denali_remove(denali);
 	iounmap(denali->reg);
-- 
2.7.4

