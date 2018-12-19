Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D85C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30B9214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GockwP+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbeLSQzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:55:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38817 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbeLSQzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:55:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so7218677wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 08:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aJTY62VyUxIxe3zF1N9XdMNgD3O8RydDrIiHc13sLXM=;
        b=GockwP+8/HLpkTJAOM2nWXrKQy83SvmSUxEC1ChVVUqL2akQZFDPBuHSGvTkw8cHKB
         zdx8ExVWX+A4fJON5uA/ixKglxl1amZT83tbUkVUmR96ipfFQ+4Ru6hfuGVoytu7RjkY
         WsWk/k0UtSTGQhHntUTsFPQiexLWo9xkULfJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aJTY62VyUxIxe3zF1N9XdMNgD3O8RydDrIiHc13sLXM=;
        b=UigFg4ME4smKcQXbJpXEbPLcvj+TAIrZWCT1xzEYXnTv4IgTegjpEDO+kZfKBy71wd
         BqNb2nsE6CG8nk0ikGzBes8oF28nCBd0+TZwkDtGKUi+pXYzXPJbxUQ73hV6hY+O28T3
         C+We0BSCV+PccXGNC0rKKL+xn/Pd4BMBFW/rANvUEApGCxDsroIN7kfME3we3hhN8fSk
         ZfTlgJF4EjgA2tH/iP8iWn5YpHx8Nv/gUIY4BET+CtTESiUtY6ORlybfd7FeEe+SLULo
         /r5Lgf24sySQpd5eYgWUE/OydtsHhcwAf575te5+8ST7q5D8RECCLNxTQKnfXJ6kj0/Q
         vl7A==
X-Gm-Message-State: AA+aEWbNTMR5j6Dk/Dnn1sJN3ILeqaD/MWxwNfLf6inwuWcHqpL9VBDP
        t4p0kZpmM19jShiV2EabpyqO7g==
X-Google-Smtp-Source: AFSGD/WWvVmslWyKFaSfsi/6l0xYKBkiTZogrKxguh3SeRzRL6bOs+npotMNAss/sdbpTShJ0MRp9g==
X-Received: by 2002:a1c:8acd:: with SMTP id m196mr8038143wmd.120.1545238541354;
        Wed, 19 Dec 2018 08:55:41 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id x81sm6918668wmg.17.2018.12.19.08.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 08:55:40 -0800 (PST)
Date:   Wed, 19 Dec 2018 16:55:38 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Will Deacon <will.deacon@arm.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [REPOST PATCH v6 3/4] kgdb: Don't round up a CPU that failed
 rounding up before
Message-ID: <20181219165538.dbrymi2y5jno2ih7@holly.lan>
References: <20181205033828.6156-1-dianders@chromium.org>
 <20181205033828.6156-4-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205033828.6156-4-dianders@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 07:38:27PM -0800, Douglas Anderson wrote:
> If we're using the default implementation of kgdb_roundup_cpus() that
> uses smp_call_function_single_async() we can end up hanging
> kgdb_roundup_cpus() if we try to round up a CPU that failed to round
> up before.
> 
> Specifically smp_call_function_single_async() will try to wait on the
> csd lock for the CPU that we're trying to round up.  If the previous
> round up never finished then that lock could still be held and we'll
> just sit there hanging.
> 
> There's not a lot of use trying to round up a CPU that failed to round
> up before.  Let's keep a flag that indicates whether the CPU started
> but didn't finish to round up before.  If we see that flag set then
> we'll skip the next round up.
> 
> In general we have a few goals here:
> - We never want to end up calling smp_call_function_single_async()
>   when the csd is still locked.  This is accomplished because
>   flush_smp_call_function_queue() unlocks the csd _before_ invoking
>   the callback.  That means that when kgdb_nmicallback() runs we know
>   for sure the the csd is no longer locked.  Thus when we set
>   "rounding_up = false" we know for sure that the csd is unlocked.
> - If there are no timeouts rounding up we should never skip a round
>   up.
> 
> NOTE #1: In general trying to continue running after failing to round
> up CPUs doesn't appear to be supported in the debugger.  When I
> simulate this I find that kdb reports "Catastrophic error detected"
> when I try to continue.  I can overrule and continue anyway, but it
> should be noted that we may be entering the land of dragons here.
> Possibly the "Catastrophic error detected" was added _because_ of the
> future failure to round up, but even so this is an area of the code
> that hasn't been strongly tested.
> 
> NOTE #2: I did a bit of testing before and after this change.  I
> introduced a 10 second hang in the kernel while holding a spinlock
> that I could invoke on a certain CPU with 'taskset -c 3 cat /sys/...".
> 
> Before this change if I did:
> - Invoke hang
> - Enter debugger
> - g (which warns about Catastrophic error, g again to go anyway)
> - g
> - Enter debugger
> 
> ...I'd hang the rest of the 10 seconds without getting a debugger
> prompt.  After this change I end up in the debugger the 2nd time after
> only 1 second with the standard warning about 'Timed out waiting for
> secondary CPUs.'
> 
> I'll also note that once the CPU finished waiting I could actually
> debug it (aka "btc" worked)
> 
> I won't promise that everything works perfectly if the errant CPU
> comes back at just the wrong time (like as we're entering or exiting
> the debugger) but it certainly seems like an improvement.
> 
> NOTE #3: setting 'kgdb_info[cpu].rounding_up = false' is in
> kgdb_nmicallback() instead of kgdb_call_nmi_hook() because some
> implementations override kgdb_call_nmi_hook().  It shouldn't hurt to
> have it in kgdb_nmicallback() in any case.
> 
> NOTE #4: this logic is really only needed because there is no API call
> like "smp_try_call_function_single_async()" or "smp_csd_is_locked()".
> If such an API existed then we'd use it instead, but it seemed a bit
> much to add an API like this just for kgdb.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

Applied! Thanks.


> ---
> 
> Changes in v6:
> - Moved smp_call_function_single_async() error check to patch 3.
> 
> Changes in v5: None
> Changes in v4:
> - Removed smp_mb() calls.
> 
> Changes in v3:
> - Don't round up a CPU that failed rounding up before new for v3.
> 
> Changes in v2: None
> 
>  kernel/debug/debug_core.c | 20 +++++++++++++++++++-
>  kernel/debug/debug_core.h |  1 +
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 10db2833a423..1fb8b239e567 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -247,6 +247,7 @@ void __weak kgdb_roundup_cpus(void)
>  	call_single_data_t *csd;
>  	int this_cpu = raw_smp_processor_id();
>  	int cpu;
> +	int ret;
>  
>  	for_each_online_cpu(cpu) {
>  		/* No need to roundup ourselves */
> @@ -254,8 +255,23 @@ void __weak kgdb_roundup_cpus(void)
>  			continue;
>  
>  		csd = &per_cpu(kgdb_roundup_csd, cpu);
> +
> +		/*
> +		 * If it didn't round up last time, don't try again
> +		 * since smp_call_function_single_async() will block.
> +		 *
> +		 * If rounding_up is false then we know that the
> +		 * previous call must have at least started and that
> +		 * means smp_call_function_single_async() won't block.
> +		 */
> +		if (kgdb_info[cpu].rounding_up)
> +			continue;
> +		kgdb_info[cpu].rounding_up = true;
> +
>  		csd->func = kgdb_call_nmi_hook;
> -		smp_call_function_single_async(cpu, csd);
> +		ret = smp_call_function_single_async(cpu, csd);
> +		if (ret)
> +			kgdb_info[cpu].rounding_up = false;
>  	}
>  }
>  
> @@ -788,6 +804,8 @@ int kgdb_nmicallback(int cpu, void *regs)
>  	struct kgdb_state kgdb_var;
>  	struct kgdb_state *ks = &kgdb_var;
>  
> +	kgdb_info[cpu].rounding_up = false;
> +
>  	memset(ks, 0, sizeof(struct kgdb_state));
>  	ks->cpu			= cpu;
>  	ks->linux_regs		= regs;
> diff --git a/kernel/debug/debug_core.h b/kernel/debug/debug_core.h
> index 127d9bc49fb4..b4a7c326d546 100644
> --- a/kernel/debug/debug_core.h
> +++ b/kernel/debug/debug_core.h
> @@ -42,6 +42,7 @@ struct debuggerinfo_struct {
>  	int			ret_state;
>  	int			irq_depth;
>  	int			enter_kgdb;
> +	bool			rounding_up;
>  };
>  
>  extern struct debuggerinfo_struct kgdb_info[];
> -- 
> 2.20.0.rc1.387.gf8505762e3-goog
> 
