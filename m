Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00732C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45C120864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45C120864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967215AbeFRIb7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:31:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34252 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966915AbeFRIb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:31:56 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DC856C3C;
        Mon, 18 Jun 2018 08:31:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        ak@linux.intel.com, eranian@google.com, acme@redhat.com,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 065/189] perf/x86/intel: Dont enable freeze-on-smi for PerfMon V1
Date:   Mon, 18 Jun 2018 10:12:41 +0200
Message-Id: <20180618081211.916095042@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit 4e949e9b9d1e3edcdab3b54656c5851bd9e49c67 ]

The SMM freeze feature was introduced since PerfMon V2. But the current
code unconditionally enables the feature for all platforms. It can
generate #GP exception, if the related FREEZE_WHILE_SMM bit is set for
the machine with PerfMon V1.

To disable the feature for PerfMon V1, perf needs to
- Remove the freeze_on_smi sysfs entry by moving intel_pmu_attrs to
  intel_pmu, which is only applied to PerfMon V2 and later.
- Check the PerfMon version before flipping the SMM bit when starting CPU

Fixes: 6089327f5424 ("perf/x86: Add sysfs entry to freeze counters on SMI")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: ak@linux.intel.com
Cc: eranian@google.com
Cc: acme@redhat.com
Link: https://lkml.kernel.org/r/1524682637-63219-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/intel/core.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3331,7 +3331,8 @@ static void intel_pmu_cpu_starting(int c
 
 	cpuc->lbr_sel = NULL;
 
-	flip_smm_bit(&x86_pmu.attr_freeze_on_smi);
+	if (x86_pmu.version > 1)
+		flip_smm_bit(&x86_pmu.attr_freeze_on_smi);
 
 	if (!cpuc->shared_regs)
 		return;
@@ -3494,6 +3495,8 @@ static __initconst const struct x86_pmu
 	.cpu_dying		= intel_pmu_cpu_dying,
 };
 
+static struct attribute *intel_pmu_attrs[];
+
 static __initconst const struct x86_pmu intel_pmu = {
 	.name			= "Intel",
 	.handle_irq		= intel_pmu_handle_irq,
@@ -3524,6 +3527,8 @@ static __initconst const struct x86_pmu
 	.format_attrs		= intel_arch3_formats_attr,
 	.events_sysfs_show	= intel_event_sysfs_show,
 
+	.attrs			= intel_pmu_attrs,
+
 	.cpu_prepare		= intel_pmu_cpu_prepare,
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
@@ -3902,8 +3907,6 @@ __init int intel_pmu_init(void)
 
 	x86_pmu.max_pebs_events		= min_t(unsigned, MAX_PEBS_EVENTS, x86_pmu.num_counters);
 
-
-	x86_pmu.attrs			= intel_pmu_attrs;
 	/*
 	 * Quirk: v2 perfmon does not report fixed-purpose events, so
 	 * assume at least 3 events, when not running in a hypervisor:


