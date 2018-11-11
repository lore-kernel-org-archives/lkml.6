Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB914C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BDD2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BDD2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbeKLF6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:58:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731360AbeKLF6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:58:35 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABK8fVi102723
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:09:06 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2npd3uu4va-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:09:06 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 20:09:05 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 20:08:59 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABK8vBf45613166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 20:08:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE62CB206C;
        Sun, 11 Nov 2018 20:08:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9FC0B2067;
        Sun, 11 Nov 2018 20:08:57 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 20:08:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EE2D816C5D5F; Sun, 11 Nov 2018 12:08:58 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Dennis Krein <Dennis.Krein@netapp.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH tip/core/rcu 3/4] srcu: Lock srcu_data structure in srcu_gp_start()
Date:   Sun, 11 Nov 2018 12:08:56 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111200834.GA10983@linux.ibm.com>
References: <20181111200834.GA10983@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111120-0064-0000-0000-00000372302E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116027; UDB=6.00577118; IPR=6.00896127;
 MB=3.00024115; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 20:09:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111120-0065-0000-0000-00003B4D4B6B
Message-Id: <20181111200857.11711-3-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dennis Krein <Dennis.Krein@netapp.com>

The srcu_gp_start() function is called with the srcu_struct structure's
->lock held, but not with the srcu_data structure's ->lock.  This is
problematic because this function accesses and updates the srcu_data
structure's ->srcu_cblist, which is protected by that lock.  Failing to
hold this lock can result in corruption of the SRCU callback lists,
which in turn can result in arbitrarily bad results.

This commit therefore makes srcu_gp_start() acquire the srcu_data
structure's ->lock across the calls to rcu_segcblist_advance() and
rcu_segcblist_accelerate(), thus preventing this corruption.

Reported-by: Bart Van Assche <bvanassche@acm.org>
Reported-by: Christoph Hellwig <hch@infradead.org>
Reported-by: Sebastian Kuzminsky <seb.kuzminsky@gmail.com>
Signed-off-by: Dennis Krein <Dennis.Krein@netapp.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Tested-by: Dennis Krein <Dennis.Krein@netapp.com>
Cc: <stable@vger.kernel.org> # 4.12.x
---
 kernel/rcu/srcutree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 60f3236beaf7..697a2d7e8e8a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -451,10 +451,12 @@ static void srcu_gp_start(struct srcu_struct *sp)
 
 	lockdep_assert_held(&ACCESS_PRIVATE(sp, lock));
 	WARN_ON_ONCE(ULONG_CMP_GE(sp->srcu_gp_seq, sp->srcu_gp_seq_needed));
+	spin_lock_rcu_node(sdp);  /* Interrupts already disabled. */
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&sp->srcu_gp_seq));
 	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
 				       rcu_seq_snap(&sp->srcu_gp_seq));
+	spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
 	smp_mb(); /* Order prior store to ->srcu_gp_seq_needed vs. GP start. */
 	rcu_seq_start(&sp->srcu_gp_seq);
 	state = rcu_seq_state(READ_ONCE(sp->srcu_gp_seq));
-- 
2.17.1

