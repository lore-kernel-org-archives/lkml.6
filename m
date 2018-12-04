Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A74C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B13B20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B13B20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbeLDTTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:19:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbeLDTTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:19:11 -0500
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D04C72082B;
        Tue,  4 Dec 2018 19:19:10 +0000 (UTC)
Date:   Tue, 4 Dec 2018 14:19:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     mingo@redhat.com, catalin.marinas@arm.com, will.deacon@arm.com,
        keescook@chromium.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tracing: add cond_resched to ftrace_replace_code()
Message-ID: <20181204141908.76e7afa5@vmware.local.home>
In-Reply-To: <20181204191229.6851-1-anders.roxell@linaro.org>
References: <20181204191229.6851-1-anders.roxell@linaro.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  4 Dec 2018 20:12:28 +0100
Anders Roxell <anders.roxell@linaro.org> wrote:

> When running in qemu on an kernel built with allmodconfig and debug
> options (in particular kcov and ubsan) enabled, ftrace_replace_code
> function call take minutes. The ftrace selftest calls
> ftrace_replace_code to look >40000 through
> ftrace_make_call/ftrace_make_nop, and these end up calling
> __aarch64_insn_write/aarch64_insn_patch_text_nosync.
> 
> Microseconds add up because this is called in a loop for each dyn_ftrace
> record, and this triggers the softlockup watchdog unless we let it sleep
> occasionally.
> 
> Rework so that we call cond_resched() if !irqs_disabled() && !preempt_count().
> 
> Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  kernel/trace/ftrace.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index c375e33239f7..582e3441e318 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2419,11 +2419,14 @@ void __weak ftrace_replace_code(int enable)
>  {
>  	struct dyn_ftrace *rec;
>  	struct ftrace_page *pg;
> +	bool schedulable;
>  	int failed;
>  
>  	if (unlikely(ftrace_disabled))
>  		return;
>  
> +	schedulable = !irqs_disabled() && !preempt_count();
> +
>  	do_for_each_ftrace_rec(pg, rec) {
>  
>  		if (rec->flags & FTRACE_FL_DISABLED)
> @@ -2435,6 +2438,13 @@ void __weak ftrace_replace_code(int enable)
>  			/* Stop processing */
>  			return;
>  		}
> +		/*
> +		 * Some archs calls this function with interrupts or preemption
> +		 * disabled. Howeve, other archs don't and this can cause a
> +		 * tremendous unneeded latency.
> +		 */

Actually, could you move the comment up where schedulable gets set?

Thanks!

-- Steve

> +		if (schedulable)
> +			cond_resched();
>  	} while_for_each_ftrace_rec();
>  }
>  

