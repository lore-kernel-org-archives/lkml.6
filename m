Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCEAC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C69B27BCE
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="njWJlFNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C69B27BCE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936388AbeF2Spk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:45:40 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36609 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932375AbeF2Spi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:45:38 -0400
Received: by mail-pl0-f68.google.com with SMTP id a7-v6so4862954plp.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3vFXZ+ABLKjpZ3kKVOChXl5BjFWqcYN8M/C11BL6jaI=;
        b=njWJlFNchvtSrCurZO2ZBMYtHqVStbT5B5nG5UE4yhki5VH4Eo6D6Yo+VyzNRppWMG
         6hxtMrFD1h6RVbDw/V3rNUxsGAZB5TIKq9JImmn44kmFlZ9W+h3x4xvOZHwjz2UVrO35
         EBqTZnUwXtgDKJYgT9AU+1brrdFZlMq5X0eww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3vFXZ+ABLKjpZ3kKVOChXl5BjFWqcYN8M/C11BL6jaI=;
        b=TAY2oCA1nfwaFu+UwQ5yDg3AuUE+zfvrX90485DrenIbrA/oKBfEXS2MoVIU23ndMJ
         d55U5xgTY7FiLaadE933A52qWtWR/OSrKb9TRjqO2LP19vtvazR6anZQSyk0WuPuiBcd
         jmKEYYcEh3Yki4ReOxNmXybtG2Ju0uLSPy+/e9onO4oSou25xWtpuD8Gt+Fi2L/NyWzA
         Pd1X89xK01j8vO1xHhEL2G+JkiHiARYvEd616+zaL3bEUAhIiMdT81ciRbt7lEdV4Ft+
         saoXh9H+6SWl5Pm1JuEDXkG8kFIjMv3M0OxabRBikXX0pYP4HbEFuNtdZMOmpHxLUPs2
         k0kA==
X-Gm-Message-State: APt69E3mIrKK24CGGiSg7lITdjy6HIFAyuBva7HMYf9gH5LYsIOSYDox
        pwnVEeGXoAPGFRFQnTIMWDvR2Q==
X-Google-Smtp-Source: ADUXVKLpqjGYQhW1Gz0png3Rzg3TzvY8zW6wZB/sQMs1uco4ZfDRuRCQdx5UWDzJIOcGXiD7t7SCUg==
X-Received: by 2002:a17:902:728a:: with SMTP id d10-v6mr15916944pll.192.1530297938127;
        Fri, 29 Jun 2018 11:45:38 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id e10-v6sm12412075pgv.48.2018.06.29.11.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 11:45:37 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:45:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf/arm-cci: Remove VLA usage
Message-ID: <20180629184536.GA37337@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
removes the VLA in favor of a maximum size and adds a sanity check
at registration time. The sizes are all explicitly enumerated already,
so this just collects them into macros.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/perf/arm-cci.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 0d09d8e669cd..1bfeb160c5b1 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -53,6 +53,16 @@ enum {
 	CCI_IF_MAX,
 };
 
