Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85710C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1F42081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1F42081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbeKKACJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 19:02:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:33748 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729022AbeKKACJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 19:02:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36393AE41;
        Sat, 10 Nov 2018 14:16:57 +0000 (UTC)
Date:   Sat, 10 Nov 2018 15:16:48 +0100
From:   Borislav Petkov <bp@suse.de>
To:     hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        wang.yi59@zte.com.cn, linux-kernel@vger.kernel.org, matz@suse.de
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:ras/core] x86/mce: Fix -Wmissing-prototypes warnings
Message-ID: <20181110141647.GA20073@zn.tnic>
References: <alpine.DEB.2.21.1811081633160.1549@nanos.tec.linutronix.de>
 <tip-d813dfb28641306f66cf1e2c3586f39ab4f84b27@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tip-d813dfb28641306f66cf1e2c3586f39ab4f84b27@git.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 02:51:56AM -0800, tip-bot for Borislav Petkov wrote:

...

> diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mcheck/therm_throt.c
> index 2da67b70ba98..8a2a842d1a72 100644
> --- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
> +++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
> @@ -25,6 +25,7 @@
>  #include <linux/cpu.h>
>  
>  #include <asm/processor.h>
> +#include <asm/traps.h>
>  #include <asm/apic.h>
>  #include <asm/mce.h>
>  #include <asm/msr.h>
> @@ -390,7 +391,7 @@ static void unexpected_thermal_interrupt(void)
>  
>  static void (*smp_thermal_vector)(void) = unexpected_thermal_interrupt;
>  
> -asmlinkage __visible void __irq_entry smp_thermal_interrupt(struct pt_regs *r)
> +asmlinkage __visible void __irq_entry smp_thermal_interrupt(void)

And looking at this more, *this* is actually the wrong fix. Goes to show
how important that warning is...

Anyway, all those interrupt handlers run with struct pt_regs * in %rdi,
see the apic interrupt asm glue:

.macro apicinterrupt3 num sym do_sym
ENTRY(\sym)
        UNWIND_HINT_IRET_REGS
        pushq   $~(\num)
.Lcommon_\sym:
        call    interrupt_entry
        UNWIND_HINT_REGS indirect=1
        call    \do_sym /* rdi points to pt_regs */
		^^^^^^^^^^

so the real fix should be this.

Even if the argument doesn't get used, its prototype should specify it
as interrupt_entry() does all that preparation and puts a pt_regs ptr on
stack.

---
From: Borislav Petkov <bp@suse.de>
Date: Fri, 9 Nov 2018 23:13:13 +0100
Subject: [PATCH] x86/mce: Fix -Wmissing-prototypes warnings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the proper includes and make smca_get_name() static.

Fix an actual bug too which the warning triggered:

  arch/x86/kernel/cpu/mcheck/therm_throt.c:395:39: error: conflicting \
  types for ‘smp_thermal_interrupt’
   asmlinkage __visible void __irq_entry smp_thermal_interrupt(struct pt_regs *r)
                                         ^~~~~~~~~~~~~~~~~~~~~
  In file included from arch/x86/kernel/cpu/mcheck/therm_throt.c:29:
  ./arch/x86/include/asm/traps.h:107:17: note: previous declaration of \
	  ‘smp_thermal_interrupt’ was here
   asmlinkage void smp_thermal_interrupt(void);

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Yi Wang <wang.yi59@zte.com.cn>
Cc: Michael Matz <matz@suse.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1811081633160.1549@nanos.tec.linutronix.de
---
 arch/x86/include/asm/traps.h             | 6 +++---
 arch/x86/kernel/cpu/mcheck/mce_amd.c     | 5 +++--
 arch/x86/kernel/cpu/mcheck/therm_throt.c | 1 +
 arch/x86/kernel/cpu/mcheck/threshold.c   | 3 ++-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 3de69330e6c5..9ea54a764a8e 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -104,9 +104,9 @@ extern int panic_on_unrecovered_nmi;
 
 void math_emulate(struct math_emu_info *);
 #ifndef CONFIG_X86_32
-asmlinkage void smp_thermal_interrupt(void);
-asmlinkage void smp_threshold_interrupt(void);
-asmlinkage void smp_deferred_error_interrupt(void);
+asmlinkage void smp_thermal_interrupt(struct pt_regs *);
+asmlinkage void smp_threshold_interrupt(struct pt_regs *);
+asmlinkage void smp_deferred_error_interrupt(struct pt_regs *);
 #endif
 
 extern void ist_enter(struct pt_regs *regs);
diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index dd33c357548f..f6b8e62b286b 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -23,6 +23,7 @@
 #include <linux/string.h>
 
 #include <asm/amd_nb.h>
+#include <asm/traps.h>
 #include <asm/apic.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
@@ -99,7 +100,7 @@ static u32 smca_bank_addrs[MAX_NR_BANKS][NR_BLOCKS] __ro_after_init =
 	[0 ... MAX_NR_BANKS - 1] = { [0 ... NR_BLOCKS - 1] = -1 }
 };
 
-const char *smca_get_name(enum smca_bank_types t)
+static const char *smca_get_name(enum smca_bank_types t)
 {
 	if (t >= N_SMCA_BANK_TYPES)
 		return NULL;
@@ -825,7 +826,7 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 	mce_log(&m);
 }
 
-asmlinkage __visible void __irq_entry smp_deferred_error_interrupt(void)
+asmlinkage __visible void __irq_entry smp_deferred_error_interrupt(struct pt_regs *r)
 {
 	entering_irq();
 	trace_deferred_error_apic_entry(DEFERRED_ERROR_VECTOR);
diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mcheck/therm_throt.c
index 2da67b70ba98..95a7cfa6de15 100644
--- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
@@ -25,6 +25,7 @@
 #include <linux/cpu.h>
 
 #include <asm/processor.h>
+#include <asm/traps.h>
 #include <asm/apic.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
diff --git a/arch/x86/kernel/cpu/mcheck/threshold.c b/arch/x86/kernel/cpu/mcheck/threshold.c
index 2b584b319eff..13bccbc8e9e6 100644
--- a/arch/x86/kernel/cpu/mcheck/threshold.c
+++ b/arch/x86/kernel/cpu/mcheck/threshold.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 
 #include <asm/irq_vectors.h>
+#include <asm/traps.h>
 #include <asm/apic.h>
 #include <asm/mce.h>
 #include <asm/trace/irq_vectors.h>
@@ -18,7 +19,7 @@ static void default_threshold_interrupt(void)
 
 void (*mce_threshold_vector)(void) = default_threshold_interrupt;
 
-asmlinkage __visible void __irq_entry smp_threshold_interrupt(void)
+asmlinkage __visible void __irq_entry smp_threshold_interrupt(struct pt_regs *r)
 {
 	entering_irq();
 	trace_threshold_apic_entry(THRESHOLD_APIC_VECTOR);
-- 
2.19.1

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
