Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DC3C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977DD2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQFeh/4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977DD2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeH2Nuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:50:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbeH2Nui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:50:38 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6869020645;
        Wed, 29 Aug 2018 09:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535536472;
        bh=O7X/ndkF7y7dDouf8PlkYnHhVhmND3ppmDmSQXNvF+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IQFeh/4fYZpCJAkTTRdNxJLn7NSow52BRO08OypQ5iZvCLVKZ/pPsO/C7kPMPHSXq
         mGmW0y7eoubK62UJ1xOMG/w4vq76yQUy2DfW9n7+kbpIxW6lDO3sEXQcy/yvNw/PAV
         Zytk4pvZFaTgSKTI1iL4EfKxsfbSoWS4/k2K/KQQ=
Date:   Wed, 29 Aug 2018 18:54:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <linux-arch@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 3/6] fork: provide a function for copying init_mm
Message-Id: <20180829185428.e59fe325efcd4eb675e3eee3@kernel.org>
In-Reply-To: <20180829081147.184610-4-namit@vmware.com>
References: <20180829081147.184610-1-namit@vmware.com>
        <20180829081147.184610-4-namit@vmware.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 01:11:44 -0700
Nadav Amit <namit@vmware.com> wrote:

> Provide a function for copying init_mm. This function will be later used
> for setting a temporary mm.

This looks good to me :)

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  include/linux/sched/task.h |  1 +
>  kernel/fork.c              | 24 ++++++++++++++++++------
>  2 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 108ede99e533..ac0a675678f5 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -74,6 +74,7 @@ extern void exit_itimers(struct signal_struct *);
>  extern long _do_fork(unsigned long, unsigned long, unsigned long, int __user *, int __user *, unsigned long);
>  extern long do_fork(unsigned long, unsigned long, unsigned long, int __user *, int __user *);
>  struct task_struct *fork_idle(int);
> +struct mm_struct *copy_init_mm(void);
>  extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
>  extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d896e9ca38b0..a1c637b903c1 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1254,13 +1254,20 @@ void mm_release(struct task_struct *tsk, struct mm_struct *mm)
>  		complete_vfork_done(tsk);
>  }
>  
> -/*
> - * Allocate a new mm structure and copy contents from the
> - * mm structure of the passed in task structure.
> +/**
> + * dup_mm() - duplicates an existing mm structure
> + * @tsk: the task_struct with which the new mm will be associated.
> + * @oldmm: the mm to duplicate.
> + *
> + * Allocates a new mm structure and copy contents from the provided
> + * @oldmm structure.
> + *
> + * Return: the duplicated mm or NULL on failure.
>   */
> -static struct mm_struct *dup_mm(struct task_struct *tsk)
> +static struct mm_struct *dup_mm(struct task_struct *tsk,
> +				struct mm_struct *oldmm)
>  {
> -	struct mm_struct *mm, *oldmm = current->mm;
> +	struct mm_struct *mm;
>  	int err;
>  
>  	mm = allocate_mm();
> @@ -1327,7 +1334,7 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
>  	}
>  
>  	retval = -ENOMEM;
> -	mm = dup_mm(tsk);
> +	mm = dup_mm(tsk, current->mm);
>  	if (!mm)
>  		goto fail_nomem;
>  
> @@ -2127,6 +2134,11 @@ struct task_struct *fork_idle(int cpu)
>  	return task;
>  }
>  
> +struct mm_struct *copy_init_mm(void)
> +{
> +	return dup_mm(NULL, &init_mm);
> +}
> +
>  /*
>   *  Ok, this is the main fork-routine.
>   *
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
