Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A45BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F27A2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GKHA+3Vx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YWiGLd4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F27A2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965400AbeFSFj7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:39:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58300 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964895AbeFSFjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:39:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D89FF60B16; Tue, 19 Jun 2018 05:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529386794;
        bh=Iy240IvJJ8UVY1+LPtXoR58T2ywWggPYYy7Gplm9UKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GKHA+3Vx55bkbZ/j7OuplPAkudIOGlWrUKKK14R8SbBcLFh7aQu1UZnJooE4t86e3
         gYFQ8DuB8ednLzyvCK2P1OcOAz7L/5YWm3RcG3g0NW6reAKU9ri1aIR4McET45UhQo
         vZrxZAtBR+CFxx5vGRNLL/7wJvRCd3cyhUBob6Ec=
Received: from hydcbspbld03.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vviswana@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EF51A604A6;
        Tue, 19 Jun 2018 05:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529386793;
        bh=Iy240IvJJ8UVY1+LPtXoR58T2ywWggPYYy7Gplm9UKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YWiGLd4Lg0c6HJ3KT3Al7TJG/CA8vduVpC8AzbmOx8ZplNMwIGJ8RzC3SllQU/OJ4
         jWkmR8TMVMOy0kiXQka2q93Sws+rTZuHWp3sZHpPCeHtRCxg7V88ig9XoBvX3cMziK
         362wE2UuFMFw696gpXxUIus3I9ZQxm1tRIWlFxAE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF51A604A6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vviswana@codeaurora.org
From:   Vijay Viswanath <vviswana@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        vviswana@codeaurora.org, bjorn.andersson@linaro.org,
        riteshh@codeaurora.org, vbadigan@codeaurora.org,
        dianders@google.com, sayalil@codeaurora.org
Subject: [PATCH V3 2/4] mmc: sdhci-msm: Add msm version specific ops and data structures
Date:   Tue, 19 Jun 2018 11:09:19 +0530
Message-Id: <1529386761-4923-3-git-send-email-vviswana@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529386761-4923-1-git-send-email-vviswana@codeaurora.org>
References: <1529386761-4923-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to offsets of certain registers changing, the registers in
core_mem have been shifted to HC mem as well. To access these
registers, define msm version specific functions. These functions can
be loaded into the function pointers at the time of probe based on
the msm version detected.

Also defind new data structure to hold version specific Ops and
register addresses.

Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/mmc/host/sdhci-msm.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 4050c99..3d01bc2 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -226,6 +226,22 @@ struct sdhci_msm_offset {
 	.core_ddr_config_2 = 0x1bc,
 };
 
+struct sdhci_msm_variant_ops {
+	u32 (*msm_readl_relaxed)(struct sdhci_host *host, u32 offset);
+	void (*msm_writel_relaxed)(u32 val, struct sdhci_host *host,
+			u32 offset);
+};
+
+/*
+ * From V5, register spaces have changed. Wrap this info in a structure
+ * and choose the data_structure based on version info mentioned in DT.
+ */
+struct sdhci_msm_variant_info {
+	bool mci_removed;
+	const struct sdhci_msm_variant_ops *var_ops;
+	const struct sdhci_msm_offset *offset;
+};
+
 struct sdhci_msm_host {
 	struct platform_device *pdev;
 	void __iomem *core_mem;	/* MSM SDCC mapped address */
@@ -245,8 +261,45 @@ struct sdhci_msm_host {
 	wait_queue_head_t pwr_irq_wait;
 	bool pwr_irq_flag;
 	u32 caps_0;
+	bool mci_removed;
+	const struct sdhci_msm_variant_ops *var_ops;
+	const struct sdhci_msm_offset *offset;
 };
 
+/*
+ * APIs to read/write to vendor specific registers which were there in the
+ * core_mem region before MCI was removed.
+ */
+static u32 sdhci_msm_mci_variant_readl_relaxed(struct sdhci_host *host,
+		u32 offset)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+
+	return readl_relaxed(msm_host->core_mem + offset);
+}
+
+static u32 sdhci_msm_v5_variant_readl_relaxed(struct sdhci_host *host,
+		u32 offset)
+{
+	return readl_relaxed(host->ioaddr + offset);
+}
+
+static void sdhci_msm_mci_variant_writel_relaxed(u32 val,
+		struct sdhci_host *host, u32 offset)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+
+	writel_relaxed(val, msm_host->core_mem + offset);
+}
+
+static void sdhci_msm_v5_variant_writel_relaxed(u32 val,
+		struct sdhci_host *host, u32 offset)
+{
+	writel_relaxed(val, host->ioaddr + offset);
+}
+
 static unsigned int msm_get_clock_rate_for_bus_mode(struct sdhci_host *host,
 						    unsigned int clock)
 {
@@ -1481,6 +1534,28 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
 	pr_debug("%s: supported caps: 0x%08x\n", mmc_hostname(mmc), caps);
 }
 
+static const struct sdhci_msm_variant_ops mci_var_ops = {
+	.msm_readl_relaxed = sdhci_msm_mci_variant_readl_relaxed,
+	.msm_writel_relaxed = sdhci_msm_mci_variant_writel_relaxed,
+};
+
+static const struct sdhci_msm_variant_ops v5_var_ops = {
+	.msm_readl_relaxed = sdhci_msm_v5_variant_readl_relaxed,
+	.msm_writel_relaxed = sdhci_msm_v5_variant_writel_relaxed,
+};
+
+static const struct sdhci_msm_variant_info sdhci_msm_mci_var = {
+	.mci_removed = false,
+	.var_ops = &mci_var_ops,
+	.offset = &sdhci_msm_mci_offset,
+};
+
+static const struct sdhci_msm_variant_info sdhci_msm_v5_var = {
+	.mci_removed = true,
+	.var_ops = &v5_var_ops,
+	.offset = &sdhci_msm_v5_offset,
+};
+
 static const struct of_device_id sdhci_msm_dt_match[] = {
 	{ .compatible = "qcom,sdhci-msm-v4" },
 	{},
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

