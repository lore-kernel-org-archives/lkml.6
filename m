Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B5CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057DD2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gN48h4rA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057DD2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeK0DCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:02:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:35270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbeK0DCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:02:34 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10E3920862;
        Mon, 26 Nov 2018 16:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543248480;
        bh=cGEkfyLI7L5dhyu6zj/MnSifC5PuaTvMI6Z849nGQEI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gN48h4rAKRTEMwhEcl2DQnVDgIndVYKDyYqp0geKY8iEqVfYfWztDLV45Iajtbdp4
         ii0AAAZEV05a3Sw++a2RZYIn+7WkbIsTt6v0FGjCQuUZ3F7sI/OMT7zPl7U7YiC3Kv
         8kqGjzeM2sDK6WdNLZ3F7Qp+snS3axnuHWUVZQQc=
Date:   Tue, 27 Nov 2018 01:07:55 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC][PATCH 11/14] function_graph: Convert ret_stack to a
 series of longs
Message-Id: <20181127010755.0f897c13a57315a3859d225b@kernel.org>
In-Reply-To: <20181124053138.GA242510@google.com>
References: <20181122012708.491151844@goodmis.org>
        <20181122012804.122411256@goodmis.org>
        <20181124053138.GA242510@google.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018 21:31:38 -0800
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Wed, Nov 21, 2018 at 08:27:19PM -0500, Steven Rostedt wrote:
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > In order to make it possible to have multiple callbacks registered with the
> > function_graph tracer, the retstack needs to be converted from an array of
> > ftrace_ret_stack structures to an array of longs. This will allow to store
> > the list of callbacks on the stack for the return side of the functions.
> > 
> > [ Note, this currently breaks architectures that access the ret_stack of a
> >   task to handle unwinding when 'return_to_handler' is on the stack ]
> > 
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  include/linux/sched.h |   2 +-
> >  kernel/trace/fgraph.c | 123 +++++++++++++++++++++++-------------------
> >  2 files changed, 70 insertions(+), 55 deletions(-)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index d6183a55e8eb..71a084a300da 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1119,7 +1119,7 @@ struct task_struct {
> >  	int				curr_ret_depth;
> >  
> >  	/* Stack of return addresses for return function tracing: */
> > -	struct ftrace_ret_stack		*ret_stack;
> > +	unsigned long			*ret_stack;
> >  
> >  	/* Timestamp for last schedule: */
> >  	unsigned long long		ftrace_timestamp;
> > diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> > index 9b85638ecded..1389fe39f64c 100644
> > --- a/kernel/trace/fgraph.c
> > +++ b/kernel/trace/fgraph.c
> > @@ -23,6 +23,17 @@
> >  #define ASSIGN_OPS_HASH(opsname, val)
> >  #endif
> >  
> > +#define FGRAPH_RET_SIZE (sizeof(struct ftrace_ret_stack))
> > +#define FGRAPH_RET_INDEX (ALIGN(FGRAPH_RET_SIZE, sizeof(long)) / sizeof(long))
> > +#define SHADOW_STACK_SIZE (FTRACE_RETFUNC_DEPTH * FGRAPH_RET_SIZE)
> > +#define SHADOW_STACK_INDEX			\
> > +	(ALIGN(SHADOW_STACK_SIZE, sizeof(long)) / sizeof(long))
> > +#define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_INDEX - FGRAPH_RET_INDEX)
> > +
> > +#define RET_STACK(t, index) ((struct ftrace_ret_stack *)(&(t)->ret_stack[index]))
> > +#define RET_STACK_INC(c) ({ c += FGRAPH_RET_INDEX; })
> > +#define RET_STACK_DEC(c) ({ c -= FGRAPH_RET_INDEX; })
> > +
> [...]
> > @@ -514,7 +531,7 @@ void ftrace_graph_init_task(struct task_struct *t)
> >  
> >  void ftrace_graph_exit_task(struct task_struct *t)
> >  {
> > -	struct ftrace_ret_stack	*ret_stack = t->ret_stack;
> > +	unsigned long *ret_stack = t->ret_stack;
> >  
> >  	t->ret_stack = NULL;
> >  	/* NULL must become visible to IRQs before we free it: */
> > @@ -526,12 +543,10 @@ void ftrace_graph_exit_task(struct task_struct *t)
> >  /* Allocate a return stack for each task */
> >  static int start_graph_tracing(void)
> >  {
> > -	struct ftrace_ret_stack **ret_stack_list;
> > +	unsigned long **ret_stack_list;
> >  	int ret, cpu;
> >  
> > -	ret_stack_list = kmalloc_array(FTRACE_RETSTACK_ALLOC_SIZE,
> > -				       sizeof(struct ftrace_ret_stack *),
> > -				       GFP_KERNEL);
> > +	ret_stack_list = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
> >  
> 
> I had dumped the fgraph size related macros to understand the patch better, I
> got:
> [    0.909528] val of FGRAPH_RET_SIZE is 40
> [    0.910250] val of FGRAPH_RET_INDEX is 5
> [    0.910866] val of FGRAPH_ARRAY_SIZE is 16
> [    0.911488] val of FGRAPH_ARRAY_MASK is 255
> [    0.912134] val of FGRAPH_MAX_INDEX is 16
> [    0.912751] val of FGRAPH_INDEX_SHIFT is 8
> [    0.913382] val of FGRAPH_FRAME_SIZE is 168
> [    0.914033] val of FGRAPH_FRAME_INDEX is 21
>                       FTRACE_RETFUNC_DEPTH is 50
> [    0.914686] val of SHADOW_STACK_SIZE is 8400
> 
> I had a concern about memory overhead per-task. It seems the total memory
> needed per task for the stack is 8400 bytes (with my configuration with
> FUNCTION_PROFILE
> turned off).
> 
> Where as before it would be 32 * 40 = 1280 bytes. That looks like ~7 times
> more than before.

Hmm, this seems too big... I thought the shadow-stack size should be
smaller than 1 page (4kB). Steve, can we give a 4k page for shadow stack
and define FTRACE_RETFUNC_DEPTH = 4096 / FGRAPH_RET_SIZE ?

> On my system with ~4000 threads, that becomes ~32MB which seems a bit
> wasteful especially if there was only one or 2 function graph callbacks
> registered and most of the callback array in the stack isn't used.
> 
> Could we make the array size configurable at compile time and start it with a
> small number like 4 or 6?

Or, we can introduce online setting :)

Thank you,

> 
> Also for patches 1 through 10:
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> thanks,
> 
>  - Joel
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
