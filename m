Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972FCECDE2B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629DD214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629DD214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeJQOqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:46:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727460AbeJQOqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:46:12 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9H6n1NV063109
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 02:52:00 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n5x40nn43-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 02:51:59 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 17 Oct 2018 07:51:57 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 17 Oct 2018 07:51:50 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9H6pnJx18087996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Oct 2018 06:51:50 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7E514C046;
        Wed, 17 Oct 2018 06:51:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14C444C040;
        Wed, 17 Oct 2018 06:51:46 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 17 Oct 2018 06:51:45 +0000 (GMT)
Date:   Wed, 17 Oct 2018 12:21:45 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH for 4.21 03/16] sched: Implement push_task_to_cpu (v2)
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
 <20181010191936.7495-4-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181010191936.7495-4-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18101706-0028-0000-0000-00000308889F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101706-0029-0000-0000-000023C39939
Message-Id: <20181017065145.GA7111@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810170062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

> +int push_task_to_cpu(struct task_struct *p, unsigned int dest_cpu)
> +{

In your use case, is the task going to be current?
If yes, we should simply be using migrate_task_to.

> +	struct rq_flags rf;
> +	struct rq *rq;
> +	int ret = 0;
> +
> +	rq = task_rq_lock(p, &rf);
> +	update_rq_clock(rq);
> +
> +	if (!cpumask_test_cpu(dest_cpu, &p->cpus_allowed)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}

Ideally we should have checked cpus_allowed/cpu_active_mask before taking
the lock. This would help reduce the contention on the rqlock when the
passed parameter is not correct.

> +
> +	if (!cpumask_test_cpu(dest_cpu, cpu_active_mask)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	if (task_cpu(p) == dest_cpu)
> +		goto out;

Same as above.

> +
> +	if (task_running(rq, p) || p->state == TASK_WAKING) {

Why are we using migration thread to move a task in TASK_WAKING state?

> +		struct migration_arg arg = { p, dest_cpu };
> +		/* Need help from migration thread: drop lock and wait. */
> +		task_rq_unlock(rq, p, &rf);
> +		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
> +		tlb_migrate_finish(p->mm);
> +		return 0;

Why cant we use migrate_task_to instead?

> +	} else if (task_on_rq_queued(p)) {
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 455fa330de04..27ad25780204 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1340,6 +1340,15 @@ static inline void __set_task_cpu(struct task_struct *p, unsigned int cpu)
>  #endif
>  }
>  
> +#ifdef CONFIG_SMP
> +int push_task_to_cpu(struct task_struct *p, unsigned int dest_cpu);
> +#else
> +static inline int push_task_to_cpu(struct task_struct *p, unsigned int dest_cpu)
> +{
> +	return 0;
> +}
> +#endif
> +

Your usecase is outside kernel/sched. So I am not sure if this is the right
place for the declaration.

