Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC3FC282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8885218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548299028;
	bh=SwbeqvMuelXlay+iLeUO0Jf2QkbnmqQyBFnYoRTRwLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=F2VlLpqQny3NiwNC/VpxH3VjYN1HoHFQaDGQGHI8GTqFmxwlw1D7AH1NtIAyKJCJk
	 JKz+voqytpz6rDjmRPh8da8ij3ouliRnLYkGuBBfK8CQihYCkexWXGPJaCU8zsbp3B
	 pWd5tyheHibP+wTnJ+dSfa+eCMwZvgNyiwawm20o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfAXDDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 22:03:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbfAXDDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 22:03:46 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D32A21872;
        Thu, 24 Jan 2019 03:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548299025;
        bh=SwbeqvMuelXlay+iLeUO0Jf2QkbnmqQyBFnYoRTRwLY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aYBDUIxdqAtfrcRvext0vGkf2o5YOe/vYcd3jyOnW8gZy3yEwBv3YLYnZ9jLzzQNa
         MAJzjzFfdifr3Iw4OwQWNgYenod3CLZ3dNfFN8trxfi1cdlsCV/ooQH+0st94KjmhT
         Y6O95pkgzfKsK8VLCv/yAiaDdJVCh9AUGIFd6qo4=
Date:   Thu, 24 Jan 2019 12:03:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tracing: uprobes: Re-enable $comm support for
 uprobe events
Message-Id: <20190124120343.dca2887200a50c3f3ad1186b@kernel.org>
In-Reply-To: <20190123210956.0178b890@vmware.local.home>
References: <154778663676.19927.12774448308165809570.stgit@devbox>
        <154778666570.19927.5960654930869453736.stgit@devbox>
        <20190123034005.2b49e4fe@vmware.local.home>
        <20190124104322.29e62ee0024c77a40110d569@kernel.org>
        <20190123210956.0178b890@vmware.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 21:09:56 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 24 Jan 2019 10:43:22 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > >  kernel/trace/trace_uprobe.c |   15 +++++++++++++--
> > > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > > > index 3a1d5ab6b4ba..b07e498ccbc6 100644
> > > > --- a/kernel/trace/trace_uprobe.c
> > > > +++ b/kernel/trace/trace_uprobe.c
> > > > @@ -156,7 +156,10 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
> > > >  	if (unlikely(!maxlen))
> > > >  		return -ENOMEM;
> > > >  
> > > > -	ret = strncpy_from_user(dst, src, maxlen);
> > > > +	if (addr == (unsigned long)current->comm)
> > > > +		ret = strlcpy(dst, current->comm, maxlen);  
> > > 
> > > As user space (although only root) defines the size of the event being
> > > stored, and we could trick addr to be current->comm (although
> > > difficult), we could possibly leak data if maxlen is > TASK_COMM_LEN. I
> > > would feel better if we tested maxlen against TASK_COMM_LEN in this
> > > case.
> > > 
> > > 	if (maxlen > TASK_COMM_LEN)
> > > 		maxlen = TASK_COMM_LEN;
> > > 
> > > Or if we don't think it can happen, add a WARN_ON(maxlen >
> > > TASK_COMM_LEN).  
> > 
> > Hmm, I thought current->comm is null terminated, isn't it?
> 
> Yes it is. I was thinking it was a memcpy (I blame conference fatigue ;-)
> 
> > Anyway, if user can specify current->comm, he must be able to specify 
> > current->comm + TASK_COMM_LEN too by kprobe_events.
> > Moreover, it can leak any data in kernel...
> 
> But this is for uprobes, which I why I was concerned.

OK, what we will leak by this, is the address of current->comm to root
user for a specific application running instance.
Since they can try to write a data on a register and trace it like
"+0(%ax):string" and if rax register has hit the current->comm,
uprobe event will record comm, but other case, it will show "(fault)".
So they can trial and error on that (but leaking just a temporary
task instance address).

If you concern this, I can change it to store a special fixed value, like
(unsigned long)-EINVAL, instead of current->comm address. :-)

> > And also, maxlen is calculated by fetch_store_strlen, right before
> > this has been called.
> > 
> > I rather concern the case that if we have shorter size of maxlen than
> > current->comm. Would we better show "(fault)" or tail-cut name ?
> > (of course this is very difficult to happen, since the length is
> > already checked.)
> 
> Actually, it would still be OK, as strlcpy does guarantee to be nul
> terminated as long as it's greater than zero.

Ah, I meant that we can record a shorter name, like "shutdown" -> "sh". 

> Hmm, strlcpy doesn't pad the rest if what is written is shorter than
> what is allocated. Could that leak data?

Even though, there should be a data that had been recorded on the ring
buffer.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
