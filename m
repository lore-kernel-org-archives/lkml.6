Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9C2C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C64220848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FWDLNZj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C64220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbeLCQBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:01:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35980 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeLCQBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:01:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id a18so6256238wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 08:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O9CECqh3N8GGFLdUsw9wq3H3w0hYgnS1oi2Nu+LwmiA=;
        b=FWDLNZj1dH8ky6HZG7a4N/jHfKZ/U3gohwkQLSRPTIAjF7bkvwj7ZJXeMYPNQW8IyD
         xqEzSvFgk2CLDbIS5lBafRodHONkHVHfNL7csdQir6I7OUMlZJ10Af3y3Ez0HIRCsalu
         iSV3eM34Iohfuc5F7jQmtMGiXfzGvJD7g+beY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O9CECqh3N8GGFLdUsw9wq3H3w0hYgnS1oi2Nu+LwmiA=;
        b=EsJ6XNbiuk3A4Ts3a8Z2UPLoeA9NEgQQw8o8ATIKqjSfynE+oVJGvYGtf8TOVXFXYK
         F/R/DvmowIqzZxy09yBPWw9GjIP32EyZJ0/wgBzvFNZvA5zld8A2xXuKmSlclgechsBK
         zTZs9QNjTP2jT9/BVc+8gKW2M+03agcnJ/0z5V9T3XoeWydeyo4LJeqlr+QzDfiDXKTk
         Ir1neL0DV6aFqP0Jm7zO0aOtyLA66YlvBe1h89oY9ekBi2/a0DB4x1iGxY2TSYRVBkZf
         NWLi6xrzhbvlAmbOoiEeMXkx0vuyAnIetzIrcmP+LJD48wq+Qe/9uFcYgzrd5kOw97Oo
         myKQ==
X-Gm-Message-State: AA+aEWZNvgdP8nSg7iPiSG+VmpZfiPY84PPVo/YFmAddCF+o6J/aTqPG
        F4iO3T8sqFutqgFFuvfy1pyYPZdwKbayYA==
X-Google-Smtp-Source: AFSGD/WBFz8hqyhUjzisw0bIxAXXQFkqlPDxLTvwEBYLxmi+pcZRbuZg1tgGYum3Rrh/HE0rzzEMiA==
X-Received: by 2002:a1c:6783:: with SMTP id b125-v6mr8800957wmc.147.1543852904076;
        Mon, 03 Dec 2018 08:01:44 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id v6sm14107116wro.57.2018.12.03.08.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 08:01:42 -0800 (PST)
Date:   Mon, 3 Dec 2018 16:01:40 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Will Deacon <will.deacon@arm.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] kgdb: Don't round up a CPU that failed rounding
 up before
Message-ID: <20181203160140.sm22rpoklalewggu@holly.lan>
References: <20181127173839.34328-1-dianders@chromium.org>
 <20181127173839.34328-4-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127173839.34328-4-dianders@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 09:38:38AM -0800, Douglas Anderson wrote:
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

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


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
> 2.20.0.rc0.387.gc7a69e6b6c-goog
> 
