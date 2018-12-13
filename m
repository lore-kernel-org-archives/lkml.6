Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7781C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B649D20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B649D20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbeLMRJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:09:40 -0500
Received: from foss.arm.com ([217.140.101.70]:38626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbeLMRJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 12:09:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6D4FA78;
        Thu, 13 Dec 2018 09:09:38 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FB1B3F614;
        Thu, 13 Dec 2018 09:09:37 -0800 (PST)
Subject: Re: [PATCH 6/6] arm64: Use ftrace_graph_get_ret_stack() instead of
 curr_ret_stack
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20181210193007.655970639@goodmis.org>
 <20181210193335.417173167@goodmis.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <f0613902-80ac-5865-26ee-f0aac4d3b906@arm.com>
Date:   Thu, 13 Dec 2018 17:09:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181210193335.417173167@goodmis.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On 10/12/2018 19:30, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> [
>   Folks, I'm working on rewriting the function graph tracer. In order to
>   do so, some changes need to be done that affect architecture specific
>   code. I'm only able to compile test these changes. I would like to
>   have folks check out my repo and give them a test.
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
>   ftrace/core
> 
>   Head SHA1: 51584396cff54aaf57ed0bd353767d71429f77b4
> ]
> 
> The structure of the ret_stack array on the task struct is going to
> change, and accessing it directly via the curr_ret_stack index will no
> longer give the ret_stack entry that holds the return address. To access
> that, architectures must now use ftrace_graph_get_ret_stack() to get the
> associated ret_stack that matches the saved return address.

I gave this branch a spin, but I hit the WARN_ON() fairly easily:

root@debian-guest:~# echo function_graph > /sys/kernel/debug/tracing/current_tracer
root@debian-guest:~# ps
[   27.744824] WARNING: CPU: 0 PID: 2457 at arch/arm64/kernel/stacktrace.c:70
unwind_frame+0x78/0x128
[   27.745174] Modules linked in:
[   27.745375] CPU: 0 PID: 2457 Comm: ps Not tainted
4.20.0-rc3-00038-g51584396cff5 #10814
[   27.745697] Hardware name: linux,dummy-virt (DT)
[   27.745918] pstate: 80400005 (Nzcv daif +PAN -UAO)
[   27.746151] pc : unwind_frame+0x78/0x128
[   27.746337] lr : unwind_frame+0x114/0x128
[   27.746511] sp : ffff00000c893a80
[   27.746685] x29: ffff00000c893a80 x28: 0000000000000000
[   27.746914] x27: ffffffffffffffff x26: 0000000000000001
[   27.747150] x25: 0000000000000049 x24: ffff000009662940
[   27.747375] x23: 0000000000000001 x22: ffff0000096496c8
[   27.747622] x21: ffff0000096496c8 x20: 000000000000000f
[   27.747851] x19: ffff00000c893ad0 x18: 0000000000000000
[   27.748078] x17: 0000000000000000 x16: 0000000000000000
[   27.748337] x15: 0000000000000000 x14: 0000000000000000
[   27.748563] x13: ffff80000a6b2500 x12: 0000000000300000
[   27.748790] x11: 0000000000281bad x10: 0000000000000528
[   27.749322] x9 : ffff80000c808400 x8 : 0000000000000030
[   27.749557] x7 : ffff80000a503520 x6 : 0000000000000528
[   27.749790] x5 : 0000000000019a3b x4 : ffff80000a6b2580
[   27.750010] x3 : ffff80000c1a0d80 x2 : 0000000000000001
[   27.750236] x1 : 000000000000000a x0 : 0000000000000000
[   27.750460] Call trace:
[   27.750587]  unwind_frame+0x78/0x128
[   27.750761]  get_wchan+0xa4/0x110
[   27.750926]  do_task_stat+0x8d4/0x9e8
[   27.751097]  proc_tgid_stat+0x40/0x50
[   27.751271]  proc_single_show+0x5c/0xb8
[   27.751448]  seq_read+0x138/0x450
[   27.751614]  __vfs_read+0x60/0x170
[   27.751782]  vfs_read+0x94/0x150
[   27.751948]  ksys_read+0x6c/0xd0
[   27.752129]  __arm64_sys_read+0x24/0x30
[   27.752309]  el0_svc_common+0x94/0xe8
[   27.752479]  el0_svc_handler+0x38/0x78
[   27.752642]  el0_svc+0x8/0xc
[   27.752804] ---[ end trace fdae6e80cafbfff9 ]---
  PID TTY          TIME CMD
 2401 hvc0     00:00:00 login
 2451 hvc0     00:00:00 bash
 2457 hvc0     00:00:00 ps

This is single cpu kvm guest, with arm64's defconfig and:
| CONFIG_GENERIC_TRACER=y
| CONFIG_FUNCTION_TRACER=y
| CONFIG_FUNCTION_GRAPH_TRACER=y

This doesn't happen with the same configuration on v4.20-rc4.


> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index 7723dadf25be..1a29f2695ff2 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -59,15 +59,17 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  	if (tsk->ret_stack &&
>  			(frame->pc == (unsigned long)return_to_handler)) {
> -		if (WARN_ON_ONCE(frame->graph == -1))
> -			return -EINVAL;
> +		struct ftrace_ret_stack *ret_stack;
>  		/*
>  		 * This is a case where function graph tracer has
>  		 * modified a return address (LR) in a stack frame
>  		 * to hook a function return.
>  		 * So replace it to an original value.
>  		 */
> -		frame->pc = tsk->ret_stack[frame->graph--].ret;
> +		ret_stack = ftrace_graph_get_ret_stack(tsk, frame->graph++);
> +		if (WARN_ON_ONCE(!ret_stack))
> +			return -EINVAL;
> +		frame->pc = ret_stack->ret;
>  	}
>  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */


Thanks,

James
