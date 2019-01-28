Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECD8C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2582214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfA1XWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:22:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45598 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727136AbfA1XWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:22:44 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0SNIrjn157943
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 18:22:43 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qa817s9y9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 18:22:43 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 28 Jan 2019 23:22:43 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 28 Jan 2019 23:22:37 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0SNMaO017498302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Jan 2019 23:22:36 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF3F4B2068;
        Mon, 28 Jan 2019 23:22:36 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B924B2064;
        Mon, 28 Jan 2019 23:22:36 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.57])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jan 2019 23:22:36 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9935A16C62B9; Mon, 28 Jan 2019 15:22:36 -0800 (PST)
Date:   Mon, 28 Jan 2019 15:22:36 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Jann Horn <jannh@google.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Avi Kivity <avi@scylladb.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, David Sehr <sehr@google.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Maged Michael <maged.michael@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] Fix: membarrier: racy access to p->mm in
 membarrier_global_expedited()
Reply-To: paulmck@linux.ibm.com
References: <20190128220707.30774-1-mathieu.desnoyers@efficios.com>
 <20190128223948.GD4240@linux.ibm.com>
 <CAG48ez1+Vx7=ZqeLJ0waceSneCQhEcoS=bv9ggb3Dbveb+W6AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1+Vx7=ZqeLJ0waceSneCQhEcoS=bv9ggb3Dbveb+W6AQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19012823-0072-0000-0000-000003F14363
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010495; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01153188; UDB=6.00601196; IPR=6.00933550;
 MB=3.00025329; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-28 23:22:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012823-0073-0000-0000-00004AFA88E5
Message-Id: <20190128232236.GG4240@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-28_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901280171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 11:45:32PM +0100, Jann Horn wrote:
> On Mon, Jan 28, 2019 at 11:39 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > On Mon, Jan 28, 2019 at 05:07:07PM -0500, Mathieu Desnoyers wrote:
> > > Jann Horn identified a racy access to p->mm in the global expedited
> > > command of the membarrier system call.
> > >
> > > The suggested fix is to hold the task_lock() around the accesses to
> > > p->mm and to the mm_struct membarrier_state field to guarantee the
> > > existence of the mm_struct.
> > >
> > > Link: https://lore.kernel.org/lkml/CAG48ez2G8ctF8dHS42TF37pThfr3y0RNOOYTmxvACm4u8Yu3cw@mail.gmail.com
> > > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> [...]
> > > --- a/kernel/sched/membarrier.c
> > > +++ b/kernel/sched/membarrier.c
> > > @@ -81,12 +81,27 @@ static int membarrier_global_expedited(void)
> > >
> > >               rcu_read_lock();
> > >               p = task_rcu_dereference(&cpu_rq(cpu)->curr);
> > > -             if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
> > > -                                MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
> > > -                     if (!fallback)
> > > -                             __cpumask_set_cpu(cpu, tmpmask);
> > > -                     else
> > > -                             smp_call_function_single(cpu, ipi_mb, NULL, 1);
> > > +             /*
> > > +              * Skip this CPU if the runqueue's current task is NULL or if
> > > +              * it is a kernel thread.
> > > +              */
> > > +             if (p && READ_ONCE(p->mm)) {
> > > +                     bool mm_match;
> > > +
> > > +                     /*
> > > +                      * Read p->mm and access membarrier_state while holding
> > > +                      * the task lock to ensure existence of mm.
> > > +                      */
> > > +                     task_lock(p);
> > > +                     mm_match = p->mm && (atomic_read(&p->mm->membarrier_state) &
> >
> > Are we guaranteed that this p->mm will be the same as the one loaded via
> > READ_ONCE() above?
> 
> No; the way I read it, that's just an optimization and has no effect
> on correctness.
> 
> > Either way, wouldn't it be better to READ_ONCE() it a
> > single time and use the same value everywhere?
> 
> No; the first READ_ONCE() returns a pointer that you can't access
> because it wasn't read under a lock. You can only use it for a NULL
> check.

Ah, of course!  Thank you both!

							Thanx, Paul

