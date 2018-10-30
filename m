Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AFFC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2F02080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TvV4SiYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2F02080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeJ3Set (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:34:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53565 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbeJ3Ses (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:34:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id v24-v6so1177155wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 02:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hrlKwhgq7KlnK3iJRxWC2+a9rEfa75oO8OqsMOZkffY=;
        b=TvV4SiYtgP1ry6uuCCRXoMwKUmnQWIg6bLZFJumdTshPXG2s0TaeBsPI9sF8BtAi4n
         ucSWFNUlXwsjzN2C/t/rjTxNk6JAOqO7sJfnTI8veaoYqBGTtU9BmJAveKbgnDTCSFVt
         8cs64THGnG/dvLyZe8DH/MCCzInuNd5+afcmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hrlKwhgq7KlnK3iJRxWC2+a9rEfa75oO8OqsMOZkffY=;
        b=jnASRkZefLbzlUvl2/QZUJc+HOOOLbkZCIpi7Eo3G2kuaRUAw/d82IfpvA/QsdV48t
         YnPEtmy4v1aV/rWIIJzPIP9zV/Tec+frN9HOW+nj2l/M0eQZ/sKQaMEtYKzsY431giQN
         hsRGC3ie1Qxre5r0k/sDlqgwQqqW2ADicY4LJXxrXwsCSuMkPEuEVlZ0ooNrPJMJS7Gl
         IcWpcI7fnJY2hfJMqFJPIh9mm5t2soonQ6fLrkZFBZCWOGhkvvHDKx0j5NZBTu8SCTmM
         POzgqEmn5a74lwdIW9aZ+IBUhn2DUQlenxfL2QHWsY5yIyBaESLtaNVmLu3q/TLC58FI
         n6gg==
X-Gm-Message-State: AGRZ1gJpE92m80y6Y7dS9hYfvl3bsqU7acgWnpLGlJaN1y1N7KY8R0lT
        Yb2YiHc4pqxLUpbCMZTrLXM/dQ==
X-Google-Smtp-Source: AJdET5eCQvexI72hCfLBQ5s6a2y85AbZGpCbAfrcrLouMc4lQ1p/zH6lVFgEydUZJSdRRBDjoM+waw==
X-Received: by 2002:a1c:2c87:: with SMTP id s129-v6mr1066068wms.127.1540892523434;
        Tue, 30 Oct 2018 02:42:03 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id x197-v6sm20175092wme.15.2018.10.30.02.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 02:42:02 -0700 (PDT)
Date:   Tue, 30 Oct 2018 09:41:59 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>, tglx@linutronix.de,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, peterz@infradead.org,
        linux-hexagon@vger.kernel.org, frederic@kernel.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/7] smp: Don't yell about IRQs disabled in
 kgdb_roundup_cpus()
Message-ID: <20181030094159.zt6akmyxwrbzoe2x@holly.lan>
References: <20181029180707.207546-1-dianders@chromium.org>
 <20181029180707.207546-7-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029180707.207546-7-dianders@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 11:07:06AM -0700, Douglas Anderson wrote:
> In kgdb_roundup_cpus() we've got code that looks like:
>   local_irq_enable();
>   smp_call_function(kgdb_call_nmi_hook, NULL, 0);
>   local_irq_disable();
> 
> In certain cases when we drop into kgdb (like with sysrq-g on a serial
> console) we'll get a big yell that looks like:
> 
>   sysrq: SysRq : DEBUG
>   ------------[ cut here ]------------
>   DEBUG_LOCKS_WARN_ON(current->hardirq_context)
>   WARNING: CPU: 0 PID: 0 at .../kernel/locking/lockdep.c:2875 lockdep_hardirqs_on+0xf0/0x160
>   CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0 #27
>   pstate: 604003c9 (nZCv DAIF +PAN -UAO)
>   pc : lockdep_hardirqs_on+0xf0/0x160
>   ...
>   Call trace:
>    lockdep_hardirqs_on+0xf0/0x160
>    trace_hardirqs_on+0x188/0x1ac
>    kgdb_roundup_cpus+0x14/0x3c
>    kgdb_cpu_enter+0x53c/0x5cc
>    kgdb_handle_exception+0x180/0x1d4
>    kgdb_compiled_brk_fn+0x30/0x3c
>    brk_handler+0x134/0x178
>    do_debug_exception+0xfc/0x178
>    el1_dbg+0x18/0x78
>    kgdb_breakpoint+0x34/0x58
>    sysrq_handle_dbg+0x54/0x5c
>    __handle_sysrq+0x114/0x21c
>    handle_sysrq+0x30/0x3c
>    qcom_geni_serial_isr+0x2dc/0x30c
>   ...
>   ...
>   irq event stamp: ...45
>   hardirqs last  enabled at (...44): [...] __do_softirq+0xd8/0x4e4
>   hardirqs last disabled at (...45): [...] el1_irq+0x74/0x130
>   softirqs last  enabled at (...42): [...] _local_bh_enable+0x2c/0x34
>   softirqs last disabled at (...43): [...] irq_exit+0xa8/0x100
>   ---[ end trace adf21f830c46e638 ]---
> 
> Let's add kgdb to the list of reasons not to warn in
> smp_call_function_many().  That will allow us (in a future patch) to
> stop calling local_irq_enable() which will get rid of the original
> splat.
> 
> NOTE: with this change comes the obvious question: will we start
> deadlocking more often now when we drop into the debugger.  I can't
> say that for sure one way or the other, but the fact that we do the
> same logic for "oops_in_progress" makes me feel like it shouldn't
> happen too often.  Also note that the old logic of turning on
> interrupts temporarily wasn't exactly safe since (I presume) that
> could have violated spin_lock_irqsave() semantics and ended up with a
> deadlock of its own.

This is part of the code to bring all the cores to a halt and since
the other cores are still running kgdb isn't yet able to use the fact
all the CPUs are halted to bend the rules. It is better for this code
to play by the rules if it can.

Is is possible to get the roundup functions to use a private csd
alongside smp_call_function_single_async()? We could add a helper
function to the debug core to avoid having to add cpu_online loops into
every kgdb_roundup_cpus() implementaton.


Daniel.



> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  kernel/smp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 163c451af42e..bb581e58c8dc 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -19,6 +19,7 @@
>  #include <linux/sched.h>
>  #include <linux/sched/idle.h>
>  #include <linux/hypervisor.h>
> +#include <linux/kgdb.h>
>  
>  #include "smpboot.h"
>  
> @@ -413,7 +414,8 @@ void smp_call_function_many(const struct cpumask *mask,
>  	 * can't happen.
>  	 */
>  	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
> -		     && !oops_in_progress && !early_boot_irqs_disabled);
> +		     && !oops_in_progress && !early_boot_irqs_disabled
> +		     && !in_dbg_master());
>  
>  	/* Try to fastpath.  So, what's a CPU they want? Ignoring this one. */
>  	cpu = cpumask_first_and(mask, cpu_online_mask);
> -- 
> 2.19.1.568.g152ad8e336-goog
> 
