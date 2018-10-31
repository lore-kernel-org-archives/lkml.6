Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF766ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8ECB2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8ECB2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbeKACcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:32:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51642 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729896AbeKACcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:32:54 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9VHTJw6118927
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 13:33:55 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nfec100dk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 13:33:55 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 31 Oct 2018 17:33:54 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Oct 2018 17:33:50 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9VHXnIF33095830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Oct 2018 17:33:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 558FAB2066;
        Wed, 31 Oct 2018 17:33:49 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 239AAB206E;
        Wed, 31 Oct 2018 17:33:49 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.141])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 31 Oct 2018 17:33:49 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CFDB116C0BB2; Wed, 31 Oct 2018 10:33:49 -0700 (PDT)
Date:   Wed, 31 Oct 2018 10:33:49 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH RFC kenrel/rcu] Eliminate BUG_ON() for sync.c
Reply-To: paulmck@linux.ibm.com
References: <20181022145241.GA7488@linux.ibm.com>
 <20181022152406.GA7257@redhat.com>
 <20181022155644.GG4170@linux.ibm.com>
 <20181022161439.GA8640@redhat.com>
 <20181030175539.GL4170@linux.ibm.com>
 <20181031172604.GC21207@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031172604.GC21207@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18103117-0068-0000-0000-00000357301F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009960; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01110710; UDB=6.00575542; IPR=6.00890802;
 MB=3.00023981; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-31 17:33:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18103117-0069-0000-0000-00004644AA0B
Message-Id: <20181031173349.GF4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810310146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 06:26:05PM +0100, Oleg Nesterov wrote:
> On 10/30, Paul E. McKenney wrote:
> >
> > On Mon, Oct 22, 2018 at 06:14:40PM +0200, Oleg Nesterov wrote:
> > > > > ----------------------------------------------------------------------------
> > > > > Damn.
> > > > >
> > > > > This suddenly reminds me that I rewrote this code completely, and you even
> > > > > reviewed the new implementation and (iirc) acked it!
> > > > >
> > > > > However, I failed to force myself to rewrite the comments, and that is why
> > > > > I didn't send the "official" patch :/
> > > > >
> > > > > May be some time...
> > > >
> > > > Could you please point me at the last email thread?  Yes, I should be
> > > > able to find it, but I would probably get the wrong one.  :-/
> > >
> > > probably this one,
> > >
> > > 	[PATCH] rcu_sync: simplify the state machine, introduce __rcu_sync_enter()
> > > 	https://lkml.org/lkml/2016/7/16/150
> > >
> > > but I am not sure, will recheck tomorrow.
> >
> > Just following up...  Here is what I currently have.
> 
> Hmm. Are you sure you replied to the correct message? ;)
> 
> the patch below looks absolutely unrelated...

Oy...  Right message, wrong commit.

Does the one below look somewhat more relevant?  ;-)

							Thanx, Paul

------------------------------------------------------------------------

commit 10314fde6fcdbaaf7c21b539dd2db5933344344f
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Mon Oct 22 07:43:22 2018 -0700

    rcu: Eliminate BUG_ON() for sync.c
    
    The sync.c file has a number of calls to BUG_ON(), which panics the
    kernel, which is not a good strategy for devices (like embedded) that
    don't have a way to capture console output.  This commit therefore
    changes these BUG_ON() calls to WARN_ON_ONCE(), but does so quite naively.
    
    Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
    Cc: Oleg Nesterov <oleg@redhat.com>
    Cc: Peter Zijlstra <peterz@infradead.org>

diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index 3f943efcf61c..a6ba446a9693 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -125,8 +125,7 @@ void rcu_sync_enter(struct rcu_sync *rsp)
 		rsp->gp_state = GP_PENDING;
 	spin_unlock_irq(&rsp->rss_lock);
 
-	BUG_ON(need_wait && need_sync);
-
+	WARN_ON_ONCE(need_wait && need_sync);
 	if (need_sync) {
 		gp_ops[rsp->gp_type].sync();
 		rsp->gp_state = GP_PASSED;
@@ -139,7 +138,7 @@ void rcu_sync_enter(struct rcu_sync *rsp)
 		 * Nobody has yet been allowed the 'fast' path and thus we can
 		 * avoid doing any sync(). The callback will get 'dropped'.
 		 */
-		BUG_ON(rsp->gp_state != GP_PASSED);
+		WARN_ON_ONCE(rsp->gp_state != GP_PASSED);
 	}
 }
 
@@ -166,8 +165,8 @@ static void rcu_sync_func(struct rcu_head *rhp)
 	struct rcu_sync *rsp = container_of(rhp, struct rcu_sync, cb_head);
 	unsigned long flags;
 
-	BUG_ON(rsp->gp_state != GP_PASSED);
-	BUG_ON(rsp->cb_state == CB_IDLE);
+	WARN_ON_ONCE(rsp->gp_state != GP_PASSED);
+	WARN_ON_ONCE(rsp->cb_state == CB_IDLE);
 
 	spin_lock_irqsave(&rsp->rss_lock, flags);
 	if (rsp->gp_count) {
@@ -225,7 +224,7 @@ void rcu_sync_dtor(struct rcu_sync *rsp)
 {
 	int cb_state;
 
-	BUG_ON(rsp->gp_count);
+	WARN_ON_ONCE(rsp->gp_count);
 
 	spin_lock_irq(&rsp->rss_lock);
 	if (rsp->cb_state == CB_REPLAY)
@@ -235,6 +234,6 @@ void rcu_sync_dtor(struct rcu_sync *rsp)
 
 	if (cb_state != CB_IDLE) {
 		gp_ops[rsp->gp_type].wait();
-		BUG_ON(rsp->cb_state != CB_IDLE);
+		WARN_ON_ONCE(rsp->cb_state != CB_IDLE);
 	}
 }

