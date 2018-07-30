Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814F2FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292FF20873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RY/XrrRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292FF20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbeG3Htb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 03:49:31 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46313 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbeG3Hta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 03:49:30 -0400
Received: by mail-qk0-f195.google.com with SMTP id 191-v6so1124110qki.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 23:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jCDfoXZLwDfPSOmSRTVs/H7CVQWUKVaXXsHa9Bn+BEI=;
        b=RY/XrrRg7v2LUu7aMTlTS+5liKUNP7vOoDwkh0v9qWhzOGdDvqV8rFFMGbu8od8oT6
         tFbGwxwyEJ1Gs7zfRU2PO8cQ2NldfiauJyNVBAZFkzQ0+PaZ9Wr6pVu5CsEu6cZ3ASd1
         2Q99iU5/Janzh639a1/z1rIu6kSUPu+vRmPDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jCDfoXZLwDfPSOmSRTVs/H7CVQWUKVaXXsHa9Bn+BEI=;
        b=g2KaRzVN3HRYYrHnf2n0PHCuIT4LVRWSqPbF3RPcBydMnzIhW2uL1NPL1rx8OPU4j9
         dnMBQPHX+nH0Vc9fRsXx0jbyvIjOi9YaA+aSOI7o4f+K47fxykdP4dvkKj/ec5Nh/w2C
         pc9vFbw6mmTRpeTXBeWVSgVTMsuH170+aJ6cqBx7YS+69aOHIviQptr6ep/Whajizo9u
         GevQQam61GxIstZUn3bAUjzxRX9ESe8sowD71QVaTGGpuh6FjVb6Zg58bC6BhKq0vy7T
         lcYniNHXgSwxKqFuYW1hJZxmhspRo8bthBdztNmh+r8UIsxjeEvExxC5j1bMRJRcB/+L
         n+EQ==
X-Gm-Message-State: AOUpUlHqF/N+f8HMFpI48DuvzRQYIR/qWdRic9qwCqFsrmVwGhdzSL2v
        hBAs0QbN8qP2ogfJ/DSHzX3yDw==
X-Google-Smtp-Source: AAOMgpeuV+0h4Khlsae6oiAE2ntUEkybAFvS7eLid4mnJ05rZy98OW6knUTKauxTFSXCkvHtJ/mh5A==
X-Received: by 2002:a37:b91:: with SMTP id 139-v6mr14632896qkl.429.1532931366567;
        Sun, 29 Jul 2018 23:16:06 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.252.250])
        by smtp.gmail.com with ESMTPSA id z12-v6sm6211778qkf.40.2018.07.29.23.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 29 Jul 2018 23:16:06 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        vikram.prakash@broadcom.com
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] mmc: sdhci-pltfm: Convert DT properties to generic device properties
Date:   Mon, 30 Jul 2018 11:45:42 +0530
Message-Id: <1532931343-9499-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532931343-9499-1-git-send-email-srinath.mannam@broadcom.com>
References: <1532931343-9499-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Convert DT properties to generic device properties
so that drivers can get properties from DT or ACPI.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 68 +++++++++++++++++++++++++-----------------
 drivers/mmc/host/sdhci-pltfm.h |  7 ++++-
 2 files changed, 46 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 02bea61..b231c9a 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -30,6 +30,7 @@
 
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/of.h>
 #ifdef CONFIG_PPC
 #include <asm/machdep.h>
