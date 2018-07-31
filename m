Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36CAC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D4B20870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D4B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbeGaVUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:20:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:3846 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732322AbeGaVUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:20:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2018 12:38:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,428,1526367600"; 
   d="scan'208";a="77594081"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga001.jf.intel.com with ESMTP; 31 Jul 2018 12:38:43 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, fenghua.yu@intel.com,
        tony.luck@intel.com, vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 1/2] perf/x86: Expose PMC hardware reservation
Date:   Tue, 31 Jul 2018 12:38:28 -0700
Message-Id: <dcf5f19f0434261d4a475b47a965b2294fa069cd.1533064851.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1533064851.git.reinette.chatre@intel.com>
References: <cover.1533064851.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1533064851.git.reinette.chatre@intel.com>
References: <cover.1533064851.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When multiple users need to use performance counters a reservation
mechanism is required to ensure coordination. This reservation
mechanism already exists and any user can currently reserve/release
a single performance counter and/or its matching event configuration
via the exported symbols reserve_perfctr_nmi() and reserve_evntsel_nmi()
(and their matching release functions). These reservation functions
take as parameter a single performance counter or event configuration
register at a time and they are typically called in a loop where they
are called for every counter on the system.

The current users of these exported symbols are oprofile and the x86
events system that each use wrappers to these exported symbols as a way
to reserve the entire pmc system - calling a reserve of each counter
and its configuration registers.

A user wanting to use x86 PMC hardware can currently do so by duplicating
the x86 PMC hardware reservation by creating a new wrapper for the exported
reserve_perfctr_nmi() and reserve_evntsel_nmi() functions. This
duplication is not desirable and thus the current wrapping x86 pmc
reservation routine itself (reserve_pmc_hardware()) and matching
release function (release_pmc_hardware()) are exported for users needing
to coordinate use of PMC hardware.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/events/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5f4829f10129..e883a0a11f53 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -144,7 +144,7 @@ static DEFINE_MUTEX(pmc_reserve_mutex);
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
-static bool reserve_pmc_hardware(void)
+bool reserve_pmc_hardware(void)
 {
 	int i;
 
@@ -173,7 +173,7 @@ static bool reserve_pmc_hardware(void)
 	return false;
 }
 
-static void release_pmc_hardware(void)
+void release_pmc_hardware(void)
 {
 	int i;
 
@@ -189,6 +189,8 @@ static bool reserve_pmc_hardware(void) { return true; }
 static void release_pmc_hardware(void) {}
 
 #endif
+EXPORT_SYMBOL(reserve_pmc_hardware);
+EXPORT_SYMBOL(release_pmc_hardware);
 
 static bool check_hw_exists(void)
 {
-- 
2.17.0

