Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CA2C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A606206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tseYKfu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A606206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbeLDNjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 08:39:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbeLDNjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 08:39:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C525206B6;
        Tue,  4 Dec 2018 13:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543930780;
        bh=AUOps6vsAp5H0ofVvGFUrs0Z8qFuqwt5MJBumjVMxeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tseYKfu7/ndCoXZzIcgEeXSgIOV6HepMyUwv6D6fuIS3luU9f1EmZUAOFqHcBy+UR
         bOULq9G+2WNnESpg97DsT5OCQu+a8iX+WhO4R31eVQeyVg0HPcRCu/U8HHrlmPEDeT
         0RzAHAx0Q+ojkIRGGKjfKTJDoy/eZmihKVu81bPw=
Date:   Tue, 4 Dec 2018 14:39:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
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
Message-ID: <20181204133938.GA4749@kroah.com>
References: <20181204103726.750894136@linuxfoundation.org>
 <20181204103730.767674414@linuxfoundation.org>
 <alpine.DEB.2.21.1812041213140.8181@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812041213140.8181@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 12:14:13PM +0100, Thomas Gleixner wrote:
> On Tue, 4 Dec 2018, Greg Kroah-Hartman wrote:
> > --- a/arch/x86/kernel/process_32.c
> > +++ b/arch/x86/kernel/process_32.c
> > @@ -234,7 +234,6 @@ __switch_to(struct task_struct *prev_p,
> >  	struct fpu *prev_fpu = &prev->fpu;
> >  	struct fpu *next_fpu = &next->fpu;
> >  	int cpu = smp_processor_id();
> > -	struct tss_struct *tss = &per_cpu(cpu_tss_rw, cpu);
> >  
> >  	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
> >  
> > @@ -266,12 +265,7 @@ __switch_to(struct task_struct *prev_p,
> >  	if (get_kernel_rpl() && unlikely(prev->iopl != next->iopl))
> >  		set_iopl_mask(next->iopl);
> >  
> > -	/*
> > -	 * Now maybe handle debug registers and/or IO bitmaps
> > -	 */
> > -	if (unlikely(task_thread_info(prev_p)->flags & _TIF_WORK_CTXSW_PREV ||
> > -		     task_thread_info(next_p)->flags & _TIF_WORK_CTXSW_NEXT))
> > -		__switch_to_xtra(prev_p, next_p, tss);
> > +	switch_to_extra(prev_p, next_p);
> 
> This is missing the hunk below.
> 
> Thanks,
> 
> 	tglx
> 
> 8<------------------
> 
> diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
> index 67cecc9a2b6f..c2df91eab573 100644
> --- a/arch/x86/kernel/process_32.c
> +++ b/arch/x86/kernel/process_32.c
> @@ -59,6 +59,8 @@
>  #include <asm/intel_rdt_sched.h>
>  #include <asm/proto.h>
>  
> +#include "process.h"
> +
>  void __show_regs(struct pt_regs *regs, int all)
>  {
>  	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L;

Thanks, now updated.

greg k-h
