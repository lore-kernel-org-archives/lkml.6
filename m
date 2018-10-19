Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B2FECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7082087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7082087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeJTE3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 00:29:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726274AbeJTE3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 00:29:38 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9JKJq0u142635
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 16:22:00 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n7m0dd9vp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 16:22:00 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 19 Oct 2018 16:21:59 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 19 Oct 2018 16:21:57 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9JKLuu125755732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Oct 2018 20:21:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B80FB2067;
        Fri, 19 Oct 2018 20:21:56 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF9BCB2066;
        Fri, 19 Oct 2018 20:21:55 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.109])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 19 Oct 2018 20:21:55 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C894616C359E; Fri, 19 Oct 2018 13:21:55 -0700 (PDT)
Date:   Fri, 19 Oct 2018 13:21:55 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Raslan, KarimAllah" <karahmed@amazon.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: Benefit from expedited grace period in __wait_rcu_gp
Reply-To: paulmck@linux.ibm.com
References: <1539910145-24305-1-git-send-email-karahmed@amazon.de>
 <20181019123106.GX2674@linux.ibm.com>
 <1539978350.11839.6.camel@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1539978350.11839.6.camel@amazon.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18101920-0052-0000-0000-00000346A8B3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009902; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01105080; UDB=6.00572140; IPR=6.00885131;
 MB=3.00023828; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-19 20:21:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101920-0053-0000-0000-00005E7907C0
Message-Id: <20181019202155.GR2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-19_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810190180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 07:45:51PM +0000, Raslan, KarimAllah wrote:
> On Fri, 2018-10-19 at 05:31 -0700, Paul E. McKenney wrote:
> > On Fri, Oct 19, 2018 at 02:49:05AM +0200, KarimAllah Ahmed wrote:
> > > 
> > > When expedited grace-period is set, both synchronize_sched
> > > synchronize_rcu_bh can be optimized to have a significantly lower latency.
> > > 
> > > Improve wait_rcu_gp handling to also account for expedited grace-period.
> > > The downside is that wait_rcu_gp will not wait anymore for all RCU variants
> > > concurrently when an expedited grace-period is set, however, given the
> > > improved latency it does not really matter.
> > > 
> > > Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> > 
> > Cute!
> > 
> > Unfortunately, there are a few problems with this patch:
> > 
> > 1.	I will be eliminating synchronize_rcu_mult() due to the fact that
> > 	the upcoming RCU flavor consolidation eliminates its sole caller.
> > 	See 5fc9d4e000b1 ("rcu: Eliminate synchronize_rcu_mult()")
> > 	in my -rcu tree.  This would of course also eliminate the effects
> > 	of this patch.
> 
> Your patch covers our use-case already, but I still think that the semantics 
> for wait_rcu_gp is not clear to me.
> 
> The problem for us was that sched_cpu_deactivate would call
> synchronize_rcu_mult which does not check for "expedited" at all. So even
> though we are already using rcu_expedited sysctl variable, synchronize_rcu_mult 
> was just ignoring it.
> 
> That being said, I indeed overlooked rcu_normal and that it takes precedence 
> over expedited and I did not notice at all the deadlock you mentioned below!
> 
> That can however be easily fixed by also checking for !rcu_gp_is_normal.

???

The aforementioned 5fc9d4e000b1 commit replaces the synchronize_rcu_mult()
with synchronize_rcu(), which really would be subject to the sysfs
variables.  Of course, this is not yet in mainline, so it perhaps cannot
solve your immediate problem, which probably involve older kernels in
any case.  More on this below...

> > 2.	The real-time guys' users are not going to be at all happy
> > 	with the IPIs resulting from the _expedited() API members.
> > 	Yes, they can boot with rcupdate.rcu_normal=1, but they don't
> > 	always need that big a hammer, and use of this kernel parameter
> > 	can slow down boot, hibernation, suspend, network configuration,
> > 	and much else besides.	We therefore don't want them to have to
> > 	use rcupdate.rcu_normal=1 unless absolutely necessary.
> 
> I might be missing something here. Why would they need to "explicitly" use 
> rcu_normal? If rcu_expedited is set, would not the expected behavior is to call 
> into the expedited version?
> 
> My patch should only activate *expedited* if and only if it is set.

You are right, I was confused.  However...

> I think I might be misunderstanding the expected behavior 
> from synchronize_rcu_mult. My understanding is that something like:
> 
> synchronize_rcu_mult(call_rcu_sched) and synchronize_rcu() should have an 
> identical behavior, right?

You would clearly prefer that it did, and the commit log does seem to
read that way, but synchronize_rcu_mult() is going away anyway, so there
isn't a whole lot of point in arguing about what it should have done.
And the eventual implementation (with 5fc9d4e000b1 or its successor)
will act as you want.

> At least in this commit:
> 
> commit d7d34d5e46140 ("sched: Rely on synchronize_rcu_mult() de-duplication")
> 
> .. the change clearly gives the impression that they can be used 
> interchangeably. The problem is that this is not true when you look at the 
> implementation. One of them (i.e. synchronize_rcu) will respect the
> expedite_rcu flag set by sysfs while the other (i.e. synchronize_rcu_mult) 
> simply ignores it.
> 
> So my patch is about making sure that both of the variants actually respect 
> it.

