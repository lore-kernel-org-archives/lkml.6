Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492CEC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83DE21990
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83DE21990
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbeHIBJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 21:09:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727530AbeHIBJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 21:09:11 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w78MiSg7055581
        for <linux-kernel@vger.kernel.org>; Wed, 8 Aug 2018 18:47:23 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kr72hd742-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 18:47:23 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 8 Aug 2018 18:47:21 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Aug 2018 18:47:16 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w78MlFLn7733604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Aug 2018 22:47:15 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A0CBB2064;
        Wed,  8 Aug 2018 18:46:39 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD529B205F;
        Wed,  8 Aug 2018 18:46:38 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Aug 2018 18:46:38 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B560A16C3967; Wed,  8 Aug 2018 15:47:16 -0700 (PDT)
Date:   Wed, 8 Aug 2018 15:47:16 -0700
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
References: <CAJWu+opjqKgZj30PYpyvip=EtP8CuqaEy65++nuvj37QMT6GCw@mail.gmail.com>
 <20180807222856.3ede96e7@vmware.local.home>
 <CAJWu+oqcM_-rtuUe7hhMHyZ2UKZ5J4rBZO7UoHxxd2DAs=aHdA@mail.gmail.com>
 <CAJWu+oqPUuF4rFOQ8=G3+ZxXJxiiNRBYE8C=zZ93A8qA+muHEg@mail.gmail.com>
 <20180808130041.GI24813@linux.vnet.ibm.com>
 <CAJWu+oopkDMe9AtuiRqAubuPk_H=NSifTDpWLdgCTEvR6zZiMw@mail.gmail.com>
 <20180808144922.GN24813@linux.vnet.ibm.com>
 <CAJWu+orf_LipWwo30OX+gZwHS1v5QWub4BHgrA6zQ7d4K+i6ew@mail.gmail.com>
 <20180808201852.GZ24813@linux.vnet.ibm.com>
 <CAJWu+op0H9vry70YXx6x3e37Sxsgb45go7B9MmE-y2O5wdLOYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+op0H9vry70YXx6x3e37Sxsgb45go7B9MmE-y2O5wdLOYg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18080822-0052-0000-0000-0000031BC4FB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009509; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01071095; UDB=6.00551462; IPR=6.00850675;
 MB=3.00022597; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-08 22:47:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080822-0053-0000-0000-00005DA97F26
Message-Id: <20180808224716.GE24813@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808080226
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 03:15:31PM -0700, Joel Fernandes wrote:
> On Wed, Aug 8, 2018 at 1:18 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> [...]
> >> >> >> It does start to seem like a show stopper :-(
> >> >> >
> >> >> > I suppose that an srcu_read_lock_nmi() and srcu_read_unlock_nmi() could
> >> >> > be added, which would do atomic ops on sp->sda->srcu_lock_count.  Not sure
> >> >> > whether this would be fast enough to be useful, but easy to provide:
> >> >> >
> >> >> > int __srcu_read_lock_nmi(struct srcu_struct *sp)  /* UNTESTED. */
> >> >> > {
> >> >> >         int idx;
> >> >> >
> >> >> >         idx = READ_ONCE(sp->srcu_idx) & 0x1;
> >> >> >         atomic_inc(&sp->sda->srcu_lock_count[idx]);
> >> >> >         smp_mb__after_atomic(); /* B */  /* Avoid leaking critical section. */
> >> >> >         return idx;
> >> >> > }
> >> >> >
> >> >> > void __srcu_read_unlock_nmi(struct srcu_struct *sp, int idx)
> >> >> > {
> >> >> >         smp_mb__before_atomic(); /* C */  /* Avoid leaking critical section. */
> >> >> >         atomic_inc(&sp->sda->srcu_unlock_count[idx]);
> >> >> > }
> >> >> >
> >> >> > With appropriate adjustments to also allow Tiny RCU to also work.
> >> >> >
> >> >> > Note that you have to use _nmi() everywhere, not just in NMI handlers.
> >> >> > In fact, the NMI handlers are the one place you -don't- need to use
> >> >> > _nmi(), strangely enough.
> >> >> >
> >> >> > Might be worth a try -- smp_mb__{before,after}_atomic() is a no-op on
> >> >> > some architectures, for example.
> >> >>
> >> >> Continuing Steve's question on regular interrupts, do we need to use
> >> >> this atomic_inc API for regular interrupts as well? So I guess
> >> >
> >> > If NMIs use one srcu_struct and non-NMI uses another, the current
> >> > srcu_read_lock() and srcu_read_unlock() will work just fine.  If any given
> >> > srcu_struct needs both NMI and non-NMI readers, then we really do need
> >> > __srcu_read_lock_nmi() and __srcu_read_unlock_nmi() for that srcu_struct.
> >>
> >> Yes, I believe as long as in_nmi() works reliably, we can use the
> >> right srcu_struct (NMI vs non-NMI) and it would be fine.
> >>
> >> Going through this thread, it sounds though that this_cpu_inc may not
> >> be reliable on all architectures even for non-NMI interrupts and
> >> local_inc may be the way to go.
> >
> > My understanding is that this_cpu_inc() is defined to handle interrupts,
> > so any architecture on which it is unreliable needs to fix its bug.  ;-)
> 
> Yes that's my understanding as well.
> 
> Then may be I'm missing something about yours/Steve's conversations in
> the morning, about why we need bother with the local_inc then. So the
> current SRCU code with the separate NMI handle should work fine (for
> future merge windows) as long as we're using a separate srcu_struct
> for NMI. :-)

I do believe that to be true.  But only as long as that separate
srcu_struct is -only- used for NMI.

If this is what you have been pushing for all along, please accept my
apologies for my being slow!

That said, your approach does require you to have a perfect way to
distinguish between NMI and not-NMI.  If the distinguishing is even
in the slightest imperfect, then some sort of NMI-safe SRCU reader
approach is of course required.

							Thanx, Paul

> >> For next merge window (not this one), lets do that then? Paul, if you
> >> could provide me an SRCU API that uses local_inc, then I believe that
> >> coupled with this patch should be all that's needed:
> >> https://lore.kernel.org/patchwork/patch/972657/
> >>
> >> Steve did express concern though if in_nmi() works reliably (i.e.
> >> tracepoint doesn't fire from "thunk" code before in_nmi() is
> >> available). Any thoughts on that Steve?
> >
> > Agreed, not the upcoming merge window.  But we do need to work out
> > exactly what is the right way to do this.
> 
> Agreed, thanks!
> 
>  - Joel
> 

