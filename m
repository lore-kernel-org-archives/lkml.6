Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0477C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F8122419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F8122419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732332AbeKNTYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:24:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:34206 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727558AbeKNTYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:24:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7DFE7ADEF;
        Wed, 14 Nov 2018 09:22:06 +0000 (UTC)
Date:   Wed, 14 Nov 2018 10:22:04 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     riel@redhat.com, linux@rasmusvillemoes.dk, keescook@chromium.org,
        viro@ZenIV.linux.org.uk, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, rostedt@goodmis.org, tglx@linutronix.de,
        mingo@kernel.org, rppt@linux.vnet.ibm.com,
        linux@dominikbrodowski.net, pasha.tatashin@oracle.com,
        ard.biesheuvel@linaro.org, luto@amacapital.net, wad@chromium.org,
        riel@surriel.com, ebiederm@xmission.com,
        kirill.shutemov@linux.intel.com, guro@fb.com,
        marcos.souza.org@gmail.com, zhong.weidong@zte.com.cn
Subject: Re: [PATCH v2] fork: Fix some -Wmissing-prototypes warnings
Message-ID: <20181114092204.GH23419@dhcp22.suse.cz>
References: <1542170087-23645-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1542170087-23645-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-11-18 12:34:47, Yi Wang wrote:
> We get a warning when building kernel with W=1:
> kernel/fork.c:167:13: warning: no previous prototype for ‘arch_release_thread_stack’ [-Wmissing-prototypes]
> kernel/fork.c:779:13: warning: no previous prototype for ‘fork_init’ [-Wmissing-prototypes]
> 
> Add the missing declaration in head file to fix this.
> 
> Also, remove arch_release_thread_stack() completely because no
> arch seems to implement it since bb9d81264 (arch: remove tile port).
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>

Looks good to me.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> v2: remove arch_release_thread_stack(). Thanks to Rasmus.
> ---
>  include/linux/sched/task.h | 2 ++
>  init/main.c                | 1 -
>  kernel/fork.c              | 5 -----
>  3 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 108ede9..44c6f15 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -39,6 +39,8 @@
>  
>  extern void proc_caches_init(void);
>  
> +extern void fork_init(void);
> +
>  extern void release_task(struct task_struct * p);
>  
>  #ifdef CONFIG_HAVE_COPY_THREAD_TLS
> diff --git a/init/main.c b/init/main.c
> index ee14710..8feda42 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -105,7 +105,6 @@
>  static int kernel_init(void *);
>  
>  extern void init_IRQ(void);
> -extern void fork_init(void);
>  extern void radix_tree_init(void);
>  
>  /*
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 07cddff..c6d02be 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -164,10 +164,6 @@ static inline void free_task_struct(struct task_struct *tsk)
>  }
>  #endif
>  
> -void __weak arch_release_thread_stack(unsigned long *stack)
> -{
> -}
> -
>  #ifndef CONFIG_ARCH_THREAD_STACK_ALLOCATOR
>  
>  /*
> @@ -417,7 +413,6 @@ static void release_task_stack(struct task_struct *tsk)
>  		return;  /* Better to leak the stack than to free prematurely */
>  
>  	account_kernel_stack(tsk, -1);
> -	arch_release_thread_stack(tsk->stack);
>  	free_thread_stack(tsk);
>  	tsk->stack = NULL;
>  #ifdef CONFIG_VMAP_STACK
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
