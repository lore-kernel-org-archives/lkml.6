Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D396DC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930042087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930042087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933166AbeGIMZj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:25:39 -0400
Received: from smtp1.de.adit-jv.com ([62.225.105.245]:49394 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932797AbeGIMZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:25:37 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id EC9AE3C015E;
        Mon,  9 Jul 2018 14:25:34 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VKqtIr8A4ZVo; Mon,  9 Jul 2018 14:25:28 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 431263C09A0;
        Mon,  9 Jul 2018 14:25:28 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 9 Jul 2018
 14:25:27 +0200
Date:   Mon, 9 Jul 2018 14:25:24 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
CC:     Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH] locking/lockdep: Report comm/pid/timestamp information
Message-ID: <20180709122524.GA30596@vmlxhi-102.adit-jv.com>
References: <20180709005725.18184-1-erosca@de.adit-jv.com>
 <20180709083118.GA2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180709083118.GA2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 10:31:18AM +0200, Peter Zijlstra wrote:
> On Mon, Jul 09, 2018 at 02:57:25AM +0200, Eugeniu Rosca wrote:
> > diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> > index 6fc77d4dbdcd..eeed7ea2e198 100644
> > --- a/include/linux/lockdep.h
> > +++ b/include/linux/lockdep.h
> > @@ -186,6 +186,10 @@ struct lock_list {
> >  	struct list_head		entry;
> >  	struct lock_class		*class;
> >  	struct stack_trace		trace;
> > +	unsigned long long		ts;
> > +	char				comm[16];
> > +	pid_t				pid;
> > +	int				cpu;
> >  	int				distance;
> >  
> >  	/*
> 
> Yeah, not going to happen. You grow that structure from 64 bytes to 96
> bytes and with that grow the static footprint of the kernel by 512k (in
> the very best case)

I  confirm that in case of x86_64, the bss size is increased by ~1M [1]
with standard v4.18-rc4 x86_64_defconfig + CONFIG_LOCKDEP.

> possibly again breaking things like sparc (which
> have a strict limit on the kernel image size).

For sparc there seems to be a dedicated CONFIG_LOCKDEP_SMALL, which
seems to downsize the lockdep implementation anyway.

> And all that for data that I've never needed and never even considered
> useful when looking at lockdep output.

It's likely because you infer about certain aspects which are not
clearly stated in the deadlock report. As example, the original report
doesn't say that the process which holds 'cpu_hotplug_lock.rw_sem'
is different to the process which holds the other locks. On the
contrary, it tells the user that all the locks are being held by the
same task, which seems to be wrong.

You likely also infer about the order of consuming the locks based on
the contents of the stack dump associated to each lock. Without doing
some mental diffs between the backtraces, it's not possible to see the
chronological order of consuming the locks. Actually this only works for
backtraces with common history, i.e. there is no clue what is the
time/point of acquiring 'cpu_hotplug_lock.rw_sem' relative to the other
locks.

The patch mostly shares my personal experience of trying to make sense
of lockdep output. It's OK if it doesn't reach mainline.

I still hope that I can get some feedback from community regarding
the actual cpufreq-related issue pointed out in the splat. I can also
reproduce it on v4.14, so it appears to be in the kernel for quite
some time.

Thank you in advance.

Best regards,
Eugeniu.

[1] BSS size increase after applying the patch
$ bloaty -s vm vmlinux.after -- vmlinux.before   
     VM SIZE                           FILE SIZE
 --------------                     --------------
  +8.2% +1024Ki .bss                      0  [ = ]
  ----snip----
  +2.6% +1024Ki TOTAL               +3.36Ki  +0.0%
