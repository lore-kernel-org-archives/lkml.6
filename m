Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8213C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B632192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436815AbfBOMSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 07:18:10 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:59357 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393015AbfBOMSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 07:18:09 -0500
Received: from 79.184.254.36.ipv4.supernova.orange.pl (79.184.254.36) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 77901c4a3c54f026; Fri, 15 Feb 2019 13:18:07 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Chen Yu <y.c.chen@intel.com>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH 2/2] cpufreq: intel_pstate: Eliminate intel_pstate_get_base_pstate()
Date:   Fri, 15 Feb 2019 13:16:40 +0100
Message-ID: <2580980.jRUbltTAZz@aspire.rjw.lan>
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

There is only one caller of intel_pstate_get_base_pstate() and it is
more straightforward to carry out the computation directly in the
caller, so do that and drop intel_pstate_get_base_pstate().

No intentional changes of behavior.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1447,12 +1447,6 @@ static int knl_get_turbo_pstate(void)
 	return ret;
 }
 
-static int intel_pstate_get_base_pstate(struct cpudata *cpu)
-{
-	return global.no_turbo || global.turbo_disabled ?
-			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
-}
-
 static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
 {
 	trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
@@ -1973,7 +1967,8 @@ static void intel_pstate_update_perf_lim
 	if (hwp_active) {
 		intel_pstate_get_hwp_max(cpu->cpu, &turbo_max, &max_state);
 	} else {
-		max_state = intel_pstate_get_base_pstate(cpu);
+		max_state = global.no_turbo || global.turbo_disabled ?
+			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
 		turbo_max = cpu->pstate.turbo_pstate;
 	}
 

