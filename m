Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F081C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9AC20676
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7qPe3TH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9AC20676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbeHXMze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:55:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39900 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbeHXMze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:55:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so4266264pff.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 02:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F8ycUMm5cEF7zHqTC/mFHa7ECSePE1v/XI0xbfy/QLA=;
        b=Z7qPe3THEZioTqfmBT0VRxkEuJMLizX/DerVHLOSNrZCI2MSmODuw9sjtk9OfJ9+Fl
         D/qHOUKLUXODKZ8UbB/cFmv8tgDt7hNumQhM5lErvlyvQQ22+27KkijbhMKYB4B20VXc
         GgTu5PWE3jdRUwaT4fezdVhVpGHqKJbGnQQyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F8ycUMm5cEF7zHqTC/mFHa7ECSePE1v/XI0xbfy/QLA=;
        b=i9zc/TkBXziTo9U6V/kpthne1w2d450RewlskoHxKLH9B8u/oz/J04nJrZFZXIXbYw
         4fhOgD7BazLfZ/7Qxh1sKqzFRfFRWykVNHNR4HHuVKGfocuxfSWpy+uO7k3d72llulYz
         25PwC7pfIj0daDi3bCfUjqYtFTKMdLJqJJ9Idnh9tK3N3KeYo5rkIhd9tuIM2gamUF2r
         IGOD2h6nxJOSNYwnMp2aptL+WWwHecUO+L06HBKzUQFwUGEP4WOk9PV/vt6o385ecfdi
         z2hVYqhy4rlsNzCk+HUnF/+4YMjEU+QkGnyq7TDTI52htw3S2/3x9clDVskhaMg0oHsz
         1W1w==
X-Gm-Message-State: APzg51DaVSDIKikamaLr7wOUQZqIaAzYEABpf3rR4EEOw+bJnJTseEfF
        QSLnAzk9hcxrHc+cLn1lpettTw==
X-Google-Smtp-Source: ANB0VdZQK18eQxcC5TdU8bmpkHXvDCIIgQiAo0FSgNjWKd2BO8gCP/G/QX5blZg1G9R27WfktzIQgA==
X-Received: by 2002:a63:1c07:: with SMTP id c7-v6mr888654pgc.109.1535102507976;
        Fri, 24 Aug 2018 02:21:47 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id g6-v6sm9520314pfb.11.2018.08.24.02.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Aug 2018 02:21:47 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V6 7/9] mmc: sdhci: SDMA may use Auto-CMD23 in v4 mode
Date:   Fri, 24 Aug 2018 17:20:26 +0800
Message-Id: <1535102428-20332-8-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535102428-20332-1-git-send-email-zhang.chunyan@linaro.org>
References: <1535102428-20332-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Host Version 4 Enable is set to 1, SDMA uses ADMA System Address
register (05Fh-058h) instead of using register (000h-004h) to indicate
its system address of data location. The register (000h-004h) is
re-assigned to 32-bit Block Count and Auto CMD23 argument, so then SDMA
may use Auto CMD23.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7e01601..1cb55f2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3828,10 +3828,14 @@ int sdhci_setup_host(struct sdhci_host *host)
 	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
 		host->flags |= SDHCI_AUTO_CMD12;
 
-	/* Auto-CMD23 stuff only works in ADMA or PIO. */
+	/*
+	 * For v3 mode, Auto-CMD23 stuff only works in ADMA or PIO;
+	 * For v4 mode, SDMA may use Auto-CMD23 as well.
+	 */
 	if ((host->version >= SDHCI_SPEC_300) &&
 	    ((host->flags & SDHCI_USE_ADMA) ||
-	     !(host->flags & SDHCI_USE_SDMA)) &&
+	     (!host->v4_mode && !(host->flags & SDHCI_USE_SDMA)) ||
+	     (host->v4_mode && (host->flags & SDHCI_USE_SDMA))) &&
 	     !(host->quirks2 & SDHCI_QUIRK2_ACMD23_BROKEN)) {
 		host->flags |= SDHCI_AUTO_CMD23;
 		DBG("Auto-CMD23 available\n");
-- 
2.7.4

