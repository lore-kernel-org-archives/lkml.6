Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B2BC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2002089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2002089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeJCEx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:53:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725744AbeJCEx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:53:26 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w92M43xm087286
        for <linux-kernel@vger.kernel.org>; Tue, 2 Oct 2018 18:07:54 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mvfb8c05u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 18:07:54 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 2 Oct 2018 18:07:53 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Oct 2018 18:07:48 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w92M7m1047251636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Oct 2018 22:07:48 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BABDBB206C;
        Tue,  2 Oct 2018 18:05:59 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B271B2068;
        Tue,  2 Oct 2018 18:05:59 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.172])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Oct 2018 18:05:59 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8764016C0E9D; Tue,  2 Oct 2018 15:07:48 -0700 (PDT)
Date:   Tue, 2 Oct 2018 15:07:48 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC 1/2] sched/core: Convert synchronize_rcu_mult to
 synchronize_rcu
Reply-To: paulmck@linux.ibm.com
References: <20181002012012.13133-1-joel@joelfernandes.org>
 <20181002033801.GP4222@linux.ibm.com>
 <20181002212019.GC89166@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002212019.GC89166@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18100222-0068-0000-0000-000003464D64
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009811; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01096972; UDB=6.00567268; IPR=6.00877014;
 MB=3.00023593; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-02 22:07:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100222-0069-0000-0000-000045EF5AFB
Message-Id: <20181002220748.GM4222@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-02_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810020205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 02:20:19PM -0700, Joel Fernandes wrote:
> On Mon, Oct 01, 2018 at 08:38:01PM -0700, Paul E. McKenney wrote:
> > On Mon, Oct 01, 2018 at 06:20:11PM -0700, Joel Fernandes wrote:
> > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > 
> > > synchronize_rcu_mult is now obsolete since all the different RCU flavors
> > > have been consolidated and the API is now common on the updater side.
> > > sched/core.c is the only user of it. All call_rcu_<flavor> calls boil
> > > down to the same call_rcu. So there's no point in calling
> > > synchronize_rcu_mult infact it could potentially be slower due to
> > > waiting for the call_rcu callback twice. Just call synchronize_rcu here
> > > which should do the job.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > Well, the theory was that I was going to keep this series hidden until
> > the consolidation hit mainline just to avoid confusion, but please see
> > 5fc9d4e000b1 ("rcu: Eliminate synchronize_rcu_mult()"), which I just
> > now pushed to -rcu.  To your credit, you did get most of it.  ;-)
> 
> Glad you already took care of that ;-) I should have taken a peek at rcu/test
> branch :D

You wouldn't have seen anything before yesterday, so no worries!

> > Here is the full list:
> > 
> > pick 1f3e6eaed8fa Apply coccinelle script to consolidate calls to RCU-bh and RCU-sched
> > pick 5fc9d4e000b1 rcu: Eliminate synchronize_rcu_mult()
> > pick a8475496801e rcu: Consolidate the RCU update functions invoked by sync.c
> > pick d8ffb03461ad sched/membarrier: Replace synchronize_sched() with synchronize_rcu()
> > 
> > Of course, I will need to rerun the coccinelle script and split the
> > result across subsystems, but I am waiting until the current pull
> > request hits mainline.  Let's face it, none of us need to do debugging
> > on someone consolidating their RCU updates before at least this commit
> > and its predecessors hit mainline:
> > 
> > 709fdce7545c ("rcu: Express Tiny RCU updates in terms of RCU rather than RCU-sched")
> > 
> > I sent the pull request to Ingo a few days ago, so with some luck this
> > will all get to mainline during the next merge window, and then it is
> > open season on outside-of-RCU cleanups.  ;-)
> 
> Cool, thanks,

And Ingo did pull it, and you should have been CCed on a few of the
-tip notifications.  ;-)

							Thanx, Paul

