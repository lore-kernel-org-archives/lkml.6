Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06767C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A001B219E8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A001B219E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbeHHPUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 11:20:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726971AbeHHPUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 11:20:24 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w78Cwp4K078164
        for <linux-kernel@vger.kernel.org>; Wed, 8 Aug 2018 09:00:48 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kqxdwxgsx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 09:00:48 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 8 Aug 2018 09:00:46 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Aug 2018 09:00:42 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w78D0f6b18743754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Aug 2018 13:00:41 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2607BB2066;
        Wed,  8 Aug 2018 09:00:05 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8634B2068;
        Wed,  8 Aug 2018 09:00:04 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.212.138])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Aug 2018 09:00:04 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 30E0B16C0722; Wed,  8 Aug 2018 06:00:41 -0700 (PDT)
Date:   Wed, 8 Aug 2018 06:00:41 -0700
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
References: <6B9E5DC9-0859-41B4-9B72-A7D85E9EA2AD@google.com>
 <20180807194515.4e549c1a@gandalf.local.home>
 <6D0A3FD6-2190-4CC0-A3C0-7B3759E73243@google.com>
 <20180807204820.50b83c6d@vmware.local.home>
 <CAJWu+oqBOEJicepLaUG=JpmtDTgxjRdMyJAgOEUkdk4NzX0esw@mail.gmail.com>
 <20180807215522.04114097@vmware.local.home>
 <CAJWu+opjqKgZj30PYpyvip=EtP8CuqaEy65++nuvj37QMT6GCw@mail.gmail.com>
 <20180807222856.3ede96e7@vmware.local.home>
 <CAJWu+oqcM_-rtuUe7hhMHyZ2UKZ5J4rBZO7UoHxxd2DAs=aHdA@mail.gmail.com>
 <CAJWu+oqPUuF4rFOQ8=G3+ZxXJxiiNRBYE8C=zZ93A8qA+muHEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+oqPUuF4rFOQ8=G3+ZxXJxiiNRBYE8C=zZ93A8qA+muHEg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18080813-0052-0000-0000-0000031B6A11
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009507; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01070960; UDB=6.00551345; IPR=6.00850479;
 MB=3.00022588; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-08 13:00:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080813-0053-0000-0000-00005DA82D42
Message-Id: <20180808130041.GI24813@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-08_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808080135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 08:53:54PM -0700, Joel Fernandes wrote:
> On Tue, Aug 7, 2018 at 8:44 PM, Joel Fernandes <joelaf@google.com> wrote:
> > Hi Steve,
> >
> > On Tue, Aug 7, 2018 at 7:28 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> [...]
> >>> @@ -171,8 +174,7 @@ extern void syscall_unregfunc(void);
> >>>                       } while ((++it_func_ptr)->func);                \
> >>>               }                                                       \
> >>>                                                                       \
> >>> -             if (rcuidle)                                            \
> >>> -                     srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
> >>> +             srcu_read_unlock_notrace(ss, idx);                      \
> >>
> >> Hmm, why do we have the two different srcu handles?
> >
> > Because if the memory operations happening on the normal SRCU handle
> > (during srcu_read_lock) is interrupted by NMI, then the other handle
> > (devoted to NMI) could be used instead and not bother the interrupted
> > handle. Does that makes sense?
> >
> > When I talked to Paul few months ago about SRCU from NMI context, he
> > mentioned the per-cpu memory operations during srcu_read_lock can be
> > NMI interrupted, that's why we added that warning.
> 
> So I looked more closely, __srcu_read_lock on 2 different handles may
> still be doing a this_cpu_inc on the same location..
> (sp->sda->srcu_lock_count). :-(
> 
> Paul any ideas on how to solve this?

You lost me on this one.  When you said "2 different handles", I assumed
that you meant two different values of "sp", which would have two
different addresses for &sp->sda->srcu_lock_count.  What am I missing?

> It does start to seem like a show stopper :-(

I suppose that an srcu_read_lock_nmi() and srcu_read_unlock_nmi() could
be added, which would do atomic ops on sp->sda->srcu_lock_count.  Not sure
whether this would be fast enough to be useful, but easy to provide:

int __srcu_read_lock_nmi(struct srcu_struct *sp)  /* UNTESTED. */
{
	int idx;

	idx = READ_ONCE(sp->srcu_idx) & 0x1;
	atomic_inc(&sp->sda->srcu_lock_count[idx]);
	smp_mb__after_atomic(); /* B */  /* Avoid leaking critical section. */
	return idx;
}

void __srcu_read_unlock_nmi(struct srcu_struct *sp, int idx)
{
	smp_mb__before_atomic(); /* C */  /* Avoid leaking critical section. */
	atomic_inc(&sp->sda->srcu_unlock_count[idx]);
}

With appropriate adjustments to also allow Tiny RCU to also work.

Note that you have to use _nmi() everywhere, not just in NMI handlers.
In fact, the NMI handlers are the one place you -don't- need to use
_nmi(), strangely enough.

Might be worth a try -- smp_mb__{before,after}_atomic() is a no-op on
some architectures, for example.

							Thanx, Paul

