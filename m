Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7488DC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E4F20645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E4F20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbeJVXLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:11:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727554AbeJVXLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:11:42 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9MEn91w055722
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 10:52:48 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n9ghkrjb2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 10:52:48 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 22 Oct 2018 10:52:47 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 22 Oct 2018 10:52:43 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9MEqgGx27197648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Oct 2018 14:52:42 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15D9FB2066;
        Mon, 22 Oct 2018 14:52:42 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E62F0B205F;
        Mon, 22 Oct 2018 14:52:41 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.169.161])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 22 Oct 2018 14:52:41 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8C63216C35F5; Mon, 22 Oct 2018 07:52:41 -0700 (PDT)
Date:   Mon, 22 Oct 2018 07:52:41 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     oleg@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: [PATCH RFC kenrel/rcu] Eliminate BUG_ON() for sync.c
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18102214-0072-0000-0000-000003B9D3F0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009916; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01106373; UDB=6.00572935; IPR=6.00886457;
 MB=3.00023857; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-22 14:52:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102214-0073-0000-0000-000049D7F1A0
Message-Id: <20181022145241.GA7488@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-22_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=772 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810220127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sync.c file has a number of calls to BUG_ON(), which panics the
kernel, which is not a good strategy for devices (like embedded) that
don't have a way to capture console output.  This commit therefore
changes these BUG_ON() calls to WARN_ON_ONCE(), but does so quite naively.

Improved changes welcome.  ;-)

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>

diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index 3f943efcf61c..28ac78ba0656 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -125,12 +125,12 @@ void rcu_sync_enter(struct rcu_sync *rsp)
 		rsp->gp_state = GP_PENDING;
 	spin_unlock_irq(&rsp->rss_lock);
 
-	BUG_ON(need_wait && need_sync);
-
 	if (need_sync) {
 		gp_ops[rsp->gp_type].sync();
 		rsp->gp_state = GP_PASSED;
 		wake_up_all(&rsp->gp_wait);
+		if (WARN_ON_ONCE(need_wait))
+			wait_event(rsp->gp_wait, rsp->gp_state == GP_PASSED);
 	} else if (need_wait) {
 		wait_event(rsp->gp_wait, rsp->gp_state == GP_PASSED);
 	} else {
@@ -139,7 +139,7 @@ void rcu_sync_enter(struct rcu_sync *rsp)
 		 * Nobody has yet been allowed the 'fast' path and thus we can
 		 * avoid doing any sync(). The callback will get 'dropped'.
 		 */
-		BUG_ON(rsp->gp_state != GP_PASSED);
+		WARN_ON_ONCE(rsp->gp_state != GP_PASSED);
 	}
 }
 
@@ -166,8 +166,8 @@ static void rcu_sync_func(struct rcu_head *rhp)
 	struct rcu_sync *rsp = container_of(rhp, struct rcu_sync, cb_head);
 	unsigned long flags;
 
-	BUG_ON(rsp->gp_state != GP_PASSED);
-	BUG_ON(rsp->cb_state == CB_IDLE);
+	WARN_ON_ONCE(rsp->gp_state != GP_PASSED);
+	WARN_ON_ONCE(rsp->cb_state == CB_IDLE);
 
 	spin_lock_irqsave(&rsp->rss_lock, flags);
 	if (rsp->gp_count) {
@@ -225,7 +225,7 @@ void rcu_sync_dtor(struct rcu_sync *rsp)
 {
 	int cb_state;
 
-	BUG_ON(rsp->gp_count);
+	WARN_ON_ONCE(rsp->gp_count);
 
 	spin_lock_irq(&rsp->rss_lock);
 	if (rsp->cb_state == CB_REPLAY)
@@ -235,6 +235,6 @@ void rcu_sync_dtor(struct rcu_sync *rsp)
 
 	if (cb_state != CB_IDLE) {
 		gp_ops[rsp->gp_type].wait();
-		BUG_ON(rsp->cb_state != CB_IDLE);
+		WARN_ON_ONCE(rsp->cb_state != CB_IDLE);
 	}
 }

