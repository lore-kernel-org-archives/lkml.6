Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0CBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD63221738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbfBSUBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:01:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:8764 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729718AbfBSUBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:01:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 12:01:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="139918103"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga001.jf.intel.com with ESMTP; 19 Feb 2019 12:01:01 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, acme@kernel.org,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, jolsa@redhat.com, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 08/10] perf/x86/intel/rapl: Support die scope counters on CLX-AP
Date:   Tue, 19 Feb 2019 12:00:09 -0800
Message-Id: <1550606411-5313-9-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
References: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

CLX-AP has the same RAPL counters as SKX, but they are die scope.

Add clx_ap_rapl_init for CLX-AP.
Add new attr_groups for DIE_DOMAIN.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/rapl.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index c1ba09c..110b491 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -589,6 +589,18 @@ static const struct attribute_group *rapl_pkg_attr_groups[] = {
 	NULL,
 };
 
+static struct attribute_group rapl_die_pmu_events_group = {
+	.name = "events",
+	.attrs = NULL, /* patched at runtime */
+};
+
+static const struct attribute_group *rapl_die_attr_groups[] = {
+	&rapl_pmu_attr_group,
+	&rapl_pmu_format_group,
+	&rapl_die_pmu_events_group,
+	NULL,
+};
+
 static int __rapl_cpu_offline(unsigned int cpu, struct rapl_pmus *pmus)
 {
 	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu, pmus);
@@ -791,6 +803,9 @@ static int __init init_rapl_pmus(const struct intel_rapl_events *events,
 	if (type == PACKAGE_DOMAIN) {
 		rapl_pkg_pmu_events_group.attrs = events->attrs;
 		pmus->pmu.attr_groups = rapl_pkg_attr_groups;
+	} else if (type == DIE_DOMAIN) {
+		rapl_die_pmu_events_group.attrs = events->attrs;
+		pmus->pmu.attr_groups = rapl_die_attr_groups;
 	}
 	pmus->pmu.task_ctx_nr = perf_invalid_context;
 	pmus->pmu.event_init = rapl_pmu_event_init;
@@ -860,6 +875,12 @@ static const struct intel_rapl_init_fun hsx_rapl_init __initconst = {
 	.events[PACKAGE_DOMAIN].attrs = rapl_events_srv_attr,
 };
 
+static const struct intel_rapl_init_fun clx_ap_rapl_init __initconst = {
+	.apply_quirk = true,
+	.events[DIE_DOMAIN].cntr_mask = RAPL_IDX_SRV,
+	.events[DIE_DOMAIN].attrs = rapl_events_srv_attr,
+};
+
 static const struct intel_rapl_init_fun hsw_rapl_init __initconst = {
 	.apply_quirk = false,
 	.events[PACKAGE_DOMAIN].cntr_mask = RAPL_IDX_HSW,
@@ -933,7 +954,11 @@ static int __init rapl_pmu_init(void)
 	if (!id)
 		return -ENODEV;
 
-	rapl_init = (struct intel_rapl_init_fun *)id->driver_data;
+	if ((boot_cpu_data.x86_model == INTEL_FAM6_SKYLAKE_X) &&
+	    (boot_cpu_data.x86_max_dies > 1))
+		rapl_init = (struct intel_rapl_init_fun *)&clx_ap_rapl_init;
+	else
+		rapl_init = (struct intel_rapl_init_fun *)id->driver_data;
 	apply_quirk = rapl_init->apply_quirk;
 
 	ret = rapl_check_hw_unit(apply_quirk);
-- 
2.7.4

