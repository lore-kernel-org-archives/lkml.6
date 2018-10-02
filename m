Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9835C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A7C2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A7C2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeJCAnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 20:43:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60783 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeJCAnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 20:43:06 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7Ovy-0000wQ-NO; Tue, 02 Oct 2018 19:58:10 +0200
Date:   Tue, 2 Oct 2018 19:58:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [Patch v2 4/4] x86/speculation: Add prctl to control indirect
 branch speculation per process
In-Reply-To: <ae3fb86f74de2001ddab477579afd813bca9baa9.1537920575.git.tim.c.chen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1810021949450.1435@nanos.tec.linutronix.de>
References: <cover.1537920575.git.tim.c.chen@linux.intel.com> <ae3fb86f74de2001ddab477579afd813bca9baa9.1537920575.git.tim.c.chen@linux.intel.com>
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

On Tue, 25 Sep 2018, Tim Chen wrote:
>  
> +void arch_set_dumpable(struct task_struct *tsk, struct mm_struct *mm, int value)
> +{
> +	if (!static_branch_unlikely(&spectre_v2_app_lite))
> +		return;
> +	if (!static_cpu_has(X86_FEATURE_STIBP))
> +		return;
> +
> +	if ((unsigned) value != SUID_DUMP_USER) {

First of all we use unsigned int and not unsigned, Aside of that why is the
argument not unsigned int right away?

> +		set_tsk_thread_flag(tsk, TIF_STIBP);
> +		return;
> +	}
> +
> +	if (!task_spec_indir_branch_disable(tsk)) {
> +		clear_tsk_thread_flag(tsk, TIF_STIBP);
> +	}

No braces for single line statements required.

> +}
> +
>  #ifdef CONFIG_SECCOMP
>  void arch_seccomp_spec_mitigate(struct task_struct *task)
>  {
> @@ -766,11 +824,33 @@ static int ssb_prctl_get(struct task_struct *task)
>  	}
>  }
>  
> -static void set_stibp(struct task_struct *tsk)
> -{
> -	/*
> -	 * For lite protection mode, we set STIBP only 
> -	 * for non-dumpable processes.
> -	 */
> -
> -	if (!static_branch_unlikely(&spectre_v2_app_lite))
> -		return;
> -
> -	if (!tsk || !tsk->mm)
> -		return;
> -
> -	if (get_dumpable(tsk->mm) != SUID_DUMP_USER)
> -		set_tsk_thread_flag(tsk, TIF_STIBP);
> -	else
> -		clear_tsk_thread_flag(tsk, TIF_STIBP);
> -}

This patch ordering is really strange. You first add set_stibp() just to
replace it in the next patch.


> diff --git a/fs/exec.c b/fs/exec.c
> index 1ebf6e5..89edadd 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1362,9 +1362,9 @@ void setup_new_exec(struct linux_binprm * bprm)
>  	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
>  	    !(uid_eq(current_euid(), current_uid()) &&
>  	      gid_eq(current_egid(), current_gid())))
> -		set_dumpable(current->mm, suid_dumpable);
> +		set_dumpable(current, current->mm, suid_dumpable);
>  	else
> -		set_dumpable(current->mm, SUID_DUMP_USER);
> +		set_dumpable(current, current->mm, SUID_DUMP_USER);

What's the point of adding an argument instead of just replacing mm with
task?

> +void __weak arch_set_dumpable(struct task_struct *tsk, struct mm_struct *mm, int value)
> +{
> +	return;
> +}

So this wants to be structured as follows:

 Patch 1: Change the argument from mm to task and update the implementation of
 	  set_dumpable() accordingly and fixup the users

 Patch 2: Introduce the weak arch_set_dumpable()
	 
 Patch N: Add the x86 implementation along with the patch which adds the
          stipb magic instead of having that extra step of set_stipb() and
          then replacing it.

 ....

 Patch X: Add the PRCTL

It's well documented that patches should do one thing at a time and not
come as a hodgepogde of changes.

Thanks,

	tglx
