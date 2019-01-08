Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA10C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC462070C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546915287;
	bh=sM/33vzmu89Axb0sLLS7eReaGPk+LcLaGHDTXCYjwX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ozwFxgCfHRftV7LhYzWf5N/ALQW7cUgPRrKLc8hNTykl+CRzLMv9tMkURsVqurAzV
	 WTqm6AGSdrbsk6KWMGzpsoEmDy0UaVnfXjOxm9fFIMSg5BEaBvqlKSRlw4qhMvGtwA
	 68x4H/X5O5IOsN9hISCJfHbwHPyP4eT/OLfBffBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfAHCl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 21:41:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:53672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727147AbfAHCl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 21:41:26 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4BCC206A3;
        Tue,  8 Jan 2019 02:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546915285;
        bh=sM/33vzmu89Axb0sLLS7eReaGPk+LcLaGHDTXCYjwX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JQcH43mxrj5zI0d5A7Ig1J6Dzy+Zzmxa7tN5CgitGj1uAv/5vnHTVDsryf1bKGUny
         blz+55w6Sjf/tzW/8y3aX73k6M3njILIhgEVJ7hoF9lW3oaRaBRRN1MGpY5yFvdeKU
         TMXr/daeaKFV2daWdS7LaFpG/soWp6Ls1WgUfrgk=
Date:   Tue, 8 Jan 2019 11:41:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrea Righi <righi.andrea@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] kprobes: Mark ftrace mcount handler functions
 nokprobe
Message-Id: <20190108114123.7b47c5c9365f856ee36f3ac3@kernel.org>
In-Reply-To: <20190107122951.1f843dc6@gandalf.local.home>
References: <154686789378.15479.2886543882215785247.stgit@devbox>
        <154686795211.15479.15577152313750689302.stgit@devbox>
        <20190107145536.GA1944@xps-13>
        <20190107122951.1f843dc6@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2019 12:29:51 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 7 Jan 2019 15:55:36 +0100
> Andrea Righi <righi.andrea@gmail.com> wrote:
> 
> > On Mon, Jan 07, 2019 at 10:32:32PM +0900, Masami Hiramatsu wrote:
> > > Mark ftrace mcount handler functions nokprobe since
> > > probing on these functions with kretprobe pushes
> > > return address incorrectly on kretprobe shadow stack.
> > > 
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > Reported-by: Francis Deslauriers <francis.deslauriers@efficios.com>
> > > ---
> > >  kernel/trace/ftrace.c |    5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > > index f0ff24173a0b..ad4babad4a03 100644
> > > --- a/kernel/trace/ftrace.c
> > > +++ b/kernel/trace/ftrace.c
> > > @@ -6250,7 +6250,7 @@ void ftrace_reset_array_ops(struct trace_array *tr)
> > >  	tr->ops->func = ftrace_stub;
> > >  }
> > >  
> > > -static inline void
> > > +static nokprobe_inline void  
> > 
> > I think we need to #include <linux/kprobes.h>, otherwise:
> > 
> >   CC      kernel/trace/ftrace.o
> > kernel/trace/ftrace.c:6219:24: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘void’
> >  static nokprobe_inline void
> >                         ^~~~
> > 
> >  kernel/trace/ftrace.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 3a58ad280d83..0333241034d5 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -32,6 +32,7 @@
> >  #include <linux/sort.h>
> >  #include <linux/list.h>
> >  #include <linux/hash.h>
> > +#include <linux/kprobes.h>
> >  #include <linux/rcupdate.h>
> >  
> >  #include <trace/events/sched.h>
> 
> And zero day just caught it too.
> 
> Masami, want to fold this into your patch and send out a v2?

Yes, I'll do that.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
