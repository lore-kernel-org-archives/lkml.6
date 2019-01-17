Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AA5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4D320855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547718444;
	bh=o28NqsGSY95ZLjTV2EWyCit9Vwdp0y6JgTbhsEgWIRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KJnj7NU74ApdBU8g5eMPQBb5GI7k+k/4IhUcBmr9MDkP914iCcWBGVIAJfwz2DfqH
	 dO3LZm9mPWzCrqfwJncmiAu3SoooRrl4CO1bhapdnMg3qSB9Xobg96hbIRK/bywtP/
	 +9cPVLZkSLIvIZ8o8NBMhMg8476k4wXCKxf5mI88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfAQJrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:47:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728872AbfAQJrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:47:21 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E13862054F;
        Thu, 17 Jan 2019 09:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547718439;
        bh=o28NqsGSY95ZLjTV2EWyCit9Vwdp0y6JgTbhsEgWIRg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SXNEQ/Cx5Y8V25Q3bReRh7v0QNXjcKQFQ40OoqyxoQxdMXZ6DyNnestPcYvUAsSvn
         IzBEmJQA5p0hRSsePGf2L/c65Lqrxwg8lDnrwGwn+WjFhP+AnqhNSlfh0XyDEI2Ins
         zbW0ssBWjYby9zJpmwk9Q/HnF1f3RP1EcxEsXbkU=
Date:   Thu, 17 Jan 2019 18:47:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andreas Ziegler <andreas.ziegler@fau.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: uprobes: bug in comm/string output?
Message-Id: <20190117184717.9bbd1218b9f4fe6a8070a0fe@kernel.org>
In-Reply-To: <17147ef5-4348-9a02-d781-0f089fe603f5@fau.de>
References: <bf358673-ceb2-65bf-80c9-4b1c09a8a264@fau.de>
        <8b67136d-28d7-a734-6366-9511e30d66a7@fau.de>
        <20190116190054.ac22c8495540578834446236@kernel.org>
        <62276858-9135-2393-8993-64e1088db7b9@fau.de>
        <20190117151309.711d41ebdd761b525a168837@kernel.org>
        <20190117170015.403157bf619907f8467189fe@kernel.org>
        <17147ef5-4348-9a02-d781-0f089fe603f5@fau.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 09:08:41 +0100
Andreas Ziegler <andreas.ziegler@fau.de> wrote:

> On 17.01.19 09:00, Masami Hiramatsu wrote:
> > On Thu, 17 Jan 2019 15:13:09 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> >> On Wed, 16 Jan 2019 11:16:07 +0100
> >> Andreas Ziegler <andreas.ziegler@fau.de> wrote:
> >>
> >>>
> >>> I went into this a bit deeper today, and right now it is simply failing 
> >>> to parse the code because there is no FETCH_OP_COMM case in 
> >>> process_fetch_insn() for uprobes so that will return -EILSEQ, leading to 
> >>> a make_data_loc(0, ...) in store_trace_args(). If we just add 
> >>> FETCH_OP_COMM and let val point to current->comm (that's what 
> >>> trace_kprobe.c does), we get an -EFAULT return value from 
> >>> fetch_store_string because strncpy_from_user() checks if the argument is 
> >>> in user space.
> >>
> >> Correct. I missed to add OP_COMM support. And uprobe's fetch_store_string
> >> is only for user space strings.
> >>
> >>> So I think we might need a special case for that, something like 
> >>> FETCH_OP_ST_COMM_STRING which is only used for FETCH_OP_COMM and copies 
> >>> current->comm over to the dynamic area. The implementation could be 
> >>> similar to the old fetch_comm_string implementation before your rewrite.
> >>
> >> Hmm, instead, I would like to add current->comm checker and only allows
> >> to copy that. That would be simpler and enough.
> >>
> >> Could you test below patch?
> >>
> >>
> >> tracing: uprobes: Re-enable $comm support for uprobe events
> >>
> >> From: Masami Hiramatsu <mhiramat@kernel.org>
> >>
> >> Since commit 533059281ee5 ("tracing: probeevent: Introduce new
> >> argument fetching code") dropped the $comm support from uprobe
> >> events, this re-enable it.
> 
> this should read 're-enables'.
> 
> >>
> >> For $comm support, use strncpy() instead of strncpy_from_user()
>                              ^
> we're using strlcpy(), not strncpy().
> 
> >> to copy current task's comm. Because it is in the kernel space,
> >> strncpy_from_user() always fails to copy the comm.
> >> This also use strlen() instead of strlen_user() to measure the
>                ^                        ^
> 'uses', and the function should be 'strnlen_user()'.
> 
> >> length of the comm.
> >>
> >> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> >> Reported-by: Andreas Ziegler <andreas.ziegler@fau.de>
> >> ---
> >>  kernel/trace/trace_uprobe.c |   13 +++++++++++--
> >>  1 file changed, 11 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> >> index e335576b9411..97d134e83e0f 100644
> >> --- a/kernel/trace/trace_uprobe.c
> >> +++ b/kernel/trace/trace_uprobe.c
> >> @@ -156,7 +156,10 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
> >>  	if (unlikely(!maxlen))
> >>  		return -ENOMEM;
> >>  
> >> -	ret = strncpy_from_user(dst, src, maxlen);
> >> +	if (addr == (unsigned long)current->comm)
> >> +		ret = strlcpy(dst, current->comm, maxlen);
> >> +	else
> >> +		ret = strncpy_from_user(dst, src, maxlen);
> >>  	if (ret >= 0) {
> >>  		if (ret == maxlen)
> >>  			dst[ret - 1] = '\0';
> >> @@ -173,7 +176,10 @@ fetch_store_strlen(unsigned long addr)
> >>  	int len;
> >>  	void __user *vaddr = (void __force __user *) addr;
> >>  
> >> -	len = strnlen_user(vaddr, MAX_STRING_SIZE);
> >> +	if (addr == (unsigned long)current->comm)
> >> +		len = strlen(current->comm);
> > 
> > To balance with the strnlen_user, we must increse the len in this block.
> > (strlen doesn't count the final '\0', but strnlen_user counts it)
> > 
> 
> yes, we need to add a '+ 1' here.
> 
> With the typos and this one fixed, this is
> 
> Acked-by: Andreas Ziegler <andreas.ziegler@fau.de>

Thank you for fixing typo and Ack :)

Thanks you,

> 
> > Thank you,
> > 
> >> +	else
> >> +		len = strnlen_user(vaddr, MAX_STRING_SIZE);
> >>  
> >>  	return (len > MAX_STRING_SIZE) ? 0 : len;
> >>  }
> >> @@ -213,6 +219,9 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
> >>  	case FETCH_OP_IMM:
> >>  		val = code->immediate;
> >>  		break;
> >> +	case FETCH_OP_COMM:
> >> +		val = (unsigned long)current->comm;
> >> +		break;
> >>  	case FETCH_OP_FOFFS:
> >>  		val = translate_user_vaddr(code->immediate);
> >>  		break;
> > 
> > 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
