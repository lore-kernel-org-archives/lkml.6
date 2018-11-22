Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B671C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90DA20831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMybYely"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90DA20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392716AbeKVSa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:30:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45744 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732609AbeKVSa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:30:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id v6so8199651wrr.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 23:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9fziplyvQipdpzmlHAiUXg6x4YQz1+OmVF0FMVvNNZA=;
        b=qMybYely/4JAcnDmpDk4IJnw6BhUKBgrHtBDXMVKMCOC4gd4jVhy7vM+RYG8o9iMhe
         TzEe6ityhPyur5BIj5UT50HVhmfhZuAcTFQp2OrWR7aL4pW51gOGkbkpdsCNx6FTHzGW
         ZY53goH2j1PyYZ5Te2qkt/59NY8QyuY5AVgzl0n2Kmz9h64y/w15B0GRjP2GahGsLVqd
         2lgPuq6vwXSbyQQqPzzS9o5K4jEk9Mbdoduf+W9lB7B4HOsMcH6Sf9PY21ViisCL6LIo
         jVjUJ4LI+wVcYUdHm7TasfAvo7kRR0M6k94xZmD+NOGC16ykCJCjdvPwyDJO1w5bUbTY
         K9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9fziplyvQipdpzmlHAiUXg6x4YQz1+OmVF0FMVvNNZA=;
        b=Q/3fyE1NBKevrLHN7/GtLkJo0acduciVStLZ4Cj0sSVpG7xzARZ50egxlxzSlaLevB
         8xcJwLHnrk8ccv4qIgbhl1NnW3cVQ2DPpf7ndjCueajzSIGJv/Rb8EJsYA7maPFkkmwQ
         PDI8+WF7pUKlEZmaaeLDmFBvcl2hpI+qcug4y9wDYfrXyiu9Kx44rB1Sya4xnmGquRdQ
         Zn9E3ca5K9q+B2Ins7OPvht4ufeFE6Kf3eoM9rHAAEY0aUm2Lp8//oKVF4q/fPj9Km58
         1izll6ZlXX6odM86V2lTrYRoSbZQELrslTWpgEtXcrwqVc5hMtEESRMA+C7ivFJS+nhk
         swBg==
X-Gm-Message-State: AA+aEWbyEN2daMU50W+oxGFM2Vbh6pSBhJjhNREx6S2llmU455RovZw3
        30sfYlFqgsn7wsbFZT0JRAE=
X-Google-Smtp-Source: AFSGD/WavFJFXubumSx0vFc68H0NjGaGekIWbn1vp0Kf5Pc2l3lNcXwaAQ1DDazJvdLiiGIzxTvpjA==
X-Received: by 2002:a5d:5089:: with SMTP id a9mr8836832wrt.327.1542873129995;
        Wed, 21 Nov 2018 23:52:09 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w9sm4250351wme.47.2018.11.21.23.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 23:52:09 -0800 (PST)
Date:   Thu, 22 Nov 2018 08:52:06 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 17/24] x86/speculation: Move IBPB control out of
 switch_mm()
Message-ID: <20181122075206.GG41788@gmail.com>
References: <20181121201430.559770965@linutronix.de>
 <20181121201723.948990148@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121201723.948990148@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> IBPB control is currently in switch_mm() to avoid issuing IBPB when
> switching between tasks of the same process.
> 
> But that's not covering the case of sandboxed tasks which get the
> TIF_SPEC_IB flag set via seccomp. There the barrier is required when the
> potentially malicious task is switched out because the task which is
> switched in might have it not set and would still be attackable.
> 
> For tasks which mark themself with TIF_SPEC_IB via the prctl, the barrier
> needs to be when the tasks switches in because the previous one might be an
> attacker.

s/themself
 /themselves
> 
> Move the code out of switch_mm() and evaluate the TIF bit in
> switch_to(). Make it an inline function so it can be used both in 32bit and
> 64bit code.

s/32bit
 /32-bit

s/64bit
 /64-bit

> 
> This loses the optimization of switching back to the same process, but
> that's wrong in the context of seccomp anyway as it does not protect tasks
> of the same process against each other.
> 
> This could be optimized by keeping track of the last user task per cpu and
> avoiding the barrier when the task is immediately scheduled back and the
> thread inbetween was a kernel thread. It's dubious whether that'd be worth
> the extra load/store and conditional operations. Keep it optimized for the
> common case where the TIF bit is not set.

