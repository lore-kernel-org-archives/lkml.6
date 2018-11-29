Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4954FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156EF2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yc3rTrJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156EF2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbeK3BfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:35:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:36682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388461AbeK3BfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:35:04 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D16321479;
        Thu, 29 Nov 2018 14:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501771;
        bh=aYxdrScUatLC/QcnGdGTY1m0q96J24wtUSe+Ri679FM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yc3rTrJHNPjXT/xSZmwkRBLyaLs5VAfrrAsVwKoDuIUQQjxdr/vw26V+zCpNys9Pn
         S5rXe1j4eThJa86IwcSpQIClBVEiLqCuGtXRskNZm5h8SLbswqf1hhuLwIdW/a6NaI
         aRLAzAzMBovSW56gOk9ECz0gYN0ocZClAB7OuSUE=
Date:   Thu, 29 Nov 2018 23:29:27 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-Id: <20181129232927.74ca5f294e97fc58b15bf8c6@kernel.org>
In-Reply-To: <20181126113215.4259d473@gandalf.local.home>
References: <20181122012708.491151844@goodmis.org>
        <20181126182112.422b914dd00ecb36e15f7b07@kernel.org>
        <20181126113215.4259d473@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Mon, 26 Nov 2018 11:32:15 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 26 Nov 2018 18:21:12 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> 
> > > Note, if another fgraph_ops is registered in the same location, its
> > > retfunc may be called that was set by a previous fgraph_ops. This
> > > is not a regression because that's what can happen today if you unregister
> > > a callback from the current function_graph tracer and register another
> > > one. If this is an issue, there are ways to solve it.  
> > 
> > Yeah, I need the solution, maybe an API to get correct return address? :)
> 
> One way to solve this is to also have a counter array that gets updated
> every time the index array gets updated. And save the counter to the
> shadow stack index as well. This way, we only call the return if the
> counter on the stack matches what's in the counter on the counter array
> for the index.

Hmm, but we already know the current stack "header" entry when calling
handlers, don't we? I thought we just calcurate out from curr_ret_stack.

> > By the way, are there any way to hold a private data on each ret_stack entry?
> > Since kretprobe supports "entry data" passed from entry_handler to
> > return handler, we have to store the data or data-instance on the ret_stack.
> > 
> > This feature is used by systemtap to save the function entry data, like
> > function parameters etc., so that return handler analyzes the parameters
> > with return value.
> 
> Yes, I remember you telling me about this at plumbers, and while I was
> writing this code I had that in mind. It wouldn't be too hard to
> implement, I just left it off for now. I also left it off because I
> have some questions about what exactly is needed. What size do you
> require to be stored. Especially if we want to keep the shadow stack
> smaller. I was going to find a way to implement some of the data that
> is already stored via the ret_stack with this instead, and make the
> ret_stack entry smaller. Should we allow just sizeof(long)*3? or just
> let user choose any size and if they run out of stack, then too bad. We
> just wont let it crash.

I need only sizeof(unsigned long). If the kretprobe user requires more,
it will be fall back to current method -- get an "instance" and store
its address to the entry :-)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
