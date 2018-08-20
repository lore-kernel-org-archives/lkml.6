Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B52C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB6720C03
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB6720C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeHTLnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 07:43:05 -0400
Received: from foss.arm.com ([217.140.101.70]:33978 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbeHTLnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 07:43:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84D5180D;
        Mon, 20 Aug 2018 01:28:24 -0700 (PDT)
Received: from [10.4.13.92] (e112298-lin.emea.arm.com [10.4.13.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E50B3F2EA;
        Mon, 20 Aug 2018 01:28:22 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] arm64: reliable stacktraces
To:     Torsten Duwe <duwe@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
References: <20180817102544.C628D68EF4@newverein.lst.de>
 <20180817102733.B777568EF6@newverein.lst.de>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <b9985f25-1c85-cac1-8cd2-66f71cb0b40b@arm.com>
Date:   Mon, 20 Aug 2018 09:28:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180817102733.B777568EF6@newverein.lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Torsten,

On 17/08/18 11:27, Torsten Duwe wrote:
> This is more an RFC in the original sense: is this basically
> the correct approach? (as I had to tweak the save_stack API a bit).
> 
> In particular the code does not detect interrupts and exception
> frames, and does not yet check whether the code address is valid.
> The latter check would also have to be omitted for the latest frame
> on other tasks' stacks. This would require some more tweaking.
> 
> unwind_frame() now reports whether we had to stop normally or due to
> an error condition; walk_stackframe() will pass that info.
> __save_stack_trace() is used for a start to check the validity of a
> frame; maybe save_stack_trace_tsk_reliable() will need its own callback.
> 
> The question is whether this change, once complete, is sufficient
> (as on powerpc) or whether a port of objtool is needed, like x86.
> 

I'm not sure I understand the involvement of objtool in this.
IIUC objtool just provides a way to check that the code manages stack 
frames consistently. It gives you more confidence in how the code 
manages the frame.

If the semantics of HAVE_RELIABLE_STACKTRACE is "are you able to tell 
whether that stacktrace is good or corrupted?", the code looks mostly 
fine to me.

> I can dig into this myself and draw conclusions, but I'd prefer
> to have some input from ARM people here...
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> 
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -127,8 +127,9 @@ config ARM64
>   	select HAVE_PERF_EVENTS
>   	select HAVE_PERF_REGS
>   	select HAVE_PERF_USER_STACK_DUMP
> -	select HAVE_REGS_AND_STACK_ACCESS_API
>   	select HAVE_RCU_TABLE_FREE
> +	select HAVE_REGS_AND_STACK_ACCESS_API
> +	select HAVE_RELIABLE_STACKTRACE
>   	select HAVE_STACKPROTECTOR
>   	select HAVE_SYSCALL_TRACEPOINTS
>   	select HAVE_KPROBES
> --- a/arch/arm64/include/asm/stacktrace.h
> +++ b/arch/arm64/include/asm/stacktrace.h
> @@ -33,7 +33,7 @@ struct stackframe {
>   };
>   
>   extern int unwind_frame(struct task_struct *tsk, struct stackframe *frame);
> -extern void walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
> +extern int walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
>   			    int (*fn)(struct stackframe *, void *), void *data);
>   extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk);
>   
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index d5718a060672..fe0dd4745ff3 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -81,23 +81,27 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
>   	 * both are NULL.
>   	 */
>   	if (!frame->fp && !frame->pc)
> -		return -EINVAL;
> +		return 1;

unwind_frame is not static so we should take care of other callers.

I can see one in arch/arm64/kernel/time.c, profile_pc which checks 
"unwind_frame(...) < 0" to exit a loop, but now you have made 1 a valid 
stop condition.

I think the other callers are just checking "unwind_frame(...) != 0" as 
stop condition so those should be fine.

Perhaps adding a little comment on unwind_frame "0 -> Stack trace goes 
on, 1 -> reached end of stack trace, 2 -> stack trace looks" would be nice.

>   
>   	return 0;
>   }
>   
> -void notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
> +int notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
>   		     int (*fn)(struct stackframe *, void *), void *data)
>   {
>   	while (1) {
>   		int ret;
>   
> -		if (fn(frame, data))
> -			break;
> +		ret = fn(frame, data);
> +		if (ret)
> +			return ret;
>   		ret = unwind_frame(tsk, frame);
>   		if (ret < 0)
> +			return ret;
> +		if (ret > 0)
>   			break;
>   	}
> +	return 0;
>   }
>   
>   #ifdef CONFIG_STACKTRACE
> @@ -145,14 +149,15 @@ void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
>   		trace->entries[trace->nr_entries++] = ULONG_MAX;
>   }
>   
> -static noinline void __save_stack_trace(struct task_struct *tsk,
> +static noinline int __save_stack_trace(struct task_struct *tsk,
>   	struct stack_trace *trace, unsigned int nosched)
>   {
>   	struct stack_trace_data data;
>   	struct stackframe frame;
> +	int ret;
>   
>   	if (!try_get_task_stack(tsk))
> -		return;
> +		return -EBUSY;
>   
>   	data.trace = trace;
>   	data.skip = trace->skip;
> @@ -171,11 +176,12 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
>   	frame.graph = tsk->curr_ret_stack;
>   #endif
>   
> -	walk_stackframe(tsk, &frame, save_trace, &data);
> +	ret = walk_stackframe(tsk, &frame, save_trace, &data);
>   	if (trace->nr_entries < trace->max_entries)
>   		trace->entries[trace->nr_entries++] = ULONG_MAX;
>   
>   	put_task_stack(tsk);
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
>   
> @@ -190,4 +196,12 @@ void save_stack_trace(struct stack_trace *trace)
>   }
>   
>   EXPORT_SYMBOL_GPL(save_stack_trace);
> +
> +int save_stack_trace_tsk_reliable(struct task_struct *tsk,
> +				  struct stack_trace *trace)
> +{
> +	return __save_stack_trace(tsk, trace, 1);
> +}
> +EXPORT_SYMBOL_GPL(save_stack_trace_tsk_reliable);
> +
>   #endif
> 

-- 
Julien Thierry
