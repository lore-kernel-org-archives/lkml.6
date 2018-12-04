Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF35C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BC8214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bi5MEpW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BC8214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeLDLBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:01:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:46534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbeLDLBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:01:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07C212146D;
        Tue,  4 Dec 2018 11:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921267;
        bh=UqGDGMw+MnkD18Xm68ZXUieIztOXYc569hHMCWE0e9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bi5MEpW17Rs9cANWeHHRLruy6xQqxmEEUwl/nLP5S3SQJeuwwO3MMMhH7Cv9uUBLo
         W17Ntjje2q8PYAzcMC5xwN5tBys6yUbXn+TcMtqGLDC5agCrZmuehuCJ1e7b9zPJpL
         n5J2mGIEtme3OqYE/itziY+JDB6zzRISkZXk3Tsk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 119/139] ASoC: intel: cht_bsw_max98090_ti: Add quirk for boards using pmc_plt_clk_0
Date:   Tue,  4 Dec 2018 11:50:00 +0100
Message-Id: <20181204103655.550033708@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit a182ecd3809c8d5a2da80c520f3602e301c5317e upstream.

Some boards such as the Swanky model Chromebooks use pmc_plt_clk_0 for the
mclk instead of pmc_plt_clk_3.

This commit adds a DMI based quirk for this.

This fixing audio no longer working on these devices after
commit 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
that commit fixes us unnecessary keeping unused clocks on, but in case
of the Swanky that was breaking audio support since we were not using
the right clock in the cht_bsw_max98090_ti machine driver.

Cc: stable@vger.kernel.org
Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
Reported-and-tested-by: Dean Wallace <duffydack73@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c |   32 ++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -19,6 +19,7 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
+#include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -35,6 +36,8 @@
 #define CHT_PLAT_CLK_3_HZ	19200000
 #define CHT_CODEC_DAI	"HiFi"
 
+#define QUIRK_PMC_PLT_CLK_0				0x01
+
 struct cht_mc_private {
 	struct clk *mclk;
 	struct snd_soc_jack jack;
@@ -385,11 +388,29 @@ static struct snd_soc_card snd_soc_card_
 	.num_controls = ARRAY_SIZE(cht_mc_controls),
 };
 
+static const struct dmi_system_id cht_max98090_quirk_table[] = {
+	{
+		/* Swanky model Chromebook (Toshiba Chromebook 2) */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Swanky"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{}
+};
+
 static int snd_cht_mc_probe(struct platform_device *pdev)
 {
+	const struct dmi_system_id *dmi_id;
 	struct device *dev = &pdev->dev;
 	int ret_val = 0;
 	struct cht_mc_private *drv;
+	const char *mclk_name;
+	int quirks = 0;
+
+	dmi_id = dmi_first_match(cht_max98090_quirk_table);
+	if (dmi_id)
+		quirks = (unsigned long)dmi_id->driver_data;
 
 	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
 	if (!drv)
@@ -411,11 +432,16 @@ static int snd_cht_mc_probe(struct platf
 	snd_soc_card_cht.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&snd_soc_card_cht, drv);
 
-	drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
+	if (quirks & QUIRK_PMC_PLT_CLK_0)
+		mclk_name = "pmc_plt_clk_0";
+	else
+		mclk_name = "pmc_plt_clk_3";
+
+	drv->mclk = devm_clk_get(&pdev->dev, mclk_name);
 	if (IS_ERR(drv->mclk)) {
 		dev_err(&pdev->dev,
-			"Failed to get MCLK from pmc_plt_clk_3: %ld\n",
-			PTR_ERR(drv->mclk));
+			"Failed to get MCLK from %s: %ld\n",
+			mclk_name, PTR_ERR(drv->mclk));
 		return PTR_ERR(drv->mclk);
 	}
 


