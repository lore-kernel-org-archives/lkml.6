Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FCBC71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B2B20652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B2B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeJOVvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:51:55 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55846 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726469AbeJOVvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:51:55 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9FDwW1w010377;
        Mon, 15 Oct 2018 16:03:43 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2n35u5c5fa-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 15 Oct 2018 16:03:43 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 16F3E31;
        Mon, 15 Oct 2018 14:03:43 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DDF2C4E69;
        Mon, 15 Oct 2018 14:03:42 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.44) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 15 Oct
 2018 16:03:42 +0200
Received: from localhost (10.201.23.16) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 15 Oct 2018 16:03:42
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <robh@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>
Subject: [PATCH 3/4] ASoC: stm32: sai: set sai as mclk clock provider
Date:   Mon, 15 Oct 2018 16:03:35 +0200
Message-ID: <1539612216-12602-4-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539612216-12602-1-git-send-email-olivier.moysan@st.com>
References: <1539612216-12602-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-15_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add master clock generation support in STM32 SAI.
The master clock provided by SAI can be used to feed a codec.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai.h     |   3 +
 sound/soc/stm/stm32_sai_sub.c | 275 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 242 insertions(+), 36 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.h b/sound/soc/stm/stm32_sai.h
index f25422174909..08de899c766b 100644
--- a/sound/soc/stm/stm32_sai.h
+++ b/sound/soc/stm/stm32_sai.h
@@ -91,6 +91,9 @@
 #define SAI_XCR1_OSR_SHIFT	26
 #define SAI_XCR1_OSR		BIT(SAI_XCR1_OSR_SHIFT)
 
+#define SAI_XCR1_MCKEN_SHIFT	27
+#define SAI_XCR1_MCKEN		BIT(SAI_XCR1_MCKEN_SHIFT)
+
 /******************* Bit definition for SAI_XCR2 register *******************/
 #define SAI_XCR2_FTH_SHIFT	0
 #define SAI_XCR2_FTH_MASK	GENMASK(2, SAI_XCR2_FTH_SHIFT)
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 56a227e0bd71..31d22abd3204 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_irq.h>
@@ -68,6 +69,8 @@
 #define SAI_IEC60958_BLOCK_FRAMES	192
 #define SAI_IEC60958_STATUS_BYTES	24
 
