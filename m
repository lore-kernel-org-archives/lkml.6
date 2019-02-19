Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE0DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6E821773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfBSUBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:01:04 -0500
Received: from mga11.intel.com ([192.55.52.93]:8744 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729772AbfBSUBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:01:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 12:00:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="139918092"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga001.jf.intel.com with ESMTP; 19 Feb 2019 12:01:00 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, acme@kernel.org,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, jolsa@redhat.com, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 06/10] perf/x86/intel/cstate: Support die scope counters on CLX-AP
Date:   Tue, 19 Feb 2019 12:00:07 -0800
Message-Id: <1550606411-5313-7-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
References: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

CLX-AP has the same PKG Cstate counters as SKX, but they are die scope.

Add clx_ap_cstates for CLX-AP.
Share the package code with die for now.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/cstate.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 5f71606..8e7d906 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -31,6 +31,7 @@
  * with the perf_event core subsystem.
  *  - 'cstate_core': The counter is available for each physical core.
  *    The counters include CORE_C*_RESIDENCY.
+ *  - 'cstate_die': The counter is available for each physical die.
  *  - 'cstate_pkg': The counter is available for each physical package.
  *    The counters include PKG_C*_RESIDENCY.
  *
@@ -118,6 +119,7 @@ struct cstate_model {
 		struct {
 			unsigned long	pkg_events;
 			unsigned long	core_events;
+			unsigned long	die_events;
 		};
 	};
 	unsigned long		quirks;
@@ -446,6 +448,17 @@ static const struct cstate_model snb_cstates __initconst = {
 				  BIT(PERF_CSTATE_PKG_C7_RES),
 };
 
+static const struct cstate_model clx_ap_cstates __initconst = {
+	.core_events		= BIT(PERF_CSTATE_CORE_C3_RES) |
+				  BIT(PERF_CSTATE_CORE_C6_RES) |
+				  BIT(PERF_CSTATE_CORE_C7_RES),
+
+	.die_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
+				  BIT(PERF_CSTATE_PKG_C3_RES) |
+				  BIT(PERF_CSTATE_PKG_C6_RES) |
+				  BIT(PERF_CSTATE_PKG_C7_RES),
+};
+
 static const struct cstate_model hswult_cstates __initconst = {
 	.core_events		= BIT(PERF_CSTATE_CORE_C3_RES) |
 				  BIT(PERF_CSTATE_CORE_C6_RES) |
@@ -574,7 +587,8 @@ static bool __init cstate_probe_msr(const unsigned long evmsk,
 	int max;
 	u64 val;
 
-	if (type == PACKAGE_DOMAIN) {
+	if ((type == PACKAGE_DOMAIN) ||
+	    (type == DIE_DOMAIN)) {
 		max = PERF_CSTATE_PKG_EVENT_MAX;
 		msr = pkg_msr;
 		attrs = pkg_events_attrs;
@@ -672,7 +686,8 @@ static int __init cstate_init(void)
 			continue;
 		pmu = &cstate_pmus[i]->pmu;
 
-		if (i == PACKAGE_DOMAIN)
+		if ((i == PACKAGE_DOMAIN) ||
+		    (i == DIE_DOMAIN))
 			pmu->attr_groups = pkg_attr_groups;
 		else if (i == CORE_DOMAIN)
 			pmu->attr_groups = core_attr_groups;
@@ -707,6 +722,7 @@ static int __init cstate_init(void)
 
 static int __init cstate_pmu_init(void)
 {
+	const struct cstate_model *cstate;
 	const struct x86_cpu_id *id;
 	int err;
 
@@ -717,7 +733,12 @@ static int __init cstate_pmu_init(void)
 	if (!id)
 		return -ENODEV;
 
-	err = cstate_probe((const struct cstate_model *) id->driver_data);
+	if ((boot_cpu_data.x86_model == INTEL_FAM6_SKYLAKE_X) &&
+	    (boot_cpu_data.x86_max_dies > 1))
+		cstate = &clx_ap_cstates;
+	else
+		cstate = (const struct cstate_model *) id->driver_data;
+	err = cstate_probe(cstate);
 	if (err)
 		return err;
 
-- 
2.7.4

