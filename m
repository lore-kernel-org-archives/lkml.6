Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87B0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900E22173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfAGR3y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:29:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:42922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbfAGR3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:29:54 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF2F42087F;
        Mon,  7 Jan 2019 17:29:52 +0000 (UTC)
Date:   Mon, 7 Jan 2019 12:29:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrea Righi <righi.andrea@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] kprobes: Mark ftrace mcount handler functions
 nokprobe
Message-ID: <20190107122951.1f843dc6@gandalf.local.home>
In-Reply-To: <20190107145536.GA1944@xps-13>
References: <154686789378.15479.2886543882215785247.stgit@devbox>
        <154686795211.15479.15577152313750689302.stgit@devbox>
        <20190107145536.GA1944@xps-13>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2019 15:55:36 +0100
Andrea Righi <righi.andrea@gmail.com> wrote:

> On Mon, Jan 07, 2019 at 10:32:32PM +0900, Masami Hiramatsu wrote:
> > Mark ftrace mcount handler functions nokprobe since
> > probing on these functions with kretprobe pushes
> > return address incorrectly on kretprobe shadow stack.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Reported-by: Francis Deslauriers <francis.deslauriers@efficios.com>
> > ---
> >  kernel/trace/ftrace.c |    5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index f0ff24173a0b..ad4babad4a03 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -6250,7 +6250,7 @@ void ftrace_reset_array_ops(struct trace_array *tr)
> >  	tr->ops->func = ftrace_stub;
> >  }
> >  
> > -static inline void
> > +static nokprobe_inline void  
> 
> I think we need to #include <linux/kprobes.h>, otherwise:
> 
>   CC      kernel/trace/ftrace.o
> kernel/trace/ftrace.c:6219:24: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘void’
>  static nokprobe_inline void
>                         ^~~~
> 
>  kernel/trace/ftrace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 3a58ad280d83..0333241034d5 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -32,6 +32,7 @@
>  #include <linux/sort.h>
>  #include <linux/list.h>
>  #include <linux/hash.h>
> +#include <linux/kprobes.h>
>  #include <linux/rcupdate.h>
>  
>  #include <trace/events/sched.h>

And zero day just caught it too.

Masami, want to fold this into your patch and send out a v2?

-- Steve