s/cpu/CPU

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/nospec-branch.h |    2 +
>  arch/x86/include/asm/spec-ctrl.h     |   46 +++++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/tlbflush.h      |    2 -
>  arch/x86/kernel/cpu/bugs.c           |   16 +++++++++++-
>  arch/x86/kernel/process_32.c         |   11 ++++++--
>  arch/x86/kernel/process_64.c         |   11 ++++++--
>  arch/x86/mm/tlb.c                    |   39 -----------------------------
>  7 files changed, 81 insertions(+), 46 deletions(-)
> 
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -312,6 +312,8 @@ do {									\
>  } while (0)
>  
>  DECLARE_STATIC_KEY_FALSE(switch_to_cond_stibp);
> +DECLARE_STATIC_KEY_FALSE(switch_to_cond_ibpb);
> +DECLARE_STATIC_KEY_FALSE(switch_to_always_ibpb);
>  
>  #endif /* __ASSEMBLY__ */
>  
> --- a/arch/x86/include/asm/spec-ctrl.h
> +++ b/arch/x86/include/asm/spec-ctrl.h
> @@ -76,6 +76,52 @@ static inline u64 ssbd_tif_to_amd_ls_cfg
>  	return (tifn & _TIF_SSBD) ? x86_amd_ls_cfg_ssbd_mask : 0ULL;
>  }
>  
> +/**
> + * switch_to_ibpb - Issue IBPB on task switch
> + * @next:	Pointer to the next task
> + * @prev_tif:	Threadinfo flags of the previous task
> + * @next_tif:	Threadinfo flags of the next task
> + *
> + * IBPB flushes the branch predictor, which stops Spectre-v2 attacks
> + * between user space tasks. Depending on the mode the flush is made
> + * conditional.
> + */
> +static inline void switch_to_ibpb(struct task_struct *next,
> +				  unsigned long prev_tif,
> +				  unsigned long next_tif)
> +{
> +	if (static_branch_unlikely(&switch_to_always_ibpb)) {
> +		/* Only flush when switching to a user task. */
> +		if (next->mm)
> +			indirect_branch_prediction_barrier();
> +	}
> +
> +	if (static_branch_unlikely(&switch_to_cond_ibpb)) {
> +		/*
> +		 * Both tasks' threadinfo flags are checked for TIF_SPEC_IB.
> +		 *
> +		 * For an outgoing sandboxed task which has TIF_SPEC_IB set
> +		 * via seccomp this is needed because it might be malicious
> +		 * and the next user task switching in might not have it
> +		 * set.
> +		 *
> +		 * For an incoming task which has set TIF_SPEC_IB itself
> +		 * via prctl() this is needed because the previous user
> +		 * task might be malicious and have the flag unset.
> +		 *
> +		 * This could be optimized by keeping track of the last
> +		 * user task per cpu and avoiding the barrier when the task
> +		 * is immediately scheduled back and the thread inbetween
> +		 * was a kernel thread. It's dubious whether that'd be
> +		 * worth the extra load/store and conditional operations.
> +		 * Keep it optimized for the common case where the TIF bit
> +		 * is not set.
> +		 */
> +		if ((prev_tif | next_tif) & _TIF_SPEC_IB)
> +			indirect_branch_prediction_barrier();

s/cpu/CPU

> +
> +		switch (mode) {
> +		case SPECTRE_V2_APP2APP_STRICT:
> +			static_branch_enable(&switch_to_always_ibpb);
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		pr_info("mitigation: Enabling %s Indirect Branch Prediction Barrier\n",
> +			mode == SPECTRE_V2_APP2APP_STRICT ? "forced" : "conditional");

Maybe s/forced/always-on, to better match the code?

> @@ -617,11 +619,16 @@ void compat_start_thread(struct pt_regs
>  	/* Reload sp0. */
>  	update_task_stack(next_p);
>  
> +	prev_tif = task_thread_info(prev_p)->flags;
> +	next_tif = task_thread_info(next_p)->flags;
> +	/* Indirect branch prediction barrier control */
> +	switch_to_ibpb(next_p, prev_tif, next_tif);
> +
>  	/*
>  	 * Now maybe reload the debug registers and handle I/O bitmaps
>  	 */
> -	if (unlikely(task_thread_info(next_p)->flags & _TIF_WORK_CTXSW_NEXT ||
> -		     task_thread_info(prev_p)->flags & _TIF_WORK_CTXSW_PREV))
> +	if (unlikely(next_tif & _TIF_WORK_CTXSW_NEXT ||
> +		     prev_tif & _TIF_WORK_CTXSW_PREV))
>  		__switch_to_xtra(prev_p, next_p, tss);

Hm, the repetition between process_32.c and process_64.c is getting 
stronger - could some of this be unified into process.c? (in later 
patches)

Thanks,

	Ingo
