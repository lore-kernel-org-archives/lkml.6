Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0B8C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839CB2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839CB2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbeJKOrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:47:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:4385 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbeJKOrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:47:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 00:21:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,367,1534834800"; 
   d="scan'208";a="96532676"
Received: from shbuild999.sh.intel.com ([10.239.146.218])
  by fmsmga004.fm.intel.com with ESMTP; 11 Oct 2018 00:17:09 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        H Peter Anvin <hpa@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH RFC] panic: Avoid extra noisy messages due to stopped cpus
Date:   Thu, 11 Oct 2018 15:17:48 +0800
Message-Id: <1539242268-63036-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes when debugging kernel panic, we saw many extra noisy error
messages after the expected end:

[   35.743249] ---[ end Kernel panic - not syncing: Fatal exception
[   35.749975] ------------[ cut here ]------------

These messages may overflow the sceen (framebuffer) and make debugging
much difficulter.

This hack patch just quickly prevent these noisy message, and would
really like to get some comments and suggestions.

I have tried other ways like adding a panic notifier block inside
tick/sched code to cancel tick_sched timer in panic case, which
also works.

These extra messages are of 2 kinds:
a)
	 WARNING: CPU: 1 PID: 280 at kernel/sched/core.c:1198 set_task_cpu+0x183/0x190
	 Call Trace:
	  <IRQ>
	  try_to_wake_up+0x157/0x430
	  default_wake_function+0xd/0x10
	  autoremove_wake_function+0x11/0x60
	  __wake_up_common+0x8a/0x160
	  __wake_up_common_lock+0x6c/0x90
	  __wake_up+0xe/0x10
	  wake_up_klogd_work_func+0x3b/0x60
	  irq_work_run_list+0x4e/0x80
	  irq_work_tick+0x40/0x50
	  update_process_times+0x3d/0x50
	  tick_sched_timer+0x38/0x80
	  __hrtimer_run_queues+0xce/0x200
	  hrtimer_interrupt+0xac/0x1f0
	  smp_apic_timer_interrupt+0x6e/0x140
	  apic_timer_interrupt+0x8e/0xa0

b)
	sched: Unexpected reschedule of offline CPU#0!
	 ------------[ cut here ]------------
	 WARNING: CPU: 1 PID: 300 at arch/x86/kernel/smp.c:141 native_smp_send_reschedule+0x3d/0x50
	  trigger_load_balance+0x125/0x230
	  scheduler_tick+0xa2/0xd0
	  update_process_times+0x42/0x50
	  tick_sched_handle.isra.5+0x21/0x60
	  tick_sched_timer+0x38/0x80
	  __hrtimer_run_queues+0xce/0x200
	  hrtimer_interrupt+0xac/0x1f0
	  smp_apic_timer_interrupt+0x6e/0x140
	  apic_timer_interrupt+0x8e/0xa0

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 arch/x86/kernel/process.c | 1 +
 kernel/sched/fair.c       | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index c93fcfd..b703862 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -520,6 +520,7 @@ void stop_this_cpu(void *dummy)
 	 * Remove this CPU:
 	 */
 	set_cpu_online(smp_processor_id(), false);
+	set_cpu_active(smp_processor_id(), false);
 	disable_local_APIC();
 	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7fc4a37..cf41b7b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9034,7 +9034,7 @@ static inline int find_new_ilb(void)
 {
 	int ilb = cpumask_first(nohz.idle_cpus_mask);
 
-	if (ilb < nr_cpu_ids && idle_cpu(ilb))
+	if (ilb < nr_cpu_ids && idle_cpu(ilb) && cpu_online(ilb))
 		return ilb;
 
 	return nr_cpu_ids;
-- 
2.7.4

