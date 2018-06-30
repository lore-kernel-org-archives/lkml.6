Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A8DC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 17:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501A025419
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 17:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501A025419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbeF3RDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 13:03:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60650 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751155AbeF3RDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 13:03:19 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5UGwfa9053217
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 13:03:18 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jx46ng5kr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 13:03:18 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 30 Jun 2018 13:03:17 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 30 Jun 2018 13:03:14 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5UH3De88978900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 30 Jun 2018 17:03:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 425A9B206A;
        Sat, 30 Jun 2018 13:03:01 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F4DEB2067;
        Sat, 30 Jun 2018 13:03:01 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.206.224])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 30 Jun 2018 13:03:00 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C86F416C3F1E; Sat, 30 Jun 2018 10:05:22 -0700 (PDT)
Date:   Sat, 30 Jun 2018 10:05:22 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,oom: Bring OOM notifier callbacks to outside of OOM
 killer.
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180621073142.GA10465@dhcp22.suse.cz>
 <2d8c3056-1bc2-9a32-d745-ab328fd587a1@i-love.sakura.ne.jp>
 <20180626170345.GA3593@linux.vnet.ibm.com>
 <20180627072207.GB32348@dhcp22.suse.cz>
 <20180627143125.GW3593@linux.vnet.ibm.com>
 <20180628113942.GD32348@dhcp22.suse.cz>
 <20180628213105.GP3593@linux.vnet.ibm.com>
 <20180629090419.GD13860@dhcp22.suse.cz>
 <20180629125218.GX3593@linux.vnet.ibm.com>
 <20180629132638.GD5963@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629132638.GD5963@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18063017-0052-0000-0000-000003068259
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009284; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01054587; UDB=6.00540819; IPR=6.00832509;
 MB=3.00021942; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-30 17:03:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18063017-0053-0000-0000-00005D31DD36
Message-Id: <20180630170522.GZ3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806300200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 03:26:38PM +0200, Michal Hocko wrote:
> On Fri 29-06-18 05:52:18, Paul E. McKenney wrote:
> > On Fri, Jun 29, 2018 at 11:04:19AM +0200, Michal Hocko wrote:
> > > On Thu 28-06-18 14:31:05, Paul E. McKenney wrote:
> > > > On Thu, Jun 28, 2018 at 01:39:42PM +0200, Michal Hocko wrote:
> [...]
> > > > > Well, I am not really sure what is the objective of the oom notifier to
> > > > > point you to the right direction. IIUC you just want to kick callbacks
> > > > > to be handled sooner under a heavy memory pressure, right? How is that
> > > > > achieved? Kick a worker?
> > > > 
> > > > That is achieved by enqueuing a non-lazy callback on each CPU's callback
> > > > list, but only for those CPUs having non-empty lists.  This causes
> > > > CPUs with lists containing only lazy callbacks to be more aggressive,
> > > > in particular, it prevents such CPUs from hanging out idle for seconds
> > > > at a time while they have callbacks on their lists.
> > > > 
> > > > The enqueuing happens via an IPI to the CPU in question.
> > > 
> > > I am afraid this is too low level for my to understand what is going on
> > > here. What are lazy callbacks and why do they need any specific action
> > > when we are getting close to OOM? I mean, I do understand that we might
> > > have many callers of call_rcu and free memory lazily. But there is quite
> > > a long way before we start the reclaim until we reach the OOM killer path.
> > > So why don't those callbacks get called during that time period? How are
> > > their triggered when we are not hitting the OOM path? They surely cannot
> > > sit there for ever, right? Can we trigger them sooner? Maybe the
> > > shrinker is not the best fit but we have a retry feedback loop in the page
> > > allocator, maybe we can kick this processing from there.
> > 
> > The effect of RCU's current OOM code is to speed up callback invocation
> > by at most a few seconds (assuming no stalled CPUs, in which case
> > it is not possible to speed up callback invocation).
> > 
> > Given that, I should just remove RCU's OOM code entirely?
> 
> Yeah, it seems so. I do not see how this would really help much. If we
> really need some way to kick callbacks then we should do so much earlier
> in the reclaim process - e.g. when we start struggling to reclaim any
> memory.

One approach would be to tell RCU "It is time to trade CPU for memory"
at the beginning of that struggle and then tell RCU "Go back to optimizing
for CPU" at the end of that struggle.  Is there already a way to do this?
If so, RCU should probably just switch to it.

But what is the typical duration of such a struggle?  Does this duration
change with workload?  (I suspect that the answers are "who knows?" and
"yes", but you tell me!)  Are there other oom handlers that would prefer
the approach of the previous paragraph?

> I am curious. Has the notifier been motivated by a real world use case
> or it was "nice thing to do"?

It was introduced by b626c1b689364 ("rcu: Provide OOM handler to motivate
lazy RCU callbacks").  The motivation for this commit was a set of changes
that improved energy efficiency by making CPUs sleep for longer when all
of their pending callbacks were known to only free memory (as opposed
to doing a wakeup or some such).  Prior to this set of changes, a CPU
with callbacks would invoke those callbacks (thus freeing the memory)
within a jiffy or so of the end of a grace period.  After this set of
changes, a CPU might wait several seconds.  This was a concern to people
with small-memory systems, hence commit b626c1b689364.

							Thanx, Paul

