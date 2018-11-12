Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF6CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBFA216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBFA216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbeKLMP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 07:15:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729482AbeKLMP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 07:15:58 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAC2NaqD006935
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 21:25:01 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2npw8qphds-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 21:25:01 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 12 Nov 2018 02:25:00 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 12 Nov 2018 02:24:55 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAC2OsUU46465264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 02:24:54 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 796D1B2064;
        Mon, 12 Nov 2018 02:24:54 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 418ADB205F;
        Mon, 12 Nov 2018 02:24:54 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Nov 2018 02:24:54 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B316D16C5D4F; Sun, 11 Nov 2018 18:24:55 -0800 (PST)
Date:   Sun, 11 Nov 2018 18:24:55 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH tip/core/rcu 23/41] sched: Replace synchronize_sched()
 with synchronize_rcu()
Reply-To: paulmck@linux.ibm.com
References: <20181111194104.GA4787@linux.ibm.com>
 <20181111194410.6368-23-paulmck@linux.ibm.com>
 <20181112001233.GC3056@worktop>
 <20181112004528.GA4170@linux.ibm.com>
 <20181112005329.GG3056@worktop>
 <20181112014736.GB4170@linux.ibm.com>
 <20181112020710.GJ3056@worktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112020710.GJ3056@worktop>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18111202-0064-0000-0000-000003726D9E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010030; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116145; UDB=6.00577118; IPR=6.00896253;
 MB=3.00024116; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-12 02:24:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111202-0065-0000-0000-00003B4E0BED
Message-Id: <20181112022455.GD4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811120020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 03:07:10AM +0100, Peter Zijlstra wrote:
> On Sun, Nov 11, 2018 at 05:47:36PM -0800, Paul E. McKenney wrote:
> > On Mon, Nov 12, 2018 at 01:53:29AM +0100, Peter Zijlstra wrote:
> > > On Sun, Nov 11, 2018 at 04:45:28PM -0800, Paul E. McKenney wrote:
> > > > On Mon, Nov 12, 2018 at 01:12:33AM +0100, Peter Zijlstra wrote:
> > > > > On Sun, Nov 11, 2018 at 11:43:52AM -0800, Paul E. McKenney wrote:
> > > > > > Now that synchronize_rcu() waits for preempt-disable regions of code
> > > > > > as well as RCU read-side critical sections, synchronize_sched() can be
> > > > > > replaced by synchronize_rcu().  This commit therefore makes this change.
> > > > > 
> > > > > Yes, but it also waits for an actual RCU quiestent state, which makes
> > > > > synchoinize_rcu() potentially much more expensive than an actual
> > > > > synchronize_sched().
> > > > 
> > > > None of the readers have changed.
> > > > 
> > > > For the updaters, if CONFIG_PREEMPT=n, synchronize_rcu() and
> > > > synchronize_sched() always were one and the same.  When CONFIG_PREEMPT=y,
> > > > synchronize_rcu() and synchronize_sched() are now one and the same.
> > > 
> > > The Changelog does not state this; and does the commit that makes that
> > > happen state the regression potential?
> > 
> > The Changelog says this:
> > 
> > 	Now that synchronize_rcu() waits for preempt-disable
> > 	regions of code as well as RCU read-side critical sections,
> > 	synchronize_sched() can be replaced by synchronize_rcu().
> > 	This commit therefore makes this change.
> > 
> > The "synchronize_rcu() waits for preempt-disable regions of code as
> > well as RCU read-side critical sections" seems pretty unambiguous to me.
> > Exactly what more are you wanting said there?
> 
> The quoted bit only states that synchronize_rcu() is sufficient; it does
> not say it is equivalent and the patch is a nop. It also doesn't say
> that the purpose is to get rid of the synchronize_sched() function.
> 
> > There were quite a few commits involved in making this happen.  Perhaps
> > the most pertinent are these:
> > 
> > 3e3100989869 ("rcu: Defer reporting RCU-preempt quiescent states when disabled")
> > 45975c7d21a1 ("rcu: Define RCU-sched API in terms of RCU for Tree RCU PREEMPT builds")
> 
> The latter; it does not mention that this will possible make
> synchronize_sched() quite a bit more expensive on PREEMPT=y builds :/

In theory, sure.  In practice, people have switched any number of
things from RCU-sched to RCU and back without problems.

> > Normal grace periods are almost always quite long compared to typical
> > read-side critical sections, preempt-disable regions of code, and so on.
> > So in the common case this should be OK.  Or are you instead worried
> > about synchronize_sched_expedited()?
> 
> No, I still feel expedited should not exist at all ;-)

I figured as much.  ;-)

> But for PREEMPT=y synchronize_sched() can be quite a bit shorter than
> synchronize_rcu(), since we don't have to wait for preempted read side
> stuff.

Again, there are quite a few places that have managed that transition
without issue.  Why do you expect this change to have problems that have
not been seen elsewhere?

> > > > > So why are we doing this?
> > > > 
> > > > Given that synchronize_rcu() and synchronize_sched() are now always one
> > > > and the same, this is a distinction without a difference.
> > > 
> > > The Changelog did not state a reason for the patch. Therefore it is a
> > > bad patch.
> > 
> > ???  Here is the current definition of synchronize_sched() in mainline:
> > 
> > 	static inline void synchronize_sched(void)
> > 	{
> > 		synchronize_rcu();
> > 	}
> 
> Again, the patch didn't say that.
> 
> If the Changelog would've read something like:
> 
> "Since synchronize_sched() is now equivalent to synchronize_rcu(),
> replace the synchronize_sched() usage such that we can eventually remove
> the interface."
> 
> It would've been clear that the patch is a nop and what the purpose
> was.

I can easily make that change.

							Thanx, Paul

