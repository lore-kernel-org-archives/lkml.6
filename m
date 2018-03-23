Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbeCWUEp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 16:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751843AbeCWUEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 16:04:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A55421839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 23 Mar 2018 16:04:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>,
        =?UTF-8?B?QW3Dg8Kpcmljbw==?= Wang <xiyou.wangcong@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] [RFC] init, tracing: Add initcall trace events
Message-ID: <20180323160441.3217664d@vmware.local.home>
In-Reply-To: <20180323125016.270ea1558fe2499b1a12bfd7@linux-foundation.org>
References: <20180323150241.878778199@goodmis.org>
        <20180323125016.270ea1558fe2499b1a12bfd7@linux-foundation.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018 12:50:16 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 23 Mar 2018 11:02:41 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > A while ago we had a boot tracer. But it was eventually removed:
> >  commit 30dbb20e68e6f ("tracing: Remove boot tracer").
> > 
> > The rational was because there is already a initcall_debug boot option
> > that causes printk()s of all the initcall functions.  
> 
> "rationale" :)

I hate English.

> 
> > The problem with the initcall_debug option is that printk() is awfully slow,
> > and makes it difficult to see the real impact of initcalls. Mainly because
> > a single printk() is usually slower than most initcall functions.  
> 
> Not understanding this.  We do it correctly:
> 
> 	calltime = ktime_get();
> 	ret = fn();
> 	rettime = ktime_get();
> 
> so the displayed initcall timing is independent of the printk()
> execution time?
> 

It's not just the timing, it's the fact that init_debug printks disrupts
the boot process, where as tracing is less invasive to the
general runtime.

I would even argue that we remove the printks and use the trace events
instead. There's already an option to make trace events be sent to
printk(). I could have initcall_debug enable the trace events and send
them to printk.

-- Steve
