Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E05C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C7620874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732965AbeLQNbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:31:01 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56098 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbeLQNbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:31:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7E10A78;
        Mon, 17 Dec 2018 05:31:00 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B8083F5C0;
        Mon, 17 Dec 2018 05:30:59 -0800 (PST)
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
 <f0613902-80ac-5865-26ee-f0aac4d3b906@arm.com>
 <20181214220054.101f9e4c@vmware.local.home>
From:   James Morse <james.morse@arm.com>
Message-ID: <1fd00f16-24bf-11f1-a27a-4a7c8f23c11a@arm.com>
Date:   Mon, 17 Dec 2018 13:30:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181214220054.101f9e4c@vmware.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 15/12/2018 03:00, Steven Rostedt wrote:
> On Thu, 13 Dec 2018 17:09:35 +0000
> James Morse <james.morse@arm.com> wrote:
>> I gave this branch a spin, but I hit the WARN_ON() fairly easily:
> 
> Thanks for testing!
> 
> Can you see if this patch fixes it for you?

> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index d4f04f0ca646..8dfd5021b933 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -246,10 +246,10 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
>  struct ftrace_ret_stack *
>  ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
>  {
> -	idx = current->curr_ret_stack - idx;
> +	idx = task->curr_ret_stack - idx;
>  
>  	if (idx >= 0 && idx <= task->curr_ret_stack)
> -		return &current->ret_stack[idx];
> +		return &task->ret_stack[idx];
>  
>  	return NULL;
>  }
> 

Heh, yes that fixes it:

Tested-by: James Morse <james.morse@arm.com>


Thanks,

James
