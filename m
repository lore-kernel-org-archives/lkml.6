Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbeENX5I (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 19:57:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56598 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752196AbeENX5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 19:57:06 -0400
Date: Mon, 14 May 2018 16:58:32 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joe Perches <joe@perches.com>
Cc: Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/18] rcu: Use pr_fmt to prefix "rcu: " to logging output
Reply-To: paulmck@linux.vnet.ibm.com
References: <cover.1525964381.git.joe@perches.com>
 <41d9686471d67f6f98d160e5891bf61061515b6d.1525964386.git.joe@perches.com>
 <20180514202910.GI26088@linux.vnet.ibm.com>
 <32216d8f154b29400d4c11bae91850591114f7f8.camel@perches.com>
 <20180514222456.GO26088@linux.vnet.ibm.com>
 <3c7770a062355650fb61e48a5fbeb9653d98d85a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c7770a062355650fb61e48a5fbeb9653d98d85a.camel@perches.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051423-0048-0000-0000-0000026CF447
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032391; UDB=6.00527789; IPR=6.00811523;
 MB=3.00021114; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 23:57:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051423-0049-0000-0000-0000451F5318
Message-Id: <20180514235832.GR26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140234
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 03:54:13PM -0700, Joe Perches wrote:
> On Mon, 2018-05-14 at 15:24 -0700, Paul E. McKenney wrote:
> > On Mon, May 14, 2018 at 02:41:59PM -0700, Joe Perches wrote:
> > > On Mon, 2018-05-14 at 13:29 -0700, Paul E. McKenney wrote:
> > > > On Thu, May 10, 2018 at 08:45:44AM -0700, Joe Perches wrote:
> > > > > Use a consistent logging prefix for all rcu related output.
> > > > > 
> > > > > Signed-off-by: Joe Perches <joe@perches.com>
> > > > 
> > > > I took parts of this (thank you!) but have concerns about other parts.
> > > 
> > > []
> > > > > diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> > > > > index 076a50fb22ad..ebdd77b45470 100644
> > > > > --- a/kernel/rcu/rcuperf.c
> > > > > +++ b/kernel/rcu/rcuperf.c
> > > > > @@ -19,6 +19,9 @@
> > > > >   *
> > > > >   * Authors: Paul E. McKenney <paulmck@us.ibm.com>
> > > > >   */
> > > > > +
> > > > > +#define pr_fmt(fmt) "rcu: " fmt
> > > > 
> > > > This is going to get us messages of the form "rcu: rcu-perf:", not?
> > > > (And other odd combinations, depending on the flavor of RCU under test.)
> > > > If so, this does not seem to be an improvement.
> > > 
> > > That depends on the existing embedded content of the format.
> > > This will prefix just "rcu: " to pr_<level> output.
> > 
> > OK, so to make this work, I need to create special-purpose pr_fmt()
> > definitions for torture, rcutorture, locktorture, and rcuperf.  Most
> > of the rest don't care.
> 
> Yes, or allow the new generic #define for pr_fmt
> to set those prefixes for you
> 
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> 
> will do the appropriate thing for rcutorture,

OK.  For rcutorture, there are special prefixes.  More on this at the end.

