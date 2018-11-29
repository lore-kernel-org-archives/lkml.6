Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52427C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DA5213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DA5213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbeK3Dwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:52:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:44982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729326AbeK3Dwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:52:54 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC0BE20989;
        Thu, 29 Nov 2018 16:46:53 +0000 (UTC)
Date:   Thu, 29 Nov 2018 11:46:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC][PATCH 00/14] function_graph: Rewrite to allow multiple
 users
Message-ID: <20181129114652.3696d6d7@gandalf.local.home>
In-Reply-To: <20181129232927.74ca5f294e97fc58b15bf8c6@kernel.org>
References: <20181122012708.491151844@goodmis.org>
        <20181126182112.422b914dd00ecb36e15f7b07@kernel.org>
        <20181126113215.4259d473@gandalf.local.home>
        <20181129232927.74ca5f294e97fc58b15bf8c6@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 23:29:27 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > One way to solve this is to also have a counter array that gets updated
> > every time the index array gets updated. And save the counter to the
> > shadow stack index as well. This way, we only call the return if the
> > counter on the stack matches what's in the counter on the counter array
> > for the index.  
> 
> Hmm, but we already know the current stack "header" entry when calling
> handlers, don't we? I thought we just calcurate out from curr_ret_stack.

Basically we have this:

 array: | &fgraph_ops_1 | &fgraph_ops_2 | &fgraph_ops_stub | ...

On entry of function we do:

	for (i = 0; i < array_entries; i++) {
		if (array[i]->entryfunc(...)) {
			push i onto ret_stack;
		}
	}

On the return side, we do:

	idx = pop ret_stack;

	array[idx]->retfunc(...);

We only call the retfunc of a fgraph_ops if it returned non-zero from
its entryfunc(). The return can happen a long time from now (which is
why I don't save the &fgraph_ops on the ret_stack, because then we would
never be able to free it).

In the mean time, lets say we unregistered (and freed) fgraph_ops_2 and
then added fgraph_ops_3, so the array looks like:

 array: | &fgraph_ops_1 | &fgraph_ops_3 | &fgraph_ops_stub | ...

Then a function that was called when fgraph_ops_2 was on the stack
returns, it will call array[1]->retfunc() which now belongs to
fgraph_ops_3 and not fgraph_ops_2.

But if we add a counter array that gets updated when new ops are added
to the array, we have this:

 cnt_array: |       4       |     2         |       0          |
     array: | &fgraph_ops_1 | &fgraph_ops_2 | &fgraph_ops_stub | ...

And do:

	for (i = 0; i < array_entries; i++) {
		if (array[i]->entryfunc(...)) {
			idx = cnt_array[i] << 8 | i;
			push idx onto ret_stack;
		}
	}

Then on return we have:

	idx = pop ret_stack;

	if (idx >> 8 == cnt_array[idx & 0xff])
		array[idx & 0xff]->retfunc(...);

It wouldn't call fgraph_ops_3 because we would change the cnt_array
when we remove fgraph_ops_2 and the return would not match, as
cnt_array[1] would then be "3".

> 
> > > By the way, are there any way to hold a private data on each ret_stack entry?
> > > Since kretprobe supports "entry data" passed from entry_handler to
> > > return handler, we have to store the data or data-instance on the ret_stack.
> > > 
> > > This feature is used by systemtap to save the function entry data, like
> > > function parameters etc., so that return handler analyzes the parameters
> > > with return value.  
> > 
> > Yes, I remember you telling me about this at plumbers, and while I was
> > writing this code I had that in mind. It wouldn't be too hard to
> > implement, I just left it off for now. I also left it off because I
> > have some questions about what exactly is needed. What size do you
> > require to be stored. Especially if we want to keep the shadow stack
> > smaller. I was going to find a way to implement some of the data that
> > is already stored via the ret_stack with this instead, and make the
> > ret_stack entry smaller. Should we allow just sizeof(long)*3? or just
> > let user choose any size and if they run out of stack, then too bad. We
> > just wont let it crash.  
> 
> I need only sizeof(unsigned long). If the kretprobe user requires more,
> it will be fall back to current method -- get an "instance" and store
> its address to the entry :-)

Awesome, then this shouldn't be too hard to implement.

-- Steve
