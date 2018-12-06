Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF3EC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85380208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85380208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbeLFSOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:14:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbeLFSOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:14:21 -0500
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FCC020868;
        Thu,  6 Dec 2018 18:14:20 +0000 (UTC)
Date:   Thu, 6 Dec 2018 13:14:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     akpm@linux-foundation.org, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] kernel/kcov.c: mark func write_comp_data() as notrace
Message-ID: <20181206131417.5019b1e8@vmware.local.home>
In-Reply-To: <20181206143011.23719-1-anders.roxell@linaro.org>
References: <20181206143011.23719-1-anders.roxell@linaro.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Dec 2018 15:30:11 +0100
Anders Roxell <anders.roxell@linaro.org> wrote:

> Since __sanitizer_cov_trace_const_cmp4 is marked as notrace, the
> function called from __sanitizer_cov_trace_const_cmp4 shouldn't be
> traceable either.  ftrace_graph_caller() gets called every time func
> write_comp_data() gets called if it isn't marked 'notrace'. This is the
> backtrace from gdb:
> 
>  #0  ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:179
>  #1  0xffffff8010201920 in ftrace_caller () at ../arch/arm64/kernel/entry-ftrace.S:151
>  #2  0xffffff8010439714 in write_comp_data (type=5, arg1=0, arg2=0, ip=18446743524224276596) at ../kernel/kcov.c:116
>  #3  0xffffff8010439894 in __sanitizer_cov_trace_const_cmp4 (arg1=<optimized out>, arg2=<optimized out>) at ../kernel/kcov.c:188
>  #4  0xffffff8010201874 in prepare_ftrace_return (self_addr=18446743524226602768, parent=0xffffff801014b918, frame_pointer=18446743524223531344) at ./include/generated/atomic-instrumented.h:27
>  #5  0xffffff801020194c in ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:182
> 
> Rework so that write_comp_data() that are called from
> __sanitizer_cov_trace_*_cmp*() are marked as 'notrace'.
> 
> Commit 903e8ff86753 ("kernel/kcov.c: mark funcs in __sanitizer_cov_trace_pc() as notrace")
> missed to mark write_comp_data() as 'notrace'. When that patch was
> created gcc-7 was used. In lib/Kconfig.debug
> config KCOV_ENABLE_COMPARISONS
> 	depends on $(cc-option,-fsanitize-coverage=trace-cmp)
> 
> That code path isn't hit with gcc-7. However, it were that with gcc-8.
> 
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  kernel/kcov.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 97959d7b77e2..c2277dbdbfb1 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -112,7 +112,7 @@ void notrace __sanitizer_cov_trace_pc(void)
>  EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
>  
>  #ifdef CONFIG_KCOV_ENABLE_COMPARISONS
> -static void write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
> +static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
>  {
>  	struct task_struct *t;
>  	u64 *area;

