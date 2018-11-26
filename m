Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF6EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F09020660
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F09020660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbeKZWIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:08:38 -0500
Received: from foss.arm.com ([217.140.101.70]:33170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730003AbeKZWIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:08:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1388B3918;
        Mon, 26 Nov 2018 03:14:50 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FD493F5AF;
        Mon, 26 Nov 2018 03:14:45 -0800 (PST)
From:   Andrew Murray <andrew.murray@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-s390@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org
Subject: [PATCH v2 17/20] x86: perf/core: remove unnecessary checks for exclusion
Date:   Mon, 26 Nov 2018 11:12:33 +0000
Message-Id: <1543230756-15319-18-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For drivers that do not support context exclusion we do not
advertise the PERF_PMU_CAP_EXCLUDE capability. This ensures
that perf will prevent us from handling events where any exclusion
flags are set. Let's remove the now unnecessary check for
exclusion flags.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/x86/events/amd/ibs.c          | 12 ------------
 arch/x86/events/amd/power.c        |  9 +--------
 arch/x86/events/intel/cstate.c     |  8 +-------
 arch/x86/events/intel/rapl.c       |  8 +-------
 arch/x86/events/intel/uncore_snb.c |  8 +-------
 arch/x86/events/msr.c              |  8 +-------
 6 files changed, 5 insertions(+), 48 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index d50bb4d..9e43ef6 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -253,15 +253,6 @@ static int perf_ibs_precise_event(struct perf_event *event, u64 *config)
 	return -EOPNOTSUPP;
 }
 
-static const struct perf_event_attr ibs_notsupp = {
-	.exclude_user	= 1,
-	.exclude_kernel	= 1,
-	.exclude_hv	= 1,
-	.exclude_idle	= 1,
-	.exclude_host	= 1,
-	.exclude_guest	= 1,
-};
-
 static int perf_ibs_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -282,9 +273,6 @@ static int perf_ibs_init(struct perf_event *event)
 	if (event->pmu != &perf_ibs->pmu)
 		return -ENOENT;
 
-	if (perf_flags(&event->attr) & perf_flags(&ibs_notsupp))
-		return -EINVAL;
-
 	if (config & ~perf_ibs->config_mask)
 		return -EINVAL;
 
diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
index 2aefacf..ef80c60 100644
--- a/arch/x86/events/amd/power.c
+++ b/arch/x86/events/amd/power.c
@@ -136,14 +136,7 @@ static int pmu_event_init(struct perf_event *event)
 		return -ENOENT;
 
 	/* Unsupported modes and filters. */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest  ||
-	    /* no sampling */
-	    event->attr.sample_period)
+	if (event->attr.sample_period)
 		return -EINVAL;
 
 	if (cfg != AMD_POWER_EVENTSEL_PKG)
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 9f8084f..af919c4 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -280,13 +280,7 @@ static int cstate_pmu_event_init(struct perf_event *event)
 		return -ENOENT;
 
 	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest  ||
-	    event->attr.sample_period) /* no sampling */
+	if (event->attr.sample_period) /* no sampling */
 		return -EINVAL;
 
 	if (event->cpu < 0)
diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 32f3e94..9cb94e6 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -397,13 +397,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest  ||
-	    event->attr.sample_period) /* no sampling */
+	if (event->attr.sample_period) /* no sampling */
 		return -EINVAL;
 
 	/* must be done before validate_group */
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 8527c3e..26441eb 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -374,13 +374,7 @@ static int snb_uncore_imc_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest  ||
-	    event->attr.sample_period) /* no sampling */
+	if (event->attr.sample_period) /* no sampling */
 		return -EINVAL;
 
 	/*
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index b4771a6..c4fa5d4 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -160,13 +160,7 @@ static int msr_event_init(struct perf_event *event)
 		return -ENOENT;
 
 	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest  ||
-	    event->attr.sample_period) /* no sampling */
+	if (event->attr.sample_period) /* no sampling */
 		return -EINVAL;
 
 	if (cfg >= PERF_MSR_EVENT_MAX)
-- 
2.7.4

