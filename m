Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF77C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 02:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1584020815
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 02:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laLo1l0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfADCuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 21:50:11 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45876 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfADCuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 21:50:11 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so17565963pfd.12;
        Thu, 03 Jan 2019 18:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yYwqUoZeoWegA9ar4D/yOcGjAwrZK2UjXYjbbAYEFN0=;
        b=laLo1l0w22fKjNX48Pr869jms+RwnzTmt3D4g0BwU+zMNz/H8g5znraoZRP2UIs1mN
         gr7rzN4HLGKWcwA21hDG8mElS895GPF/l7D0MTOTClpWYTjQsU6J76VAAdcwUiowJ4gP
         Vc9hpk6RA++MfL4x5OtlqyckGd0SxYqPyCoCClnO3ZJ0pe9SWzBkCsBpeLDPbtXCgnX+
         QZJ2BimJxWD/7MRJA1+6tzF6GIrplVccg5XC5wqg8bMnCcLu8w4FdEKOECwC9EIVKyDE
         /8A7HBtjD4Et7AFT4DacQ/L2hnW4n0TNYzddSufcegSuSl1GHZZOdgbP5z/O41h5hXpv
         I8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yYwqUoZeoWegA9ar4D/yOcGjAwrZK2UjXYjbbAYEFN0=;
        b=E5iBJh5Jj/y+A8/e+YfvAGNIlT1imcMlILisiuPDx3zxavhDOetqJnj1lCwPHfD4J1
         fl9OfvhEc09FdKljcRq0/gzumf/MkCb75xSRdpLiPW/rVu7qcRpPL5BxOzqxTMWWC7I4
         mNsdMHhjtRt+cKQmaoZlwbauro6+7wirLZoobmE470aLAmvEX6/PSPfTmssKH06KqjWA
         uANpL57eRLHvOsAW2kSDE/g6mZZyp72oillHs3dvTYjG9uhwgIERiiHxtBguF4OQlE8Y
         /g5dt2go2+EYuOHGHlZ9nnS6Y0W4iMB5oclLx61Jw4NjGQvvxNqBFEA0CMRfy758/Ua8
         P3yA==
X-Gm-Message-State: AJcUukdcn7SVnOmdosCU+gnZyabigyqoK8Y++5roWaqFlqNWXq16lohV
        sG5t+838NwYVg1d7s6dW3YM=
X-Google-Smtp-Source: ALg8bN7DGS6Ue2TU76gW5qUN6jHJTiD6lkIlkOu05PykcCVk9qIakjd+9qU7oZ60Pemu7IzwlA8JcQ==
X-Received: by 2002:a63:c42:: with SMTP id 2mr168650pgm.372.1546570209634;
        Thu, 03 Jan 2019 18:50:09 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x186sm83832893pfb.59.2019.01.03.18.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 18:50:08 -0800 (PST)
Date:   Thu, 3 Jan 2019 18:50:06 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        ebiederm@xmission.com, luto@kernel.org, carlos@redhat.com,
        dhowells@redhat.com, viro@zeniv.linux.org.uk, simo@redhat.com,
        eparis@parisplace.org, serge@hallyn.com
Subject: Re: [PATCH ghak90 (was ghak32) V4 01/10] audit: collect audit task
 parameters
Message-ID: <20190104025006.GA15567@roeck-us.net>
References: <cover.1533065887.git.rgb@redhat.com>
 <8e617ab568df28a66dfbe3284452de186b42fb0f.1533065887.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e617ab568df28a66dfbe3284452de186b42fb0f.1533065887.git.rgb@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Tue, Jul 31, 2018 at 04:07:36PM -0400, Richard Guy Briggs wrote:
> The audit-related parameters in struct task_struct should ideally be
> collected together and accessed through a standard audit API.
> 
> Collect the existing loginuid, sessionid and audit_context together in a
> new struct audit_task_info called "audit" in struct task_struct.
> 
> Use kmem_cache to manage this pool of memory.
> Un-inline audit_free() to be able to always recover that memory.
> 
> See: https://github.com/linux-audit/audit-kernel/issues/81
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

