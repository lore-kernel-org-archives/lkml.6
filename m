Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3263BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EFA2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EFA2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbeKLGGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:06:38 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53276 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730996AbeKLGGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:06:38 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsq-0000l5-L3; Sun, 11 Nov 2018 19:59:00 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsW-0001jw-U7; Sun, 11 Nov 2018 19:58:40 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=" 
        <ville.syrjala@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.449271276@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 262/366] x86/apm: Don't access __preempt_count with
 zeroed fs
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 6f6060a5c9cc76fdbc22748264e6aa3779ec2427 upstream.

APM_DO_POP_SEGS does not restore fs/gs which were zeroed by
APM_DO_ZERO_SEGS. Trying to access __preempt_count with
zeroed fs doesn't really work.

Move the ibrs call outside the APM_DO_SAVE_SEGS/APM_DO_RESTORE_SEGS
invocations so that fs is actually restored before calling
preempt_enable().

Fixes the following sort of oopses:
[    0.313581] general protection fault: 0000 [#1] PREEMPT SMP
[    0.313803] Modules linked in:
[    0.314040] CPU: 0 PID: 268 Comm: kapmd Not tainted 4.16.0-rc1-triton-bisect-00090-gdd84441a7971 #19
[    0.316161] EIP: __apm_bios_call_simple+0xc8/0x170
[    0.316161] EFLAGS: 00210016 CPU: 0
[    0.316161] EAX: 00000102 EBX: 00000000 ECX: 00000102 EDX: 00000000
[    0.316161] ESI: 0000530e EDI: dea95f64 EBP: dea95f18 ESP: dea95ef0
[    0.316161]  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
[    0.316161] CR0: 80050033 CR2: 00000000 CR3: 015d3000 CR4: 000006d0
[    0.316161] Call Trace:
[    0.316161]  ? cpumask_weight.constprop.15+0x20/0x20
[    0.316161]  on_cpu0+0x44/0x70
[    0.316161]  apm+0x54e/0x720
[    0.316161]  ? __switch_to_asm+0x26/0x40
[    0.316161]  ? __schedule+0x17d/0x590
[    0.316161]  kthread+0xc0/0xf0
[    0.316161]  ? proc_apm_show+0x150/0x150
[    0.316161]  ? kthread_create_worker_on_cpu+0x20/0x20
[    0.316161]  ret_from_fork+0x2e/0x38
[    0.316161] Code: da 8e c2 8e e2 8e ea 57 55 2e ff 1d e0 bb 5d b1 0f 92 c3 5d 5f 07 1f 89 47 0c 90 8d b4 26 00 00 00 00 90 8d b4 26 00 00 00 00 90 <64> ff 0d 84 16 5c b1 74 7f 8b 45 dc 8e e0 8b 45 d8 8e e8 8b 45
[    0.316161] EIP: __apm_bios_call_simple+0xc8/0x170 SS:ESP: 0068:dea95ef0
[    0.316161] ---[ end trace 656253db2deaa12c ]---

Fixes: dd84441a7971 ("x86/speculation: Use IBRS if available before calling into firmware")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc:  David Woodhouse <dwmw@amazon.co.uk>
Cc:  "H. Peter Anvin" <hpa@zytor.com>
Cc:  x86@kernel.org
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20180709133534.5963-1-ville.syrjala@linux.intel.com
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/apm.h | 6 ------
 arch/x86/kernel/apm_32.c   | 5 +++++
 2 files changed, 5 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/apm.h
+++ b/arch/x86/include/asm/apm.h
@@ -6,8 +6,6 @@
 #ifndef _ASM_X86_MACH_DEFAULT_APM_H
 #define _ASM_X86_MACH_DEFAULT_APM_H
 
-#include <asm/nospec-branch.h>
-
 #ifdef APM_ZERO_SEGS
 #	define APM_DO_ZERO_SEGS \
 		"pushl %%ds\n\t" \
@@ -33,7 +31,6 @@ static inline void apm_bios_call_asm(u32
 	 * N.B. We do NOT need a cld after the BIOS call
 	 * because we always save and restore the flags.
 	 */
-	firmware_restrict_branch_speculation_start();
 	__asm__ __volatile__(APM_DO_ZERO_SEGS
 		"pushl %%edi\n\t"
 		"pushl %%ebp\n\t"
@@ -46,7 +43,6 @@ static inline void apm_bios_call_asm(u32
 		  "=S" (*esi)
 		: "a" (func), "b" (ebx_in), "c" (ecx_in)
 		: "memory", "cc");
-	firmware_restrict_branch_speculation_end();
 }
 
 static inline u8 apm_bios_call_simple_asm(u32 func, u32 ebx_in,
@@ -59,7 +55,6 @@ static inline u8 apm_bios_call_simple_as
 	 * N.B. We do NOT need a cld after the BIOS call
 	 * because we always save and restore the flags.
 	 */
-	firmware_restrict_branch_speculation_start();
 	__asm__ __volatile__(APM_DO_ZERO_SEGS
 		"pushl %%edi\n\t"
 		"pushl %%ebp\n\t"
@@ -72,7 +67,6 @@ static inline u8 apm_bios_call_simple_as
 		  "=S" (si)
 		: "a" (func), "b" (ebx_in), "c" (ecx_in)
 		: "memory", "cc");
-	firmware_restrict_branch_speculation_end();
 	return error;
 }
 
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -239,6 +239,7 @@
 #include <asm/olpc.h>
 #include <asm/paravirt.h>
 #include <asm/reboot.h>
+#include <asm/nospec-branch.h>
 
 #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
 extern int (*console_blank_hook)(int);
@@ -614,11 +615,13 @@ static long __apm_bios_call(void *_call)
 	gdt[0x40 / 8] = bad_bios_desc;
 
 	apm_irq_save(flags);
+	firmware_restrict_branch_speculation_start();
 	APM_DO_SAVE_SEGS;
 	apm_bios_call_asm(call->func, call->ebx, call->ecx,
 			  &call->eax, &call->ebx, &call->ecx, &call->edx,
 			  &call->esi);
 	APM_DO_RESTORE_SEGS;
+	firmware_restrict_branch_speculation_end();
 	apm_irq_restore(flags);
 	gdt[0x40 / 8] = save_desc_40;
 	put_cpu();
@@ -690,10 +693,12 @@ static long __apm_bios_call_simple(void
 	gdt[0x40 / 8] = bad_bios_desc;
 
 	apm_irq_save(flags);
+	firmware_restrict_branch_speculation_start();
 	APM_DO_SAVE_SEGS;
 	error = apm_bios_call_simple_asm(call->func, call->ebx, call->ecx,
 					 &call->eax);
 	APM_DO_RESTORE_SEGS;
+	firmware_restrict_branch_speculation_end();
 	apm_irq_restore(flags);
 	gdt[0x40 / 8] = save_desc_40;
 	put_cpu();