@@ -51,11 +52,10 @@ static const struct sdhci_ops sdhci_pltfm_ops = {
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
-#ifdef CONFIG_OF
-static bool sdhci_of_wp_inverted(struct device_node *np)
+static bool sdhci_wp_inverted(struct device *dev)
 {
-	if (of_get_property(np, "sdhci,wp-inverted", NULL) ||
-	    of_get_property(np, "wp-inverted", NULL))
+	if (device_property_present(dev, "sdhci,wp-inverted") ||
+	    device_property_present(dev, "wp-inverted"))
 		return true;
 
 	/* Old device trees don't have the wp-inverted property. */
@@ -66,52 +66,64 @@ static bool sdhci_of_wp_inverted(struct device_node *np)
 #endif /* CONFIG_PPC */
 }
 
-void sdhci_get_of_property(struct platform_device *pdev)
+#ifdef CONFIG_OF
+static void sdhci_get_compatibility(struct platform_device *pdev)
 {
+	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct device_node *np = pdev->dev.of_node;
+
+	if (!np)
+		return;
+
+	if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
+		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
+
+	if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
+	    of_device_is_compatible(np, "fsl,p1010-esdhc") ||
+	    of_device_is_compatible(np, "fsl,t4240-esdhc") ||
+	    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
+		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+}
+#else
+void sdhci_get_compatibility(struct platform_device *pdev) {}
+#endif /* CONFIG_OF */
+
+void sdhci_get_property(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	u32 bus_width;
 
-	if (of_get_property(np, "sdhci,auto-cmd12", NULL))
+	if (device_property_present(dev, "sdhci,auto-cmd12"))
 		host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
 
-	if (of_get_property(np, "sdhci,1-bit-only", NULL) ||
-	    (of_property_read_u32(np, "bus-width", &bus_width) == 0 &&
+	if (device_property_present(dev, "sdhci,1-bit-only") ||
+	    (device_property_read_u32(dev, "bus-width", &bus_width) == 0 &&
 	    bus_width == 1))
 		host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
 
-	if (sdhci_of_wp_inverted(np))
+	if (sdhci_wp_inverted(dev))
 		host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
 
-	if (of_get_property(np, "broken-cd", NULL))
+	if (device_property_present(dev, "broken-cd"))
 		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
-	if (of_get_property(np, "no-1-8-v", NULL))
+	if (device_property_present(dev, "no-1-8-v"))
 		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 
-	if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
-		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
-
-	if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
-	    of_device_is_compatible(np, "fsl,p1010-esdhc") ||
-	    of_device_is_compatible(np, "fsl,t4240-esdhc") ||
-	    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
-		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+	sdhci_get_compatibility(pdev);
 
-	of_property_read_u32(np, "clock-frequency", &pltfm_host->clock);
+	device_property_read_u32(dev, "clock-frequency", &pltfm_host->clock);
 
-	if (of_find_property(np, "keep-power-in-suspend", NULL))
+	if (device_property_present(dev, "keep-power-in-suspend"))
 		host->mmc->pm_caps |= MMC_PM_KEEP_POWER;
 
-	if (of_property_read_bool(np, "wakeup-source") ||
-	    of_property_read_bool(np, "enable-sdio-wakeup")) /* legacy */
+	if (device_property_read_bool(dev, "wakeup-source") ||
+	    device_property_read_bool(dev, "enable-sdio-wakeup")) /* legacy */
 		host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
 }
-#else
-void sdhci_get_of_property(struct platform_device *pdev) {}
-#endif /* CONFIG_OF */
-EXPORT_SYMBOL_GPL(sdhci_get_of_property);
+EXPORT_SYMBOL_GPL(sdhci_get_property);
 
 struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 				    const struct sdhci_pltfm_data *pdata,
@@ -184,7 +196,7 @@ int sdhci_pltfm_register(struct platform_device *pdev,
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
-	sdhci_get_of_property(pdev);
+	sdhci_get_property(pdev);
 
 	ret = sdhci_add_host(host);
 	if (ret)
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 1e91fb1..6109987 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -90,7 +90,12 @@ static inline void sdhci_be32bs_writeb(struct sdhci_host *host, u8 val, int reg)
 }
 #endif /* CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER */
 
-extern void sdhci_get_of_property(struct platform_device *pdev);
+void sdhci_get_property(struct platform_device *pdev);
+
+static inline void sdhci_get_of_property(struct platform_device *pdev)
+{
+	return sdhci_get_property(pdev);
+}
 
 extern struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 					  const struct sdhci_pltfm_data *pdata,
-- 
2.7.4

