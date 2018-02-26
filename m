Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbeBZV4Q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:56:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41210 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751716AbeBZV4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:56:11 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 5/5] rcu: Remove SRCU throttling
Date: Mon, 26 Feb 2018 13:56:32 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226215614.GA31616@linux.vnet.ibm.com>
References: <20180226215614.GA31616@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022621-0040-0000-0000-000003FD5C12
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995531; UDB=6.00506033; IPR=6.00774859;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 21:56:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022621-0041-0000-0000-000007FE6622
Message-Id: <1519682192-31987-5-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260275
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in srcu_gp_end() inserts a delay every 0x3ff grace periods in
order to prevent SRCU grace-period work from consuming an entire CPU
when there is a long sequence of expedited SRCU grace-period requests.
However, all of SRCU's grace-period work is carried out in workqueues,
which are in turn within kthreads, which are automatically throttled as
needed by the scheduler.  In particular, if there is plenty of idle time,
there is no point in throttling.

This commit therefore removes the expedited SRCU grace-period throttling.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/srcutree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index f962f4428c39..e2796f79a597 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -596,9 +596,7 @@ static void srcu_gp_end(struct srcu_struct *sp)
 	    ULONG_CMP_LT(gpseq, sp->srcu_gp_seq_needed)) {
 		srcu_gp_start(sp);
 		spin_unlock_irq_rcu_node(sp);
-		/* Throttle expedited grace periods: Should be rare! */
-		srcu_reschedule(sp, rcu_seq_ctr(gpseq) & 0x3ff
-				    ? 0 : SRCU_INTERVAL);
+		srcu_reschedule(sp, 0);
 	} else {
 		spin_unlock_irq_rcu_node(sp);
 	}
-- 
2.5.2
