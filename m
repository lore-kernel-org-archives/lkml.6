Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C92DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1142086D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547769017;
	bh=7XpQ1lYb+oSgboJPsTTY47/KAEi8rB2zD+3xaGwVh00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=BePyybwod4mEkhma9zrSUkL5n7lSMv3OJAuO9qCXdTd5TUa/V/b73g8eyAjO9fV60
	 +Io0LaNhK8M6MARbNi7EGIx7CQb+HERf9mmSgJliiKqyKS1svxwrftOjYgnY/FA8Dl
	 xu0t/SC6Hrs2dqTAia4+/MdLlhTOX7xMenLyMG5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfAQXuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:50:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfAQXuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:50:15 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDDF320859;
        Thu, 17 Jan 2019 23:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547769013;
        bh=7XpQ1lYb+oSgboJPsTTY47/KAEi8rB2zD+3xaGwVh00=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c7KsUkz+ii4MM3zQAw4UGTzLStS99vh7pB81NBg3O8heShNn0FzRBoZboIrJrszQ1
         vBNzU418iOn+JU0+BFQg3jrHzdWiXhwO6TSPCTA9VqAhP3+LQ1kS54JP3SHpTpvTaZ
         uSCcAv2NImQWMCOC7J+yeEwyp7+0wSDL3IZAJ/zs=
Date:   Fri, 18 Jan 2019 08:50:11 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andreas Ziegler <andreas.ziegler@fau.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: uprobes: bug in comm/string output?
Message-Id: <20190118085011.511954a760961e4eb6b8e423@kernel.org>
In-Reply-To: <15ce335e-d40e-f9ef-e85a-507e153c55cb@fau.de>
References: <bf358673-ceb2-65bf-80c9-4b1c09a8a264@fau.de>
        <8b67136d-28d7-a734-6366-9511e30d66a7@fau.de>
        <20190116190054.ac22c8495540578834446236@kernel.org>
        <62276858-9135-2393-8993-64e1088db7b9@fau.de>
        <20190117151309.711d41ebdd761b525a168837@kernel.org>
        <20190117170015.403157bf619907f8467189fe@kernel.org>
        <17147ef5-4348-9a02-d781-0f089fe603f5@fau.de>
        <20190117184717.9bbd1218b9f4fe6a8070a0fe@kernel.org>
        <15ce335e-d40e-f9ef-e85a-507e153c55cb@fau.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 14:44:41 +0100
Andreas Ziegler <andreas.ziegler@fau.de> wrote:

