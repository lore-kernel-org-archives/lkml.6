Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A11C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098AF2063F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfANMMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:12:01 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60556 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfANMMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:12:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 261B680D;
        Mon, 14 Jan 2019 04:12:00 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2FBA3F5BD;
        Mon, 14 Jan 2019 04:11:58 -0800 (PST)
Date:   Mon, 14 Jan 2019 12:11:56 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     rostedt@goodmis.org, linux@armlinux.org.uk, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] fgraph: record function return value
Message-ID: <20190114121151.GC10258@lakrids.cambridge.arm.com>
References: <20190112065701.30841-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190112065701.30841-1-changbin.du@gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 02:57:01PM +0800, Changbin Du wrote:
> This patch adds a new trace option 'funcgraph-retval' and is disabled by
> default. When this option is enabled, fgraph tracer will show the return
> value of each function. This is useful to find/analyze a original error
> source in a call graph.
> 
> One limitation is that kernel doesn't know the prototype of functions. So
> fgraph assumes all functions have a retvalue of type int. You must ignore
> the value of *void* function. And if the retvalue looks like an error code
> then both hexadecimal and decimal number are displayed.

This sounds more confusing than helpful, and it sounds like this has
overlap with FTRACE_WITH_REGS functionality.

> diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
> index 81b8eb5c4633..223f4ad269d4 100644
> --- a/arch/arm64/kernel/entry-ftrace.S
> +++ b/arch/arm64/kernel/entry-ftrace.S
> @@ -202,6 +202,7 @@ ENTRY(return_to_handler)
>  	stp x4, x5, [sp, #32]
>  	stp x6, x7, [sp, #48]
>  
> +	mov	x1, x0			// return value
>  	mov	x0, x29			//     parent's fp
>  	bl	ftrace_return_to_handler// addr = ftrace_return_to_hander(fp);
>  	mov	x30, x0			// restore the original return address

What about indirect return values? Those go via x8.

Additionally, in some cases (e.g. static functions with cross-function
optimization), the compiler might not follow the usual PCS, so the
return value might not be in x0 regardless. Maybe such functions aren't
hooked by ftrace today?

Generally, I don't think that this is going to be reliable.

> +config HAVE_FTRACE_RETVAL
> +	bool
> +
>  config HAVE_DYNAMIC_FTRACE
>  	bool
>  	help
> @@ -160,6 +163,7 @@ config FUNCTION_GRAPH_TRACER
>  	depends on HAVE_FUNCTION_GRAPH_TRACER
>  	depends on FUNCTION_TRACER
>  	depends on !X86_32 || !CC_OPTIMIZE_FOR_SIZE
> +	select HAVE_FTRACE_RETVAL if (X86 || ARM)

... but not arm64?

Thanks,
Mark.
