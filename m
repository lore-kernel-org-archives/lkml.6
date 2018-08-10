Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC61DC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAEAB208AD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAEAB208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbeHJPSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbeHJPSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:18:22 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C8B120883;
        Fri, 10 Aug 2018 12:48:35 +0000 (UTC)
Date:   Fri, 10 Aug 2018 08:48:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "zhangwei(Jovi)" <jovi.zhangwei@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] uprobes: Use synchronize_rcu() not synchronize_sched()
Message-ID: <20180810084832.70b9a62a@gandalf.local.home>
In-Reply-To: <20180810113548.GA3677@redhat.com>
References: <20180809160553.469e1e32@gandalf.local.home>
        <20180810113548.GA3677@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2018 13:35:49 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 08/09, Steven Rostedt wrote:
> >
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -952,7 +952,7 @@ probe_event_disable(struct trace_uprobe *tu, struct trace_event_file *file)
> >
> >  		list_del_rcu(&link->list);
> >  		/* synchronize with u{,ret}probe_trace_func */
> > -		synchronize_sched();
> > +		synchronize_rcu();  
> 
> Can't we change uprobe_trace_func() and uretprobe_trace_func() to use
> rcu_read_lock_sched() instead? It is more cheap.

Is it? rcu_read_lock_sched() is a preempt_disable(), where
rcu_read_lock() may just be a task counter increment.

> 
> 
> Hmm. probe_event_enable() does list_del + kfree on failure, this doesn't
> look right... Not only because kfree() can race with list_for_each_entry_rcu(),
> we should not put the 1st link on list until uprobe_buffer_enable().
> 
> Does the patch below make sense or I am confused?

I guess the question is, if it isn't enabled, are there any users or
even past users still running. If not, then I think the current code is
OK, as there shouldn't be anything happening to race with it.

-- Steve

> 
> Oleg.
> 
> 
> --- x/kernel/trace/trace_uprobe.c
> +++ x/kernel/trace/trace_uprobe.c
> @@ -896,8 +896,6 @@ probe_event_enable(struct trace_uprobe *
>  			return -ENOMEM;
>  
>  		link->file = file;
> -		list_add_tail_rcu(&link->list, &tu->tp.files);
> -
>  		tu->tp.flags |= TP_FLAG_TRACE;
>  	} else {
>  		if (tu->tp.flags & TP_FLAG_TRACE)
> @@ -909,7 +907,7 @@ probe_event_enable(struct trace_uprobe *
>  	WARN_ON(!uprobe_filter_is_empty(&tu->filter));
>  
>  	if (enabled)
> -		return 0;
> +		goto add;
>  
>  	ret = uprobe_buffer_enable();
>  	if (ret)
> @@ -920,7 +918,8 @@ probe_event_enable(struct trace_uprobe *
>  	ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
>  	if (ret)
>  		goto err_buffer;
> -
> + add:
> +	list_add_tail_rcu(&link->list, &tu->tp.files);
>  	return 0;
>  
>   err_buffer:
> @@ -928,7 +927,6 @@ probe_event_enable(struct trace_uprobe *
>  
>   err_flags:
>  	if (file) {
> -		list_del(&link->list);
>  		kfree(link);
>  		tu->tp.flags &= ~TP_FLAG_TRACE;
>  	} else {

