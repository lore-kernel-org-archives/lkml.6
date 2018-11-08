Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9825ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79673204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79673204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeKIEZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:25:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726860AbeKIEZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:25:41 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8IiVSp021589
        for <linux-kernel@vger.kernel.org>; Thu, 8 Nov 2018 13:48:52 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nmpqhbspf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 13:48:51 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 8 Nov 2018 18:48:51 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Nov 2018 18:48:49 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA8ImmWG42074264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 18:48:48 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 393D4B2066;
        Thu,  8 Nov 2018 18:48:48 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18DF5B205F;
        Thu,  8 Nov 2018 18:48:48 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.215.156])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Nov 2018 18:48:48 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B8A0F16C17EB; Thu,  8 Nov 2018 10:48:47 -0800 (PST)
Date:   Thu, 8 Nov 2018 10:48:47 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: srcu: use cpu_online() instead custom check
Reply-To: paulmck@linux.ibm.com
References: <20181101231228.GA9118@linux.ibm.com>
 <20181108163850.sjedoaom64tzvqgc@linutronix.de>
 <20181108171024.GM4170@linux.ibm.com>
 <20181108174655.mnm3cr4wn2hrrtep@linutronix.de>
 <20181108180517.GR4170@linux.ibm.com>
 <20181108181630.nsr3cyjwsch2y2r5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108181630.nsr3cyjwsch2y2r5@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110818-0064-0000-0000-00000370DC87
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010009; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000269; SDB=6.01114564; UDB=6.00577118; IPR=6.00894663;
 MB=3.00024077; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-08 18:48:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110818-0065-0000-0000-00003B45602E
Message-Id: <20181108184847.GT4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 07:16:30PM +0100, Sebastian Andrzej Siewior wrote:
> On 2018-11-08 10:05:17 [-0800], Paul E. McKenney wrote:
> > Just to make sure I understand, this is the call to queue_delayed_work_on()
> > from srcu_queue_delayed_work_on(), right?
> 
> correct.
> 
> > And if I am guessing correctly, you would like to get rid of the
> > constraint requiring CPUHP_RCUTREE_PREP to precede CPUHP_TIMERS_PREPARE?
> 
> no, my problem is the preempt_disable() around queue_delayed_work_on().
> If the CPUs goes offline _after_ queue_delayed_work_on() then the timer
> gets migrated and work item should show up on another CPU. 
> If the CPU is offline at queue_delayed_work_on() time then the timer
> gets enqueued and won't fire until the CPU is back online and I *think*
> that is the reason behind this "is CPU online" check.

The main reason for the "is CPU online" check was that workqueues would
very rarely splat when I tried running without it.  I did report this
to Tejun.  You could try just calling queue_delayed_work_on() without
the check, but this is a 10s of hours rcutorture splat if I remember
correctly.

> > If so, the swait_event_idle_timeout_exclusive() in rcu_gp_fqs_loop()
> > in kernel/rcu/tree.c also requires this ordering.  There are probably
> > other pieces of code needing this.
> > 
> > Plus the reason for running this on a specific CPU is that the workqueue
> > item is processing that CPU's per-CPU variables, including invoking that
> > CPU's callbacks.  The item is srcu_invoke_callbacks().
> 
> The SRCU callback is invoking per-CPU variables? Like this_cpu_ptr()?
> But if the CPU is offline then you fallback to queue_delayed_work()?

Yes, yes, and yes.  ;-)

The callbacks are queued on a per-CPU basis.

							Thanx, Paul

