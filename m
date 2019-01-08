Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECB6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C56B2070C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546915255;
	bh=pjj4hqxnJWeFTWinEWtcN1P2nHd2H4i0MD+jorAJiqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=p3Xg2fPIQQeM1TrqmFPNExPZ9rG1mIuYqwyU/CcbOca+YyIu44hJeQ822SvOBp9lJ
	 8ph0Ch98PaizIgghnptMugNMGbIjuTJLRXmHF4rq4pwLEGg1BAENaCQoJLR2VNwJY2
	 ZDQQnMgADKUQgEVSrwgoDo+kF/SawO/iJGBPb2M4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfAHCky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 21:40:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:53608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727147AbfAHCkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 21:40:53 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3EE3206A3;
        Tue,  8 Jan 2019 02:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546915252;
        bh=pjj4hqxnJWeFTWinEWtcN1P2nHd2H4i0MD+jorAJiqg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CUePgFoPNMSoXGEodxF/kiTm+LgUtTqMADdCd/QRg0z5GK39HiOLJLWifn/FZswIJ
         gLRr0b19Gmmb0EBwY9t5AaDiERWTjsMkcXCCe470uc7VsCeC6+jB0E87KAVoqfxOPh
         QeT96hap/br5kVGg3GOoFEbdbtX5iUE9VH9MKxaQ=
Date:   Tue, 8 Jan 2019 11:40:50 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andrea Righi <righi.andrea@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] kprobes: Mark ftrace mcount handler functions
 nokprobe
Message-Id: <20190108114050.25e64eeb80aab51fc70fc07d@kernel.org>
In-Reply-To: <20190107145536.GA1944@xps-13>
References: <154686789378.15479.2886543882215785247.stgit@devbox>
        <154686795211.15479.15577152313750689302.stgit@devbox>
        <20190107145536.GA1944@xps-13>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
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


Oops, I missed it while reordering other patches...

Thank you,

> 
> Thanks,
> -Andrea
> 
> >  __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
> >  		       struct ftrace_ops *ignored, struct pt_regs *regs)
> >  {
> > @@ -6310,11 +6310,13 @@ static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
> >  {
> >  	__ftrace_ops_list_func(ip, parent_ip, NULL, regs);
> >  }
> > +NOKPROBE_SYMBOL(ftrace_ops_list_func);
> >  #else
> >  static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip)
> >  {
> >  	__ftrace_ops_list_func(ip, parent_ip, NULL, NULL);
> >  }
> > +NOKPROBE_SYMBOL(ftrace_ops_no_ops);
> >  #endif
> >  
> >  /*
> > @@ -6341,6 +6343,7 @@ static void ftrace_ops_assist_func(unsigned long ip, unsigned long parent_ip,
> >  	preempt_enable_notrace();
> >  	trace_clear_recursion(bit);
> >  }
> > +NOKPROBE_SYMBOL(ftrace_ops_assist_func);
> >  
> >  /**
> >   * ftrace_ops_get_func - get the function a trampoline should call


-- 
Masami Hiramatsu <mhiramat@kernel.org>
