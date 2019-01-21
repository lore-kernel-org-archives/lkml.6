Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8367AFA3729
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5394C20663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfAULWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:22:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57723 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbfAULW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:22:29 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0LBLrUn2493563
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 21 Jan 2019 03:21:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0LBLpuq2493560;
        Mon, 21 Jan 2019 03:21:51 -0800
Date:   Mon, 21 Jan 2019 03:21:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrew Murray <tipbot@zytor.com>
Message-ID: <tip-2ff40250691eaf28866eab449148843b39f65d7b@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        torvalds@linux-foundation.org, linux@armlinux.org.uk,
        paulus@samba.org, tglx@linutronix.de, will.deacon@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        benh@kernel.crashing.org, rth@twiddle.net, acme@kernel.org,
        bp@alien8.de, peterz@infradead.org, mpe@ellerman.id.au,
        hpa@zytor.com, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        mingo@kernel.org, andrew.murray@arm.com
Reply-To: linux@armlinux.org.uk, paulus@samba.org, mark.rutland@arm.com,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          acme@kernel.org, bp@alien8.de, benh@kernel.crashing.org,
          rth@twiddle.net, andrew.murray@arm.com, mingo@kernel.org,
          mattst88@gmail.com, peterz@infradead.org,
          ink@jurassic.park.msu.ru, mpe@ellerman.id.au, hpa@zytor.com,
          tglx@linutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
          will.deacon@arm.com
In-Reply-To: <1547128414-50693-11-git-send-email-andrew.murray@arm.com>
References: <1547128414-50693-11-git-send-email-andrew.murray@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core, arch/x86: Use PERF_PMU_CAP_NO_EXCLUDE
 for exclusion incapable PMUs
Git-Commit-ID: 2ff40250691eaf28866eab449148843b39f65d7b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2ff40250691eaf28866eab449148843b39f65d7b
Gitweb:     https://git.kernel.org/tip/2ff40250691eaf28866eab449148843b39f65d7b
Author:     Andrew Murray <andrew.murray@arm.com>
AuthorDate: Thu, 10 Jan 2019 13:53:32 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 21 Jan 2019 11:01:27 +0100

perf/core, arch/x86: Use PERF_PMU_CAP_NO_EXCLUDE for exclusion incapable PMUs

For drivers that do not support context exclusion let's advertise the
PERF_PMU_CAP_NOEXCLUDE capability. This ensures that perf will
prevent us from handling events where any exclusion flags are set.
Let's also remove the now unnecessary check for exclusion flags.

PMU drivers that support at least one exclude flag won't have the
PERF_PMU_CAP_NOEXCLUDE capability set - these PMU drivers should still
check and fail on unsupported exclude flags. These missing tests are
not added in this patch.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: robin.murphy@arm.com
Cc: suzuki.poulose@arm.com
Link: https://lkml.kernel.org/r/1547128414-50693-11-git-send-email-andrew.murray@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/amd/ibs.c          | 13 +------------
 arch/x86/events/amd/power.c        | 10 ++--------
 arch/x86/events/intel/cstate.c     | 12 +++---------
 arch/x86/events/intel/rapl.c       |  9 ++-------
 arch/x86/events/intel/uncore_snb.c |  9 ++-------
 arch/x86/events/msr.c              | 10 ++--------
 6 files changed, 12 insertions(+), 51 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index d50bb4dc0650..62f317c9113a 100644
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
 
@@ -537,6 +525,7 @@ static struct perf_ibs perf_ibs_fetch = {
 		.start		= perf_ibs_start,
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	},
 	.msr			= MSR_AMD64_IBSFETCHCTL,
 	.config_mask		= IBS_FETCH_CONFIG_MASK,
diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
index 2aefacf5c5b2..c5ff084551c6 100644
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
@@ -226,6 +219,7 @@ static struct pmu pmu_class = {
 	.start		= pmu_event_start,
 	.stop		= pmu_event_stop,
 	.read		= pmu_event_read,
+	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 };
 
 static int power_cpu_exit(unsigned int cpu)
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index d2e780705c5a..94a4b7fc75d0 100644
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
@@ -437,7 +431,7 @@ static struct pmu cstate_core_pmu = {
 	.start		= cstate_pmu_event_start,
 	.stop		= cstate_pmu_event_stop,
 	.read		= cstate_pmu_event_update,
-	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT,
+	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT | PERF_PMU_CAP_NO_EXCLUDE,
 	.module		= THIS_MODULE,
 };
 
@@ -451,7 +445,7 @@ static struct pmu cstate_pkg_pmu = {
 	.start		= cstate_pmu_event_start,
 	.stop		= cstate_pmu_event_stop,
 	.read		= cstate_pmu_event_update,
-	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT,
+	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT | PERF_PMU_CAP_NO_EXCLUDE,
 	.module		= THIS_MODULE,
 };
 
diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 91039ffed633..94dc564146ca 100644
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
@@ -699,6 +693,7 @@ static int __init init_rapl_pmus(void)
 	rapl_pmus->pmu.stop		= rapl_pmu_event_stop;
 	rapl_pmus->pmu.read		= rapl_pmu_event_read;
 	rapl_pmus->pmu.module		= THIS_MODULE;
+	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
 	return 0;
 }
 
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 2593b0d7aeee..b12517fae77a 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -397,13 +397,7 @@ static int snb_uncore_imc_event_init(struct perf_event *event)
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
@@ -497,6 +491,7 @@ static struct pmu snb_uncore_imc_pmu = {
 	.start		= uncore_pmu_event_start,
 	.stop		= uncore_pmu_event_stop,
 	.read		= uncore_pmu_event_read,
+	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 };
 
 static struct intel_uncore_ops snb_uncore_imc_ops = {
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 1b9f85abf9bc..a878e6286e4a 100644
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
@@ -256,7 +250,7 @@ static struct pmu pmu_msr = {
 	.start		= msr_event_start,
 	.stop		= msr_event_stop,
 	.read		= msr_event_update,
-	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT,
+	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT | PERF_PMU_CAP_NO_EXCLUDE,
 };
 
 static int __init msr_init(void)
