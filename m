Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4721EC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CE32175F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CE32175F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeHHSYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:24:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727081AbeHHSYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:24:16 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w78FxfqE127415
        for <linux-kernel@vger.kernel.org>; Wed, 8 Aug 2018 12:03:57 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kr1gfppus-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 12:03:56 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 8 Aug 2018 12:03:56 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Aug 2018 12:03:50 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w78G3nmY10748392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Aug 2018 16:03:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DDEAB2064;
        Wed,  8 Aug 2018 12:03:13 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D1F0B205F;
        Wed,  8 Aug 2018 12:03:13 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Aug 2018 12:03:13 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 85A7316C0FCF; Wed,  8 Aug 2018 09:03:50 -0700 (PDT)
Date:   Wed, 8 Aug 2018 09:03:50 -0700
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
References: <CAJWu+oqBOEJicepLaUG=JpmtDTgxjRdMyJAgOEUkdk4NzX0esw@mail.gmail.com>
 <20180807215522.04114097@vmware.local.home>
 <CAJWu+opjqKgZj30PYpyvip=EtP8CuqaEy65++nuvj37QMT6GCw@mail.gmail.com>
 <20180807222856.3ede96e7@vmware.local.home>
 <CAJWu+oqcM_-rtuUe7hhMHyZ2UKZ5J4rBZO7UoHxxd2DAs=aHdA@mail.gmail.com>
 <CAJWu+oqPUuF4rFOQ8=G3+ZxXJxiiNRBYE8C=zZ93A8qA+muHEg@mail.gmail.com>
 <20180808130041.GI24813@linux.vnet.ibm.com>
 <20180808102700.38c4169d@gandalf.local.home>
 <20180808144200.GM24813@linux.vnet.ibm.com>
 <20180808112705.22e6a96d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808112705.22e6a96d@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18080816-0060-0000-0000-0000029A8A83
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009507; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01070999; UDB=6.00551382; IPR=6.00850540;
 MB=3.00022590; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-08 16:03:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080816-0061-0000-0000-00004619A84F
Message-Id: <20180808160350.GR24813@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-08_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808080163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 11:27:05AM -0400, Steven Rostedt wrote:
> On Wed, 8 Aug 2018 07:42:00 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > > There's also a local_inc() if you are using per cpu pointers, that is
> > > suppose to guarantee atomicity for single cpu operations. That's what
> > > the ftrace ring buffer uses.  
> > 
> > Good point, that becomes atomic_long_inc() or equivalent on most
> > architectures, but an incl instruction (not locked) on x86.  So updating
> > my earlier still-untested thought:
> > 
> > int __srcu_read_lock_nmi(struct srcu_struct *sp)  /* UNTESTED. */
> > {
> > 	int idx;
> > 
> > 	idx = READ_ONCE(sp->srcu_idx) & 0x1;
> > 	local_inc(&sp->sda->srcu_lock_count[idx]);
> > 	smp_mb__after_atomic(); /* B */  /* Avoid leaking critical section. */
> > 	return idx;
> > }
> > 
> > void __srcu_read_unlock_nmi(struct srcu_struct *sp, int idx)
> > {
> > 	smp_mb__before_atomic(); /* C */  /* Avoid leaking critical section. */
> > 	local_inc(&sp->sda->srcu_unlock_count[idx]);
> > }
> > 
> > Would that work, or is there a better way to handle this?
> 
> This would work much better than using the atomic ops, and I think it
> would be doable.

OK, here is hoping!

> I may need to revert the srcu for trace_*_rcidle() for now, as I want
> most of the other changes in this merge window, and it's getting too
> late to do it with these updates.

Agreed, especially since I normally freeze for the next merge window
shortly after -rc5.  ;-)

							Thanx, Paul

