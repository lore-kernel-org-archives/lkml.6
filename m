Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754206AbeDJPPA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:15:00 -0400
Received: from smtprelay0148.hostedemail.com ([216.40.44.148]:51908 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753097AbeDJPO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:14:58 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2198:2199:2393:2525:2553:2559:2564:2682:2685:2691:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:7903:8985:9025:9121:10004:10400:10848:11026:11232:11233:11658:11914:12043:12296:12663:12740:12760:12895:13069:13161:13229:13311:13357:13439:14181:14581:14659:14721:21080:21433:21451:21627:30054:30060:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: fuel07_2b0159758bd38
X-Filterd-Recvd-Size: 3167
Message-ID: <bece0d90535709ef39006adb5f481993d6063929.camel@perches.com>
Subject: Re: Subject: [PATCH] [PATCH] time: tick-sched: use bool for
 tick_stopped
From: Joe Perches <joe@perches.com>
To: Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc: yuankuiz@codeaurora.org, Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, aulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@kernel.org>, Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        apw@canonical.com
Date: Tue, 10 Apr 2018 08:14:54 -0700
In-Reply-To: <20180410123305.GF4082@hirez.programming.kicks-ass.net>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
         <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>
         <20180410123305.GF4082@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-10 at 14:33 +0200, Peter Zijlstra wrote:
> On Tue, Apr 10, 2018 at 10:00:01AM +0200, Rafael J. Wysocki wrote:
> > On Tue, Apr 10, 2018 at 9:33 AM,  <yuankuiz@codeaurora.org> wrote:
> > > +++ b/kernel/time/tick-sched.h
> > > @@ -48,8 +48,8 @@ struct tick_sched {
> > >         unsigned long                   check_clocks;
> > >         enum tick_nohz_mode             nohz_mode;
> > > 
> > > +       bool                            tick_stopped    : 1;
> > >         unsigned int                    inidle          : 1;
> > > -       unsigned int                    tick_stopped    : 1;
> > >         unsigned int                    idle_active     : 1;
> > >         unsigned int                    do_timer_last   : 1;
> > >         unsigned int                    got_idle_tick   : 1;
> > 
> > I don't think this is a good idea at all.
> > 
> > Please see https://lkml.org/lkml/2017/11/21/384 for example.
> 
> Joe, apw, could we get Checkpatch to whinge about _Bool in composite
> types? That should immediately also disqualify using it as the base type
> of bitfields.

Whinging about bool <foo> : <x> seems entirely sensible
and straightforward to do.

I'm not so sure about bool in structs as a patch context
could be adding a bool to local stack definitions and
there's no real ability to determine if the bool is in a
struct or on the stack.

Also, I think there's nothing really wrong with using
bool in structs.  Steven Rostedt's rationale in
https://lkml.org/lkml/2017/11/21/207 isn't really right
as sizeof(int) is 4 not 1 and sizeof(bool) is 1 on arches
without alignment issues.  I believe when using gcc,
sizeof(bool) is always 1 and there may be alignment padding
added on some arches.  Dunno.

But I think the battle is already lost anyway.

git grep -P  '(?<!static|extern)\s+bool\s+\w+\s*;' include | wc -l
1543
