Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0035C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8813C21A53
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8813C21A53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbeHHWkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 18:40:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729625AbeHHWkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 18:40:16 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w78KEIoI136900
        for <linux-kernel@vger.kernel.org>; Wed, 8 Aug 2018 16:18:59 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kr3d1t7mw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 16:18:59 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 8 Aug 2018 16:18:57 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Aug 2018 16:18:52 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w78KIpRK62587080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Aug 2018 20:18:51 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A5FBB2065;
        Wed,  8 Aug 2018 16:18:15 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCD37B205F;
        Wed,  8 Aug 2018 16:18:14 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Aug 2018 16:18:14 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 664CD16C1014; Wed,  8 Aug 2018 13:18:52 -0700 (PDT)
Date:   Wed, 8 Aug 2018 13:18:52 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Joel Fernandes <joelaf@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v12 3/3] tracing: Centralize preemptirq tracepoints and
 unify their usage
Reply-To: paulmck@linux.vnet.ibm.com
References: <CAJWu+oqBOEJicepLaUG=JpmtDTgxjRdMyJAgOEUkdk4NzX0esw@mail.gmail.com>
 <20180807215522.04114097@vmware.local.home>
 <CAJWu+opjqKgZj30PYpyvip=EtP8CuqaEy65++nuvj37QMT6GCw@mail.gmail.com>
 <20180807222856.3ede96e7@vmware.local.home>
 <CAJWu+oqcM_-rtuUe7hhMHyZ2UKZ5J4rBZO7UoHxxd2DAs=aHdA@mail.gmail.com>
 <CAJWu+oqPUuF4rFOQ8=G3+ZxXJxiiNRBYE8C=zZ93A8qA+muHEg@mail.gmail.com>
 <20180808130041.GI24813@linux.vnet.ibm.com>
 <CAJWu+oopkDMe9AtuiRqAubuPk_H=NSifTDpWLdgCTEvR6zZiMw@mail.gmail.com>
 <20180808144922.GN24813@linux.vnet.ibm.com>
 <CAJWu+orf_LipWwo30OX+gZwHS1v5QWub4BHgrA6zQ7d4K+i6ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+orf_LipWwo30OX+gZwHS1v5QWub4BHgrA6zQ7d4K+i6ew@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18080820-0068-0000-0000-00000325B5B2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009508; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01071059; UDB=6.00551432; IPR=6.00850625;
 MB=3.00022594; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-08 20:18:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080820-0069-0000-0000-000045533724
Message-Id: <20180808201852.GZ24813@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808080204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 12:24:20PM -0700, Joel Fernandes wrote:
> On Wed, Aug 8, 2018 at 7:49 AM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> [...]
> >
> >> In that case based on what you're saying, the patch I sent to using
> >> different srcu_struct for NMI is still good I guess...
> >
> > As long as you wait for both SRCU grace periods.  Hmmm...  Maybe that means
> > that there is still a use for synchronize_rcu_mult():
> >
> >         void call_srcu_nmi(struct rcu_head *rhp, rcu_callback_t func)
> >         {
> >                 call_srcu(&trace_srcu_struct_nmi, rhp, func);
> >         }
> >
> >         void call_srcu_nonmi(struct rcu_head *rhp, rcu_callback_t func)
> >         {
> >                 call_srcu(&trace_srcu_struct_nonmi, rhp, func);
> >         }
> >
> >         ...
> >
> >         /* Wait concurrently on the two grace periods. */
> >         synchronize_rcu_mult(call_srcu_nmi, call_srcu_nonmi);
> >
> > On the other hand, I bet that doing this is just fine in your use case:
> >
> >         synchronize_srcu(&trace_srcu_struct_nmi);
> >         synchronize_srcu(&trace_srcu_struct_nonmi);
> >
> > But please note that synchronize_rcu_mult() is no more in my -rcu tree,
> > so if you do want it please let me know (and please let me know why it
> > is important).
> 
> I did the chaining thing (one callback calling another), that should
> work too right? I believe that is needed so that the tracepoint
> callbacks are freed at one point and only when both NMI and non-NMI
> read sections have completed.

Yes, that works also.  It is possible to make that happen concurrently
via atomic_dec_and_test() or similar, but if the latency is not a problem,
why bother?

> >> >> It does start to seem like a show stopper :-(
> >> >
> >> > I suppose that an srcu_read_lock_nmi() and srcu_read_unlock_nmi() could
> >> > be added, which would do atomic ops on sp->sda->srcu_lock_count.  Not sure
> >> > whether this would be fast enough to be useful, but easy to provide:
> >> >
> >> > int __srcu_read_lock_nmi(struct srcu_struct *sp)  /* UNTESTED. */
> >> > {
> >> >         int idx;
> >> >
> >> >         idx = READ_ONCE(sp->srcu_idx) & 0x1;
> >> >         atomic_inc(&sp->sda->srcu_lock_count[idx]);
> >> >         smp_mb__after_atomic(); /* B */  /* Avoid leaking critical section. */
> >> >         return idx;
> >> > }
> >> >
> >> > void __srcu_read_unlock_nmi(struct srcu_struct *sp, int idx)
> >> > {
> >> >         smp_mb__before_atomic(); /* C */  /* Avoid leaking critical section. */
> >> >         atomic_inc(&sp->sda->srcu_unlock_count[idx]);
> >> > }
> >> >
> >> > With appropriate adjustments to also allow Tiny RCU to also work.
> >> >
> >> > Note that you have to use _nmi() everywhere, not just in NMI handlers.
> >> > In fact, the NMI handlers are the one place you -don't- need to use
> >> > _nmi(), strangely enough.
> >> >
> >> > Might be worth a try -- smp_mb__{before,after}_atomic() is a no-op on
> >> > some architectures, for example.
> >>
> >> Continuing Steve's question on regular interrupts, do we need to use
> >> this atomic_inc API for regular interrupts as well? So I guess
> >
> > If NMIs use one srcu_struct and non-NMI uses another, the current
> > srcu_read_lock() and srcu_read_unlock() will work just fine.  If any given
> > srcu_struct needs both NMI and non-NMI readers, then we really do need
> > __srcu_read_lock_nmi() and __srcu_read_unlock_nmi() for that srcu_struct.
> 
> Yes, I believe as long as in_nmi() works reliably, we can use the
> right srcu_struct (NMI vs non-NMI) and it would be fine.
> 
> Going through this thread, it sounds though that this_cpu_inc may not
> be reliable on all architectures even for non-NMI interrupts and
> local_inc may be the way to go.

My understanding is that this_cpu_inc() is defined to handle interrupts,
so any architecture on which it is unreliable needs to fix its bug.  ;-)

> For next merge window (not this one), lets do that then? Paul, if you
> could provide me an SRCU API that uses local_inc, then I believe that
> coupled with this patch should be all that's needed:
> https://lore.kernel.org/patchwork/patch/972657/
> 
> Steve did express concern though if in_nmi() works reliably (i.e.
> tracepoint doesn't fire from "thunk" code before in_nmi() is
> available). Any thoughts on that Steve?

Agreed, not the upcoming merge window.  But we do need to work out
exactly what is the right way to do this.

							Thanx, Paul

