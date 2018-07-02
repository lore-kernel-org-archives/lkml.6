Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CEFC6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 03:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6863325834
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 03:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6863325834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933390AbeGBDBK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 23:01:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51352 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932468AbeGBDBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 23:01:08 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w622wo8v091053
        for <linux-kernel@vger.kernel.org>; Sun, 1 Jul 2018 23:01:07 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jybgx8cqh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 23:01:07 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 1 Jul 2018 23:01:06 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 1 Jul 2018 23:01:02 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w62311UL18743598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jul 2018 03:01:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB872B2066;
        Sun,  1 Jul 2018 23:00:47 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A38A9B2072;
        Sun,  1 Jul 2018 23:00:47 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.206.224])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun,  1 Jul 2018 23:00:47 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 45A7C16CA314; Sun,  1 Jul 2018 20:03:13 -0700 (PDT)
Date:   Sun, 1 Jul 2018 20:03:13 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH RFC tip/core/rcu 1/2] rcu: Defer reporting RCU-preempt
 quiescent states when disabled
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180627204835.GA25456@linux.vnet.ibm.com>
 <20180627204915.27253-1-paulmck@linux.vnet.ibm.com>
 <20180701174045.GA111992@joelaf.mtv.corp.google.com>
 <20180701222501.GC3593@linux.vnet.ibm.com>
 <20180702003732.GB95395@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702003732.GB95395@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070203-0072-0000-0000-000003781DED
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009292; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01055266; UDB=6.00541227; IPR=6.00833188;
 MB=3.00021955; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-02 03:01:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070203-0073-0000-0000-0000488ED626
Message-Id: <20180702030313.GH3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807020034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 05:37:32PM -0700, Joel Fernandes wrote:
> On Sun, Jul 01, 2018 at 03:25:01PM -0700, Paul E. McKenney wrote:
> [...]
> > > > @@ -602,6 +589,66 @@ static void rcu_read_unlock_special(struct task_struct *t)
> > > >  	}
> > > >  }
> > > >  
> > > > +/*
> > > > + * Is a deferred quiescent-state pending, and are we also not in
> > > > + * an RCU read-side critical section?  It is the caller's responsibility
> > > > + * to ensure it is otherwise safe to report any deferred quiescent
> > > > + * states.  The reason for this is that it is safe to report a
> > > > + * quiescent state during context switch even though preemption
> > > > + * is disabled.  This function cannot be expected to understand these
> > > > + * nuances, so the caller must handle them.
> > > > + */
> > > > +static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
> > > > +{
> > > > +	return (this_cpu_ptr(&rcu_preempt_data)->deferred_qs ||
> > > > +		READ_ONCE(t->rcu_read_unlock_special.s)) &&
> > > > +	       !t->rcu_read_lock_nesting;
> > > > +}
> > > > +
> > > > +/*
> > > > + * Report a deferred quiescent state if needed and safe to do so.
> > > > + * As with rcu_preempt_need_deferred_qs(), "safe" involves only
> > > > + * not being in an RCU read-side critical section.  The caller must
> > > > + * evaluate safety in terms of interrupt, softirq, and preemption
> > > > + * disabling.
> > > > + */
> > > > +static void rcu_preempt_deferred_qs(struct task_struct *t)
> > > > +{
> > > > +	unsigned long flags;
> > > > +
> > > > +	if (!rcu_preempt_need_deferred_qs(t))
> > > > +		return;
> > > > +	local_irq_save(flags);
> > > > +	rcu_preempt_deferred_qs_irqrestore(t, flags);
> > > > +}
> > > > +
> > > > +/*
> > > > + * Handle special cases during rcu_read_unlock(), such as needing to
> > > > + * notify RCU core processing or task having blocked during the RCU
> > > > + * read-side critical section.
> > > > + */
> > > > +static void rcu_read_unlock_special(struct task_struct *t)
> > > > +{
> > > > +	unsigned long flags;
> > > > +	bool preempt_bh_were_disabled = !!(preempt_count() & ~HARDIRQ_MASK);
> > > 
> > > Would it be better to just test for those bits just to be safe the higher
> > > order bits don't bleed in, such as PREEMPT_NEED_RESCHED, something like the
> > > following based on the 'dev' branch?
> > 
> > Good point!  My plan is to merge it into the original commit with
> > attribution.  Please let me know if you have objections.
> > 
> 
> Sure! That sounds good to me.

Very good, I now have a "squash" commit queued, thank you!

							Thanx, Paul

