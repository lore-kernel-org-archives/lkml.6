Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142CEC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58CD2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfA1Wj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:39:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726906AbfA1Wj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 17:39:58 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0SMYBqK110834
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 17:39:57 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qa9gkkgjd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 17:39:56 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 28 Jan 2019 22:39:55 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 28 Jan 2019 22:39:49 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0SMdmwF11337808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jan 2019 22:39:48 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8A0AB2065;
        Mon, 28 Jan 2019 22:39:48 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C5ADB2064;
        Mon, 28 Jan 2019 22:39:48 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.57])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jan 2019 22:39:48 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8B62E16C62B9; Mon, 28 Jan 2019 14:39:48 -0800 (PST)
Date:   Mon, 28 Jan 2019 14:39:48 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Jann Horn <jannh@google.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128220707.30774-1-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19012822-0060-0000-0000-000003020DB4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010495; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01153174; UDB=6.00601187; IPR=6.00933536;
 MB=3.00025329; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-28 22:39:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012822-0061-0000-0000-00004818586D
Message-Id: <20190128223948.GD4240@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-28_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901280166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 05:07:07PM -0500, Mathieu Desnoyers wrote:
> Jann Horn identified a racy access to p->mm in the global expedited
> command of the membarrier system call.
> 
> The suggested fix is to hold the task_lock() around the accesses to
> p->mm and to the mm_struct membarrier_state field to guarantee the
> existence of the mm_struct.
> 
> Link: https://lore.kernel.org/lkml/CAG48ez2G8ctF8dHS42TF37pThfr3y0RNOOYTmxvACm4u8Yu3cw@mail.gmail.com
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Tested-by: Jann Horn <jannh@google.com>
> CC: Jann Horn <jannh@google.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Peter Zijlstra (Intel) <peterz@infradead.org>
> CC: Ingo Molnar <mingo@kernel.org>
> CC: Andrea Parri <parri.andrea@gmail.com>
> CC: Andy Lutomirski <luto@kernel.org>
> CC: Avi Kivity <avi@scylladb.com>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Boqun Feng <boqun.feng@gmail.com>
> CC: Dave Watson <davejwatson@fb.com>
> CC: David Sehr <sehr@google.com>
> CC: H. Peter Anvin <hpa@zytor.com>
> CC: Linus Torvalds <torvalds@linux-foundation.org>
> CC: Maged Michael <maged.michael@gmail.com>
> CC: Michael Ellerman <mpe@ellerman.id.au>
> CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> CC: Paul Mackerras <paulus@samba.org>
> CC: Russell King <linux@armlinux.org.uk>
> CC: Will Deacon <will.deacon@arm.com>
> CC: stable@vger.kernel.org # v4.16+
> CC: linux-api@vger.kernel.org
> ---
>  kernel/sched/membarrier.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> index 76e0eaf4654e..305fdcc4c5f7 100644
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -81,12 +81,27 @@ static int membarrier_global_expedited(void)
> 
>  		rcu_read_lock();
>  		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
> -		if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
> -				   MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
> -			if (!fallback)
> -				__cpumask_set_cpu(cpu, tmpmask);
> -			else
> -				smp_call_function_single(cpu, ipi_mb, NULL, 1);
> +		/*
> +		 * Skip this CPU if the runqueue's current task is NULL or if
> +		 * it is a kernel thread.
> +		 */
> +		if (p && READ_ONCE(p->mm)) {
> +			bool mm_match;
> +
> +			/*
> +			 * Read p->mm and access membarrier_state while holding
> +			 * the task lock to ensure existence of mm.
> +			 */
> +			task_lock(p);
> +			mm_match = p->mm && (atomic_read(&p->mm->membarrier_state) &

Are we guaranteed that this p->mm will be the same as the one loaded via
READ_ONCE() above?  Either way, wouldn't it be better to READ_ONCE() it a
single time and use the same value everywhere?

							Thanx, Paul

> +					     MEMBARRIER_STATE_GLOBAL_EXPEDITED);
> +			task_unlock(p);
> +			if (mm_match) {
> +				if (!fallback)
> +					__cpumask_set_cpu(cpu, tmpmask);
> +				else
> +					smp_call_function_single(cpu, ipi_mb, NULL, 1);
> +			}
>  		}
>  		rcu_read_unlock();
>  	}
> -- 
> 2.17.1
> 