Overall I am not sure if keeping task_struct a bit smaller is worth
the added complexity, but I guess that is just me. 

Anyway, couple of nitpicks. Please feel free to ignore, and my apologies
if some of all of the comments are duplicates.

Guenter

> ---
>  include/linux/audit.h | 34 ++++++++++++++++++++++++----------
>  include/linux/sched.h |  5 +----
>  init/init_task.c      |  3 +--
>  init/main.c           |  2 ++
>  kernel/auditsc.c      | 51 ++++++++++++++++++++++++++++++++++++++++++---------
>  kernel/fork.c         |  4 +++-
>  6 files changed, 73 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 9334fbe..8964332 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -219,8 +219,15 @@ static inline void audit_log_task_info(struct audit_buffer *ab,
>  
>  /* These are defined in auditsc.c */
>  				/* Public API */

Not sure if the structure below belongs after "Public API".
Is it part of the public API ?

> +struct audit_task_info {
> +	kuid_t			loginuid;
> +	unsigned int		sessionid;
> +	struct audit_context	*ctx;
> +};

Add empty line ?

> +extern struct audit_task_info init_struct_audit;
> +extern void __init audit_task_init(void);
>  extern int  audit_alloc(struct task_struct *task);
> -extern void __audit_free(struct task_struct *task);
> +extern void audit_free(struct task_struct *task);
>  extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
>  				  unsigned long a2, unsigned long a3);
>  extern void __audit_syscall_exit(int ret_success, long ret_value);
> @@ -242,12 +249,15 @@ extern void audit_seccomp_actions_logged(const char *names,
>  
>  static inline void audit_set_context(struct task_struct *task, struct audit_context *ctx)
>  {
> -	task->audit_context = ctx;
> +	task->audit->ctx = ctx;
>  }
>  
>  static inline struct audit_context *audit_context(void)
>  {
> -	return current->audit_context;
> +	if (current->audit)
> +		return current->audit->ctx;
> +	else
> +		return NULL;

Unnecessary else (and static checkers may complain).

>  }
>  
>  static inline bool audit_dummy_context(void)
> @@ -255,11 +265,7 @@ static inline bool audit_dummy_context(void)
>  	void *p = audit_context();
>  	return !p || *(int *)p;
>  }
> -static inline void audit_free(struct task_struct *task)
> -{
> -	if (unlikely(task->audit_context))
> -		__audit_free(task);
> -}
> +
>  static inline void audit_syscall_entry(int major, unsigned long a0,
>  				       unsigned long a1, unsigned long a2,
>  				       unsigned long a3)
> @@ -331,12 +337,18 @@ extern int auditsc_get_stamp(struct audit_context *ctx,
>  
>  static inline kuid_t audit_get_loginuid(struct task_struct *tsk)
>  {
> -	return tsk->loginuid;
> +	if (tsk->audit)
> +		return tsk->audit->loginuid;
> +	else
> +		return INVALID_UID;

Unnecessary else.

>  }
>  
>  static inline unsigned int audit_get_sessionid(struct task_struct *tsk)
>  {
> -	return tsk->sessionid;
> +	if (tsk->audit)
> +		return tsk->audit->sessionid;
> +	else
> +		return AUDIT_SID_UNSET;

Unnecessary else.

>  }
>  
>  extern void __audit_ipc_obj(struct kern_ipc_perm *ipcp);
> @@ -461,6 +473,8 @@ static inline void audit_fanotify(unsigned int response)
>  extern int audit_n_rules;
>  extern int audit_signals;
>  #else /* CONFIG_AUDITSYSCALL */
> +static inline void __init audit_task_init(void)
> +{ }
>  static inline int audit_alloc(struct task_struct *task)
>  {
>  	return 0;
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 87bf02d..e117272 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -30,7 +30,6 @@
>  #include <linux/rseq.h>
>  
>  /* task_struct member predeclarations (sorted alphabetically): */
> -struct audit_context;
>  struct backing_dev_info;
>  struct bio_list;
>  struct blk_plug;
> @@ -873,10 +872,8 @@ struct task_struct {
>  
>  	struct callback_head		*task_works;
>  
> -	struct audit_context		*audit_context;
>  #ifdef CONFIG_AUDITSYSCALL
> -	kuid_t				loginuid;
> -	unsigned int			sessionid;
> +	struct audit_task_info		*audit;
>  #endif
>  	struct seccomp			seccomp;
>  
> diff --git a/init/init_task.c b/init/init_task.c
> index 74f60ba..4058840 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -119,8 +119,7 @@ struct task_struct init_task
>  	.thread_group	= LIST_HEAD_INIT(init_task.thread_group),
>  	.thread_node	= LIST_HEAD_INIT(init_signals.thread_head),
>  #ifdef CONFIG_AUDITSYSCALL
> -	.loginuid	= INVALID_UID,
> -	.sessionid	= AUDIT_SID_UNSET,
> +	.audit		= &init_struct_audit,
>  #endif
>  #ifdef CONFIG_PERF_EVENTS
>  	.perf_event_mutex = __MUTEX_INITIALIZER(init_task.perf_event_mutex),
> diff --git a/init/main.c b/init/main.c
> index 3b4ada1..6aba171 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -92,6 +92,7 @@
>  #include <linux/rodata_test.h>
>  #include <linux/jump_label.h>
>  #include <linux/mem_encrypt.h>
> +#include <linux/audit.h>
>  
>  #include <asm/io.h>
>  #include <asm/bugs.h>
> @@ -721,6 +722,7 @@ asmlinkage __visible void __init start_kernel(void)
>  	nsfs_init();
>  	cpuset_init();
>  	cgroup_init();
> +	audit_task_init();
>  	taskstats_init_early();
>  	delayacct_init();
>  
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index fb20746..88779a7 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -841,7 +841,7 @@ static inline struct audit_context *audit_take_context(struct task_struct *tsk,
>  						      int return_valid,
>  						      long return_code)
>  {
> -	struct audit_context *context = tsk->audit_context;
> +	struct audit_context *context = tsk->audit->ctx;
>  
>  	if (!context)
>  		return NULL;
> @@ -926,6 +926,15 @@ static inline struct audit_context *audit_alloc_context(enum audit_state state)
>  	return context;
>  }
>  
> +static struct kmem_cache *audit_task_cache;
> +
> +void __init audit_task_init(void)
> +{
> +	audit_task_cache = kmem_cache_create("audit_task",
> +					     sizeof(struct audit_task_info),
> +					     0, SLAB_PANIC, NULL);
> +}
> +
>  /**
>   * audit_alloc - allocate an audit context block for a task
>   * @tsk: task
> @@ -940,17 +949,28 @@ int audit_alloc(struct task_struct *tsk)
>  	struct audit_context *context;
>  	enum audit_state     state;
>  	char *key = NULL;
> +	struct audit_task_info *info;
> +
> +	info = kmem_cache_zalloc(audit_task_cache, GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +	info->loginuid = audit_get_loginuid(current);
> +	info->sessionid = audit_get_sessionid(current);
> +	tsk->audit = info;
>  
>  	if (likely(!audit_ever_enabled))
>  		return 0; /* Return if not auditing. */
>  
>  	state = audit_filter_task(tsk, &key);
>  	if (state == AUDIT_DISABLED) {
> +		audit_set_context(tsk, NULL);
>  		clear_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
>  		return 0;
>  	}
>  
>  	if (!(context = audit_alloc_context(state))) {
> +		tsk->audit = NULL;
> +		kmem_cache_free(audit_task_cache, info);
>  		kfree(key);
>  		audit_log_lost("out of memory in audit_alloc");
>  		return -ENOMEM;
> @@ -962,6 +982,12 @@ int audit_alloc(struct task_struct *tsk)
>  	return 0;
>  }
>  
> +struct audit_task_info init_struct_audit = {
> +	.loginuid = INVALID_UID,
> +	.sessionid = AUDIT_SID_UNSET,
> +	.ctx = NULL,
> +};
> +
>  static inline void audit_free_context(struct audit_context *context)
>  {
>  	audit_free_names(context);
> @@ -1469,26 +1495,33 @@ static void audit_log_exit(struct audit_context *context, struct task_struct *ts
>  }
>  
>  /**
> - * __audit_free - free a per-task audit context
> + * audit_free - free a per-task audit context
>   * @tsk: task whose audit context block to free
>   *
>   * Called from copy_process and do_exit
>   */
> -void __audit_free(struct task_struct *tsk)
> +void audit_free(struct task_struct *tsk)
>  {
>  	struct audit_context *context;
> +	struct audit_task_info *info;
>  
>  	context = audit_take_context(tsk, 0, 0);
> -	if (!context)
> -		return;
> -
>  	/* Check for system calls that do not go through the exit
>  	 * function (e.g., exit_group), then free context block.
>  	 * We use GFP_ATOMIC here because we might be doing this
>  	 * in the context of the idle thread */
>  	/* that can happen only if we are called from do_exit() */
> -	if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT)
> +	if (context && context->in_syscall &&
> +	    context->current_state == AUDIT_RECORD_CONTEXT)
>  		audit_log_exit(context, tsk);
> +	/* Freeing the audit_task_info struct must be performed after
> +	 * audit_log_exit() due to need for loginuid and sessionid.
> +	 */
> +	info = tsk->audit;
> +	tsk->audit = NULL;
> +	kmem_cache_free(audit_task_cache, info);
> +	if (!context)
> +		return;
>  	if (!list_empty(&context->killed_trees))
>  		audit_kill_trees(&context->killed_trees);

Looks kind of terrible with the repeated check if context is NULL.
Maybe reorder ?

	context = audit_take_context(tsk, 0, 0);
	if (context) {
		/* do all the context work */
	}
	kmem_cache_free(audit_task_cache, tsk->audit);
	tsk->audit = NULL;	// is that even necessary ?

If "info" is really needed, ie if tsk (and tsk->audit) can be accessed
from another thread in parallel, I'd be a bit concerned about the lack
of sync() or similar after clearing tsk->audit.

Another option might have been to separate audit_free() into
audit_free_context() and audit_free_info().

>  
> @@ -2071,8 +2104,8 @@ int audit_set_loginuid(kuid_t loginuid)
>  			sessionid = (unsigned int)atomic_inc_return(&session_id);
>  	}
>  
> -	task->sessionid = sessionid;
> -	task->loginuid = loginuid;
> +	task->audit->sessionid = sessionid;
> +	task->audit->loginuid = loginuid;
>  out:
>  	audit_log_set_loginuid(oldloginuid, loginuid, oldsessionid, sessionid, rc);
>  	return rc;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9440d61..1bfb0ff 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1721,7 +1721,9 @@ static __latent_entropy struct task_struct *copy_process(
>  	p->start_time = ktime_get_ns();
>  	p->real_start_time = ktime_get_boot_ns();
>  	p->io_context = NULL;
> -	audit_set_context(p, NULL);
> +#ifdef CONFIG_AUDITSYSCALL
> +	p->audit = NULL;
> +#endif /* CONFIG_AUDITSYSCALL */

audit_alloc() is called a bit later and sets p->audit, so I don't think
this is really necessary.

>  	cgroup_fork(p);
>  #ifdef CONFIG_NUMA
>  	p->mempolicy = mpol_dup(p->mempolicy);
