Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF29C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED28A2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED28A2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeHVT6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 15:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbeHVT6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 15:58:52 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C1CA206B7;
        Wed, 22 Aug 2018 16:33:17 +0000 (UTC)
Date:   Wed, 22 Aug 2018 12:33:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG v4.14-rt] kernel BUG at
 /work/rt/stable-rt.git/kernel/sched/core.c:1639!
Message-ID: <20180822123315.3a184f9c@gandalf.local.home>
In-Reply-To: <20180822121749.5c4632d7@gandalf.local.home>
References: <20180817162340.6e8482fd@gandalf.local.home>
        <1534588142.2516.10.camel@gmx.de>
        <1534597992.15909.17.camel@gmx.de>
        <1534660115.6187.4.camel@gmx.de>
        <20180822121749.5c4632d7@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sebastian,


On Wed, 22 Aug 2018 12:17:49 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 19 Aug 2018 08:28:35 +0200
> Mike Galbraith <efault@gmx.de> wrote:
> 
> > On Sat, 2018-08-18 at 15:13 +0200, Mike Galbraith wrote:
> > > seems it has be something from the 4.17 cycle that went back to 4.14-
> > > stable after 4.1[56]-stable trees went extinct.  
> > 
> > See ("sched/core: Require cpu_active() in select_task_rq(), for user tasks")
> > 
> > Fix it like so?
> > 
> > sched: Allow pinned user tasks to be awakened to the CPU they pinned
> > 
> > Since 7af443ee16976, select_fallback_rq() will BUG() if the CPU to
> > which a task has pinned itself and pinned becomes !cpu_active()
> > while it slept.  Serving a 10 megaton eviction notice is neither
> > helpful nor required, the task will migrate when it can do so.
> 
> This seems to fix the issue that I was seeing. Thanks!
> 
> I'll add this to my repo as well.

I'm going to hold off on pulling this in until I see it in your tree,
because a stable RT branch should not carry anything that isn't in the
head RT tree. And it appears that this can affect your repo too.

-- Steve

> 
> > 
> > Signed-off-by: Mike Galbraith <efault@gmx.de>
> > ---
> >  kernel/sched/core.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -980,7 +980,7 @@ static inline bool is_cpu_allowed(struct
> >  	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> >  		return false;
> >  
> > -	if (is_per_cpu_kthread(p))
> > +	if (is_per_cpu_kthread(p) || __migrate_disabled(p))
> >  		return cpu_online(cpu);
> >  
> >  	return cpu_active(cpu);
> 

