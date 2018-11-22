Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD467C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5898820831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIsgDbvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5898820831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392798AbeKVSfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:35:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35471 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbeKVSfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:35:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so8249293wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 23:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2HaWyTvgiJUb+NJGKmxFl3YL/PsbvR0ZmFsNS1vswIk=;
        b=IIsgDbvsZRAZ87uP21Aysw0Hy3RCPTMBFdWyuJ385KqWeeHVvpr4KhQHveNeLSumKJ
         g1jORxuTdqRTxRlhd13T2pEslp29rqtSTlVXelpiEKsFnRxiut7B8ezDgfYmPfdbSVM0
         UlxgbtshjpcJqiH/Ro1sBMx4DsUR1RfmgWiz4dYWsI8mAeqrFSaW0eq87GLECcw3TodM
         5tharOep6CbalxqNQo9fj4Z8BHNuVQlcIfWi+NDeFnVXJn+MbWInNDIlzuhZvnr0cxpL
         0sYsO+s62oURZ1TYWXjw37BTJZtID98bbC3ovn9csLx/yuf5d2GtjqknWIrCyLt6OhNg
         cyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2HaWyTvgiJUb+NJGKmxFl3YL/PsbvR0ZmFsNS1vswIk=;
        b=abf4q6+LY2wtkyjrsAuEQfkZsiPJ4hg5Drk4istcBmHOc74UCRjrzINPEBWRzJegYl
         VjgB4kFeYTY8fzR2g155AozA+AknRn2E+TFNpoJV6GCefExAvsC7ObkmnzYc49xv4qau
         67z++DDRL+RwCN/ZWUuYVO3hTeMjpC8Fylq5qovbfNUUjiy3apJTgHDu9KYXvHsu39D1
         pJ/bAO8J79TXlehoC8jVhadJNlTc73i1gwS3yap0qi24ubC2urO186DcDG0EWkxD1J8y
         uH4esyldrX9aOSUGOthe0goaA4D+BCcGJTiEsW3Zr8GIfjn95HnFD2jXegJhDTOQ57JJ
         O1DA==
X-Gm-Message-State: AA+aEWbxzm1amiWXh4w+kvIKWUGUTnx+FbjBdnog5tCl6aHsijfe45cw
        roh3Np6uX/6X1KNUdWuzBhE=
X-Google-Smtp-Source: AFSGD/Wbpn5e4iTBBy4DI7buZu7KJrvK13GqxBt5ad8AxDDAtfXoXGbnLUMuncv2xWx5xbEwwoqf4Q==
X-Received: by 2002:a5d:4303:: with SMTP id h3mr4242910wrq.273.1542873433023;
        Wed, 21 Nov 2018 23:57:13 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q12sm24606513wrx.31.2018.11.21.23.57.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 23:57:12 -0800 (PST)
Date:   Thu, 22 Nov 2018 08:57:09 +0100
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
        Kees Cook <keescook@chromium.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [patch 16/24] x86/speculation: Prepare for per task indirect
 branch speculation control
Message-ID: <20181122075709.GH41788@gmail.com>
References: <20181121201430.559770965@linutronix.de>
 <20181121201723.856044561@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121201723.856044561@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Tim Chen <tim.c.chen@linux.intel.com>