I am guessing that you need to make an older version of the kernel
expedite the CPU-hotplug grace periods.  I am also guessing that you can
carry patches to your kernels.  If so, I suggest the following simpler
change to sched_cpu_deactivate() in kernel/sched/core.c:

	if (rcu_gp_is_expedited()) {
		synchronize_sched_expedited();
		if (IS_ENABLED(CONFIG_PREEMPT))
			synchronize_rcu_expedited();
	} else {
		synchronize_rcu_mult(call_rcu, call_rcu_sched);
	}

As soon as this patch conflicts due to the synchronize_rcu_mult()
becoming synchronize_rcu(), you can drop the patch.  And this is the only
use of synchronize_rcu_mult(), so this approach loses no generality.
Longer term, this patch might possibly be the backport of 5fc9d4e000b1
back to v4.14, but at the end of the day this is up to the various
-stable maintainers.

Hmmm...  If you are running CONFIG_PREEMPT=n, you can use an even
simpler replacement for synchronize_rcu_mult():

	synchronize_sched_expedited(); /* Bug if CONFIG_PREEMPT=y!!! */

Would either of those two approaches work for you, or am I still missing
something?

							Thanx, Paul

> > 3.	If the real-time guys' users were to have booted with
> > 	rcupdate.rcu_normal=1, then synchronize_sched_expedited()
> > 	would invoke _synchronize_rcu_expedited, which would invoke
> > 	wait_rcu_gp(), which would invoke _wait_rcu_gp() which would
> > 	invoke __wait_rcu_gp(), which, given your patch, would in turn
> > 	invoke synchronize_sched_expedited().  This situation could
> > 	well prevent their systems from meeting their response-time
> > 	requirements.
> > 
> > So I cannot accept this patch nor for that matter any similar patch.
> > 
> > But what were you really trying to get done here?  If you were thinking
> > of adding another synchronize_rcu_mult(), the flavor consolidation will
> > make that unnecessary in most cases.  If you are trying to speed up
> > CPU-hotplug operations, I suggest using the rcu_expedited sysctl variable
> > when taking a CPU offline.  If something else, please let me know what
> > it is so that we can work out how the problem might best be solved.
> > 
> > 							Thanx, Paul
> > 
> > > 
> > > ---
> > >  kernel/rcu/update.c | 34 ++++++++++++++++++++++++++++------
> > >  1 file changed, 28 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > > index 68fa19a..44b8817 100644
> > > --- a/kernel/rcu/update.c
> > > +++ b/kernel/rcu/update.c
> > > @@ -392,13 +392,27 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
> > >  			might_sleep();
> > >  			continue;
> > >  		}
> > > -		init_rcu_head_on_stack(&rs_array[i].head);
> > > -		init_completion(&rs_array[i].completion);
> > > +
> > >  		for (j = 0; j < i; j++)
> > >  			if (crcu_array[j] == crcu_array[i])
> > >  				break;
> > > -		if (j == i)
> > > -			(crcu_array[i])(&rs_array[i].head, wakeme_after_rcu);
> > > +		if (j != i)
> > > +			continue;
> > > +
> > > +		if ((crcu_array[i] == call_rcu_sched ||
> > > +		     crcu_array[i] == call_rcu_bh)
> > > +		    && rcu_gp_is_expedited()) {
> > > +			if (crcu_array[i] == call_rcu_sched)
> > > +				synchronize_sched_expedited();
> > > +			else
> > > +				synchronize_rcu_bh_expedited();
> > > +
> > > +			continue;
> > > +		}
> > > +
> > > +		init_rcu_head_on_stack(&rs_array[i].head);
> > > +		init_completion(&rs_array[i].completion);
> > > +		(crcu_array[i])(&rs_array[i].head, wakeme_after_rcu);
> > >  	}
> > > 
> > >  	/* Wait for all callbacks to be invoked. */
> > > @@ -407,11 +421,19 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
> > >  		    (crcu_array[i] == call_rcu ||
> > >  		     crcu_array[i] == call_rcu_bh))
> > >  			continue;
> > > +
> > > +		if ((crcu_array[i] == call_rcu_sched ||
> > > +		     crcu_array[i] == call_rcu_bh)
> > > +		    && rcu_gp_is_expedited())
> > > +			continue;
> > > +
> > >  		for (j = 0; j < i; j++)
> > >  			if (crcu_array[j] == crcu_array[i])
> > >  				break;
> > > -		if (j == i)
> > > -			wait_for_completion(&rs_array[i].completion);
> > > +		if (j != i)
> > > +			continue;
> > > +
> > > +		wait_for_completion(&rs_array[i].completion);
> > >  		destroy_rcu_head_on_stack(&rs_array[i].head);
> > >  	}
> > >  }
> > > -- 
> > > 2.7.4
> > > 
> > 
> Amazon Development Center Germany GmbH
> Berlin - Dresden - Aachen
> main office: Krausenstr. 38, 10117 Berlin
> Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
> Ust-ID: DE289237879
> Eingetragen am Amtsgericht Charlottenburg HRB 149173 B

