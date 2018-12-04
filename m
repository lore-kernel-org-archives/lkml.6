Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE9DC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC2F2082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC2F2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbeLDLOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:14:36 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44537 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbeLDLOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:14:35 -0500
Received: from conf.hotelmediterraneo.com ([2.228.78.71] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gU8eq-0003Qh-Hb; Tue, 04 Dec 2018 12:14:28 +0100
Date:   Tue, 4 Dec 2018 12:14:13 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 4.14 098/146] x86/process: Consolidate and simplify
 switch_to_xtra() code
In-Reply-To: <20181204103730.767674414@linuxfoundation.org>
Message-ID: <alpine.DEB.2.21.1812041213140.8181@nanos.tec.linutronix.de>
References: <20181204103726.750894136@linuxfoundation.org> <20181204103730.767674414@linuxfoundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018, Greg Kroah-Hartman wrote:
> --- a/arch/x86/kernel/process_32.c
> +++ b/arch/x86/kernel/process_32.c
> @@ -234,7 +234,6 @@ __switch_to(struct task_struct *prev_p,
>  	struct fpu *prev_fpu = &prev->fpu;
>  	struct fpu *next_fpu = &next->fpu;
>  	int cpu = smp_processor_id();
> -	struct tss_struct *tss = &per_cpu(cpu_tss_rw, cpu);
>  
>  	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
>  
> @@ -266,12 +265,7 @@ __switch_to(struct task_struct *prev_p,
>  	if (get_kernel_rpl() && unlikely(prev->iopl != next->iopl))
>  		set_iopl_mask(next->iopl);
>  
> -	/*
> -	 * Now maybe handle debug registers and/or IO bitmaps
> -	 */
> -	if (unlikely(task_thread_info(prev_p)->flags & _TIF_WORK_CTXSW_PREV ||
> -		     task_thread_info(next_p)->flags & _TIF_WORK_CTXSW_NEXT))
> -		__switch_to_xtra(prev_p, next_p, tss);
> +	switch_to_extra(prev_p, next_p);

This is missing the hunk below.

Thanks,

	tglx

8<------------------

diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 67cecc9a2b6f..c2df91eab573 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -59,6 +59,8 @@
 #include <asm/intel_rdt_sched.h>
 #include <asm/proto.h>
 
+#include "process.h"
+
 void __show_regs(struct pt_regs *regs, int all)
 {
 	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L;