> 
> To avoid the overhead of STIBP always on, it's necessary to allow per task
> control of STIBP.
> 
> Add a new task flag TIF_SPEC_IB and evaluate it during context switch if
> SMT is active and flag evaluation is enabled by the speculation control
> code. Add the conditional evaluation to x86_virt_spec_ctrl() as well so the
> guest/host switch works properly.
> 
> This has no effect because TIF_SPEC_IB cannot be set yet and the static key
> which controls evaluation is off. Preparatory patch for adding the control
> code.
> 
> [ tglx: Simplify the context switch logic and make the TIF evaluation
>   	depend on SMP=y and on the static key controlling the conditional
>   	update. Rename it to TIF_SPEC_IB because it controls both STIBP and
>   	IBPB ]
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>  arch/x86/include/asm/msr-index.h   |    5 +++--
>  arch/x86/include/asm/spec-ctrl.h   |   12 ++++++++++++
>  arch/x86/include/asm/thread_info.h |    5 ++++-
>  arch/x86/kernel/cpu/bugs.c         |    4 ++++
>  arch/x86/kernel/process.c          |   24 ++++++++++++++++++++++--
>  5 files changed, 45 insertions(+), 5 deletions(-)
> 
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -41,9 +41,10 @@
>  
>  #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
>  #define SPEC_CTRL_IBRS			(1 << 0)   /* Indirect Branch Restricted Speculation */
> -#define SPEC_CTRL_STIBP			(1 << 1)   /* Single Thread Indirect Branch Predictors */
> +#define SPEC_CTRL_STIBP_SHIFT		1	   /* Single Thread Indirect Branch Predictor (STIBP) bit */
> +#define SPEC_CTRL_STIBP			(1 << SPEC_CTRL_STIBP_SHIFT)	/* STIBP mask */
>  #define SPEC_CTRL_SSBD_SHIFT		2	   /* Speculative Store Bypass Disable bit */
> -#define SPEC_CTRL_SSBD			(1 << SPEC_CTRL_SSBD_SHIFT)   /* Speculative Store Bypass Disable */
> +#define SPEC_CTRL_SSBD			(1 << SPEC_CTRL_SSBD_SHIFT)	/* Speculative Store Bypass Disable */
>  
>  #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
>  #define PRED_CMD_IBPB			(1 << 0)   /* Indirect Branch Prediction Barrier */
> --- a/arch/x86/include/asm/spec-ctrl.h
> +++ b/arch/x86/include/asm/spec-ctrl.h
> @@ -53,12 +53,24 @@ static inline u64 ssbd_tif_to_spec_ctrl(
>  	return (tifn & _TIF_SSBD) >> (TIF_SSBD - SPEC_CTRL_SSBD_SHIFT);
>  }
>  
> +static inline u64 stibp_tif_to_spec_ctrl(u64 tifn)
> +{
> +	BUILD_BUG_ON(TIF_SPEC_IB < SPEC_CTRL_STIBP_SHIFT);
> +	return (tifn & _TIF_SPEC_IB) >> (TIF_SPEC_IB - SPEC_CTRL_STIBP_SHIFT);
> +}
> +
>  static inline unsigned long ssbd_spec_ctrl_to_tif(u64 spec_ctrl)
>  {
>  	BUILD_BUG_ON(TIF_SSBD < SPEC_CTRL_SSBD_SHIFT);
>  	return (spec_ctrl & SPEC_CTRL_SSBD) << (TIF_SSBD - SPEC_CTRL_SSBD_SHIFT);
>  }
>  
> +static inline unsigned long stibp_spec_ctrl_to_tif(u64 spec_ctrl)
> +{
> +	BUILD_BUG_ON(TIF_SPEC_IB < SPEC_CTRL_STIBP_SHIFT);
> +	return (spec_ctrl & SPEC_CTRL_STIBP) << (TIF_SPEC_IB - SPEC_CTRL_STIBP_SHIFT);
> +}
> +
>  static inline u64 ssbd_tif_to_amd_ls_cfg(u64 tifn)
>  {
>  	return (tifn & _TIF_SSBD) ? x86_amd_ls_cfg_ssbd_mask : 0ULL;
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -83,6 +83,7 @@ struct thread_info {
>  #define TIF_SYSCALL_EMU		6	/* syscall emulation active */
>  #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
>  #define TIF_SECCOMP		8	/* secure computing */
> +#define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
>  #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
>  #define TIF_UPROBE		12	/* breakpointed or singlestepping */
>  #define TIF_PATCH_PENDING	13	/* pending live patching update */
> @@ -110,6 +111,7 @@ struct thread_info {
>  #define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
>  #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
>  #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
> +#define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
>  #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
>  #define _TIF_UPROBE		(1 << TIF_UPROBE)
>  #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
> @@ -146,7 +148,8 @@ struct thread_info {
>  
>  /* flags to check in __switch_to() */
>  #define _TIF_WORK_CTXSW							\
> -	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP|_TIF_SSBD)
> +	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP|		\
> +	 _TIF_SSBD|_TIF_SPEC_IB)
>  
>  #define _TIF_WORK_CTXSW_PREV (_TIF_WORK_CTXSW|_TIF_USER_RETURN_NOTIFY)
>  #define _TIF_WORK_CTXSW_NEXT (_TIF_WORK_CTXSW)
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -148,6 +148,10 @@ x86_virt_spec_ctrl(u64 guest_spec_ctrl,
>  		    static_cpu_has(X86_FEATURE_AMD_SSBD))
>  			hostval |= ssbd_tif_to_spec_ctrl(ti->flags);
>  
> +		/* Check whether dynamic indirect branch control is on */
> +		if (static_branch_unlikely(&switch_to_cond_stibp))
> +			hostval |= stibp_tif_to_spec_ctrl(ti->flags);
> +
>  		if (hostval != guestval) {
>  			msrval = setguest ? guestval : hostval;
>  			wrmsrl(MSR_IA32_SPEC_CTRL, msrval);
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -12,6 +12,7 @@
>  #include <linux/sched/debug.h>
>  #include <linux/sched/task.h>
>  #include <linux/sched/task_stack.h>
> +#include <linux/sched/topology.h>
>  #include <linux/init.h>
>  #include <linux/export.h>
>  #include <linux/pm.h>
> @@ -406,6 +407,11 @@ static __always_inline void spec_ctrl_up
>  	if (static_cpu_has(X86_FEATURE_SSBD))
>  		msr |= ssbd_tif_to_spec_ctrl(tifn);
>  
> +	/* Only evaluate STIBP if dynamic control is enabled */
> +	if (IS_ENABLED(CONFIG_SMP) &&
> +	    static_branch_unlikely(&switch_to_cond_stibp))
> +		msr |= stibp_tif_to_spec_ctrl(tifn);

> +	/*
> +	 * Only evaluate TIF_SPEC_IB if dynamic control is
> +	 * enabled, otherwise avoid the MSR write
> +	 */
> +	if (IS_ENABLED(CONFIG_SMP) &&
> +	    static_branch_unlikely(&switch_to_cond_stibp))
> +		updmsr |= !!(tif_diff & _TIF_SPEC_IB);

Small nit:

we use several terms here in an interchangeable fashion:

 - 'dynamic control'
 - 'conditional STIBP'

The in-code variable naming follows the second nomenclature, while we 
often mention 'dynamic control' - and the relationship is not always 
obvious immediately.

It might make sense to pick one of these - for example if we pick 
'conditional STIBP' then the second comment would become:

	/*
	 * Only evaluate TIF_SPEC_IB if conditional STIBP is
	 * enabled, otherwise avoid the MSR write
	 */

etc.

Thanks,

	ngo