+#define SAI_MCLK_NAME_LEN		32
+
 /**
  * struct stm32_sai_sub_data - private data of SAI sub block (block A or B)
  * @pdev: device data pointer
@@ -80,6 +83,7 @@
  * @pdata: SAI block parent data pointer
  * @np_sync_provider: synchronization provider node
  * @sai_ck: kernel clock feeding the SAI clock generator
+ * @sai_mclk: master clock from SAI mclk provider
  * @phys_addr: SAI registers physical base address
  * @mclk_rate: SAI block master clock frequency (Hz). set at init
  * @id: SAI sub block id corresponding to sub-block A or B
@@ -110,6 +114,7 @@ struct stm32_sai_sub_data {
 	struct stm32_sai_data *pdata;
 	struct device_node *np_sync_provider;
 	struct clk *sai_ck;
+	struct clk *sai_mclk;
 	dma_addr_t phys_addr;
 	unsigned int mclk_rate;
 	unsigned int id;
@@ -251,6 +256,177 @@ static const struct snd_kcontrol_new iec958_ctls = {
 	.put = snd_pcm_iec958_put,
 };
 
+struct stm32_sai_mclk_data {
+	struct clk_hw hw;
+	unsigned long freq;
+	struct stm32_sai_sub_data *sai_data;
+};
+
+#define to_mclk_data(_hw) container_of(_hw, struct stm32_sai_mclk_data, hw)
+#define STM32_SAI_MAX_CLKS 1
+
+static int stm32_sai_get_clk_div(struct stm32_sai_sub_data *sai,
+				 unsigned long input_rate,
+				 unsigned long output_rate)
+{
+	int version = sai->pdata->conf->version;
+	int div;
+
+	div = DIV_ROUND_CLOSEST(input_rate, output_rate);
+	if (div > SAI_XCR1_MCKDIV_MAX(version)) {
+		dev_err(&sai->pdev->dev, "Divider %d out of range\n", div);
+		return -EINVAL;
+	}
+	dev_dbg(&sai->pdev->dev, "SAI divider %d\n", div);
+
+	if (input_rate % div)
+		dev_dbg(&sai->pdev->dev,
+			"Rate not accurate. requested (%ld), actual (%ld)\n",
+			output_rate, input_rate / div);
+
+	return div;
+}
+
+static int stm32_sai_set_clk_div(struct stm32_sai_sub_data *sai,
+				 unsigned int div)
+{
+	int version = sai->pdata->conf->version;
+	int ret, cr1, mask;
+
+	if (div > SAI_XCR1_MCKDIV_MAX(version)) {
+		dev_err(&sai->pdev->dev, "Divider %d out of range\n", div);
+		return -EINVAL;
+	}
+
+	mask = SAI_XCR1_MCKDIV_MASK(SAI_XCR1_MCKDIV_WIDTH(version));
+	cr1 = SAI_XCR1_MCKDIV_SET(div);
+	ret = regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX, mask, cr1);
+	if (ret < 0)
+		dev_err(&sai->pdev->dev, "Failed to update CR1 register\n");
+
+	return ret;
+}
+
+static long stm32_sai_mclk_round_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long *prate)
+{
+	struct stm32_sai_mclk_data *mclk = to_mclk_data(hw);
+	struct stm32_sai_sub_data *sai = mclk->sai_data;
+	int div;
+
+	div = stm32_sai_get_clk_div(sai, *prate, rate);
+	if (div < 0)
+		return div;
+
+	mclk->freq = *prate / div;
+
+	return mclk->freq;
+}
+
+static unsigned long stm32_sai_mclk_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct stm32_sai_mclk_data *mclk = to_mclk_data(hw);
+
+	return mclk->freq;
+}
+
+static int stm32_sai_mclk_set_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long parent_rate)
+{
+	struct stm32_sai_mclk_data *mclk = to_mclk_data(hw);
+	struct stm32_sai_sub_data *sai = mclk->sai_data;
+	unsigned int div;
+	int ret;
+
+	div = stm32_sai_get_clk_div(sai, parent_rate, rate);
+	if (div < 0)
+		return div;
+
+	ret = stm32_sai_set_clk_div(sai, div);
+	if (ret)
+		return ret;
+
+	mclk->freq = rate;
+
+	return 0;
+}
+
+static int stm32_sai_mclk_enable(struct clk_hw *hw)
+{
+	struct stm32_sai_mclk_data *mclk = to_mclk_data(hw);
+	struct stm32_sai_sub_data *sai = mclk->sai_data;
+
+	dev_dbg(&sai->pdev->dev, "Enable master clock\n");
+
+	return regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX,
+				  SAI_XCR1_MCKEN, SAI_XCR1_MCKEN);
+}
+
+static void stm32_sai_mclk_disable(struct clk_hw *hw)
+{
+	struct stm32_sai_mclk_data *mclk = to_mclk_data(hw);
+	struct stm32_sai_sub_data *sai = mclk->sai_data;
+
+	dev_dbg(&sai->pdev->dev, "Disable master clock\n");
+
+	regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX, SAI_XCR1_MCKEN, 0);
+}
+
+static const struct clk_ops mclk_ops = {
+	.enable = stm32_sai_mclk_enable,
+	.disable = stm32_sai_mclk_disable,
+	.recalc_rate = stm32_sai_mclk_recalc_rate,
+	.round_rate = stm32_sai_mclk_round_rate,
+	.set_rate = stm32_sai_mclk_set_rate,
+};
+
+static int stm32_sai_add_mclk_provider(struct stm32_sai_sub_data *sai)
+{
+	struct clk_hw *hw;
+	struct stm32_sai_mclk_data *mclk;
+	struct device *dev = &sai->pdev->dev;
+	const char *pname = __clk_get_name(sai->sai_ck);
+	char *mclk_name, *p, *s = (char *)pname;
+	int ret, i = 0;
+
+	mclk = devm_kzalloc(dev, sizeof(mclk), GFP_KERNEL);
+	if (!mclk)
+		return -ENOMEM;
+
+	mclk_name = devm_kcalloc(dev, sizeof(char),
+				 SAI_MCLK_NAME_LEN, GFP_KERNEL);
+	if (!mclk_name)
+		return -ENOMEM;
+
+	/*
+	 * Forge mclk clock name from parent clock name and suffix.
+	 * String after "_" char is stripped in parent name.
+	 */
+	p = mclk_name;
+	while (*s && *s != '_' && (i < (SAI_MCLK_NAME_LEN - 6))) {
+		*p++ = *s++;
+		i++;
+	}
+	STM_SAI_IS_SUB_A(sai) ?
+		strncat(p, "a_mclk", 6) : strncat(p, "b_mclk", 6);
+
+	mclk->hw.init = CLK_HW_INIT(mclk_name, pname, &mclk_ops, 0);
+	mclk->sai_data = sai;
+	hw = &mclk->hw;
+
+	dev_dbg(dev, "Register master clock %s\n", mclk_name);
+	ret = devm_clk_hw_register(&sai->pdev->dev, hw);
+	if (ret) {
+		dev_err(dev, "mclk register returned %d\n", ret);
+		return ret;
+	}
+	sai->sai_mclk = hw->clk;
+
+	/* register mclk provider */
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
+}
+
 static irqreturn_t stm32_sai_isr(int irq, void *devid)
 {
 	struct stm32_sai_sub_data *sai = (struct stm32_sai_sub_data *)devid;
@@ -312,15 +488,25 @@ static int stm32_sai_set_sysclk(struct snd_soc_dai *cpu_dai,
 	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
 	int ret;
 
-	if ((dir == SND_SOC_CLOCK_OUT) && sai->master) {
+	if (dir == SND_SOC_CLOCK_OUT) {
 		ret = regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX,
 					 SAI_XCR1_NODIV,
 					 (unsigned int)~SAI_XCR1_NODIV);
 		if (ret < 0)
 			return ret;
 
-		sai->mclk_rate = freq;
 		dev_dbg(cpu_dai->dev, "SAI MCLK frequency is %uHz\n", freq);
+		sai->mclk_rate = freq;
+
+		if (sai->sai_mclk) {
+			ret = clk_set_rate_exclusive(sai->sai_mclk,
+						     sai->mclk_rate);
+			if (ret) {
+				dev_err(cpu_dai->dev,
+					"Could not set mclk rate\n");
+				return ret;
+			}
+		}
 	}
 
 	return 0;
@@ -715,15 +901,9 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
 {
 	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
 	int cr1, mask, div = 0;
-	int sai_clk_rate, mclk_ratio, den, ret;
-	int version = sai->pdata->conf->version;
+	int sai_clk_rate, mclk_ratio, den;
 	unsigned int rate = params_rate(params);
 
-	if (!sai->mclk_rate) {
-		dev_err(cpu_dai->dev, "Mclk rate is null\n");
-		return -EINVAL;
-	}
-
 	if (!(rate % 11025))
 		clk_set_parent(sai->sai_ck, sai->pdata->clk_x11k);
 	else
@@ -731,14 +911,22 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
 	sai_clk_rate = clk_get_rate(sai->sai_ck);
 
 	if (STM_SAI_IS_F4(sai->pdata)) {
-		/*
-		 * mclk_rate = 256 * fs
-		 * MCKDIV = 0 if sai_ck < 3/2 * mclk_rate
-		 * MCKDIV = sai_ck / (2 * mclk_rate) otherwise
+		/* mclk on (NODIV=0)
+		 *   mclk_rate = 256 * fs
+		 *   MCKDIV = 0 if sai_ck < 3/2 * mclk_rate
+		 *   MCKDIV = sai_ck / (2 * mclk_rate) otherwise
+		 * mclk off (NODIV=1)
+		 *   MCKDIV ignored. sck = sai_ck
 		 */
-		if (2 * sai_clk_rate >= 3 * sai->mclk_rate)
-			div = DIV_ROUND_CLOSEST(sai_clk_rate,
-						2 * sai->mclk_rate);
+		if (!sai->mclk_rate)
+			return 0;
+
+		if (2 * sai_clk_rate >= 3 * sai->mclk_rate) {
+			div = stm32_sai_get_clk_div(sai, sai_clk_rate,
+						    2 * sai->mclk_rate);
+			if (div < 0)
+				return div;
+		}
 	} else {
 		/*
 		 * TDM mode :
@@ -750,8 +938,10 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
 		 * Note: NOMCK/NODIV correspond to same bit.
 		 */
 		if (STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
-			div = DIV_ROUND_CLOSEST(sai_clk_rate,
-						(params_rate(params) * 128));
+			div = stm32_sai_get_clk_div(sai, sai_clk_rate,
+						    rate * 128);
+			if (div < 0)
+				return div;
 		} else {
 			if (sai->mclk_rate) {
 				mclk_ratio = sai->mclk_rate / rate;
@@ -764,31 +954,22 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
 						mclk_ratio);
 					return -EINVAL;
 				}
-				div = DIV_ROUND_CLOSEST(sai_clk_rate,
-							sai->mclk_rate);
+				div = stm32_sai_get_clk_div(sai, sai_clk_rate,
+							    sai->mclk_rate);
+				if (div < 0)
+					return div;
 			} else {
 				/* mclk-fs not set, master clock not active */
 				den = sai->fs_length * params_rate(params);
-				div = DIV_ROUND_CLOSEST(sai_clk_rate, den);
+				div = stm32_sai_get_clk_div(sai, sai_clk_rate,
+							    den);
+				if (div < 0)
+					return div;
 			}
 		}
 	}
 
-	if (div > SAI_XCR1_MCKDIV_MAX(version)) {
-		dev_err(cpu_dai->dev, "Divider %d out of range\n", div);
-		return -EINVAL;
-	}
-	dev_dbg(cpu_dai->dev, "SAI clock %d, divider %d\n", sai_clk_rate, div);
-
-	mask = SAI_XCR1_MCKDIV_MASK(SAI_XCR1_MCKDIV_WIDTH(version));
-	cr1 = SAI_XCR1_MCKDIV_SET(div);
-	ret = regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX, mask, cr1);
-	if (ret < 0) {
-		dev_err(cpu_dai->dev, "Failed to update CR1 register\n");
-		return ret;
-	}
-
-	return 0;
+	return stm32_sai_set_clk_div(sai, div);
 }
 
 static int stm32_sai_hw_params(struct snd_pcm_substream *substream,
@@ -881,6 +1062,9 @@ static void stm32_sai_shutdown(struct snd_pcm_substream *substream,
 			   SAI_XCR1_NODIV);
 
 	clk_disable_unprepare(sai->sai_ck);
+
+	clk_rate_exclusive_put(sai->sai_mclk);
+
 	sai->substream = NULL;
 }
 
@@ -903,6 +1087,8 @@ static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	struct stm32_sai_sub_data *sai = dev_get_drvdata(cpu_dai->dev);
 	int cr1 = 0, cr1_mask;
 
+	sai->cpu_dai = cpu_dai;
+
 	sai->dma_params.addr = (dma_addr_t)(sai->phys_addr + STM_SAI_DR_REGX);
 	/*
 	 * DMA supports 4, 8 or 16 burst sizes. Burst size 4 is the best choice,
@@ -1181,6 +1367,23 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 		return PTR_ERR(sai->sai_ck);
 	}
 
+	if (STM_SAI_IS_F4(sai->pdata))
+		return 0;
+
+	/* Register mclk provider if requested */
+	if (of_find_property(np, "#clock-cells", NULL)) {
+		ret = stm32_sai_add_mclk_provider(sai);
+		if (ret < 0)
+			return ret;
+	} else {
+		sai->sai_mclk = devm_clk_get(&pdev->dev, "MCLK");
+		if (IS_ERR(sai->sai_mclk)) {
+			if (PTR_ERR(sai->sai_mclk) != -ENOENT)
+				return PTR_ERR(sai->sai_mclk);
+			sai->sai_mclk = NULL;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.7.4

