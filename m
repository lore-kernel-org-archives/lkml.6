Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B4E05C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6945E208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TnpcXpCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6945E208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934154AbeFLO5W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:57:22 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45302 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933394AbeFLO5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:57:20 -0400
Received: by mail-wr0-f193.google.com with SMTP id o12-v6so24410857wrm.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 07:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lSxJbUdHNmVBPGUOkpXnq+1zAeru6Vo8+QUxKtlWkQ8=;
        b=TnpcXpCooscpUzEozegNOvd6xJahWMXweN9g3OOY8LL9ILst7gJJRdeXWd3WOHHNe3
         lpTsSHiQxYabG6h0XmoJb8v1dwdEgNMmpyLP4Gq1xdhZRI77jTWPl6kh0mt03K5sawCs
         Qb90VfMArix+tZnWuyBEASyoc4k4PDfUp3Zko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lSxJbUdHNmVBPGUOkpXnq+1zAeru6Vo8+QUxKtlWkQ8=;
        b=A/WXiO347bUihiJxH2hZsLz/8BtcO/HM+nuKbyySxus5J2qHDJ8xNkxAcU3V7Dp4K0
         qxhrjJROOw2fMq2AaV0GPrSNn0H3yn+6/JpAgKbK+7f+ZQ2g6S/vW5Lv2efskBdkc+m4
         /u48UQCNf4xrEXMikK1cCEJsHj0hHnis/k09rVCnnCM7bfdpvRwi3oohZfRpVZ+4/o/7
         FbtD9eAyVEFlUvyT2aDKhnPRhuU0mr0wkM31TuFkzU0ZG3+U9z1wt7Hdt1H107Vcyd3G
         t9TqULNckLSSnL3umnX69jgoz5FpqU0wyf1CVNZjR7Colg2ASOKurrJJBPFfI05tzIup
         LNoQ==
X-Gm-Message-State: APt69E0hKleACzFtuHf2kpsKWLZsmHWvLBAWb9Si1LPM7XYpDYCtqg1z
        C40XSKWQiqJpQOvaAkQKh5MpGg==
X-Google-Smtp-Source: ADUXVKL+5iuqSc9jLM2C2/T5DM2/FTcxuBTkyiIhYoCnnJ8XFt4h2gIltBJfljIO52k78N3Ti2fKpA==
X-Received: by 2002:adf:f8c2:: with SMTP id f2-v6mr538977wrq.237.1528815439365;
        Tue, 12 Jun 2018 07:57:19 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id o16-v6sm474408wrp.8.2018.06.12.07.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jun 2018 07:57:18 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        sboyd@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] irqchip/gic-v3: do not access GICR_WAKER if its secured register.
Date:   Tue, 12 Jun 2018 15:55:16 +0100
Message-Id: <20180612145516.30897-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GICR_WAKER can be a secured register, check this before accessing it
as its done in power management code.

Without this patch Qualcomm DB820c board crashes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 5a67ec084588..38136d6e9ca5 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -656,6 +656,12 @@ static int gic_dist_supports_lpis(void)
 	return !!(readl_relaxed(gic_data.dist_base + GICD_TYPER) & GICD_TYPER_LPIS) && !gicv3_nolpi;
 }
 
+/* Check whether it's single security state view */
+static bool gic_dist_security_disabled(void)
+{
+	return readl_relaxed(gic_data.dist_base + GICD_CTLR) & GICD_CTLR_DS;
+}
+
 static void gic_cpu_init(void)
 {
 	void __iomem *rbase;
@@ -664,7 +670,8 @@ static void gic_cpu_init(void)
 	if (gic_populate_rdist())
 		return;
 
-	gic_enable_redist(true);
+	if (gic_dist_security_disabled())
+		gic_enable_redist(true);
 
 	rbase = gic_data_rdist_sgi_base();
 
@@ -819,11 +826,6 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 #endif
 
 #ifdef CONFIG_CPU_PM
-/* Check whether it's single security state view */
-static bool gic_dist_security_disabled(void)
-{
-	return readl_relaxed(gic_data.dist_base + GICD_CTLR) & GICD_CTLR_DS;
-}
 
 static int gic_cpu_pm_notifier(struct notifier_block *self,
 			       unsigned long cmd, void *v)
-- 
2.16.2

