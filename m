Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EA7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F248020664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F248020664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbeK0D0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:26:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:45066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbeK0D0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:26:54 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD84820663;
        Mon, 26 Nov 2018 16:32:16 +0000 (UTC)
Date:   Mon, 26 Nov 2018 11:32:15 -0500
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
Message-ID: <20181126113215.4259d473@gandalf.local.home>
In-Reply-To: <20181126182112.422b914dd00ecb36e15f7b07@kernel.org>
References: <20181122012708.491151844@goodmis.org>
        <20181126182112.422b914dd00ecb36e15f7b07@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 18:21:12 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:


> > Note, if another fgraph_ops is registered in the same location, its
> > retfunc may be called that was set by a previous fgraph_ops. This
> > is not a regression because that's what can happen today if you unregister
> > a callback from the current function_graph tracer and register another
> > one. If this is an issue, there are ways to solve it.  
> 
> Yeah, I need the solution, maybe an API to get correct return address? :)

One way to solve this is to also have a counter array that gets updated
every time the index array gets updated. And save the counter to the
shadow stack index as well. This way, we only call the return if the
counter on the stack matches what's in the counter on the counter array
for the index.

> 
> By the way, are there any way to hold a private data on each ret_stack entry?
> Since kretprobe supports "entry data" passed from entry_handler to
> return handler, we have to store the data or data-instance on the ret_stack.
> 
> This feature is used by systemtap to save the function entry data, like
> function parameters etc., so that return handler analyzes the parameters
> with return value.

Yes, I remember you telling me about this at plumbers, and while I was
writing this code I had that in mind. It wouldn't be too hard to
implement, I just left it off for now. I also left it off because I
have some questions about what exactly is needed. What size do you
require to be stored. Especially if we want to keep the shadow stack
smaller. I was going to find a way to implement some of the data that
is already stored via the ret_stack with this instead, and make the
ret_stack entry smaller. Should we allow just sizeof(long)*3? or just
let user choose any size and if they run out of stack, then too bad. We
just wont let it crash.

-- Steve
