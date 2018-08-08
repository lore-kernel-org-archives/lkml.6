Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8B7C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA38521737
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA38521737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeHHRCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:02:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42304 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726954AbeHHRCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:02:06 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w78EdoSl062723
        for <linux-kernel@vger.kernel.org>; Wed, 8 Aug 2018 10:42:08 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kr08c6kq5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 10:42:08 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 8 Aug 2018 10:42:05 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Aug 2018 10:42:00 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w78Efx6216843144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Aug 2018 14:41:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3899B2065;
        Wed,  8 Aug 2018 10:41:23 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8240DB205F;
        Wed,  8 Aug 2018 10:41:23 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Aug 2018 10:41:23 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8096516C0727; Wed,  8 Aug 2018 07:42:00 -0700 (PDT)
Date:   Wed, 8 Aug 2018 07:42:00 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joelaf@google.com>,
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
References: <6D0A3FD6-2190-4CC0-A3C0-7B3759E73243@google.com>
 <20180807204820.50b83c6d@vmware.local.home>
 <CAJWu+oqBOEJicepLaUG=JpmtDTgxjRdMyJAgOEUkdk4NzX0esw@mail.gmail.com>
 <20180807215522.04114097@vmware.local.home>
 <CAJWu+opjqKgZj30PYpyvip=EtP8CuqaEy65++nuvj37QMT6GCw@mail.gmail.com>
 <20180807222856.3ede96e7@vmware.local.home>
 <CAJWu+oqcM_-rtuUe7hhMHyZ2UKZ5J4rBZO7UoHxxd2DAs=aHdA@mail.gmail.com>
 <CAJWu+oqPUuF4rFOQ8=G3+ZxXJxiiNRBYE8C=zZ93A8qA+muHEg@mail.gmail.com>
 <20180808130041.GI24813@linux.vnet.ibm.com>
 <20180808102700.38c4169d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808102700.38c4169d@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18080814-0072-0000-0000-0000038D74EE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009507; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01070983; UDB=6.00551365; IPR=6.00850513;
 MB=3.00022589; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-08 14:42:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080814-0073-0000-0000-000049026778
Message-Id: <20180808144200.GM24813@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808080152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 10:27:00AM -0400, Steven Rostedt wrote:
> On Wed, 8 Aug 2018 06:00:41 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > 
> > I suppose that an srcu_read_lock_nmi() and srcu_read_unlock_nmi() could
> > be added, which would do atomic ops on sp->sda->srcu_lock_count.  Not sure
> > whether this would be fast enough to be useful, but easy to provide:
> > 
> > int __srcu_read_lock_nmi(struct srcu_struct *sp)  /* UNTESTED. */
> > {
> > 	int idx;
> > 
> > 	idx = READ_ONCE(sp->srcu_idx) & 0x1;
> > 	atomic_inc(&sp->sda->srcu_lock_count[idx]);
> > 	smp_mb__after_atomic(); /* B */  /* Avoid leaking critical section. */
> > 	return idx;
> > }
> > 
> > void __srcu_read_unlock_nmi(struct srcu_struct *sp, int idx)
> > {
> > 	smp_mb__before_atomic(); /* C */  /* Avoid leaking critical section. */
> > 	atomic_inc(&sp->sda->srcu_unlock_count[idx]);
> > }
> > 
> > With appropriate adjustments to also allow Tiny RCU to also work.
> > 
> > Note that you have to use _nmi() everywhere, not just in NMI handlers.
> > In fact, the NMI handlers are the one place you -don't- need to use
> > _nmi(), strangely enough.
> > 
> > Might be worth a try -- smp_mb__{before,after}_atomic() is a no-op on
> > some architectures, for example.
> 
> Note this would kill the performance that srcu gives that Joel wants.
> Switching from a this_cpu_inc() to a atomic_inc() would be a huge
> impact.

I don't know how huge it would be, but that concern is exactly why I am
proposing adding _nmi() interfaces rather than just directly changing
the stock __srcu_read_lock() and __srcu_read_unlock() functions.

> There's also a local_inc() if you are using per cpu pointers, that is
> suppose to guarantee atomicity for single cpu operations. That's what
> the ftrace ring buffer uses.

Good point, that becomes atomic_long_inc() or equivalent on most
architectures, but an incl instruction (not locked) on x86.  So updating
my earlier still-untested thought:

int __srcu_read_lock_nmi(struct srcu_struct *sp)  /* UNTESTED. */
{
	int idx;

	idx = READ_ONCE(sp->srcu_idx) & 0x1;
	local_inc(&sp->sda->srcu_lock_count[idx]);
	smp_mb__after_atomic(); /* B */  /* Avoid leaking critical section. */
	return idx;
}

void __srcu_read_unlock_nmi(struct srcu_struct *sp, int idx)
{
	smp_mb__before_atomic(); /* C */  /* Avoid leaking critical section. */
	local_inc(&sp->sda->srcu_unlock_count[idx]);
}

Would that work, or is there a better way to handle this?

								Thanx, Paul

