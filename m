Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D32C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4F82080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4F82080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbeKLF6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:58:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48176 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726374AbeKLF6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:58:33 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABK8bnd102531
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:09:03 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2npd3uu4ta-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:09:03 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 20:09:03 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 20:08:58 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABK8vra3867112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 20:08:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3FFCB206B;
        Sun, 11 Nov 2018 20:08:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B18B7B2064;
        Sun, 11 Nov 2018 20:08:57 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 20:08:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E728B16C5D1B; Sun, 11 Nov 2018 12:08:58 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 2/4] srcu: Prevent __call_srcu() counter wrap with read-side critical section
Date:   Sun, 11 Nov 2018 12:08:55 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111200834.GA10983@linux.ibm.com>
References: <20181111200834.GA10983@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111120-0060-0000-0000-000002D0FDC2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116027; UDB=6.00578737; IPR=6.00896127;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 20:09:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111120-0061-0000-0000-0000472A0F8B
Message-Id: <20181111200857.11711-2-paulmck@linux.ibm.com>
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

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

Ever since cdf7abc4610a ("srcu: Allow use of Tiny/Tree SRCU from
both process and interrupt context"), it has been permissible
to use SRCU read-side critical sections in interrupt context.
This allows __call_srcu() to use SRCU read-side critical sections to
prevent a new SRCU grace period from ending before the call to either
srcu_funnel_gp_start() or srcu_funnel_exp_start completes, thus preventing
SRCU grace-period counter overflow during that time.

Note that this does not permit removal of the counter-wrap checks in
srcu_gp_end().  These check are necessary to handle the case where
a given CPU does not interact at all with SRCU for an extended time
period.

This commit therefore adds an SRCU read-side critical section to
__call_srcu() in order to prevent grace period counter wrap during
the funnel-locking process.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/srcutree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index a8846ed7f352..60f3236beaf7 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -858,6 +858,7 @@ void __call_srcu(struct srcu_struct *sp, struct rcu_head *rhp,
 		 rcu_callback_t func, bool do_norm)
 {
 	unsigned long flags;
+	int idx;
 	bool needexp = false;
 	bool needgp = false;
 	unsigned long s;
@@ -871,6 +872,7 @@ void __call_srcu(struct srcu_struct *sp, struct rcu_head *rhp,
 		return;
 	}
 	rhp->func = func;
+	idx = srcu_read_lock(sp);
 	local_irq_save(flags);
 	sdp = this_cpu_ptr(sp->sda);
 	spin_lock_rcu_node(sdp);
@@ -892,6 +894,7 @@ void __call_srcu(struct srcu_struct *sp, struct rcu_head *rhp,
 		srcu_funnel_gp_start(sp, sdp, s, do_norm);
 	else if (needexp)
 		srcu_funnel_exp_start(sp, sdp->mynode, s);
+	srcu_read_unlock(sp, idx);
 }
 
 /**
-- 
2.17.1