> Hi,
> 
> On 1/17/19 10:47 AM, Masami Hiramatsu wrote:
> > On Thu, 17 Jan 2019 09:08:41 +0100
> > Andreas Ziegler <andreas.ziegler@fau.de> wrote:
> > 
> >> On 17.01.19 09:00, Masami Hiramatsu wrote:
> >>> On Thu, 17 Jan 2019 15:13:09 +0900
> >>> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >>>
> >>>> On Wed, 16 Jan 2019 11:16:07 +0100
> >>>> Andreas Ziegler <andreas.ziegler@fau.de> wrote:
> >>>>
> >>>>>
> >>>>> I went into this a bit deeper today, and right now it is simply failing
> >>>>> to parse the code because there is no FETCH_OP_COMM case in
> >>>>> process_fetch_insn() for uprobes so that will return -EILSEQ, leading to
> >>>>> a make_data_loc(0, ...) in store_trace_args(). If we just add
> >>>>> FETCH_OP_COMM and let val point to current->comm (that's what
> >>>>> trace_kprobe.c does), we get an -EFAULT return value from
> >>>>> fetch_store_string because strncpy_from_user() checks if the argument is
> >>>>> in user space.
> >>>>
> >>>> Correct. I missed to add OP_COMM support. And uprobe's fetch_store_string
> >>>> is only for user space strings.
> >>>>
> >>>>> So I think we might need a special case for that, something like
> >>>>> FETCH_OP_ST_COMM_STRING which is only used for FETCH_OP_COMM and copies
> >>>>> current->comm over to the dynamic area. The implementation could be
> >>>>> similar to the old fetch_comm_string implementation before your rewrite.
> >>>>
> >>>> Hmm, instead, I would like to add current->comm checker and only allows
> >>>> to copy that. That would be simpler and enough.
> >>>>
> >>>> Could you test below patch?
> >>>>
> >>>>
> >>>> tracing: uprobes: Re-enable $comm support for uprobe events
> >>>>
> >>>> From: Masami Hiramatsu <mhiramat@kernel.org>
> >>>>
> >>>> Since commit 533059281ee5 ("tracing: probeevent: Introduce new
> >>>> argument fetching code") dropped the $comm support from uprobe
> >>>> events, this re-enable it.
> >>
> >> this should read 're-enables'.
> >>
> >>>>
> >>>> For $comm support, use strncpy() instead of strncpy_from_user()
> >>                               ^
> >> we're using strlcpy(), not strncpy().
> >>
> >>>> to copy current task's comm. Because it is in the kernel space,
> >>>> strncpy_from_user() always fails to copy the comm.
> >>>> This also use strlen() instead of strlen_user() to measure the
> >>                 ^                        ^
> >> 'uses', and the function should be 'strnlen_user()'.
> >>
> >>>> length of the comm.
> >>>>
> >>>> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> >>>> Reported-by: Andreas Ziegler <andreas.ziegler@fau.de>
> >>>> ---
> >>>>   kernel/trace/trace_uprobe.c |   13 +++++++++++--
> >>>>   1 file changed, 11 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> >>>> index e335576b9411..97d134e83e0f 100644
> >>>> --- a/kernel/trace/trace_uprobe.c
> >>>> +++ b/kernel/trace/trace_uprobe.c
> >>>> @@ -156,7 +156,10 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
> >>>>   	if (unlikely(!maxlen))
> >>>>   		return -ENOMEM;
> >>>>   
> >>>> -	ret = strncpy_from_user(dst, src, maxlen);
> >>>> +	if (addr == (unsigned long)current->comm)
> >>>> +		ret = strlcpy(dst, current->comm, maxlen);
> >>>> +	else
> >>>> +		ret = strncpy_from_user(dst, src, maxlen);
> >>>>   	if (ret >= 0) {
> >>>>   		if (ret == maxlen)
> >>>>   			dst[ret - 1] = '\0';
> >>>> @@ -173,7 +176,10 @@ fetch_store_strlen(unsigned long addr)
> >>>>   	int len;
> >>>>   	void __user *vaddr = (void __force __user *) addr;
> >>>>   
> >>>> -	len = strnlen_user(vaddr, MAX_STRING_SIZE);
> >>>> +	if (addr == (unsigned long)current->comm)
> >>>> +		len = strlen(current->comm);
> >>>
> >>> To balance with the strnlen_user, we must increse the len in this block.
> >>> (strlen doesn't count the final '\0', but strnlen_user counts it)
> >>>
> >>
> >> yes, we need to add a '+ 1' here.
> >>
> >> With the typos and this one fixed, this is
> >>
> >> Acked-by: Andreas Ziegler <andreas.ziegler@fau.de>
> > 
> > Thank you for fixing typo and Ack :)
> > 
> > Thanks you,
>  >
> >>
> >>> Thank you,
> >>>
> >>>> +	else
> >>>> +		len = strnlen_user(vaddr, MAX_STRING_SIZE);
> >>>>   
> >>>>   	return (len > MAX_STRING_SIZE) ? 0 : len;
> >>>>   }
> >>>> @@ -213,6 +219,9 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
> >>>>   	case FETCH_OP_IMM:
> >>>>   		val = code->immediate;
> >>>>   		break;
> >>>> +	case FETCH_OP_COMM:
> >>>> +		val = (unsigned long)current->comm;
> >>>> +		break;
> >>>>   	case FETCH_OP_FOFFS:
> >>>>   		val = translate_user_vaddr(code->immediate);
> >>>>   		break;
> >>>
> >>>
> >>
> > 
> > 
> as the original commit breaking $comm support was merged for v4.20 
> (which is a stable kernel) and the wrong behaviour with multiple strings 
> exists in all longterm/stable releases (tested back to v4.4), do you 
> think this should be going into a stable release once it's merged?

Yes, clearly your patch should go to stable to fix the multiple string
support. Mine is only for v4.20.

Thank you!

> 
> I added Greg as he might know the answer to that.
> 
> Thanks,
> 
> Andreas
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
