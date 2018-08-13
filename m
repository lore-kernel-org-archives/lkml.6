Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A9FC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C3821760
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C3821760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbeHMPYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:24:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728356AbeHMPYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:24:44 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7DCbhBg016484
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 08:42:36 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ku9622vq6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 08:42:36 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 13 Aug 2018 08:42:33 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 Aug 2018 08:42:30 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7DCgTcM2687286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Aug 2018 12:42:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 176DFB2065;
        Mon, 13 Aug 2018 08:41:47 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9DECB205F;
        Mon, 13 Aug 2018 08:41:46 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.219.61])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 13 Aug 2018 08:41:46 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3774416C0F5B; Mon, 13 Aug 2018 05:42:32 -0700 (PDT)
Date:   Mon, 13 Aug 2018 05:42:32 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     dave@stgolabs.net, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] kernel: rcu: a possible sleep-in-atomic-context bug in
 srcu_read_delay()
Reply-To: paulmck@linux.vnet.ibm.com
References: <4179b4d2-b832-abcd-d407-b865765f28d6@gmail.com>
 <20180813041826.GL24813@linux.vnet.ibm.com>
 <5b3fd721-541c-5165-ef54-d6c476318d92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b3fd721-541c-5165-ef54-d6c476318d92@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18081312-2213-0000-0000-000002DA1ADA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009535; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01072909; UDB=6.00552773; IPR=6.00852861;
 MB=3.00022688; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-13 12:42:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081312-2214-0000-0000-00005B2FAB4A
Message-Id: <20180813124232.GM24813@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808130137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 05:26:49PM +0800, Jia-Ju Bai wrote:
> 
> 
> On 2018/8/13 12:18, Paul E. McKenney wrote:
> >On Mon, Aug 13, 2018 at 11:04:10AM +0800, Jia-Ju Bai wrote:
> >>The kernel may sleep with holding a spinlock.
> >>
> >>The function call paths (from bottom to top) in Linux-4.16 are:
> >>
> >>[FUNC] schedule_timeout_interruptible
> >>kernel/rcu/rcutorture.c, 523: schedule_timeout_interruptible in
> >>srcu_read_delay
> >>kernel/rcu/rcutorture.c, 1105: [FUNC_PTR]srcu_read_delay in
> >>rcu_torture_timer
> >>kernel/rcu/rcutorture.c, 1104: spin_lock in rcu_torture_timer
> >>
> >>Note that [FUNC_PTR] means a function pointer call is used.
> >>
> >>I do not find a good way to fix, so I only report.
> >>This is found by my static analysis tool (DSAC).
> >Interesting.  I would have expected to have gotten a "scheduling while
> >atomic" error message, which I do not recall seeing.  And I ran a great
> >deal of rcutorture on v4.16.
> >
> >So let's see...  As you say, the rcu_torture_timer() function does in
> >fact acquire rand_lock in 4.16 and 4.17, in which case sleeping would
> >indeed be illegal.  But let's take a look at srcu_read_delay():
> >
> >static void
> >srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
> >{
> >	long delay;
> >	const long uspertick = 1000000 / HZ;
> >	const long longdelay = 10;
> >
> >	/* We want there to be long-running readers, but not all the time. */
> >
> >	delay = torture_random(rrsp) %
> >		(nrealreaders * 2 * longdelay * uspertick);
> >	if (!delay && in_task()) {
> >		schedule_timeout_interruptible(longdelay);
> >		rtrsp->rt_delay_jiffies = longdelay;
> >	} else {
> >		rcu_read_delay(rrsp, rtrsp);
> >	}
> >}
> >
> >The call to schedule_timeout_interruptible() cannot happen unless the
> >in_task() macro returns true, which it won't if the SOFTIRQ_OFFSET bit
> >is set:
> >
> >#define in_task()		(!(preempt_count() & \
> >				   (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
> >
> >And the SOFTIRQ_OFFSET bit will be set if srcu_read_delay()
> >is invoked from a timer handler, which is the case for the
> >call from rcu_torture_timer().  So if that lock is held,
> >schedule_timeout_interruptible() won't ever be invoked.
> 
> Thanks for your reply :)
> My tool does not track this bit...
> Sorry for this false report.

Not a problem, a few false positives are to be expected.  And it looks
like you have some work to do on your tool -- which is good, because I
would not want you to be bored.  ;-)

							Thanx, Paul

