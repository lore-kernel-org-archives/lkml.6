Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932948AbeDXIGc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:06:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52216 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756326AbeDXIGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:06:20 -0400
Date: Tue, 24 Apr 2018 10:06:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: peng.hao2@zte.com.cn
Cc: tglx@linutronix.de, pbonzini@redhat.com, mingo@redhat.com,
        x86@kernel.org, len.brown@intel.com, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] x86: tsc: fix L2 guest always in tsc_early
 clocksource
Message-ID: <20180424080609.GP4082@hirez.programming.kicks-ass.net>
References: <201804240956524049538@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201804240956524049538@zte.com.cn>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 09:56:52AM +0800, peng.hao2@zte.com.cn wrote:
> >On Tue, Apr 24, 2018 at 09:08:54AM +0800, Peng Hao wrote:
> >> In L2 guest tsc_read_refs always return ULLONG_MAX, and that will
> >> call tsc_refine_calibration_work periodly. So L2 guest will read
> >> acpi timer port 0x608 periodly.
> >> The patch will let it out of "if(tsc_start == -1){}" infinite loop.
> 
> >Help me out a little. What's an L2 guest?

> kvm nested virtual machine.

So why not say nested guest? I though someone did a new hypervisor based
on L4 or so and called it L2 for funnies.

> >So if the whole TSC sync has no way of ever working; what is your patch
> >doing? How is the actual TSC calibrated?

> It exists a period loop in tsc_refine_calibration_work: tsc_start = tsc_read_refs() = -1,so it call schedule_delayed_work(&tsc_irqwork,HZ),
> then tsc_start = tsc_read_refs() = -1 ....
> during the process it accesses 0x608 periodly and it is unnecessary and just influencees performance for L2 guest.
> The patch let it out of the period loop and changes from early-tsc to tsc clocksource.So it will not access ioport 0x608
> periodly.

Can you please teach your mailer to wrap at 78 chars?

> The kvmclock give a interface kvm_get_tsc_khz  to get the tsc_khz.

But why are you getting to tsc_refine_calibration_work() in the first
place? If kvm_get_tsc_khz() returns a known good value, it should set
X86_FEATURE_TSC_KNOWN_FREQ such that we don't attempt to 'refine'
things.

Something like the below perhaps?

---
 arch/x86/kernel/kvmclock.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 8b26c9e01cc4..918948eaa232 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -138,6 +138,13 @@ static unsigned long kvm_get_tsc_khz(void)
 	src = &hv_clock[cpu].pvti;
 	tsc_khz = pvclock_tsc_khz(src);
 	put_cpu();
+
+	/*
+	 * TSC frequency is reported by the host; calibration against (virtual)
+	 * HPET/PM-timer in a guest is dodgy and will not be accurate.
+	 */
+	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+
 	return tsc_khz;
 }
 
