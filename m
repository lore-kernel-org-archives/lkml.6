Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EACBC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696DE206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfAIVul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:50:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727311AbfAIVuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:50:20 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09LnSOV034832
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:50:19 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwq4rnf26-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:50:18 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:50:17 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:50:11 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LoAhf21168280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:50:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72321B2065;
        Wed,  9 Jan 2019 21:50:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52486B2066;
        Wed,  9 Jan 2019 21:50:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:50:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2417916C63C3; Wed,  9 Jan 2019 13:50:10 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 01/10] rcutorture: Record grace periods in forward-progress histogram
Date:   Wed,  9 Jan 2019 13:49:59 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109214944.GA5610@linux.ibm.com>
References: <20190109214944.GA5610@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0060-0000-0000-000002F641C6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144152; UDB=6.00595713; IPR=6.00924415;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:50:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0061-0000-0000-000047DC7BF7
Message-Id: <20190109215008.6401-1-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit records grace periods in rcutorture's n_launders_hist[]
histogram, thus allowing rcu_torture_fwd_cb_hist() to print out the
elapsed number of grace periods between buckets.  This information
helps to determine whether a lack of forward progress is due to stalled
grace periods on the one hand or due to sluggish callback invocation on
the other.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/rcutorture.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index f6e85faa4ff4..0955f3a20952 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1630,21 +1630,34 @@ static bool rcu_fwd_emergency_stop;
 #define MIN_FWD_CB_LAUNDERS	3	/* This many CB invocations to count. */
 #define MIN_FWD_CBS_LAUNDERED	100	/* Number of counted CBs. */
 #define FWD_CBS_HIST_DIV	10	/* Histogram buckets/second. */
-static long n_launders_hist[2 * MAX_FWD_CB_JIFFIES / (HZ / FWD_CBS_HIST_DIV)];
+struct rcu_launder_hist {
+	long n_launders;
+	unsigned long launder_gp_seq;
+};
+#define N_LAUNDERS_HIST (2 * MAX_FWD_CB_JIFFIES / (HZ / FWD_CBS_HIST_DIV))
+static struct rcu_launder_hist n_launders_hist[N_LAUNDERS_HIST];
+static unsigned long rcu_launder_gp_seq_start;
 
 static void rcu_torture_fwd_cb_hist(void)
 {
+	unsigned long gps;
+	unsigned long gps_old;
 	int i;
 	int j;
 
 	for (i = ARRAY_SIZE(n_launders_hist) - 1; i > 0; i--)
-		if (n_launders_hist[i] > 0)
+		if (n_launders_hist[i].n_launders > 0)
 			break;
 	pr_alert("%s: Callback-invocation histogram (duration %lu jiffies):",
 		 __func__, jiffies - rcu_fwd_startat);
-	for (j = 0; j <= i; j++)
-		pr_cont(" %ds/%d: %ld",
-			j + 1, FWD_CBS_HIST_DIV, n_launders_hist[j]);
+	gps_old = rcu_launder_gp_seq_start;
+	for (j = 0; j <= i; j++) {
+		gps = n_launders_hist[j].launder_gp_seq;
+		pr_cont(" %ds/%d: %ld:%ld",
+			j + 1, FWD_CBS_HIST_DIV, n_launders_hist[j].n_launders,
+			rcutorture_seq_diff(gps, gps_old));
+		gps_old = gps;
+	}
 	pr_cont("\n");
 }
 
@@ -1666,7 +1679,8 @@ static void rcu_torture_fwd_cb_cr(struct rcu_head *rhp)
 	i = ((jiffies - rcu_fwd_startat) / (HZ / FWD_CBS_HIST_DIV));
 	if (i >= ARRAY_SIZE(n_launders_hist))
 		i = ARRAY_SIZE(n_launders_hist) - 1;
-	n_launders_hist[i]++;
+	n_launders_hist[i].n_launders++;
+	n_launders_hist[i].launder_gp_seq = cur_ops->get_gp_seq();
 	spin_unlock_irqrestore(&rcu_fwd_lock, flags);
 }
 
@@ -1786,9 +1800,10 @@ static void rcu_torture_fwd_prog_cr(void)
 	n_max_cbs = 0;
 	n_max_gps = 0;
 	for (i = 0; i < ARRAY_SIZE(n_launders_hist); i++)
-		n_launders_hist[i] = 0;
+		n_launders_hist[i].n_launders = 0;
 	cver = READ_ONCE(rcu_torture_current_version);
 	gps = cur_ops->get_gp_seq();
+	rcu_launder_gp_seq_start = gps;
 	while (time_before(jiffies, stopat) &&
 	       !READ_ONCE(rcu_fwd_emergency_stop) && !torture_must_stop()) {
 		rfcp = READ_ONCE(rcu_fwd_cb_head);
-- 
2.17.1

