Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753688AbeD3RTW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 13:19:22 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:39792 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753441AbeD3RTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 13:19:21 -0400
X-Google-Smtp-Source: AB8JxZrtufVuhHjrF61wj0Mh4Jux4Q5SjfNwboaIvLNSA9UmmfOmtCSWHVzzCNJZojUhSb+ya23EUw==
Subject: Re: [PATCH v3] init: Fix false positives in W+X checking
To: Jeffrey Hugo <jhugo@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
        Jan Glauber <jan.glauber@caviumnetworks.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Timur Tabi <timur@codeaurora.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <1525103946-29526-1-git-send-email-jhugo@codeaurora.org>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <e87810b2-db26-ee13-731a-cde53185e977@redhat.com>
Date: Mon, 30 Apr 2018 10:19:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525103946-29526-1-git-send-email-jhugo@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/30/2018 08:59 AM, Jeffrey Hugo wrote:
> load_module() creates W+X mappings via __vmalloc_node_range() (from
> layout_and_allocate()->move_module()->module_alloc()) by using
> PAGE_KERNEL_EXEC.  These mappings are later cleaned up via
> "call_rcu_sched(&freeinit->rcu, do_free_init)" from do_init_module().
> 
> This is a problem because call_rcu_sched() queues work, which can be run
> after debug_checkwx() is run, resulting in a race condition.  If hit, the
> race results in a nasty splat about insecure W+X mappings, which results
> in a poor user experience as these are not the mappings that
> debug_checkwx() is intended to catch.
> 
> This issue is observed on multiple arm64 platforms, and has been
> artificially triggered on an x86 platform.
> 
> Address the race by flushing the queued work before running the
> arch-defined mark_rodata_ro() which then calls debug_checkwx().
> 
> Reported-by: Timur Tabi <timur@codeaurora.org>
> Reported-by: Jan Glauber <jan.glauber@caviumnetworks.com>
> Fixes: e1a58320a38d ("x86/mm: Warn on W^X mappings")
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> Acked-by: Kees Cook <keescook@chromium.org>
> Acked-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: Will Deacon <will.deacon@arm.com>
> ---
> 

Acked-by: Laura Abbott <labbott@redhat.com>

If you don't have a tree for this to go through, I might suggest having
Kees take it.

> v3:
> -added comment to module code to establish matching connection
> -added acks by Kees, Ingo, and Will
> 
> v2:
> -was "arm64: mm: Fix false positives in W+X checking" (see [1])
> -moved to common code based on review and confirmation of issue on x86
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/573776.html
> 
>   init/main.c     | 7 +++++++
>   kernel/module.c | 5 +++++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/init/main.c b/init/main.c
> index b795aa3..499d957 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1034,6 +1034,13 @@ static int __init set_debug_rodata(char *str)
>   static void mark_readonly(void)
>   {
>   	if (rodata_enabled) {
> +		/*
> +		 * load_module() results in W+X mappings, which are cleaned up
> +		 * with call_rcu_sched().  Let's make sure that queued work is
> +		 * flushed so that we don't hit false positives looking for
> +		 * insecure pages which are W+X.
> +		 */
> +		rcu_barrier_sched();
>   		mark_rodata_ro();
>   		rodata_test();
>   	} else
> diff --git a/kernel/module.c b/kernel/module.c
> index a6e43a5..7b71c3c 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3516,6 +3516,11 @@ static noinline int do_init_module(struct module *mod)
>   	 * walking this with preempt disabled.  In all the failure paths, we
>   	 * call synchronize_sched(), but we don't want to slow down the success
>   	 * path, so use actual RCU here.
> +	 * Note that module_alloc() on most architectures creates W+X page
> +	 * mappings which won't be cleaned up until do_free_init() runs.  Any
> +	 * code such as mark_rodata_ro() which depends on those mappings to
> +	 * be cleaned up needs to sync with the queued work - ie
> +	 * rcu_barrier_sched()
>   	 */
>   	call_rcu_sched(&freeinit->rcu, do_free_init);
>   	mutex_unlock(&module_mutex);
> 
