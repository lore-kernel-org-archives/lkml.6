Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730FDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3844221479
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RY4fcTY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3844221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388668AbeK3Bfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:35:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732139AbeK3Bfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:35:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6A5C2146D;
        Thu, 29 Nov 2018 14:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501803;
        bh=bWdgogtaMGgtMsmBcr+LUJJh2Wy2QuKFDGWh9j6/nM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RY4fcTY/Vg+1R5dBVGGlvRKFmsAAcSeLN83WdYVn8HrZZFFfODb4XeYZNr1Sg5ZM9
         LGCItTv/qzo710JLrbwa5CH8IjM9lYsOXb5Ruea4AAlo2Wzog5J8aiCRAAf0SVzYkN
         WwpFgYamh/ePCKqlAnuDLTMHmOpcdKQIjy/XLXbM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anisse Astier <anisse@astier.eu>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 020/110] mmc: sdhci-pci: Workaround GLK firmware failing to restore the tuning value
Date:   Thu, 29 Nov 2018 15:11:51 +0100
Message-Id: <20181129135922.069971642@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit 5305ec6a27b2dc7398a689e661a4a2e951026f09 upstream.

GLK firmware can indicate that the tuning value will be restored after
runtime suspend, but not actually do that. Add a workaround that detects
such cases, and lets the driver do re-tuning instead.

Reported-by: Anisse Astier <anisse@astier.eu>
Tested-by: Anisse Astier <anisse@astier.eu>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-pci-core.c |   79 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 2 deletions(-)

--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -12,6 +12,7 @@
  *     - JMicron (hardware and technical support)
  */
 
+#include <linux/bitfield.h>
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/highmem.h>
@@ -462,6 +463,9 @@ struct intel_host {
 	u32	dsm_fns;
 	int	drv_strength;
 	bool	d3_retune;
+	bool	rpm_retune_ok;
+	u32	glk_rx_ctrl1;
+	u32	glk_tun_val;
 };
 
 static const guid_t intel_dsm_guid =
@@ -791,6 +795,77 @@ cleanup:
 	return ret;
 }
 
+#ifdef CONFIG_PM
+#define GLK_RX_CTRL1	0x834
+#define GLK_TUN_VAL	0x840
+#define GLK_PATH_PLL	GENMASK(13, 8)
+#define GLK_DLY		GENMASK(6, 0)
+/* Workaround firmware failing to restore the tuning value */
+static void glk_rpm_retune_wa(struct sdhci_pci_chip *chip, bool susp)
+{
+	struct sdhci_pci_slot *slot = chip->slots[0];
+	struct intel_host *intel_host = sdhci_pci_priv(slot);
+	struct sdhci_host *host = slot->host;
+	u32 glk_rx_ctrl1;
+	u32 glk_tun_val;
+	u32 dly;
+
+	if (intel_host->rpm_retune_ok || !mmc_can_retune(host->mmc))
+		return;
+
+	glk_rx_ctrl1 = sdhci_readl(host, GLK_RX_CTRL1);
+	glk_tun_val = sdhci_readl(host, GLK_TUN_VAL);
+
+	if (susp) {
+		intel_host->glk_rx_ctrl1 = glk_rx_ctrl1;
+		intel_host->glk_tun_val = glk_tun_val;
+		return;
+	}
+
+	if (!intel_host->glk_tun_val)
+		return;
+
+	if (glk_rx_ctrl1 != intel_host->glk_rx_ctrl1) {
+		intel_host->rpm_retune_ok = true;
+		return;
+	}
+
+	dly = FIELD_PREP(GLK_DLY, FIELD_GET(GLK_PATH_PLL, glk_rx_ctrl1) +
+				  (intel_host->glk_tun_val << 1));
+	if (dly == FIELD_GET(GLK_DLY, glk_rx_ctrl1))
+		return;
+
+	glk_rx_ctrl1 = (glk_rx_ctrl1 & ~GLK_DLY) | dly;
+	sdhci_writel(host, glk_rx_ctrl1, GLK_RX_CTRL1);
+
+	intel_host->rpm_retune_ok = true;
+	chip->rpm_retune = true;
+	mmc_retune_needed(host->mmc);
+	pr_info("%s: Requiring re-tune after rpm resume", mmc_hostname(host->mmc));
+}
+
+static void glk_rpm_retune_chk(struct sdhci_pci_chip *chip, bool susp)
+{
+	if (chip->pdev->device == PCI_DEVICE_ID_INTEL_GLK_EMMC &&
+	    !chip->rpm_retune)
+		glk_rpm_retune_wa(chip, susp);
+}
+
+static int glk_runtime_suspend(struct sdhci_pci_chip *chip)
+{
+	glk_rpm_retune_chk(chip, true);
+
+	return sdhci_cqhci_runtime_suspend(chip);
+}
+
+static int glk_runtime_resume(struct sdhci_pci_chip *chip)
+{
+	glk_rpm_retune_chk(chip, false);
+
+	return sdhci_cqhci_runtime_resume(chip);
+}
+#endif
+
 #ifdef CONFIG_ACPI
 static int ni_set_max_freq(struct sdhci_pci_slot *slot)
 {
@@ -879,8 +954,8 @@ static const struct sdhci_pci_fixes sdhc
 	.resume			= sdhci_cqhci_resume,
 #endif
 #ifdef CONFIG_PM
-	.runtime_suspend	= sdhci_cqhci_runtime_suspend,
-	.runtime_resume		= sdhci_cqhci_runtime_resume,
+	.runtime_suspend	= glk_runtime_suspend,
+	.runtime_resume		= glk_runtime_resume,
 #endif
 	.quirks			= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2		= SDHCI_QUIRK2_PRESET_VALUE_BROKEN |


