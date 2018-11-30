Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C12EC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F064D2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F064D2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbeLACde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:33:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726624AbeLACde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:33:34 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E997320868;
        Fri, 30 Nov 2018 15:23:52 +0000 (UTC)
Date:   Fri, 30 Nov 2018 10:23:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     mingo@redhat.com, catalin.marinas@arm.com, will.deacon@arm.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] arm64: ftrace: add cond_resched() to func
 ftrace_make_(call|nop)
Message-ID: <20181130102351.61045b21@gandalf.local.home>
In-Reply-To: <20181130150956.27620-1-anders.roxell@linaro.org>
References: <20181130150956.27620-1-anders.roxell@linaro.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 16:09:56 +0100
Anders Roxell <anders.roxell@linaro.org> wrote:

> Both of those functions end up calling ftrace_modify_code(), which is
> expensive because it changes the page tables and flush caches.
> Microseconds add up because this is called in a loop for each dyn_ftrace
> record, and this triggers the softlockup watchdog unless we let it sleep
> occasionally.
> Rework so that we call cond_resched() before going into the
> ftrace_modify_code() function.
> 
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I'm fine with this patch, but I'm not placing an ack on this patch
just because I don't know the repercussions of such a change. I'll let
you folks take full responsibility ;-)

-- Steve
 

> ---
>  arch/arm64/kernel/ftrace.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index de1a397d2d3f..9da38da58df7 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -130,6 +130,11 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>  	old = aarch64_insn_gen_nop();
>  	new = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
>  
> +	/* This function can take a long time when sanitizers are enabled, so
> +	 * lets make sure we allow RCU processing.
> +	 */
> +	cond_resched();
> +
>  	return ftrace_modify_code(pc, old, new, true);
>  }
>  
> @@ -188,6 +193,11 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>  
>  	new = aarch64_insn_gen_nop();
>  
> +	/* This function can take a long time when sanitizers are enabled, so
> +	 * lets make sure we allow RCU processing.
> +	 */
> +	cond_resched();
> +
>  	return ftrace_modify_code(pc, old, new, validate);
>  }
>  

