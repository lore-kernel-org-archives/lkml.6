Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05DDC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B891F2192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436922AbfBOMSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 07:18:14 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63681 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393817AbfBOMSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 07:18:10 -0500
Received: from 79.184.254.36.ipv4.supernova.orange.pl (79.184.254.36) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 2c18d8ca8c2762a1; Fri, 15 Feb 2019 13:18:08 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Chen Yu <y.c.chen@intel.com>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH 1/2] cpufreq: intel_pstate: Avoid redundant initialization of local vars
Date:   Fri, 15 Feb 2019 13:15:32 +0100
Message-ID: <2991330.GCSuaqJzpc@aspire.rjw.lan>
In-Reply-To: <2474712.mvXUDI8C0e@aspire.rjw.lan>
References: <2474712.mvXUDI8C0e@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 1a4fe38add8b ("cpufreq: intel_pstate: Remove max/min
fractions to limit performance") the initial value of the pstate local
variable in intel_pstate_max_within_limits() and the initial value of
the max_pstate local variable in intel_pstate_prepare_request() are
both immediately discarded, so initialize both these variables to
their target values upfront.

No intentional changes of behavior.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1473,11 +1473,9 @@ static void intel_pstate_set_min_pstate(
 
 static void intel_pstate_max_within_limits(struct cpudata *cpu)
 {
-	int pstate;
+	int pstate = max(cpu->pstate.min_pstate, cpu->max_perf_ratio);
 
 	update_turbo_state();
-	pstate = intel_pstate_get_base_pstate(cpu);
-	pstate = max(cpu->pstate.min_pstate, cpu->max_perf_ratio);
 	intel_pstate_set_pstate(cpu, pstate);
 }
 
@@ -1715,11 +1713,9 @@ static inline int32_t get_target_pstate(
 
 static int intel_pstate_prepare_request(struct cpudata *cpu, int pstate)
 {
-	int max_pstate = intel_pstate_get_base_pstate(cpu);
-	int min_pstate;
+	int min_pstate = max(cpu->pstate.min_pstate, cpu->min_perf_ratio);
+	int max_pstate = max(min_pstate, cpu->max_perf_ratio);
 
-	min_pstate = max(cpu->pstate.min_pstate, cpu->min_perf_ratio);
-	max_pstate = max(min_pstate, cpu->max_perf_ratio);
 	return clamp_t(int, pstate, min_pstate, max_pstate);
 }
 

