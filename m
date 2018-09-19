Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66638C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4102146E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4102146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732905AbeITDvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:51:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56956 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727983AbeITDvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:51:46 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8JM9FvR052860
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 18:11:46 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mkudfgrqn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 18:11:46 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 19 Sep 2018 18:11:45 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Sep 2018 18:11:42 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8JMBfmE25100298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Sep 2018 22:11:41 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E626EB2068;
        Wed, 19 Sep 2018 18:10:09 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C69B8B2065;
        Wed, 19 Sep 2018 18:10:09 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 19 Sep 2018 18:10:09 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D605B16C0E72; Wed, 19 Sep 2018 15:11:40 -0700 (PDT)
Date:   Wed, 19 Sep 2018 15:11:40 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: Use cpus_read_lock() while looking at
 cpu_online_mask
Reply-To: paulmck@linux.ibm.com
References: <20180910135615.tr3cvipwbhq6xug4@linutronix.de>
 <20180911160532.GJ4225@linux.vnet.ibm.com>
 <20180911162142.cc3vgook2gctus4c@linutronix.de>
 <20180911170222.GO4225@linux.vnet.ibm.com>
 <20180919205521.GE902964@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919205521.GE902964@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18091922-0072-0000-0000-000003A5E847
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009736; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01090767; UDB=6.00563531; IPR=6.00870787;
 MB=3.00023396; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-19 22:11:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091922-0073-0000-0000-0000497A482D
Message-Id: <20180919221140.GH4222@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-19_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=996 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809190214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 01:55:21PM -0700, Tejun Heo wrote:
> Hello,
> 
> On Tue, Sep 11, 2018 at 10:02:22AM -0700, Paul E. McKenney wrote:
> > > Doesn't work for me because it is still within the preempt-disable
> > > section :/.
> > > Would it work to use WORK_CPU_UNBOUND? As far as I understand it, the
> > > CPU number does not matter, you just want to spread it across multiple
> > > CPUs in the NUMA case.
> > 
> > Locality is a good thing, but yes, something like this?
> > 
> > 	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && /* or whatever it is called */
> > 	    unlikely(cpu > rnp->grphi - rnp->grplo))
> > 
> > Another approach that might be better longer term would be to have a
> > workqueue interface that treats the specified CPU as a suggestion,
> > and silently switches to WORK_CPU_UNBOUND if there is any problem
> > whatsoever with the specified CPU.  Tejun, Lai, thoughts?
> 
> Unbound workqueue is NUMA-affine by default, so using it by default
> might not harm anything.

OK, so the above workaround would function correctly on -rt, thank you!

Sebastian, is there a counterpart to CONFIG_PREEMPT_RT already in
mainline?  If so, I would be happy to make mainline safe for -rt.

>                           Also, per-cpu work items get unbound from
> the cpu if the cpu goes down while the work item is running or queued,
> so it might just work already.

There are race conditions where the work item is queued at an inopportune
time during the offline process, resulting in a splat, hence the need
for a check with preemption disabled in order to synchronize with the
synchronize_sched() in the offline process.

							Thanx, Paul

