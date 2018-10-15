Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB20C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D5B2089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D5B2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeJPAWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:22:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52656 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbeJPAWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:22:07 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9FGTEuk068397
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 12:36:08 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n4wv421ra-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 12:36:08 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 15 Oct 2018 12:36:06 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Oct 2018 12:36:03 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9FGa2vf32374984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Oct 2018 16:36:02 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B73FDB2064;
        Mon, 15 Oct 2018 12:33:57 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86935B2067;
        Mon, 15 Oct 2018 12:33:57 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.109])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 15 Oct 2018 12:33:57 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A8B9416C3403; Mon, 15 Oct 2018 09:36:06 -0700 (PDT)
Date:   Mon, 15 Oct 2018 09:36:06 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, riel@redhat.com
Subject: Re: [PATCH] rcu: Use cpus_read_lock() while looking at
 cpu_online_mask
Reply-To: paulmck@linux.ibm.com
References: <20180911162142.cc3vgook2gctus4c@linutronix.de>
 <20180911170222.GO4225@linux.vnet.ibm.com>
 <20180919205521.GE902964@devbig004.ftw2.facebook.com>
 <20180919221140.GH4222@linux.ibm.com>
 <20181012184114.w332lnkc34evd4sm@linutronix.de>
 <20181013134813.GD2674@linux.ibm.com>
 <20181015144217.nu5cp5mxlboyjbre@linutronix.de>
 <20181015150715.GA2422@tardis>
 <20181015150902.asifwhikqkz53ai4@linutronix.de>
 <20181015153348.GB8952@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015153348.GB8952@tardis>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18101516-0040-0000-0000-00000480D983
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009880; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01103087; UDB=6.00570945; IPR=6.00883139;
 MB=3.00023765; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-15 16:36:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101516-0041-0000-0000-00000888EEC2
Message-Id: <20181015163606.GW2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810150146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 11:33:48PM +0800, Boqun Feng wrote:
> On Mon, Oct 15, 2018 at 05:09:03PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2018-10-15 23:07:15 [+0800], Boqun Feng wrote:
> > > Hi, Sebastian
> > Hi Boqun,
> > 
> > > On Mon, Oct 15, 2018 at 04:42:17PM +0200, Sebastian Andrzej Siewior wrote:
> > > > On 2018-10-13 06:48:13 [-0700], Paul E. McKenney wrote:
> > > > > 
> > > > > My concern would be that it would queue it by default for the current
> > > > > CPU, which would serialize the processing, losing the concurrency of
> > > > > grace-period initialization.  But that was a long time ago, and perhaps
> > > > > workqueues have changed. 
> > > > 
> > > > but the code here is always using the first CPU of a NUMA node or did I
> > > > miss something?
> > > > 
> > > 
> > > The thing is the original way is to pick one CPU for a *RCU* node to
> > > run the grace-period work, but with your proposal, if a RCU node is
> > > smaller than a NUMA node (having fewer CPUs), we could end up having two
> > > grace-period works running on one CPU. I think that's Paul's concern.
> > 
> > Ah. Okay. From what I observed, the RCU nodes and NUMA nodes were 1:1
> > here. Noted.
> 
> Ok, in that case, there should be no significant performance difference.
> 
> > Given that I can enqueue a work item on an offlined CPU I don't see why
> > commit fcc6354365015 ("rcu: Make expedited GPs handle CPU 0 being
> > offline") should make a difference. Any objections to just revert it?
> 
> Well, that commit is trying to avoid queue a work on an offlined CPU,
> because according to workqueue API, it's the users' responsibility to
> make sure the CPU is online when a work item enqueued. So there is a
> difference ;-)
> 
> But I don't have any objection to revert it with your proposal, since
> yours is more simple and straight-forward, and doesn't perform worse if
> NUMA nodes and RCU nodes have one-to-one corresponding.
> 
> Besides, I think even if we observe some performance difference in the
> future, the best way to solve that is to make workqueue have a more
> fine-grained affine group than a NUMA node.

Please keep in mind that there are computer systems out there with NUMA
topologies that are completely incompatible with RCU's rcu_node tree
structure.  According to Rik van Riel (CCed), there are even systems
out there where CPU 0 is on socket 0, CPU 1 on socket 1, and so on,
round-robining across the sockets.

The system that convinced me that the additional constraints on
the workqueue's CPU had CPUs 0-7 on one socket and CPUs 8-15 on the
second, and with CPUs 0-15 sharing the same leaf rcu_node structure.
Unfortunately, I no longer have useful access to this system (dead disk
drive, apparently).

I am not saying that Sebastian's approach is bad, rather that it does
need to be tested on a variety of systems.

							Thanx, Paul

> Regards,
> Boqun
> 
> > 
> > > Regards,
> > > Boqun
> > 
> > Sebastian


