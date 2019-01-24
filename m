Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C234AC282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88229218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfAXCKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 21:10:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbfAXCKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 21:10:07 -0500
Received: from vmware.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E0A3217D7;
        Thu, 24 Jan 2019 02:10:05 +0000 (UTC)
Date:   Wed, 23 Jan 2019 21:09:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tracing: uprobes: Re-enable $comm support for
 uprobe events
Message-ID: <20190123210956.0178b890@vmware.local.home>
In-Reply-To: <20190124104322.29e62ee0024c77a40110d569@kernel.org>
References: <154778663676.19927.12774448308165809570.stgit@devbox>
        <154778666570.19927.5960654930869453736.stgit@devbox>
        <20190123034005.2b49e4fe@vmware.local.home>
        <20190124104322.29e62ee0024c77a40110d569@kernel.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 10:43:22 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > >  kernel/trace/trace_uprobe.c |   15 +++++++++++++--
> > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > > index 3a1d5ab6b4ba..b07e498ccbc6 100644
> > > --- a/kernel/trace/trace_uprobe.c
> > > +++ b/kernel/trace/trace_uprobe.c
> > > @@ -156,7 +156,10 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
> > >  	if (unlikely(!maxlen))
> > >  		return -ENOMEM;
> > >  
> > > -	ret = strncpy_from_user(dst, src, maxlen);
> > > +	if (addr == (unsigned long)current->comm)
> > > +		ret = strlcpy(dst, current->comm, maxlen);  
> > 
> > As user space (although only root) defines the size of the event being
> > stored, and we could trick addr to be current->comm (although
> > difficult), we could possibly leak data if maxlen is > TASK_COMM_LEN. I
> > would feel better if we tested maxlen against TASK_COMM_LEN in this
> > case.
> > 
> > 	if (maxlen > TASK_COMM_LEN)
> > 		maxlen = TASK_COMM_LEN;
> > 
> > Or if we don't think it can happen, add a WARN_ON(maxlen >
> > TASK_COMM_LEN).  
> 
> Hmm, I thought current->comm is null terminated, isn't it?

Yes it is. I was thinking it was a memcpy (I blame conference fatigue ;-)

> Anyway, if user can specify current->comm, he must be able to specify 
> current->comm + TASK_COMM_LEN too by kprobe_events.
> Moreover, it can leak any data in kernel...

But this is for uprobes, which I why I was concerned.

> 
> And also, maxlen is calculated by fetch_store_strlen, right before
> this has been called.
> 
> I rather concern the case that if we have shorter size of maxlen than
> current->comm. Would we better show "(fault)" or tail-cut name ?
> (of course this is very difficult to happen, since the length is
> already checked.)

Actually, it would still be OK, as strlcpy does guarantee to be nul
terminated as long as it's greater than zero.

Hmm, strlcpy doesn't pad the rest if what is written is shorter than
what is allocated. Could that leak data?

-- Steve
