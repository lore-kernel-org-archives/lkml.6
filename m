Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09550C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C1521714
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJdTLnxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C1521714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeHXN2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 09:28:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39780 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeHXN2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 09:28:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id m3-v6so3167689pgp.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 02:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=DF9G9tqxmnzsm6POWCrdpkzd6m/XTvoEdqvrpLp5sus=;
        b=fJdTLnxBGdlUv37iCJsWi/nBMDF6sRzONsCfaYp8EdPN9MtkTQQL1RFYku5f7ngvJp
         AjD0SgO3N1ZH9n7DfQ2hnjG83+n9jhExZpFVoAth+OZ10fihfFnxwaiL/GBML9MAXOQ+
         JNC7peIYOyVT1c1V/Xe3o4G0EmOii2sLl/su0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=DF9G9tqxmnzsm6POWCrdpkzd6m/XTvoEdqvrpLp5sus=;
        b=Y1TcZDknPSX4QlNidk1+601Xm3qYb6PeO4mVr37yQHxIWgw8gXFAXGnnJVNt1LhrRo
         E1mt3JSdvNtgVgq/MkNcGQp3/LK0IlZ3/OE6AtT2nDMlnz/OFfXpfbXG6oLEwYSMlAS4
         eYMLwLc/+7CXlkA0w2jHWqwWYz72BqEI+G6I914iZCKAKk5gb72ePyrKlBKQb9szyP5U
         1R7vVro9yY/M26Y2wMYmIjJCSsJ+J9L3a0Xh5nGV16zH3ShP7g9XUrBz/Zyv8mQ1zp3o
         1uDgmYh3u2hxzB66Bt/s0KpWP4+VaGX2PutsXG97U/JM4B+mhdG5Z9XdxrbVAEp1lsCI
         HDwQ==
X-Gm-Message-State: APzg51AUK7N8FZX2WP1rU8g94zd/esMdekFjCp+P39jIAlXJyWt49Hve
        EPY6BnjMkJzT4xSDpKZXVXJx7w==
X-Google-Smtp-Source: ANB0Vdb0Qg+Z3gkhEHFw0v27jeYYU8ClG7TLwsxNnXa37N1tqhHZaHupEBN5UUTsifEKxafUhp6XFw==
X-Received: by 2002:a63:a919:: with SMTP id u25-v6mr994691pge.211.1535104456351;
        Fri, 24 Aug 2018 02:54:16 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j16-v6sm22046560pfk.125.2018.08.24.02.54.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Aug 2018 02:54:15 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        freeman.liu@spreadtrum.com, broonie@kernel.org,
        baolin.wang@linaro.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: adc: sc27xx: Add ADC scale calibration
Date:   Fri, 24 Aug 2018 17:53:16 +0800
Message-Id: <cc6b76c5d660818d3ff7833ea5be4f32ed960f54.1535103920.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <4a7e33457617e6f0f7c9627fe20ddd3039e4fe82.1535103920.git.baolin.wang@linaro.org>
References: <4a7e33457617e6f0f7c9627fe20ddd3039e4fe82.1535103920.git.baolin.wang@linaro.org>
In-Reply-To: <4a7e33457617e6f0f7c9627fe20ddd3039e4fe82.1535103920.git.baolin.wang@linaro.org>
References: <4a7e33457617e6f0f7c9627fe20ddd3039e4fe82.1535103920.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to read calibration values from the eFuse
controller to calibrate the ADC channel scales, which can make ADC
sample data more accurate.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../bindings/iio/adc/sprd,sc27xx-adc.txt           |    4 ++
 drivers/iio/adc/sc27xx_adc.c                       |   52 ++++++++++++++++++--
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt b/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
index 8aad960..b4daa15 100644
--- a/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
@@ -12,6 +12,8 @@ Required properties:
 - interrupts: The interrupt number for the ADC device.
 - #io-channel-cells: Number of cells in an IIO specifier.
 - hwlocks: Reference to a phandle of a hwlock provider node.
+- nvmem-cells: A phandle to the calibration cells provided by eFuse device.
+- nvmem-cell-names: Should be "big_scale_calib", "small_scale_calib".
 
 Example:
 
@@ -32,5 +34,7 @@ Example:
 			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
 			#io-channel-cells = <1>;
 			hwlocks = <&hwlock 4>;
+			nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
+			nvmem-cell-names = "big_scale_calib", "small_scale_calib";
 		};
 	};
diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index 153c311..7ac78eda 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -5,6 +5,7 @@
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -87,16 +88,48 @@ struct sc27xx_adc_linear_graph {
  * should use the small-scale graph, and if more than 1.2v, we should use the
  * big-scale graph.
  */
-static const struct sc27xx_adc_linear_graph big_scale_graph = {
+static struct sc27xx_adc_linear_graph big_scale_graph = {
 	4200, 3310,
 	3600, 2832,
 };
 
-static const struct sc27xx_adc_linear_graph small_scale_graph = {
+static struct sc27xx_adc_linear_graph small_scale_graph = {
 	1000, 3413,
 	100, 341,
 };
 
+static const struct sc27xx_adc_linear_graph big_scale_graph_calib = {
+	4200, 856,
+	3600, 733,
+};
+
+static const struct sc27xx_adc_linear_graph small_scale_graph_calib = {
+	1000, 833,
+	100, 80,
+};
+
+static int sc27xx_adc_get_calib_data(u32 calib_data, int calib_adc)
+{
+	return ((calib_data & 0xff) + calib_adc - 128) * 4;
+}
+
+static void
+sc27xx_adc_scale_calibration(const struct sc27xx_adc_linear_graph *calib_graph,
+			     u32 calib_data, bool big_scale)
+{
+	struct sc27xx_adc_linear_graph *graph;
+
+	if (big_scale)
+		graph = &big_scale_graph;
+	else
+		graph = &small_scale_graph;
+
+	/* Only need to calibrate the adc values in the linear graph. */
+	graph->adc0 = sc27xx_adc_get_calib_data(calib_data, calib_graph->adc0);
+	graph->adc1 = sc27xx_adc_get_calib_data(calib_data >> 8,
+						calib_graph->adc1);
+}
+
 static int sc27xx_adc_get_ratio(int channel, int scale)
 {
 	switch (channel) {
@@ -209,7 +242,7 @@ static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
 	*div_denominator = ratio & SC27XX_RATIO_DENOMINATOR_MASK;
 }
 
-static int sc27xx_adc_to_volt(const struct sc27xx_adc_linear_graph *graph,
+static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
 			      int raw_adc)
 {
 	int tmp;
@@ -371,6 +404,7 @@ static int sc27xx_adc_write_raw(struct iio_dev *indio_dev,
 
 static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
 {
+	u32 val;
 	int ret;
 
 	ret = regmap_update_bits(data->regmap, SC27XX_MODULE_EN,
@@ -390,6 +424,18 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
 	if (ret)
 		goto disable_clk;
 
+	/* ADC channel scales' calibration from nvmem device */
+	ret = nvmem_cell_read_u32(data->dev, "big_scale_calib", &val);
+	if (ret)
+		goto disable_clk;
+
+	sc27xx_adc_scale_calibration(&big_scale_graph_calib, val, true);
+
+	ret = nvmem_cell_read_u32(data->dev, "small_scale_calib", &val);
+	if (ret)
+		goto disable_clk;
+
+	sc27xx_adc_scale_calibration(&small_scale_graph_calib, val, false);
 	return 0;
 
 disable_clk:
-- 
1.7.9.5

