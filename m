Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4A7C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1BB52086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BB52086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeKHU7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:59:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:44358 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbeKHU7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:59:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3AE72ACF9;
        Thu,  8 Nov 2018 11:24:46 +0000 (UTC)
Date:   Thu, 8 Nov 2018 12:24:43 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v6 1/3] printk: Add line-buffered printk() API.
Message-ID: <20181108112443.huqkju4uwrenvtnu@pathway.suse.cz>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181106143502.GA32748@tigerII.localdomain>
 <20181107102154.pobr7yrl5il76be6@pathway.suse.cz>
 <20181108022138.GA2343@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108022138.GA2343@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-11-08 11:21:38, Sergey Senozhatsky wrote:
> On (11/07/18 11:21), Petr Mladek wrote:
> What is the problem:
> - we have tons of CPUs, with tons of tasks running on them, with preemption,
>   and interrupts, and potentially printk-s coming from various
>   contexts/CPUs/tasks etc. so one 'cont' buffer is not enough.
> 
> What is the proposed solution:
> - if 1 is not enough then 16 will do. And if 16 is not enough then this
>   is not our problem anymore, it's a kernel misconfiguration and users'
>   fault.

I believe that I mentioned this more times. 16 buffers is the first
attempt. We could improve it later in several ways:

  + add more buffers
  + combine buffers on stack, dynamically allocated and static ones.

BTW: I do not remember seeing mixed lines from anything even close to 16
CPUs. Maybe I was just lucky or my memory is leaky.


> Let's have one more look at what we will fix and what we will break.
> 
> 'cont' has premature flushes.
> 
>   Why is it good.
>   It preserves the correct order of events.
> 
>   pr_cont("calling foo->init()....");
>   foo->init()
>    printk("Can't allocate buffer\n");    // premature flush
>   pr_cont("...blah\h");
> 
>  Will end up in the logbuf as:
>  [12345.123] calling foo->init()....
>  [12345.124] Can't allocate buffer
>  [12345.125] ...blah
> 
>  Where buffered printk will endup as:
>  [12345.123] Can't allocate buffer
>  [12345.124] calling foo->init().......blah

We will always have this problem with API using explicit buffers.
What do you suggest instead, please?

I am afraid that we are running in cycles. The other serious
alternative was having per-process and per-context buffers
but it was rejected several times.


> Not to mention that buffered printk does not flush on panic.
> So, frankly, as of now, I don't see buffered printk as a 'cont'
> replacement.

The static array of buffers can be flushed on panic.


> If our problem is OOM and lockdep print outs, then let's address only
> those two; let's not "fix" the rest of the kernel, especially the early
> boot, - we can break more things than we can mend.

Do you have any alternative proposal how to handle OOM and lockdep, please?


> [..]
> > I opened this problem once and it got lost. So I did not want to
> > complicate it at this moment.
>
> - I don't exactly like the completely of the vprintk_buffered. If
>   buffered printk is for single line, then it must be for single
>   line only.

My undestanding is that the new API is similar to the current cont
buffer from this point of view:

    + buffer size is LOG_LINE_MAX
    + it is flushed when full

The only difference is that it is flushed also when there is a
complete line. Is this a problem, please?


> And I'm not buying the "we will need this for printk origin
> info injection" argument.

I was against this idea several times. The current API does
not do anything like this.


> - It seems that buffered printk attempts to solve too many problems.
>   I'd prefer it to address just one.

This API tries to handle continuous lines more reliably.
Do I miss anything, please?

Best Regards,
Petr