+#define NUM_HW_CNTRS_CII_4XX	4
+#define NUM_HW_CNTRS_CII_5XX	8
+#define NUM_HW_CNTRS_MAX	NUM_HW_CNTRS_CII_5XX
+
+#define FIXED_HW_CNTRS_CII_4XX	1
+#define FIXED_HW_CNTRS_CII_5XX	0
+#define FIXED_HW_CNTRS_MAX	FIXED_HW_CNTRS_CII_4XX
+
+#define HW_CNTRS_MAX		(NUM_HW_CNTRS_MAX + FIXED_HW_CNTRS_MAX)
+
 struct event_range {
 	u32 min;
 	u32 max;
@@ -633,8 +643,7 @@ static void cci_pmu_sync_counters(struct cci_pmu *cci_pmu)
 {
 	int i;
 	struct cci_pmu_hw_events *cci_hw = &cci_pmu->hw_events;
-
-	DECLARE_BITMAP(mask, cci_pmu->num_cntrs);
+	DECLARE_BITMAP(mask, HW_CNTRS_MAX);
 
 	bitmap_zero(mask, cci_pmu->num_cntrs);
 	for_each_set_bit(i, cci_pmu->hw_events.used_mask, cci_pmu->num_cntrs) {
@@ -940,7 +949,7 @@ static void pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask)
 static void cci5xx_pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask)
 {
 	int i;
-	DECLARE_BITMAP(saved_mask, cci_pmu->num_cntrs);
+	DECLARE_BITMAP(saved_mask, HW_CNTRS_MAX);
 
 	bitmap_zero(saved_mask, cci_pmu->num_cntrs);
 	pmu_save_counters(cci_pmu, saved_mask);
@@ -1245,7 +1254,7 @@ static int validate_group(struct perf_event *event)
 {
 	struct perf_event *sibling, *leader = event->group_leader;
 	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
-	unsigned long mask[BITS_TO_LONGS(cci_pmu->num_cntrs)];
+	unsigned long mask[BITS_TO_LONGS(HW_CNTRS_MAX)];
 	struct cci_pmu_hw_events fake_pmu = {
 		/*
 		 * Initialise the fake PMU. We only need to populate the
@@ -1403,6 +1412,11 @@ static int cci_pmu_init(struct cci_pmu *cci_pmu, struct platform_device *pdev)
 	char *name = model->name;
 	u32 num_cntrs;
 
+	if (WARN_ON(model->num_hw_cntrs > NUM_HW_CNTRS_MAX))
+		return -EINVAL;
+	if (WARN_ON(model->fixed_hw_cntrs > FIXED_HW_CNTRS_MAX))
+		return -EINVAL;
+
 	pmu_event_attr_group.attrs = model->event_attrs;
 	pmu_format_attr_group.attrs = model->format_attrs;
 
@@ -1455,8 +1469,8 @@ static __maybe_unused struct cci_pmu_model cci_pmu_models[] = {
 #ifdef CONFIG_ARM_CCI400_PMU
 	[CCI400_R0] = {
 		.name = "CCI_400",
-		.fixed_hw_cntrs = 1,	/* Cycle counter */
-		.num_hw_cntrs = 4,
+		.fixed_hw_cntrs = FIXED_HW_CNTRS_CII_4XX, /* Cycle counter */
+		.num_hw_cntrs = NUM_HW_CNTRS_CII_4XX,
 		.cntr_size = SZ_4K,
 		.format_attrs = cci400_pmu_format_attrs,
 		.event_attrs = cci400_r0_pmu_event_attrs,
@@ -1475,8 +1489,8 @@ static __maybe_unused struct cci_pmu_model cci_pmu_models[] = {
 	},
 	[CCI400_R1] = {
 		.name = "CCI_400_r1",
-		.fixed_hw_cntrs = 1,	/* Cycle counter */
-		.num_hw_cntrs = 4,
+		.fixed_hw_cntrs = FIXED_HW_CNTRS_CII_4XX, /* Cycle counter */
+		.num_hw_cntrs = NUM_HW_CNTRS_CII_4XX,
 		.cntr_size = SZ_4K,
 		.format_attrs = cci400_pmu_format_attrs,
 		.event_attrs = cci400_r1_pmu_event_attrs,
@@ -1497,8 +1511,8 @@ static __maybe_unused struct cci_pmu_model cci_pmu_models[] = {
 #ifdef CONFIG_ARM_CCI5xx_PMU
 	[CCI500_R0] = {
 		.name = "CCI_500",
-		.fixed_hw_cntrs = 0,
-		.num_hw_cntrs = 8,
+		.fixed_hw_cntrs = FIXED_HW_CNTRS_CII_5XX,
+		.num_hw_cntrs = NUM_HW_CNTRS_CII_5XX,
 		.cntr_size = SZ_64K,
 		.format_attrs = cci5xx_pmu_format_attrs,
 		.event_attrs = cci5xx_pmu_event_attrs,
@@ -1521,8 +1535,8 @@ static __maybe_unused struct cci_pmu_model cci_pmu_models[] = {
 	},
 	[CCI550_R0] = {
 		.name = "CCI_550",
-		.fixed_hw_cntrs = 0,
-		.num_hw_cntrs = 8,
+		.fixed_hw_cntrs = FIXED_HW_CNTRS_CII_5XX,
+		.num_hw_cntrs = NUM_HW_CNTRS_CII_5XX,
 		.cntr_size = SZ_64K,
 		.format_attrs = cci5xx_pmu_format_attrs,
 		.event_attrs = cci5xx_pmu_event_attrs,
-- 
2.17.1


-- 
Kees Cook
Pixel Security
