Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbeENVmE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:42:04 -0400
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:58259 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751978AbeENVmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:42:03 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:1981:2110:2194:2199:2393:2553:2559:2562:2693:2739:2828:3138:3139:3140:3141:3142:3355:3622:3653:3673:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:5007:6119:7903:8957:9040:10004:10400:10848:11026:11232:11473:11658:11914:12043:12049:12050:12051:12296:12438:12555:12740:12760:12895:12986:13161:13229:13439:13548:14181:14659:14721:14773:21080:21324:21433:21451:21627:30029:30054:30069:30070:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: stew93_11a42c1bbea40
X-Filterd-Recvd-Size: 4378
Message-ID: <32216d8f154b29400d4c11bae91850591114f7f8.camel@perches.com>
Subject: Re: [PATCH 18/18] rcu: Use pr_fmt to prefix "rcu: " to logging
 output
From: Joe Perches <joe@perches.com>
To: paulmck@linux.vnet.ibm.com
Cc: Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-kernel@vger.kernel.org
Date: Mon, 14 May 2018 14:41:59 -0700
In-Reply-To: <20180514202910.GI26088@linux.vnet.ibm.com>
References: <cover.1525964381.git.joe@perches.com>
         <41d9686471d67f6f98d160e5891bf61061515b6d.1525964386.git.joe@perches.com>
         <20180514202910.GI26088@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-14 at 13:29 -0700, Paul E. McKenney wrote:
> On Thu, May 10, 2018 at 08:45:44AM -0700, Joe Perches wrote:
> > Use a consistent logging prefix for all rcu related output.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> I took parts of this (thank you!) but have concerns about other parts.
[]
> > diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> > index 076a50fb22ad..ebdd77b45470 100644
> > --- a/kernel/rcu/rcuperf.c
> > +++ b/kernel/rcu/rcuperf.c
> > @@ -19,6 +19,9 @@
> >   *
> >   * Authors: Paul E. McKenney <paulmck@us.ibm.com>
> >   */
> > +
> > +#define pr_fmt(fmt) "rcu: " fmt
> 
> This is going to get us messages of the form "rcu: rcu-perf:", not?
> (And other odd combinations, depending on the flavor of RCU under test.)
> If so, this does not seem to be an improvement.

That depends on the existing embedded content of the format.
This will prefix just "rcu: " to pr_<level> output.

> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
[]
> > @@ -908,7 +909,7 @@ rcu_torture_writer(void *arg)
> >  	VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
> >  	if (!can_expedite)
> >  		pr_alert("%s" TORTURE_FLAG
> > -			 " GP expediting controlled from boot/sysfs for %s.\n",
> > +			 " GP expediting controlled from boot/sysfs for %s\n",
> >  			 torture_type, cur_ops->name);

As there is _no_ pr_fmt #defined in this file,
output will/could be prefixed with KBUILD_MODNAME ": "
(in this case "rcutorture: ") if/when the generic
pr_fmt conversion patch is applied.

> >  	} else if (gp_sync && !cur_ops->sync) {
> > -		pr_alert("%s: gp_sync without primitives.\n", __func__);
> > +		pr_alert("%s: gp_sync without primitives\n", __func__);
> 
> I used a CDC Cyber 73 in the 1970s.

Fancy.  I used a CDC 6400 and an IBM 1620, but
those were pretty old when I started.

> It had tiny memory by today's
> standards, but even it had periods in its error messages.  We can easily
> afford them today, especially given that rcutorture is not included in
> small-memory Linux configurations.

OK, but I like consistency too.

~90 percent of linux logging does not use terminating periods.
For instance, on my laptop:

$ uptime -p
up 1 week, 1 day, 13 hours, 37 minute
$ dmesg | wc -l
4240
$ dmesg | grep -P "\w\.$"| wc -l
381

> > @@ -1711,11 +1712,11 @@ static void rcu_test_debug_objects(void)
> > 
> >  	/* Wait for them all to get done so we can safely return. */
> >  	rcu_barrier();
> > -	pr_alert("%s: WARN: Duplicate call_rcu() test complete.\n", KBUILD_MODNAME);
> > +	pr_alert("WARN: Duplicate call_rcu() test complete\n");
> 
> I would like to keep these, as they mark the region of console output where
> splats are expected.

The prefixes are still there...

> >  	if (cur_ops->fqs == NULL && fqs_duration != 0) {
> > -		pr_alert("rcu-torture: ->fqs NULL and non-zero fqs_duration, fqs disabled.\n");
> > +		pr_alert("->fqs NULL and non-zero fqs_duration, fqs disabled\n");
> 
> This I would like to keep.  Easier to find.

One thing that you could use to validate the
output string format is after compilation:

$ strings kernel/rcu/rcutorture.o | grep -P "^[0-6]\w+:"

With your change, you will see duplicated prefixes.

cheers, Joe
> 
