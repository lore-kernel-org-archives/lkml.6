Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A80C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FDC217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfAWIkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:40:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:48306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbfAWIkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:40:16 -0500
Received: from vmware.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4C2B20870;
        Wed, 23 Jan 2019 08:40:14 +0000 (UTC)
Date:   Wed, 23 Jan 2019 03:40:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tracing: uprobes: Re-enable $comm support for
 uprobe events
Message-ID: <20190123034005.2b49e4fe@vmware.local.home>
In-Reply-To: <154778666570.19927.5960654930869453736.stgit@devbox>
References: <154778663676.19927.12774448308165809570.stgit@devbox>
        <154778666570.19927.5960654930869453736.stgit@devbox>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 13:44:25 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since commit 533059281ee5 ("tracing: probeevent: Introduce new
> argument fetching code") dropped the $comm support from uprobe
> events, this re-enables it.
> 
> For $comm support, uses strlcpy() instead of strncpy_from_user()
> to copy current task's comm. Because it is in the kernel space,
> strncpy_from_user() always fails to copy the comm.
> This also uses strlen() instead of strnlen_user() to measure the
> length of the comm.
> 
> Fixes: 533059281ee5 ("tracing: probeevent: Introduce new argument fetching code")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reported-by: Andreas Ziegler <andreas.ziegler@fau.de>
> Acked-by: Andreas Ziegler <andreas.ziegler@fau.de>
> ---
>  kernel/trace/trace_uprobe.c |   15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 3a1d5ab6b4ba..b07e498ccbc6 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -156,7 +156,10 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
>  	if (unlikely(!maxlen))
>  		return -ENOMEM;
>  
> -	ret = strncpy_from_user(dst, src, maxlen);
> +	if (addr == (unsigned long)current->comm)
> +		ret = strlcpy(dst, current->comm, maxlen);

As user space (although only root) defines the size of the event being
stored, and we could trick addr to be current->comm (although
difficult), we could possibly leak data if maxlen is > TASK_COMM_LEN. I
would feel better if we tested maxlen against TASK_COMM_LEN in this
case.

	if (maxlen > TASK_COMM_LEN)
		maxlen = TASK_COMM_LEN;

Or if we don't think it can happen, add a WARN_ON(maxlen >
TASK_COMM_LEN).

-- Steve


> +	else
> +		ret = strncpy_from_user(dst, src, maxlen);
>  	if (ret >= 0) {
>  		if (ret == maxlen)
>  			dst[ret - 1] = '\0';
> @@ -180,7 +183,12 @@ fetch_store_strlen(unsigned long addr)
>  	int len;
>  	void __user *vaddr = (void __force __user *) addr;
>  
> -	len = strnlen_user(vaddr, MAX_STRING_SIZE);
> +	if (addr == (unsigned long)current->comm) {
> +		len = strlen(current->comm);
> +		if (len)
> +			len++;
> +	} else
> +		len = strnlen_user(vaddr, MAX_STRING_SIZE);
>  
>  	return (len > MAX_STRING_SIZE) ? 0 : len;
>  }
> @@ -220,6 +228,9 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
>  	case FETCH_OP_IMM:
>  		val = code->immediate;
>  		break;
> +	case FETCH_OP_COMM:
> +		val = (unsigned long)current->comm;
> +		break;
>  	case FETCH_OP_FOFFS:
>  		val = translate_user_vaddr(code->immediate);
>  		break;

