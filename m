Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F41C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312E42133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312E42133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbeK1DbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:31:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:53504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731035AbeK1DbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:31:03 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB1822086B;
        Tue, 27 Nov 2018 16:32:34 +0000 (UTC)
Date:   Tue, 27 Nov 2018 11:32:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: ftrace: Fix to enable syscall events on arm64
Message-ID: <20181127113233.2996bd87@gandalf.local.home>
In-Reply-To: <154333618522.27355.8094935453351562295.stgit@devbox>
References: <CAA93ih1-xpm1P0suT6SNCc_ARvAfyBEwb0-uKFikM5k4CvG8jg@mail.gmail.com>
        <154333618522.27355.8094935453351562295.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 01:29:45 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since commit 4378a7d4be30 ("arm64: implement syscall wrappers")
> introduced "__arm64_" prefix to all syscall wrapper symbols in
> sys_call_table, syscall tracer can not find corresponding
> metadata from syscall name. In the result, we have no syscall
> ftrace events on arm64 kernel, and some bpf testcases are failed
> on arm64.
> 
> To fix this issue, this introduces custom
> arch_syscall_match_sym_name() which skips first 8 bytes when
> comparing the syscall and symbol names.
> 

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> Fixes: 4378a7d4be30 ("arm64: implement syscall wrappers")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/include/asm/ftrace.h |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index caa955f10e19..a710f79db442 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -56,6 +56,15 @@ static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
>  {
>  	return is_compat_task();
>  }
> +
> +#define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
> +
> +static inline bool arch_syscall_match_sym_name(const char *sym,
> +					       const char *name)
> +{
> +	/* Since all syscall functions have __arm64_ prefix, we must skip it */
> +	return !strcmp(sym + 8, name);
> +}
>  #endif /* ifndef __ASSEMBLY__ */
>  
>  #endif /* __ASM_FTRACE_H */

