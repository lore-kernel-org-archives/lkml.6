Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACAFC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802D322477
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="kyC2PbOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802D322477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934800AbeF1ION (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:14:13 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:49412 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934404AbeF1INg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:13:36 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 144E95C09CA;
        Thu, 28 Jun 2018 10:13:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1530173615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pk1NYVr9X0tsplWMIfODhSiySJdelU2JYiMfPCE0/nE=;
        b=kyC2PbOusMEb7ODRP65++JYzuC2NWY1+1GJAxUa6eafpk4RNb8P3O01acNFcmrWXbpOqJ+
        FMgdIyR6GN3K7a9BKPOrrcKbI3p0shkzqQZtVNlRpM5QQNmNCdNFMsUFahz0jiHblofkO7
        IM+ZL7JnpKUaUUV8+dzuOdqivwrvI/A=
From:   Stefan Agner <stefan@agner.ch>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     fabio.estevam@nxp.com, haibo.chen@nxp.com, aisheng.dong@nxp.com,
        michael@amarulasolutions.com, rmk+kernel@armlinux.org.uk,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/3] mmc: sdhci: add quirk to prevent higher speed modes
Date:   Thu, 28 Jun 2018 10:13:30 +0200
Message-Id: <20180628081331.13051-3-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180628081331.13051-1-stefan@agner.ch>
References: <20180628081331.13051-1-stefan@agner.ch>
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         TAGGED_RCPT(0.00)[kernel];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[10];
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

Some hosts are capable of running higher speed modes but do not
have the board support for it. Introduce a quirk which prevents
the stack from using modes running at 100MHz or faster.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mmc/host/sdhci.c | 8 ++++++++
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1c828e0e9905..8ac257dfaab3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3749,6 +3749,14 @@ int sdhci_setup_host(struct sdhci_host *host)
 		}
 	}
 
+	if (host->quirks2 & SDHCI_QUIRK2_NO_UHS_HS200_HS400) {
+		host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
+				 SDHCI_SUPPORT_DDR50);
+
+		mmc->caps2 &= ~(MMC_CAP2_HSX00_1_8V | MMC_CAP2_HSX00_1_2V |
+				MMC_CAP2_HS400_ES);
+	}
+
 	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V) {
 		host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
 				 SDHCI_SUPPORT_DDR50);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 23966f887da6..cb2433d6d61f 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -450,6 +450,8 @@ struct sdhci_host {
  * obtainable timeout.
  */
 #define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
+/* Do not support any higher speeds (>50MHz) */
+#define SDHCI_QUIRK2_NO_UHS_HS200_HS400			(1<<18)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.18.0

