Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E13DC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E203920989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E203920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbeLEJyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:54:35 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50250 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730127AbeLEJy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:54:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 276EC80D;
        Wed,  5 Dec 2018 01:54:26 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EB5443F575;
        Wed,  5 Dec 2018 01:54:25 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 974C51AE0BA8; Wed,  5 Dec 2018 09:54:46 +0000 (GMT)
Date:   Wed, 5 Dec 2018 09:54:46 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
        keescook@chromium.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] tracing: add cond_resched to ftrace_replace_code()
Message-ID: <20181205095445.GA14317@arm.com>
References: <20181204192903.8193-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204192903.8193-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anders, Steve,

On Tue, Dec 04, 2018 at 08:29:03PM +0100, Anders Roxell wrote:
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
> index c375e33239f7..7080eb464983 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2419,11 +2419,19 @@ void __weak ftrace_replace_code(int enable)
>  {
>  	struct dyn_ftrace *rec;
>  	struct ftrace_page *pg;
> +	bool schedulable;
>  	int failed;
>  
>  	if (unlikely(ftrace_disabled))
>  		return;
>  
> +	/*
> +	 * Some archs calls this function with interrupts or preemption
> +	 * disabled. However, for other archs that can preempt, this can cause
> +	 * an tremendous unneeded latency.
> +	 */
> +	schedulable = !irqs_disabled() && !preempt_count();

Is there a reason not to use preemptible() here?

Will
