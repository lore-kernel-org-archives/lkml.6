Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0E9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B09A2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ILCVg5bV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B09A2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeKGVaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:30:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35413 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeKGVaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:30:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id z16-v6so17121098wrv.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 03:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j01Qxhiz39nito7ewQN1W1FtxPRlmQuaymrKYUa51rI=;
        b=ILCVg5bVwam473Ss2BjzMaODuDwBjw07aFa2Z47GB04e1Yx1b8DuAd3ndBFUmV90E1
         e6hoXrzvubeSqCTdkwH03ucvU3p//HWJ2NH20QtPIgK7qqV6NddGJ9+CBYFgX/+XJeFH
         OJlApgGSfiiMrwPkhJjDnL66qBNlD986jQOCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j01Qxhiz39nito7ewQN1W1FtxPRlmQuaymrKYUa51rI=;
        b=M/4uPwCj0hHr3BP1yoYDTpEJ8Phfyvct/aUKYD27c01a4OdE3Jc6DWcrswO8dU8J9A
         xJ4KF0R/sWp5d3CBKdCf5zlPwiCKWEqYXIvtWNUAkBCBF/cO7kO4nopVpHS5L/fbWgDE
         SJg/RTLZDLzIah3rPxmebHnFChE9v2jg4GV2dBppoSdrp+QWHlPjrBZPa4rTt0v0cpXH
         hlq4G3fY21aLTzpUIEgObWUis/dd/144foIOf9+8pnqym7JJ2MA1ISSeW7RH83tCwtgC
         ZbKcQ9pTpBkPTaFhEp95A8uXwuVay25PMN0LgMze97Oys/zBcRJWcoWVxtY4KY6X9t6Q
         a8iA==
X-Gm-Message-State: AGRZ1gI3A9rvdBQK/6VUV2sxVJwvP4m/Vu+un4z/5YY2NbJEZaPXWTS0
        yxj4PLk/lI1D3ekH+xuBTnL6jQ==
X-Google-Smtp-Source: AJdET5cYxL6rJzlR4/x+b/Imbe/09gHwnVdg466LN1bHsMT7euNPucd6OMAWigORKqiCfxG0eZh7uw==
X-Received: by 2002:adf:fac4:: with SMTP id a4-v6mr1698489wrs.202.1541591996873;
        Wed, 07 Nov 2018 03:59:56 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id v11-v6sm564320wrt.40.2018.11.07.03.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 03:59:55 -0800 (PST)
Date:   Wed, 7 Nov 2018 11:59:53 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] kgdb: Don't round up a CPU that failed rounding
 up before
Message-ID: <20181107115953.cnar4u2axi4poaxe@holly.lan>
References: <20181107010028.184543-1-dianders@chromium.org>
 <20181107010028.184543-4-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107010028.184543-4-dianders@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 05:00:27PM -0800, Douglas Anderson wrote:
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

It's been quite a while but AFAIR I decided to set the catastrophic
error here *because* the stuck csd lock would make restarting fragile.

So arguably we are now able to remove the code that sets this flag when
a CPU fails to round up.


> NOTE #3: setting 'kgdb_info[cpu].rounding_up = false' is in
> kgdb_nmicallback() instead of kgdb_call_nmi_hook() because some
> implementations override kgdb_call_nmi_hook().  It shouldn't hurt to
> have it in kgdb_nmicallback() in any case.

Slightly icky but I guess this is OK.

> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 23f2b5613afa..324cba8917f1 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -246,6 +246,20 @@ void __weak kgdb_roundup_cpus(void)
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
> +		smp_mb();

Not commented and I suspect this may have no useful effect. What 
(harmful) orderings does this barrier render impossible?


> +		if (kgdb_info[cpu].rounding_up)
> +			continue;
> +		kgdb_info[cpu].rounding_up = true;
> +
>  		csd->func = kgdb_call_nmi_hook;
>  		smp_call_function_single_async(cpu, csd);
>  	}
> @@ -782,6 +796,9 @@ int kgdb_nmicallback(int cpu, void *regs)
>  	struct kgdb_state kgdb_var;
>  	struct kgdb_state *ks = &kgdb_var;
>  
> +	kgdb_info[cpu].rounding_up = false;
> +	smp_mb();

Also not commented. Here I think the barrier may have a purpose (to
ensure rounding_up gets cleared before we peek at dbg_master_lock) but
if that is the case we need to comment it.
 

Daniel.
