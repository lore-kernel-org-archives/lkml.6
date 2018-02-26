Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeBZVyY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:54:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50958 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751429AbeBZVwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:52:53 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        Ildar Ismagilov <devix84@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 16/20] rcu: Fix misprint in srcu_funnel_exp_start
Date: Mon, 26 Feb 2018 13:53:06 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226215219.GA27379@linux.vnet.ibm.com>
References: <20180226215219.GA27379@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022621-0056-0000-0000-0000042458A6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995530; UDB=6.00506033; IPR=6.00774858;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 21:52:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022621-0057-0000-0000-00000866621E
Message-Id: <1519681990-31349-16-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260274
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ildar Ismagilov <devix84@gmail.com>

The srcu_funnel_exp_start() function checks to see if the srcu_struct
structure's expedited grace period counter needs updating to reflect a
newly arrived request for an expedited SRCU grace period.  Unfortunately,
the check is backwards, so this commit reverses the sense of the test.

Signed-off-by: Ildar Ismagilov <devix84@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 9c6e0eaab4d5..045b559b9f22 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -626,7 +626,7 @@ static void srcu_funnel_exp_start(struct srcu_struct *sp, struct srcu_node *snp,
 		spin_unlock_irqrestore_rcu_node(snp, flags);
 	}
 	spin_lock_irqsave_rcu_node(sp, flags);
-	if (!ULONG_CMP_LT(sp->srcu_gp_seq_needed_exp, s))
+	if (ULONG_CMP_LT(sp->srcu_gp_seq_needed_exp, s))
 		sp->srcu_gp_seq_needed_exp = s;
 	spin_unlock_irqrestore_rcu_node(sp, flags);
 }
-- 
2.5.2
