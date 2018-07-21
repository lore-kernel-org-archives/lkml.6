Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FCFECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23F420856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiaSZL3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23F420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbeGUNpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:45:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36708 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeGUNpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:45:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so13647254wro.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=izzpDpZoy3lcEGJrp0JTRJV9XPfNgiRhbOn9Kw5Sgsk=;
        b=iiaSZL3LBaGn1Guisd1NwVDjdAVd2lqDiGyAPsf+Z4RP1AkssDyvPFaOpbbE3yXM+2
         cNN1uMI28BBaO5NlEe2pEQfDXTeoHFWNSnmJDGEVxdlyFFiphrbzWqasaT1ROKD8npOa
         h37QLP9vuip2kxf6mpZefvwcFpuUNM4UHJmAFlSc6gJbN94YYQ9fnK1TicDBXd02FutL
         sfiM3L3fovfNG9ydzhG8Wdr/moT5fETUPjwl6vsSuVeHsRQ9K46VOIu0R1EEFLTyAOfB
         y/ufnitFzTX8HZyl6UfueD4ytp43mu25zamgCUOsficY53jeYZ5TJ+idHW0vgQl3SsPE
         edtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding
         :user-agent;
        bh=izzpDpZoy3lcEGJrp0JTRJV9XPfNgiRhbOn9Kw5Sgsk=;
        b=SaaUPMdRxlkoTI0kOIm3ds6tQl2LDDwRC2xellnc4DzT5q3VNjL7r9+E0RNVdz9vTf
         8Sct4/1JS3mMWlbryYs88G8ViWb3rQHxplm/BIaFd73uLsTa74XafzAez01PcwE30rUC
         pe+gDRQuAWL2lSDhlXSOJZl9i1UGqxv+eUbevfkgcK93W+HzhShWb4s4ue7D0HJRvVag
         N8itPDpTkJplLseFrBpNfoIf+ZzLuKul+hc4ib04zb3XRU4c/Ml7WuLRx0fLGurklOD5
         375dnUf3FH/mJREm3BZHZjDGwU90/sVIjF984BgXcedq6MAgA5EbGzPj+qigTJqCL0um
         b/XQ==
X-Gm-Message-State: AOUpUlGiMowUbvqYL53UjISKAutsF5GvkOeOA3M4W+zAVMTqT6w4hMSv
        lM/3pZOKRY8iBzngK7wd4po=
X-Google-Smtp-Source: AAOMgpe8hKDUIgIg33t7YPThSkmxsudHFISlPf2O4iiu1ZTPC31Mv/t6GtNvuXam/4eOtC40TPkiNw==
X-Received: by 2002:adf:e78d:: with SMTP id n13-v6mr3929675wrm.136.1532177564901;
        Sat, 21 Jul 2018 05:52:44 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j9-v6sm11408554wrv.5.2018.07.21.05.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jul 2018 05:52:44 -0700 (PDT)
Date:   Sat, 21 Jul 2018 14:52:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/pti fixes
Message-ID: <20180721125242.GA19748@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-pti-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-urgent-for-linus

   # HEAD: 6f6060a5c9cc76fdbc22748264e6aa3779ec2427 x86/apm: Don't access __preempt_count with zeroed fs

An APM fix, and a BTS hardware-tracing fix related to PTI changes.

 Thanks,

	Ingo

------------------>
Hugh Dickins (1):
      x86/events/intel/ds: Fix bts_interrupt_threshold alignment

Ville Syrjälä (1):
      x86/apm: Don't access __preempt_count with zeroed fs


 arch/x86/events/intel/ds.c | 8 +++++---
 arch/x86/include/asm/apm.h | 6 ------
 arch/x86/kernel/apm_32.c   | 5 +++++
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8a10a045b57b..8cf03f101938 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -408,9 +408,11 @@ static int alloc_bts_buffer(int cpu)
 	ds->bts_buffer_base = (unsigned long) cea;
 	ds_update_cea(cea, buffer, BTS_BUFFER_SIZE, PAGE_KERNEL);
 	ds->bts_index = ds->bts_buffer_base;
-	max = BTS_RECORD_SIZE * (BTS_BUFFER_SIZE / BTS_RECORD_SIZE);
-	ds->bts_absolute_maximum = ds->bts_buffer_base + max;
-	ds->bts_interrupt_threshold = ds->bts_absolute_maximum - (max / 16);
+	max = BTS_BUFFER_SIZE / BTS_RECORD_SIZE;
+	ds->bts_absolute_maximum = ds->bts_buffer_base +
+					max * BTS_RECORD_SIZE;
+	ds->bts_interrupt_threshold = ds->bts_absolute_maximum -
+					(max / 16) * BTS_RECORD_SIZE;
 	return 0;
 }
 
diff --git a/arch/x86/include/asm/apm.h b/arch/x86/include/asm/apm.h
index c356098b6fb9..4d4015ddcf26 100644
--- a/arch/x86/include/asm/apm.h
+++ b/arch/x86/include/asm/apm.h
@@ -7,8 +7,6 @@
 #ifndef _ASM_X86_MACH_DEFAULT_APM_H
 #define _ASM_X86_MACH_DEFAULT_APM_H
 
-#include <asm/nospec-branch.h>
-
 #ifdef APM_ZERO_SEGS
 #	define APM_DO_ZERO_SEGS \
 		"pushl %%ds\n\t" \
@@ -34,7 +32,6 @@ static inline void apm_bios_call_asm(u32 func, u32 ebx_in, u32 ecx_in,
 	 * N.B. We do NOT need a cld after the BIOS call
 	 * because we always save and restore the flags.
 	 */
-	firmware_restrict_branch_speculation_start();
 	__asm__ __volatile__(APM_DO_ZERO_SEGS
 		"pushl %%edi\n\t"
 		"pushl %%ebp\n\t"
@@ -47,7 +44,6 @@ static inline void apm_bios_call_asm(u32 func, u32 ebx_in, u32 ecx_in,
 		  "=S" (*esi)
 		: "a" (func), "b" (ebx_in), "c" (ecx_in)
 		: "memory", "cc");
-	firmware_restrict_branch_speculation_end();
 }
 
 static inline bool apm_bios_call_simple_asm(u32 func, u32 ebx_in,
@@ -60,7 +56,6 @@ static inline bool apm_bios_call_simple_asm(u32 func, u32 ebx_in,
 	 * N.B. We do NOT need a cld after the BIOS call
 	 * because we always save and restore the flags.
 	 */
-	firmware_restrict_branch_speculation_start();
 	__asm__ __volatile__(APM_DO_ZERO_SEGS
 		"pushl %%edi\n\t"
 		"pushl %%ebp\n\t"
@@ -73,7 +68,6 @@ static inline bool apm_bios_call_simple_asm(u32 func, u32 ebx_in,
 		  "=S" (si)
 		: "a" (func), "b" (ebx_in), "c" (ecx_in)
 		: "memory", "cc");
-	firmware_restrict_branch_speculation_end();
 	return error;
 }
 
diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index 5d0de79fdab0..ec00d1ff5098 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -240,6 +240,7 @@
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
@@ -690,10 +693,12 @@ static long __apm_bios_call_simple(void *_call)
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
