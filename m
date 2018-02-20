Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeBTS7M (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 13:59:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:36678 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751274AbeBTS7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 13:59:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,540,1511856000";
   d="scan'208";a="36143448"
Subject: Re: [perf/x86/intel] 41e062cd2e:
 WARNING:at_arch/x86/events/intel/ds.c:#intel_pmu_save_and_restart_reload
To: Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <fengguang.wu@intel.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, jolsa@redhat.com, eranian@google.com,
        ak@linux.intel.com, lkp@01.org
References: <1518474035-21006-2-git-send-email-kan.liang@linux.intel.com>
 <20180217062119.cemwsj6dsf4ezfn6@inn>
 <20180219124446.GR25201@hirez.programming.kicks-ass.net>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <6f44ee84-56f8-79f1-559b-08e371eaeb78@linux.intel.com>
Date: Tue, 20 Feb 2018 13:59:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219124446.GR25201@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/19/2018 7:44 AM, Peter Zijlstra wrote:
> On Sat, Feb 17, 2018 at 02:21:19PM +0800, kernel test robot wrote:
>> [  242.731381] WARNING: CPU: 3 PID: 1107 at arch/x86/events/intel/ds.c:1326 intel_pmu_save_and_restart_reload+0x87/0x90
> 
> That's the one asserting the PMU is in fact disabled.
> 
>> [  242.731417] CPU: 3 PID: 1107 Comm: netserver Not tainted 4.15.0-00001-g41e062c #1
>> [  242.731418] Hardware name: LENOVO IdeaPad U410    /Lenovo          , BIOS 65CN15WW 06/05/2012
>> [  242.731422] RIP: 0010:intel_pmu_save_and_restart_reload+0x87/0x90
>> [  242.731423] RSP: 0018:fffffe000008c8d0 EFLAGS: 00010002
>> [  242.731425] RAX: 0000000000000001 RBX: ffff88007d069800 RCX: 0000000000000000
>> [  242.731426] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff88007d069800
>> [  242.731427] RBP: 0000000000000010 R08: 0000000000000001 R09: 0000000000000001
>> [  242.731428] R10: 00000000000000b0 R11: 0000000000003000 R12: 00000000000f4243
>> [  242.731429] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
>> [  242.731431] FS:  00007f1501639700(0000) GS:ffff880112ac0000(0000) knlGS:0000000000000000
>> [  242.731432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  242.731433] CR2: 00007f65a1394d68 CR3: 000000007f62a006 CR4: 00000000001606e0
>> [  242.731434] Call Trace:
>> [  242.731438]  <NMI>
>> [  242.731443]  __intel_pmu_pebs_event+0xc8/0x260
>> [  242.731452]  ? intel_pmu_drain_pebs_nhm+0x211/0x2f0
>> [  242.731454]  intel_pmu_drain_pebs_nhm+0x211/0x2f0
>> [  242.731457]  intel_pmu_handle_irq+0x12d/0x4b0
>> [  242.731464]  ? perf_event_nmi_handler+0x2d/0x50
>> [  242.731466]  perf_event_nmi_handler+0x2d/0x50
>> [  242.731470]  nmi_handle+0x6a/0x130
>> [  242.731473]  default_do_nmi+0x4e/0x110
>> [  242.731475]  do_nmi+0xe5/0x140
>> [  242.731479]  end_repeat_nmi+0x1a/0x54
> 
> And this should have shown with any testing I think.
> 
> The problem appears to be that intel_pmu_handle_irq() uses
> __intel_pmu_disable_all() which 'forgets' to clear cpuc->enabled as per
> x86_pmu_disable().
> 
> 

Yes, the cpuc->enabled is not updated accordingly in NMI handler.
The patch as below could fix it.

Thanks,
Kan
------

 From 4d07d81e3406a6a9958cfbb34c1deb87b77721a9 Mon Sep 17 00:00:00 2001
From: Kan Liang <kan.liang@linux.intel.com>
Date: Tue, 20 Feb 2018 02:11:50 -0800
Subject: [PATCH] perf/x86/intel: Update the PMU state in NMI handler

Intel PMU is disabled in NMI handler, but cpuc->enabled is not updated
accordingly. It doesn't trigger any problems in current code. Because
no one check it. But the code quality issue will bring problem when the
code want to check the PMU state. For example, the drain_pebs() will be
modified to fix auto-reload issue. The new code will check the PMU state.

The old PMU state must be saved when entering the NMI. Because it will
be used to restore the PMU state when leaving the NMI.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
  arch/x86/events/intel/core.c | 10 +++++++++-
  1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 6461a4a..80dfaae 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2209,16 +2209,23 @@ static int intel_pmu_handle_irq(struct pt_regs 
*regs)
  	int bit, loops;
  	u64 status;
  	int handled;
+	int pmu_enabled;

  	cpuc = this_cpu_ptr(&cpu_hw_events);

  	/*
+	 * Save the PMU state.
+	 * It needs to be restored when leaving the handler.
+	 */
+	pmu_enabled = cpuc->enabled;
+	/*
  	 * No known reason to not always do late ACK,
  	 * but just in case do it opt-in.
  	 */
  	if (!x86_pmu.late_ack)
  		apic_write(APIC_LVTPC, APIC_DM_NMI);
  	intel_bts_disable_local();
+	cpuc->enabled = 0;
  	__intel_pmu_disable_all();
  	handled = intel_pmu_drain_bts_buffer();
  	handled += intel_bts_interrupt();
@@ -2328,7 +2335,8 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)

  done:
  	/* Only restore PMU state when it's active. See x86_pmu_disable(). */
-	if (cpuc->enabled)
+	cpuc->enabled = pmu_enabled;
+	if (pmu_enabled)
  		__intel_pmu_enable_all(0, true);
  	intel_bts_enable_local();

-- 
2.7.4
