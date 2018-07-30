Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A643616256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676BA20857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676BA20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbeG3SuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:50:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726762AbeG3SuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:50:15 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6UH8miF146737
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 13:14:16 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kj3w8rt75-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 13:14:16 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 30 Jul 2018 13:14:15 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Jul 2018 13:14:12 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6UHEBrG13631822
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Jul 2018 17:14:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EBA8B2067;
        Mon, 30 Jul 2018 13:13:46 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 713B8B205F;
        Mon, 30 Jul 2018 13:13:46 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 30 Jul 2018 13:13:46 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3B9C416CA4A8; Mon, 30 Jul 2018 10:14:14 -0700 (PDT)
Date:   Mon, 30 Jul 2018 10:14:14 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC tip/core/rcu] Avoid resched_cpu() when rescheduling
 the current CPU
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180727154931.GA12106@linux.vnet.ibm.com>
 <20180730092513.GD2494@hirez.programming.kicks-ass.net>
 <20180730145933.GX24813@linux.vnet.ibm.com>
 <20180730164247.GN2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730164247.GN2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18073017-0040-0000-0000-00000455B72E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009458; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01068147; UDB=6.00549071; IPR=6.00846250;
 MB=3.00022408; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-30 17:14:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18073017-0041-0000-0000-0000085BF13D
Message-Id: <20180730171414.GY24813@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=816 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807300186
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 06:42:47PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 30, 2018 at 07:59:33AM -0700, Paul E. McKenney wrote:
> 
> > > Something that might be more in line with
> > > resched_curr(smp_processor_id()) would be:
> > > 
> > > 	preempt_disable();
> > > 	if (!test_tsk_need_resched(current)) {
> > > 		set_tsk_need_resched(current);
> > > 		set_preempt_need_resched();
> > > 	}
> > > 	preempt_enable();
> > > 
> > > Where the preempt_enable() could of course instantly trigger the
> > > reschedule if it was the outer most one.
> > 
> > Ah.  So should I use resched_curr() from rcu_check_callbacks(), which
> > is invoked from the scheduling-clock interrupt?  Right now I have calls
> > to set_tsk_need_resched() and set_preempt_need_resched().
> > 
> > > > @@ -2674,10 +2675,12 @@ static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused
> > > 
> > > > -		resched_cpu(rdp->cpu); /* Provoke future context switch. */
> > > 
> > > > +		set_tsk_need_resched(current);
> > > > +		set_preempt_need_resched();
> > > 
> > > That's not obviously correct. rdp->cpu had better be smp_processor_id().
> > 
> > At the beginning of the function, we have:
> > 
> > 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
> > 
> > And this is in a softirq handler, so we are OK.
> 
> Agreed.
> 
> > > > @@ -672,7 +672,8 @@ static void sync_rcu_exp_handler(void *unused)
> > > >  			rcu_report_exp_rdp(rdp);
> > > >  		} else {
> > > >  			rdp->deferred_qs = true;
> > > > -			resched_cpu(rdp->cpu);
> > > > +			set_tsk_need_resched(t);
> > > > +			set_preempt_need_resched();
> > > 
> > > That only works if @t == current.
> > 
> > At the beginning of the function, we have:
> > 
> > 	struct task_struct *t = current;
> > 
> > So we should be OK.
> 
> Ah, the scheduler and locking code typically use to call that curr, to
> be more explicit that it is the current task.

I cargo-culted the "t" from somewhere a very long time ago, and of course
I have no idea from where.  Now I have hundreds of them in RCU.  :-/

Then again, if I am to change, doing it now when I have other full-source
changes makes sense...

> > Should I be instead using resched_curr() on some or all of these?
> 
> If, as it seems is the case, they are all targeting the current cpu and
> have (soft) interrupts disabled, then what you propose is indeed fine.

Very good, I will leave them as is, then.  Thank you for the review!
May I add your Reviewed-by, Acked-by, or some such?

							Thanx, Paul

