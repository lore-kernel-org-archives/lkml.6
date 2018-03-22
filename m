Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751930AbeCVXZl convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 19:25:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751682AbeCVXZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 19:25:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06EA21839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 22 Mar 2018 19:25:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>
Cc: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ftrace: support boot level tracing
Message-ID: <20180322192538.76164265@gandalf.local.home>
In-Reply-To: <20180320233546.Horde.R7YJoHwgHhxvd5TuazyH3GI@www.imp.polymtl.ca>
References: <1521570176.31676.3.camel@polymtl.ca>
        <20180320180104.70e3eacd@gandalf.local.home>
        <20180320233546.Horde.R7YJoHwgHhxvd5TuazyH3GI@www.imp.polymtl.ca>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2018 23:35:46 +0000
Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca> wrote:

> Steven Rostedt <rostedt@goodmis.org> a écrit :
> 
> > On Tue, 20 Mar 2018 14:22:56 -0400
> > Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca> wrote:
> >
> > Would something like this work for you?  
> 
> Yes this is working great. I have also instrumented console and security
> initcalls, I used your previous patch, changes are below.
> 
> > +	trace_initcall_level("pre_smp_initcalls");  
> 
> This should be "early" I guess : trace_initcall_level("ealry");

Hmm, I think I found an issue with what's there. I made up that name
because "early" was already taken.

> 
> 
> output of : trace_event=initcall_level
> 
> [    0.327032]   <idle>-0       0.... 89576us : initcall_level: level=console
> [    0.327454]   <idle>-0       0.... 135819us : initcall_level:  
> level=security
> [    0.327887] swapper/-1       0.... 261166us : initcall_level: level=early
> [    0.328306] swapper/-1       0.... 265248us : initcall_level: level=early

Noticed you have two "early"s.

The second early should be "pure". But that's an issue with init.c.

I'll apply mine (with minor updates) and add diffs by you. Care to give
me a "signed-off-by" for the console and security change.

-- Steve


> [    0.328742] swapper/-1       0.... 267969us : initcall_level: level=core
> [    0.329158] swapper/-1       0.... 270111us : initcall_level:  
> level=postcore
> [    0.329590] swapper/-1       0.... 271111us : initcall_level: level=arch
> [    0.330007] swapper/-1       0.... 272217us : initcall_level: level=subsys
> [    0.330429] swapper/-1       0.... 316236us : initcall_level: level=fs
> [    0.330833] swapper/-1       0.... 340523us : initcall_level: level=device
> [    0.331254] swapper/-1       0.... 388737us : initcall_level: level=late
> 
> PATCH with security and console instrumented
> 
> 
