Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751960AbeBAIZ0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 03:25:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35144 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeBAIZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 03:25:23 -0500
X-Google-Smtp-Source: AH8x224YqWn+NNEQ0wQU045Mscn3LWVBVFRTbzn5cZpdrpfjj3ZKA0uDf+NCSBlf+Rc0qJzF6vU7Ow==
Date: Thu, 1 Feb 2018 09:25:20 +0100
From: Christian Brauner <christian.brauner@canonical.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: mingo@kernel.org, hpa@zytor.com, tim.c.chen@linux.intel.com,
        dwmw@amazon.co.uk, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jpoimboe@redhat.com
Subject: Re: [tip:x86/pti] x86/speculation: Use Indirect Branch Prediction
 Barrier in context switch
Message-ID: <20180201082518.w3bk5udvzdre7zc2@gmail.com>
References: <1517263487-3708-1-git-send-email-dwmw@amazon.co.uk>
 <tip-18bf3c3ea8ece8f03b6fc58508f2dfd23c7711c7@git.kernel.org>
 <20180131070300.GA28206@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180131070300.GA28206@light.dominikbrodowski.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 08:03:00AM +0100, Dominik Brodowski wrote:
> On Tue, Jan 30, 2018 at 02:39:45PM -0800, tip-bot for Tim Chen wrote:
> > Commit-ID:  18bf3c3ea8ece8f03b6fc58508f2dfd23c7711c7
> > Gitweb:     https://git.kernel.org/tip/18bf3c3ea8ece8f03b6fc58508f2dfd23c7711c7
> > Author:     Tim Chen <tim.c.chen@linux.intel.com>
> > AuthorDate: Mon, 29 Jan 2018 22:04:47 +0000
> > Committer:  Thomas Gleixner <tglx@linutronix.de>
> > CommitDate: Tue, 30 Jan 2018 23:09:21 +0100
> > 
> > x86/speculation: Use Indirect Branch Prediction Barrier in context switch
> > 
> > Flush indirect branches when switching into a process that marked itself
> > non dumpable. This protects high value processes like gpg better,
> > without having too high performance overhead.
> 
> For the record, I am still opposed to limit this to non-dumpable processes.
> Whether a process needs protection by IBPB on context switches is a
> different question to whether a process should be allowed to be dumped,

This is especially true since you can get into a non-dumpable state
implicitly due to setuid() in a new user namespace. So avoiding the
performance hit due to IBPD is not necessary a concious decision taken
by calling prctl(), that is to say even if you care about performance
and don't want to take the IBPB hit you might accidently have to take it
when doing a setuid(). Also there are definitely workloads where
you want to be able to ptrace a task while at the same time having it do
IBPB. So let's not limit this to non-dumpable taks! Thanks Dominik!

> though the former may be a superset of the latter. In my opinion, IBPB
> should be enabled on all context switches to userspace processes, until we
> have a clear mitigation strategy for userspace against Spectre-v2 designed
> and implemented.
> 
> Thanks,
> 	Dominik
> 
> --------------------------
> From: Dominik Brodowski <linux@dominikbrodowski.net>
> Date: Wed, 31 Jan 2018 07:43:12 +0100
> Subject: [PATCH] x86/speculation: Do not limit Indirect Branch Prediction Barrier to non-dumpable processes
> 
> Whether a process needs protection by IBPB on context switches is a
> different question to whether a process should be allowed to be dumped,
> though the former may be a superset of the latter. Enable IBPB on all
> context switches to a different userspace process, until we have a clear
> mitigation strategy for userspace against Spectre-v2 designed and
> implemented.

Thanks Dominik. That makes a lot more sense!

> 
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 012d02624848..f54897b68b16 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -255,19 +255,13 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>  		 * predictor when switching between processes. This stops
>  		 * one process from doing Spectre-v2 attacks on another.
>  		 *
> -		 * As an optimization, flush indirect branches only when
> -		 * switching into processes that disable dumping. This
> -		 * protects high value processes like gpg, without having
> -		 * too high performance overhead. IBPB is *expensive*!
> -		 *
>  		 * This will not flush branches when switching into kernel
>  		 * threads. It will also not flush if we switch to idle
>  		 * thread and back to the same process. It will flush if we
> -		 * switch to a different non-dumpable process.
> +		 * switch to a different user process.
>  		 */
>  		if (tsk && tsk->mm &&
> -		    tsk->mm->context.ctx_id != last_ctx_id &&
> -		    get_dumpable(tsk->mm) != SUID_DUMP_USER)
> +		    tsk->mm->context.ctx_id != last_ctx_id)
>  			indirect_branch_prediction_barrier();
>  
>  		if (IS_ENABLED(CONFIG_VMAP_STACK)) {
