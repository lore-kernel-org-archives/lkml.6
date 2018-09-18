Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FF6ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5902146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5902146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbeISCTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 22:19:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730134AbeISCTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 22:19:00 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA0F62133F;
        Tue, 18 Sep 2018 20:44:37 +0000 (UTC)
Date:   Tue, 18 Sep 2018 16:44:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, Bryan Huntsman <bryanh@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>
Subject: Re: [PATCH 2/6] pstore: Add event tracing support
Message-ID: <20180918164434.472294f3@gandalf.local.home>
In-Reply-To: <cb17a8c9-fca1-5492-3255-eab0ea33577c@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
        <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
        <20180917193426.41c99fd5@gandalf.local.home>
        <cb17a8c9-fca1-5492-3255-eab0ea33577c@codeaurora.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2018 23:22:48 +0530
Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:

> On 9/18/2018 5:04 AM, Steven Rostedt wrote:
> > 
> > It looks like pstore_event_call() gets called from a trace event. You
> > can't call kmalloc() from one. One thing is that kmalloc has
> > tracepoints itself. You trace those you just entered an infinite loop.
> > 
> >   
> 
> Ok will remove it in v2. But any alternative way to do this?

I think I describe it below.

> 
> >> +
> >> +	event_call = fbuffer->trace_file->event_call;
> >> +	if (!event_call || !event_call->event.funcs ||
> >> +	    !event_call->event.funcs->trace)
> >> +		goto fail_event;
> >> +
> >> +	event = &fbuffer->trace_file->event_call->event;
> >> +
> >> +	spin_lock_irqsave(&psinfo->buf_lock, flags);
> >> +
> >> +	trace_seq_init(&iter->seq);
> >> +	iter->ent = fbuffer->entry;  
> > 
> > I guess what you are doing is needing to translate the raw data into
> > ascii output, and need the trace_iterator to do so.
> > 
> > You are already under a psinfo->buf_lock. Add a dummy iterator to that
> > and use it instead.
> > 
> > 	trace_seq_init(&psinfo->iter->seq);
> >   
> >> +	event_call->event.funcs->trace(iter, 0, event);  
> > 
> > 				      (psinfo->iter, 0 , event);
> > 
> > etc.
> >   
> 
> Sure, will update in v2.
> 
> >> +	trace_seq_putc(&iter->seq, 0);
> >> +
> >> +	if (seq->size > psinfo->bufsize)
> >> +		seq->size = psinfo->bufsize;
> >> +
> >> +	s = &iter->seq;
> >> +	seq = &s->seq;
> >> +
> >> +	record.buf = (char *)(seq->buffer);
> >> +	record.size = seq->len;
> >> +	psinfo->write(&record);
> >> +
> >> +	spin_unlock_irqrestore(&psinfo->buf_lock, flags);  
> > 
> > You may also need to convert these spin_locks into raw_spin_locks as
> > when PREEMPT_RT enters the kernel you don't want them to turn into
> > mutexes.
> > 
> > But that can be another patch.
> >   
> 
> I will change this in v2, but can't we have it in same patch?

I suggested a separate patch because buf_lock is used elsewhere.
Changing it to "raw_spin_lock" will affect more than just what this
patch series does. Thus, I recommend making it a separate patch to keep
this patch series from being more intrusive than it needs to be.

Thanks!

-- Steve

