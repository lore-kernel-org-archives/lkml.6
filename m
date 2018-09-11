Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0970EC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92D82086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92D82086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbeIKWCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:02:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37042 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726782AbeIKWCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:02:44 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8BGxZdp029710
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 13:02:29 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2meet3gabr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 13:02:28 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 11 Sep 2018 13:02:27 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Sep 2018 13:02:23 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8BH2MJ328049568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Sep 2018 17:02:22 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2400FB2066;
        Tue, 11 Sep 2018 13:01:02 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED953B2068;
        Tue, 11 Sep 2018 13:01:01 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 11 Sep 2018 13:01:01 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D93CC16C366F; Tue, 11 Sep 2018 10:02:22 -0700 (PDT)
Date:   Tue, 11 Sep 2018 10:02:22 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, tj@kernel.org
Subject: Re: [PATCH] rcu: Use cpus_read_lock() while looking at
 cpu_online_mask
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180910135615.tr3cvipwbhq6xug4@linutronix.de>
 <20180911160532.GJ4225@linux.vnet.ibm.com>
 <20180911162142.cc3vgook2gctus4c@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180911162142.cc3vgook2gctus4c@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18091117-0052-0000-0000-0000032EBF69
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009703; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01086838; UDB=6.00561168; IPR=6.00866849;
 MB=3.00023233; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-11 17:02:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091117-0053-0000-0000-00005E093777
Message-Id: <20180911170222.GO4225@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=860 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809110168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 06:21:42PM +0200, Sebastian Andrzej Siewior wrote:
> On 2018-09-11 09:05:32 [-0700], Paul E. McKenney wrote:
> > On Mon, Sep 10, 2018 at 03:56:16PM +0200, Sebastian Andrzej Siewior wrote:
> > > It was possible that sync_rcu_exp_select_cpus() enqueued something on
> > > CPU0 while CPU0 was offline. Such a work item wouldn't be processed
> > > until CPU0 gets back online. This problem was addressed in commit
> > > fcc6354365015 ("rcu: Make expedited GPs handle CPU 0 being offline"). I
> > > don't think the issue fully addressed.
> > > 
> > > Assume grplo = 0 and grphi = 7 and sync_rcu_exp_select_cpus() is invoked
> > > on CPU1. The preempt_disable() section on CPU1 won't ensure that CPU0
> > > remains online between looking at cpu_online_mask and invoking
> > > queue_work_on() on CPU1.
> > > 
> > > Use cpus_read_lock() to ensure that `cpu' is not going down between
> > > looking at cpu_online_mask at invoking queue_work_on() and waiting for
> > > its completion. It is added around the loop + flush_work() which is
> > > similar to work_on_cpu_safe() (and we can have multiple jobs running on
> > > NUMA systems).
> > 
> > Is this experimental or theoretical?
> 
> theoretical. I saw that hunk on RT and I can't have queue_work() within
> a preempt_disable() section here.

OK, I feel better now.  ;-)

> > If theoretical, the counter-theory
> > is that the stop-machine processing prevents any of the cpu_online_mask
> > bits from changing, though, yes, we would like to get rid of the
> > stop-machine processing.  So either way, yes, the current state could
> > use some improvement.
> > 
> > But one problem with the patch below is that sync_rcu_exp_select_cpus()
> > can be called while the cpu_hotplug_lock is write-held.  Or is that
> > somehow OK these days?  
> 
> depends. Is it okay to wait until the write-lock is dropped? If it is,
> then it is okay. If not…

The problem is that people wait for grace periods within CPU hotplug
notifiers, so the lock won't be dropped until long after that notifier
returns.

> > Assuming not, how about the (untested) patch
> > below?
> 
> Doesn't work for me because it is still within the preempt-disable
> section :/.
> Would it work to use WORK_CPU_UNBOUND? As far as I understand it, the
> CPU number does not matter, you just want to spread it across multiple
> CPUs in the NUMA case.

Locality is a good thing, but yes, something like this?

	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && /* or whatever it is called */
	    unlikely(cpu > rnp->grphi - rnp->grplo))

Another approach that might be better longer term would be to have a
workqueue interface that treats the specified CPU as a suggestion,
and silently switches to WORK_CPU_UNBOUND if there is any problem
whatsoever with the specified CPU.  Tejun, Lai, thoughts?

> > commit 5214cbbfe6a5d6b92c76c4e411a049fe57245d4a
> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Date:   Tue Sep 11 08:57:48 2018 -0700
> > 
> >     rcu: Stop expedited grace periods from relying on stop-machine
> >     
> >     The CPU-selection code in sync_rcu_exp_select_cpus() disables preemption
> >     to prevent the cpu_online_mask from changing.  However, this relies on
> >     the stop-machine mechanism in the CPU-hotplug offline code, which is not
> >     desirable (it would be good to someday remove the stop-machine mechanism).
> 
> not that I tested it, but I still don't understand how a
> preempt_disable() section on CPU1 can ensure that CPU3 won't go down. Is
> there some code that invokes stop_cpus() for each CPU or so?

Yes, there is a stop_machine_cpuslocked() in takedown_cpu().

There is also a synchronize_rcu_mult(call_rcu, call_rcu_sched) in
sched_cpu_deactivate().

The old code relies on the stop_machine_cpuslocked() and my proposed
patch relies on the synchronize_rcu_mult().

							Thanx, Paul

