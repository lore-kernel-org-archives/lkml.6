Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 56052C5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 01:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061A120693
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 01:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="U62K298i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061A120693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965331AbeFOBUf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 21:20:35 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:27011 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965003AbeFOBU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 21:20:29 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w5F1IuMN005465;
        Fri, 15 Jun 2018 10:19:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w5F1IuMN005465
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529025540;
        bh=c0VtZ6bh6DT4gRNwISv/sui2R/SxbprkHr8oObof0aI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U62K298iazBqfEcRgnr2mSX3UdVJ8g3txY1Z5q/qBTr3F2/tQLwg3LhnQXSNlGrzt
         ZnerlciH+WVuTF6e9l492H8SCFu6VGYA6XsTKQhTRng2nQFK+JzwF8vPTuU1Mn+XVO
         S6ieBOfUsq3pSuKwuULUhdMaumaC7XS0vUqKsgYtXYUiI9fFRuuopldhG255ngGQvf
         QWeI8TM8qzPZY4g4qE8d58rBMBxxquoMow8skHXr+IhLtwOlRjflzlEaEIyydyQs2h
         fB2OH6M0YeNR4cJhUXPQJG3D7IfsQq1lhJVssG9hjFxz1Bcbb+6FRfaHpklOME/tCi
         ZSzrtXIcHpumg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kbuild@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v3 3/3] mtd: rawnand: denali: optimize timing parameters for data interface
Date:   Fri, 15 Jun 2018 10:18:52 +0900
Message-Id: <1529025532-22087-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529025532-22087-1-git-send-email-yamada.masahiro@socionext.com>
References: <1529025532-22087-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit improves the ->setup_data_interface() hook.

The denali_setup_data_interface() needs the frequency of clk_x
and the ratio of clk_x / clk.

The latter is currently hardcoded in the driver, like this:

  #define DENALI_CLK_X_MULT       6

The IP datasheet requires that clk_x / clk be 4, 5, or 6.  I just
chose 6 because it is the most defensive value, but it is not optimal.
By getting the clock rate of both "clk" and "clk_x", the driver can
compute the timing values more precisely.

To not break the existing platforms, the fallback value, 50 MHz is
provided.  It is true for all upstreamed platforms.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2:
  - Split patches into sensible chunks

 drivers/mtd/nand/raw/denali.c     | 49 +++++++++++++++++++--------------------
 drivers/mtd/nand/raw/denali.h     |  1 +
 drivers/mtd/nand/raw/denali_dt.c  |  2 ++
 drivers/mtd/nand/raw/denali_pci.c |  1 +
 4 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 2a302a1..2de46d4 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -51,14 +51,6 @@ MODULE_LICENSE("GPL");
 #define DENALI_INVALID_BANK	-1
 #define DENALI_NR_BANKS		4
 
