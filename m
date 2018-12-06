Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC61C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC31220838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC31220838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbeLFQsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:48:12 -0500
Received: from foss.arm.com ([217.140.101.70]:55482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbeLFQsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:48:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01E0615AB;
        Thu,  6 Dec 2018 08:48:08 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A5433F5AF;
        Thu,  6 Dec 2018 08:48:03 -0800 (PST)
From:   Andrew Murray <andrew.murray@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Russell King <linux@armlinux.org.uk>, suzuki.poulose@arm.com,
        robin.murphy@arm.com, Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: [PATCH v3 06/12] arm: perf/core: use PERF_PMU_CAP_NO_EXCLUDE for exclude incapable PMUs
Date:   Thu,  6 Dec 2018 16:47:23 +0000
Message-Id: <1544114849-47266-7-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544114849-47266-1-git-send-email-andrew.murray@arm.com>
References: <1544114849-47266-1-git-send-email-andrew.murray@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For drivers that do not support context exclusion let's advertise the
PERF_PMU_CAP_NO_EXCLUDE capability. This ensures that perf will
prevent us from handling events where any exclusion flags are set.
Let's also remove the now unnecessary check for exclusion flags.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm/mach-imx/mmdc.c     | 9 ++-------
 arch/arm/mm/cache-l2x0-pmu.c | 9 +--------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index 04b3bf7..3453838 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -293,13 +293,7 @@ static int mmdc_pmu_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 	}
 
-	if (event->attr.exclude_user		||
-			event->attr.exclude_kernel	||
-			event->attr.exclude_hv		||
-			event->attr.exclude_idle	||
-			event->attr.exclude_host	||
-			event->attr.exclude_guest	||
-			event->attr.sample_period)
+	if (event->attr.sample_period)
 		return -EINVAL;
 
 	if (cfg < 0 || cfg >= MMDC_NUM_COUNTERS)
@@ -455,6 +449,7 @@ static int mmdc_pmu_init(struct mmdc_pmu *pmu_mmdc,
 			.start          = mmdc_pmu_event_start,
 			.stop           = mmdc_pmu_event_stop,
 			.read           = mmdc_pmu_event_update,
+			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 		},
 		.mmdc_base = mmdc_base,
 		.dev = dev,
diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
index afe5b4c..99bcd07 100644
--- a/arch/arm/mm/cache-l2x0-pmu.c
+++ b/arch/arm/mm/cache-l2x0-pmu.c
@@ -314,14 +314,6 @@ static int l2x0_pmu_event_init(struct perf_event *event)
 	    event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
 
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest)
-		return -EINVAL;
-
 	if (event->cpu < 0)
 		return -EINVAL;
 
@@ -544,6 +536,7 @@ static __init int l2x0_pmu_init(void)
 		.del = l2x0_pmu_event_del,
 		.event_init = l2x0_pmu_event_init,
 		.attr_groups = l2x0_pmu_attr_groups,
+		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
 	l2x0_pmu_reset();
-- 
2.7.4

