Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584C5C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109D0213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="w01CBHkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109D0213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeGLHsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 03:48:19 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:55534 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbeGLHsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 03:48:19 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 58FCA5C21AE;
        Thu, 12 Jul 2018 09:39:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1531381174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4wyMXkujJgN3jQUwl1mNOxOpAFMCFVzLo77q8H9i9DQ=;
        b=w01CBHkjCi6pKosB68LsEKDwUpG+XOXVToGZL0CynyNCMmdTba9lEsE5cGbjfqGOafcSXD
        Je6lBFGsjCmq4JRZBhiFHcB1qyaLnLYcM2wmYNGGvEb6Mpw0arp1VvxVpuLfnypuF/arWj
        R9t6lRZkWsg/rA0u9HKj/Iik3XxjZTk=
From:   Stefan Agner <stefan@agner.ch>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        marcel.ziswiler@toradex.com, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 3/3] mmc: tegra: prevent ACMD23 on Tegra 3
Date:   Thu, 12 Jul 2018 09:39:04 +0200
Message-Id: <20180712073904.4705-3-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712073904.4705-1-stefan@agner.ch>
References: <20180712073904.4705-1-stefan@agner.ch>
X-Spamd-Result: default: False [-0.75 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-1.65)[92.83%];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:6830, ipnet:46.140.0.0/17, country:AT];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that SD3.0 advertisement needs to be set for higher eMMC
speed modes (namely DDR52) as well. The TRM states that the SD3.0
advertisement bit should be set for all controller instances, even
for those not supporting UHS-I mode...

When specifying vqmmc-supply as a fixed 1.8V regulator on a Tegra
SD/MMC instance which is connected to a eMMC device, the stack
enables SD3.0. However, enabling it has consequences: If SDHCI 3.0
support is advertised the stack enables Auto-CMD23. Unfortunately
Auto-CMD23 seems not to work well with Tegra 3 currently. It leads
to regular warnings:
  mmc2: Got command interrupt 0x00010000 even though no command operation was in progress.

It is not entirely clear why those errors happens. It seems that
a Linux 3.1 based downstream kernel which has Auto-CMD23 support
does not show those warnings.

Use quirk SDHCI_QUIRK2_ACMD23_BROKEN to prevent Auto-CMD23 being
used for now. With this the eMMC works stable on high-speed mode
while still announcing SD3.0.

This allows to use mmc-ddr-1_8v to enables DDR52 mode. In DDR52
mode read speed improves from about 42MiB/s to 72MiB/s on an
Apalis T30.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mmc/host/sdhci-tegra.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 888a1ad511db..11c0b2069c7c 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -336,7 +336,15 @@ static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-		   SDHCI_QUIRK2_BROKEN_HS200,
+		   SDHCI_QUIRK2_BROKEN_HS200 |
+		   /*
+		    * Auto-CMD23 leads to "Got command interrupt 0x00010000 even
+		    * though no command operation was in progress."
+		    *
+		    * The exact reason is unknown, as the same hardware seems
+		    * to support Auto CMD23 on a downstream 3.1 kernel.
+		    */
+		   SDHCI_QUIRK2_ACMD23_BROKEN,
 	.ops  = &tegra_sdhci_ops,
 };
 
-- 
2.18.0