-/*
- * The bus interface clock, clk_x, is phase aligned with the core clock.  The
- * clk_x is an integral multiple N of the core clk.  The value N is configured
- * at IP delivery time, and its available value is 4, 5, or 6.  We need to align
- * to the largest value to make it work with any possible configuration.
- */
-#define DENALI_CLK_X_MULT	6
-
 static inline struct denali_nand_info *mtd_to_denali(struct mtd_info *mtd)
 {
 	return container_of(mtd_to_nand(mtd), struct denali_nand_info, nand);
@@ -954,7 +946,7 @@ static int denali_setup_data_interface(struct mtd_info *mtd, int chipnr,
 {
 	struct denali_nand_info *denali = mtd_to_denali(mtd);
 	const struct nand_sdr_timings *timings;
-	unsigned long t_clk;
+	unsigned long t_x, mult_x;
 	int acc_clks, re_2_we, re_2_re, we_2_re, addr_2_data;
 	int rdwr_en_lo, rdwr_en_hi, rdwr_en_lo_hi, cs_setup;
 	int addr_2_data_mask;
@@ -965,15 +957,24 @@ static int denali_setup_data_interface(struct mtd_info *mtd, int chipnr,
 		return PTR_ERR(timings);
 
 	/* clk_x period in picoseconds */
-	t_clk = DIV_ROUND_DOWN_ULL(1000000000000ULL, denali->clk_x_rate);
-	if (!t_clk)
+	t_x = DIV_ROUND_DOWN_ULL(1000000000000ULL, denali->clk_x_rate);
+	if (!t_x)
+		return -EINVAL;
+
+	/*
+	 * The bus interface clock, clk_x, is phase aligned with the core clock.
+	 * The clk_x is an integral multiple N of the core clk.  The value N is
+	 * configured at IP delivery time, and its available value is 4, 5, 6.
+	 */
+	mult_x = DIV_ROUND_CLOSEST_ULL(denali->clk_x_rate, denali->clk_rate);
+	if (mult_x < 4 || mult_x > 6)
 		return -EINVAL;
 
 	if (chipnr == NAND_DATA_IFACE_CHECK_ONLY)
 		return 0;
 
 	/* tREA -> ACC_CLKS */
-	acc_clks = DIV_ROUND_UP(timings->tREA_max, t_clk);
+	acc_clks = DIV_ROUND_UP(timings->tREA_max, t_x);
 	acc_clks = min_t(int, acc_clks, ACC_CLKS__VALUE);
 
 	tmp = ioread32(denali->reg + ACC_CLKS);
@@ -982,7 +983,7 @@ static int denali_setup_data_interface(struct mtd_info *mtd, int chipnr,
 	iowrite32(tmp, denali->reg + ACC_CLKS);
 
 	/* tRWH -> RE_2_WE */
-	re_2_we = DIV_ROUND_UP(timings->tRHW_min, t_clk);
+	re_2_we = DIV_ROUND_UP(timings->tRHW_min, t_x);
 	re_2_we = min_t(int, re_2_we, RE_2_WE__VALUE);
 
 	tmp = ioread32(denali->reg + RE_2_WE);
@@ -991,7 +992,7 @@ static int denali_setup_data_interface(struct mtd_info *mtd, int chipnr,
 	iowrite32(tmp, denali->reg + RE_2_WE);
 
 	/* tRHZ -> RE_2_RE */
-	re_2_re = DIV_ROUND_UP(timings->tRHZ_max, t_clk);
+	re_2_re = DIV_ROUND_UP(timings->tRHZ_max, t_x);
 	re_2_re = min_t(int, re_2_re, RE_2_RE__VALUE);
 
 	tmp = ioread32(denali->reg + RE_2_RE);
@@ -1005,8 +1006,7 @@ static int denali_setup_data_interface(struct mtd_info *mtd, int chipnr,
 	 * With WE_2_RE properly set, the Denali controller automatically takes
 	 * care of the delay; the driver need not set NAND_WAIT_TCCS.
 	 */
-	we_2_re = DIV_ROUND_UP(max(timings->tCCS_min, timings->tWHR_min),
-			       t_clk);
+	we_2_re = DIV_ROUND_UP(max(timings->tCCS_min, timings->tWHR_min), t_x);
 	we_2_re = min_t(int, we_2_re, TWHR2_AND_WE_2_RE__WE_2_RE);
 
 	tmp = ioread32(denali->reg + TWHR2_AND_WE_2_RE);
@@ -1021,7 +1021,7 @@ static int denali_setup_data_interface(struct mtd_info *mtd, int chipnr,
 	if (denali->revision < 0x0501)
 		addr_2_data_mask >>= 1;
 
-	addr_2_data = DIV_ROUND_UP(timings->tADL_min, t_clk);
+	addr_2_data = DIV_ROUND_UP(timings->tADL_min, t_x);
 	addr_2_data = min_t(int, addr_2_data, addr_2_data_mask);
 
 	tmp = ioread32(denali->reg + TCWAW_AND_ADDR_2_DATA);
@@ -1031,7 +1031,7 @@ static int denali_setup_data_interface(struct mtd_info *mtd, int chipnr,
 
 	/* tREH, tWH -> RDWR_EN_HI_CNT */
 	rdwr_en_hi = DIV_ROUND_UP(max(timings->tREH_min, timings->tWH_min),
-				  t_clk);
+				  t_x);
 	rdwr_en_hi = min_t(int, rdwr_en_hi, RDWR_EN_HI_CNT__VALUE);
 
 	tmp = ioread32(denali->reg + RDWR_EN_HI_CNT);
@@ -1040,11 +1040,10 @@ static int denali_setup_data_interface(struct mtd_info *mtd, int chipnr,
 	iowrite32(tmp, denali->reg + RDWR_EN_HI_CNT);
 
 	/* tRP, tWP -> RDWR_EN_LO_CNT */
-	rdwr_en_lo = DIV_ROUND_UP(max(timings->tRP_min, timings->tWP_min),
-				  t_clk);
+	rdwr_en_lo = DIV_ROUND_UP(max(timings->tRP_min, timings->tWP_min), t_x);
 	rdwr_en_lo_hi = DIV_ROUND_UP(max(timings->tRC_min, timings->tWC_min),
-				     t_clk);
-	rdwr_en_lo_hi = max(rdwr_en_lo_hi, DENALI_CLK_X_MULT);
+				     t_x);
+	rdwr_en_lo_hi = max_t(int, rdwr_en_lo_hi, mult_x);
 	rdwr_en_lo = max(rdwr_en_lo, rdwr_en_lo_hi - rdwr_en_hi);
 	rdwr_en_lo = min_t(int, rdwr_en_lo, RDWR_EN_LO_CNT__VALUE);
 
@@ -1054,8 +1053,8 @@ static int denali_setup_data_interface(struct mtd_info *mtd, int chipnr,
 	iowrite32(tmp, denali->reg + RDWR_EN_LO_CNT);
 
 	/* tCS, tCEA -> CS_SETUP_CNT */
-	cs_setup = max3((int)DIV_ROUND_UP(timings->tCS_min, t_clk) - rdwr_en_lo,
-			(int)DIV_ROUND_UP(timings->tCEA_max, t_clk) - acc_clks,
+	cs_setup = max3((int)DIV_ROUND_UP(timings->tCS_min, t_x) - rdwr_en_lo,
+			(int)DIV_ROUND_UP(timings->tCEA_max, t_x) - acc_clks,
 			0);
 	cs_setup = min_t(int, cs_setup, CS_SETUP_CNT__VALUE);
 
@@ -1282,7 +1281,7 @@ int denali_init(struct denali_nand_info *denali)
 	}
 
 	/* clk rate info is needed for setup_data_interface */
-	if (denali->clk_x_rate)
+	if (denali->clk_rate && denali->clk_x_rate)
 		chip->setup_data_interface = denali_setup_data_interface;
 
 	ret = nand_scan_ident(mtd, denali->max_banks, NULL);
diff --git a/drivers/mtd/nand/raw/denali.h b/drivers/mtd/nand/raw/denali.h
index 9ad33d2..1f8feaf 100644
--- a/drivers/mtd/nand/raw/denali.h
+++ b/drivers/mtd/nand/raw/denali.h
@@ -300,6 +300,7 @@
 
 struct denali_nand_info {
 	struct nand_chip nand;
+	unsigned long clk_rate;		/* core clock rate */
 	unsigned long clk_x_rate;	/* bus interface clock rate */
 	int active_bank;		/* currently selected bank */
 	struct device *dev;
diff --git a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
index afaae37..0faaad0 100644
--- a/drivers/mtd/nand/raw/denali_dt.c
+++ b/drivers/mtd/nand/raw/denali_dt.c
@@ -150,6 +150,7 @@ static int denali_dt_probe(struct platform_device *pdev)
 		goto out_disable_clk_x;
 
 	if (dt->clk_x) {
+		denali->clk_rate = clk_get_rate(dt->clk);
 		denali->clk_x_rate = clk_get_rate(dt->clk_x);
 	} else {
 		/*
@@ -158,6 +159,7 @@ static int denali_dt_probe(struct platform_device *pdev)
 		 */
 		dev_notice(dev,
 			   "necessary clock is missing. default clock rates are used.\n");
+		denali->clk_rate = 50000000;
 		denali->clk_x_rate = 200000000;
 	}
 
diff --git a/drivers/mtd/nand/raw/denali_pci.c b/drivers/mtd/nand/raw/denali_pci.c
index 49cb3e1..7c8efc4 100644
--- a/drivers/mtd/nand/raw/denali_pci.c
+++ b/drivers/mtd/nand/raw/denali_pci.c
@@ -73,6 +73,7 @@ static int denali_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	denali->irq = dev->irq;
 	denali->ecc_caps = &denali_pci_ecc_caps;
 	denali->nand.ecc.options |= NAND_ECC_MAXIMIZE;
+	denali->clk_rate = 50000000;		/* 50 MHz */
 	denali->clk_x_rate = 200000000;		/* 200 MHz */
 
 	ret = pci_request_regions(dev, DENALI_NAND_NAME);
-- 
2.7.4

