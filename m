Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C5DC7112C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DBA2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=astier-eu.20150623.gappssmtp.com header.i=@astier-eu.20150623.gappssmtp.com header.b="UpWJbEze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DBA2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=astier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbeJWSa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:30:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38271 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbeJWSa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:30:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id 193-v6so1124815wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 03:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=astier-eu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=1yJ8J3Yam1Q1wlDeQK3fsxuGh+b4WnI7dD8h+RpA+YI=;
        b=UpWJbEze0+jM+5C8+Fi9ybuFpiBJkNfHfHYzpWDsd1JZW+XssMvYQa5Os5lItXUmPD
         yJ2cYWuNp3NgDCFd11mNJ0lEhBLMFSzwlIgHz5KDBlEGLZ80JKaBtycBAr2fEkSGj5wV
         eLE/Ul7c8Ogs/mi8XoWImYH6MvzqcvoYJT6vL20SZZcBaZftSVB7AXrRDNQDR40SOGMg
         7q7az35HZp+2pd6yNE2ijxMV5kMwlLhpiJ8LEtv2iC4Yh/HN9qKmIbvZmuTJOzge/nsQ
         qjSwt/zM0jpYks0843grIPl+3yxMgB9s3toD9JCtKwrDQOM8Gh2vwe7EK08TLW0ux7W8
         T+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=1yJ8J3Yam1Q1wlDeQK3fsxuGh+b4WnI7dD8h+RpA+YI=;
        b=qTz40ofLFW82uA7IgrUGL2wZp0b+SA3U7qOIbd9gVYgtFCMyvybusk8dnQEDh94RVF
         JEq8rvqQnhRl83DjT5YLRXhTJiQD90dOGs/flQB6Q1PcHBI0LoA0hoU+HX91alDeLnKT
         isH3ZfDsoTjLD8IFn43c6KZ2bPDPPUW1BywlgHnMFGqZIQb1x8rUZiL5kistq/8MbaWD
         l4+MpeLUYWl/tMMKxZ4Ohs6l6s1N+JLLHVirnZMAn3GOw/BokaIAOSkqwpMYKKCXbZnl
         1fa1/Pvkqfl6eSwraCO6x3ttpNBglcXnmExrCKi+ysEpOvlT+ZFfpZ9Clhx4/8tS8UCd
         /LAQ==
X-Gm-Message-State: AGRZ1gJvizQhrPJsqcinPciAzZmw4mv5GnWfQCkas0JWneYCPi+AY/5T
        nrw8Lj5LVykMgGOt08yjmox93A==
X-Google-Smtp-Source: AJdET5ce2uwYGyCPfGTvewhHTTLEmoMkTtZozUEe6wFAq4dCCItDDkaT9gpst2T8EIyacsImzIvHiQ==
X-Received: by 2002:a1c:7a0a:: with SMTP id v10-v6mr2532579wmc.41.1540289263047;
        Tue, 23 Oct 2018 03:07:43 -0700 (PDT)
Received: from jaya.substantiel.local ([92.103.140.194])
        by smtp.gmail.com with ESMTPSA id i13-v6sm910930wrn.62.2018.10.23.03.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 03:07:42 -0700 (PDT)
From:   Anisse Astier <anisse@astier.eu>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Anisse Astier <anisse@astier.eu>
Subject: [PATCH v2 1/3] mmc: sdhci-pci: disable 1.8V with dmi quirk
Date:   Tue, 23 Oct 2018 12:07:27 +0200
Message-Id: <20181023100729.28864-2-anisse@astier.eu>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181023100729.28864-1-anisse@astier.eu>
References: <20181023100729.28864-1-anisse@astier.eu>
In-Reply-To: <20181022134026.GB18413@jaya>
References: <20181022134026.GB18413@jaya>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the motherboard is known not to support 1.8V properly, add the
necessary quirk on probe.

This fixes an issue on a Gemini Lake (GLK) laptop : eMMC driver will
timeout on boot (from 60seconds to 10minutes ) as the cqhci attempts CQE
recovery after a failed voltage switch. In earlier kernels, the problem
existed, but only delayed boot for about 10 seconds after an I/O error,
allowing booting on the eMMC (almost) unnoticed.

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
 drivers/mmc/host/sdhci-pci-core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 7bfd366d970d..396413f7c854 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -29,6 +29,7 @@
 #include <linux/mmc/slot-gpio.h>
 #include <linux/mmc/sdhci-pci-data.h>
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 
 #include "cqhci.h"
 
@@ -703,6 +704,16 @@ static int intel_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	return 0;
 }
 
+static const struct dmi_system_id board_no_1_8v[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "N75_77GU"),
+		},
+	},
+	{ }
+};
+
 static void byt_probe_slot(struct sdhci_pci_slot *slot)
 {
 	struct mmc_host_ops *ops = &slot->host->mmc_host_ops;
@@ -710,6 +721,12 @@ static void byt_probe_slot(struct sdhci_pci_slot *slot)
 	byt_read_dsm(slot);
 
 	ops->execute_tuning = intel_execute_tuning;
+
+	if (dmi_check_system(board_no_1_8v)) {
+		pr_debug("%s: motherboard does not support 1.8V\n",
+				mmc_hostname(slot->host->mmc));
+		slot->host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
+	}
 	ops->start_signal_voltage_switch = intel_start_signal_voltage_switch;
 }
 
-- 
2.17.2

