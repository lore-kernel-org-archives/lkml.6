Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F50C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E8E2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E8E2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeLMIjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:39:45 -0500
Received: from mail-sz2.amlogic.com ([211.162.65.114]:52978 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbeLMIjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 03:39:43 -0500
Received: from localhost.localdomain (10.28.8.16) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server id 15.0.1320.4; Thu, 13 Dec 2018
 16:40:02 +0800
From:   Sunny Luo <sunny.luo@amlogic.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Sunny Luo <sunny.luo@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        "Neil Armstrong" <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        "Jianxin Pan" <jianxin.pan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        <linux-spi@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] spi: meson-axg: enhance output enable feature
Date:   Thu, 13 Dec 2018 16:39:13 +0800
Message-ID: <1544690354-16409-3-git-send-email-sunny.luo@amlogic.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
References: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.8.16]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPICC controller in Meson-AXG is capable of driving the CLK/MOSI/SS
signal lines through the idle state (between two transmission operation),
which avoid the signals floating in unexpected state.

Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/spi/spi-meson-spicc.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index b56249d..0384c28 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -115,6 +115,13 @@
 
 #define SPICC_DWADDR	0x24	/* Write Address of DMA */
 
+#define SPICC_ENH_CTL0	0x38	/* Enhanced Feature */
+#define SPICC_ENH_MOSI_OEN		BIT(25)
+#define SPICC_ENH_CLK_OEN		BIT(26)
+#define SPICC_ENH_CS_OEN		BIT(27)
+#define SPICC_ENH_CLK_CS_DELAY_EN	BIT(28)
+#define SPICC_ENH_MAIN_CLK_AO		BIT(29)
+
 #define writel_bits_relaxed(mask, val, addr) \
 	writel_relaxed((readl_relaxed(addr) & ~(mask)) | (val), addr)
 
@@ -123,6 +130,7 @@
 
 struct meson_spicc_data {
 	unsigned int			max_speed_hz;
+	bool				has_oen;
 };
 
 struct meson_spicc_device {
@@ -145,6 +153,19 @@ struct meson_spicc_device {
 	bool				is_last_burst;
 };
 
+static void meson_spicc_oen_enable(struct meson_spicc_device *spicc)
+{
+	u32 conf;
+
+	if (!spicc->data->has_oen)
+		return;
+
+	conf = readl_relaxed(spicc->base + SPICC_ENH_CTL0) |
+		SPICC_ENH_MOSI_OEN | SPICC_ENH_CLK_OEN | SPICC_ENH_CS_OEN;
+
+	writel_relaxed(conf, spicc->base + SPICC_ENH_CTL0);
+}
+
 static inline bool meson_spicc_txfull(struct meson_spicc_device *spicc)
 {
 	return !!FIELD_GET(SPICC_TF,
@@ -453,6 +474,8 @@ static int meson_spicc_prepare_message(struct spi_master *master,
 
 	writel_bits_relaxed(BIT(24), BIT(24), spicc->base + SPICC_TESTREG);
 
+	meson_spicc_oen_enable(spicc);
+
 	return 0;
 }
 
@@ -610,11 +633,12 @@ static int meson_spicc_remove(struct platform_device *pdev)
 }
 
 static const struct meson_spicc_data meson_spicc_gx_data = {
-	.max_speed_hz	= 30000000,
+	.max_speed_hz		= 30000000,
 };
 
 static const struct meson_spicc_data meson_spicc_axg_data = {
-	.max_speed_hz	= 80000000,
+	.max_speed_hz		= 80000000,
+	.has_oen		= true,
 };
 
 static const struct of_device_id meson_spicc_of_match[] = {
-- 
2.7.4