> > Or am I missing something basic here?
> > 
> > > > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > 
> > > []
> > > > > @@ -908,7 +909,7 @@ rcu_torture_writer(void *arg)
> > > > >  	VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
> > > > >  	if (!can_expedite)
> > > > >  		pr_alert("%s" TORTURE_FLAG
> > > > > -			 " GP expediting controlled from boot/sysfs for %s.\n",
> > > > > +			 " GP expediting controlled from boot/sysfs for %s\n",
> > > > >  			 torture_type, cur_ops->name);
> > > 
> > > As there is _no_ pr_fmt #defined in this file,
> > > output will/could be prefixed with KBUILD_MODNAME ": "
> > > (in this case "rcutorture: ") if/when the generic
> > > pr_fmt conversion patch is applied.
> > 
> > Not a fan, NACK.
> > 
> > > > >  	} else if (gp_sync && !cur_ops->sync) {
> > > > > -		pr_alert("%s: gp_sync without primitives.\n", __func__);
> > > > > +		pr_alert("%s: gp_sync without primitives\n", __func__);
> > > > 
> > > > I used a CDC Cyber 73 in the 1970s.
> > > 
> > > Fancy.  I used a CDC 6400 and an IBM 1620, but
> > > those were pretty old when I started.
> > 
> > ;-)
> > 
> > > > It had tiny memory by today's
> > > > standards, but even it had periods in its error messages.  We can easily
> > > > afford them today, especially given that rcutorture is not included in
> > > > small-memory Linux configurations.
> > > 
> > > OK, but I like consistency too.
> > > 
> > > ~90 percent of linux logging does not use terminating periods.
> > > For instance, on my laptop:
> > > 
> > > $ uptime -p
> > > up 1 week, 1 day, 13 hours, 37 minute
> > > $ dmesg | wc -l
> > > 4240
> > > $ dmesg | grep -P "\w\.$"| wc -l
> > > 381
> > 
> > Why is this a problem worth fixing?  From where I sit, it is not.
> 
> It's not a _problem_.  It's just an inconsistency.
> I modify them passively when I see them.
> If you don't like it, don't take it.

OK, fair enough.  I will pass.

> > Even assuming that this is somehow worth solving, why is it buried
> > in an unrelated patch?
> 
> Touches each line fewer times.
> 
> > > > > @@ -1711,11 +1712,11 @@ static void rcu_test_debug_objects(void)
> > > > > 
> > > > >  	/* Wait for them all to get done so we can safely return. */
> > > > >  	rcu_barrier();
> > > > > -	pr_alert("%s: WARN: Duplicate call_rcu() test complete.\n", KBUILD_MODNAME);
> > > > > +	pr_alert("WARN: Duplicate call_rcu() test complete\n");
> > > > 
> > > > I would like to keep these, as they mark the region of console output where
> > > > splats are expected.
> > > 
> > > The prefixes are still there...
> > > 
> > > > >  	if (cur_ops->fqs == NULL && fqs_duration != 0) {
> > > > > -		pr_alert("rcu-torture: ->fqs NULL and non-zero fqs_duration, fqs disabled.\n");
> > > > > +		pr_alert("->fqs NULL and non-zero fqs_duration, fqs disabled\n");
> > > > 
> > > > This I would like to keep.  Easier to find.
> > > 
> > > One thing that you could use to validate the
> > > output string format is after compilation:
> > > 
> > > $ strings kernel/rcu/rcutorture.o | grep -P "^[0-6]\w+:"
> > > 
> > > With your change, you will see duplicated prefixes.
> > 
> > Except that right now there are not duplicated prefixes.  Those
> > apparently only show up after some earlier patch in/before your set is
> > applied, correct? 
> 
> yes.
> [PATCH 03/18] printk: Convert pr_fmt from blank define to KBUILD_MODNAME
> 
> > Is there some C-preprocessor macro indicating whether or not your changes
> > have been applied?
> 
> ?  pr_fmt would either be blank or something else.

OK, so if I define pr_fmt as follows, I get the old behavior?

	#define pr_fmt(fmt) fmt

If so, I can add this to the torture files, and then define pr_fmt more
sensibly for the torture files once your changes hit mainline.

Or if we can agree on the defintion, perhaps we get the sensible
definition into your patch series.  But I would much prefer the former
given the high rate of change in RCU at the moment.

Note that my concerns apply only to kernel/torture.c, kernel/rcu/rcuperf.c,
kernel/rcu/rcutorture.c, and kernel/locking/locktorture.c (despite my
earlier ack).  The other RCU files, including kernel/rcu/rcu_segcblist.c,
should be just fine with "#define pr_fmt()" added.  And I just queued
a commit to be squashed into my version of your patch 18/18 that adds
this to kernel/rcu/rcu_segcblist.c.  This joins the ones that your
patch added to kernel/rcu/srcutree.c and kernel/rcu/tree.c.

Should I also add "#define pr_fmt(fmt) "rcu: " fmt" to these files?

kernel/rcu/srcutiny.c
kernel/rcu/sync.c
kernel/rcu/tiny.c

							Thanx, Paul
