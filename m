Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A9FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98C9218A3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151240;
	bh=Da7vgIY9hpI3HkO70rfyeVWzMY5TBsby0iDEC7AEuxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NjLEgITCf0UNSDAalcVA8DjtJ/LGGKjq+thhaNZoCa6GAdIHBf/m6s+ksCtPa9QTR
	 Akhdwk+Wlr6tvQ4LIEPHWn2w9fijB/kzz6538Lci6xn82KmBIWAzYTZunGjemusMzD
	 p3R2jPnH0XVfKsVtZX9M7Bok4uiFgxHa4fvKjQjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeLRQkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:40:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbeLRQkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:40:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8FCF21873;
        Tue, 18 Dec 2018 16:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151231;
        bh=Da7vgIY9hpI3HkO70rfyeVWzMY5TBsby0iDEC7AEuxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UHX8MDZaqhApEjqC2mua3JqcmIHkB1ExNTb02ffUEKct8PKuoHLlUuCweYb1B8q4v
         e8M3p1NcmwxIU2sR9Xh0iDaFWUQzpOQpzNP9t8dixRJ/F6lR512gugCoVAFKiGjYNu
         qitCKpPUzA5BARiABJGeEVcLFwVMhrgCZZ24oImY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Faiz Abbas <faiz_abbas@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 19/44] mmc: sdhci-omap: Fix DCRC error handling during tuning
Date:   Tue, 18 Dec 2018 17:39:31 +0100
Message-Id: <20181218163929.742254637@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
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

From: Faiz Abbas <faiz_abbas@ti.com>

commit db2039fcfd5754d15986340152e4503737f68f8d upstream.

Commit 7d33c3581536 ("mmc: sdhci-omap: Workaround for Errata i802")
disabled DCRC interrupts during tuning. This write to the interrupt
enable register gets overwritten in sdhci_prepare_data() and the
interrupt is not in fact disabled. Fix this by disabling the interrupt
in the host->ier variable.

Fixes: 7d33c3581536 ("mmc: sdhci-omap: Workaround for Errata i802")
Cc: <stable@vger.kernel.org>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-omap.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -288,9 +288,9 @@ static int sdhci_omap_execute_tuning(str
 	struct device *dev = omap_host->dev;
 	struct mmc_ios *ios = &mmc->ios;
 	u32 start_window = 0, max_window = 0;
+	bool dcrc_was_enabled = false;
 	u8 cur_match, prev_match = 0;
 	u32 length = 0, max_len = 0;
-	u32 ier = host->ier;
 	u32 phase_delay = 0;
 	int ret = 0;
 	u32 reg;
@@ -317,9 +317,10 @@ static int sdhci_omap_execute_tuning(str
 	 * during the tuning procedure. So disable it during the
 	 * tuning procedure.
 	 */
-	ier &= ~SDHCI_INT_DATA_CRC;
-	sdhci_writel(host, ier, SDHCI_INT_ENABLE);
-	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
+	if (host->ier & SDHCI_INT_DATA_CRC) {
+		host->ier &= ~SDHCI_INT_DATA_CRC;
+		dcrc_was_enabled = true;
+	}
 
 	while (phase_delay <= MAX_PHASE_DELAY) {
 		sdhci_omap_set_dll(omap_host, phase_delay);
@@ -366,6 +367,9 @@ tuning_error:
 
 ret:
 	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+	/* Reenable forbidden interrupt */
+	if (dcrc_was_enabled)
+		host->ier |= SDHCI_INT_DATA_CRC;
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 	return ret;


