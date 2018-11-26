Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687FBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FC720855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tu/MFisz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FC720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeKZUOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:14:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:45504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbeKZUOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:14:47 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7441B20663;
        Mon, 26 Nov 2018 09:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543224076;
        bh=rtW4Rw31h7Yi+Bj55OFXUH/0DO+KlzAYsZJn+8lHeSs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tu/MFiszjsxmiH1MRM2fAzz3H0+g8HEF+PMqYXKPhG9eToVSgRyl+J/fKY15bYo4J
         o/AXpuqSF/sYNYuBbEr5haoEVm2Pd3zx7D8W9DOqsyMvKiOIl21gwKMUjKJTyaEU02
         hJLNmXy7p2HCzCBqjd5Wk7tTvUO3C992VA4tvWAM=
Date:   Mon, 26 Nov 2018 18:21:12 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC][PATCH 00/14] function_graph: Rewrite to allow multiple
 users
Message-Id: <20181126182112.422b914dd00ecb36e15f7b07@kernel.org>
In-Reply-To: <20181122012708.491151844@goodmis.org>
References: <20181122012708.491151844@goodmis.org>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 21 Nov 2018 20:27:08 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> I talked with many of you at Plumbers about rewriting the function graph
> tracer. Well, this is it. I was originally going to produce just a
> proof of concept, but when I found that I had to fix a design flaw
> and that covered all the arch code anyway, I decided to do more of a
> RFC patch set.

Thank you for starting this work! This might be a good way to simplify
treating of shadow stacks in kretprobe and function-graph-tracers.
(And I hope this can help me to remove some kind of complexity in
 kretprobes)

> 
> I probably should add more comments to the code, and update the 
> function graph design documentation, but I wanted to get this out
> before the US Turkey day for your enjoyment while you try to let your
> pants buckle again.

:)

Let me try to review and port kretprobe on it. On the way, I will find
issues if there are.

> 
> Why the rewrite? 
> 
> Well the fuction graph tracer is arguably the strongest of the tracers.
> It shows both the entrance and exit of a function, can give the timings
> of a function, and shows the execution of the code quite nicely.
> 
> But it has one major flaw.
> 
> It can't let more than one user access it at a time. The function
> tracer has had that feature for years now, but due to the design of
> the function graph tracer it was difficult to implement. Why?
> 
> Because you must maintain the state of a three-tuple.
> 
>  Task, Function, Callback
> 
> The state is determined at by the entryfunc and must be passed to the
> retfunc when the function being traced returns. But this is not an
> easy task, as that state can be different for each task, each function
> and each callback.
> 
> What's the solution? I use the shadow stack that is already being
> used to store the function return addresses.
> 
>   A big thanks to Masami Hiramatsu for suggesting this idea!
> 
> For now, I only allow an 16 users of the function graph tracer at a time.
> That should be more than enough. I create an array of 16 fgraph_ops
> pointers. When a user registers their fgraph_ops to the function graph
> tracer, it is assigned an index into that array, which will hold a pointer
> to the fgraph_ops being registered.
> 
> On entry of the function, the array is iterated and each entryfunc of
> the fgraph_ops in the array is called. If the entryfunc returns non-zero,
> then the index of that fgraph_ops is pushed on the shadow stack (along
> with the index to the "ret_stack entry" structure, for fast access
> to it). If the entryfunc returns zero, then it is ignored. If at least
> one function returned non-zero then the return of the traced function
> will also be traced.
> 
> On the return of the function, the shadow stack is examined and all
> the indexes that were pushed on the stack is read, and each fgraph_ops
> retfunc is called in the reverse order.
> 
> When a fgraph_ops is unregistered, its index in the array is set to point
> to a "stub" fgraph_ops that holds stub functions that just return
> "0" for the entryfunc and does nothing for the retfunc. This is because
> the retfunc may be called literally days after the entryfunc is called
> and we want to be able to free the fgraph_ops that is unregistered.
> 
> Note, if another fgraph_ops is registered in the same location, its
> retfunc may be called that was set by a previous fgraph_ops. This
> is not a regression because that's what can happen today if you unregister
> a callback from the current function_graph tracer and register another
> one. If this is an issue, there are ways to solve it.

Yeah, I need the solution, maybe an API to get correct return address? :)

By the way, are there any way to hold a private data on each ret_stack entry?
Since kretprobe supports "entry data" passed from entry_handler to
return handler, we have to store the data or data-instance on the ret_stack.

This feature is used by systemtap to save the function entry data, like
function parameters etc., so that return handler analyzes the parameters
with return value.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
