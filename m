Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C1EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5266F2630D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5266F2630D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935180AbeFZAJ1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:09:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934573AbeFZAHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:06 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q03lvq028068
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:05 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96utt87-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:05 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:04 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06wjR63373448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80A4BB2081;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FE3CB206E;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 65A3F16CA09D; Mon, 25 Jun 2018 17:09:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 21/40] rcu: Convert rcu_future_grace_period tracepoint to gp_seq
Date:   Mon, 25 Jun 2018 17:08:40 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0064-0000-0000-000003202F9B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052327; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0065-0000-0000-000039B74450
Message-Id: <20180626000859.23572-21-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit makes the rcu_future_grace_period tracepoint use gp_seq
instead of ->gpnum and ->completed.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/trace/events/rcu.h | 22 +++++++++-------------
 kernel/rcu/tree.c          |  7 +++----
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index cd229e82ec8b..286047d22314 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -103,16 +103,14 @@ TRACE_EVENT(rcu_grace_period,
  */
 TRACE_EVENT(rcu_future_grace_period,
 
-	TP_PROTO(const char *rcuname, unsigned long gpnum, unsigned long completed,
-		 unsigned long c, u8 level, int grplo, int grphi,
-		 const char *gpevent),
+	TP_PROTO(const char *rcuname, unsigned long gp_seq, unsigned long c,
+		 u8 level, int grplo, int grphi, const char *gpevent),
 
-	TP_ARGS(rcuname, gpnum, completed, c, level, grplo, grphi, gpevent),
+	TP_ARGS(rcuname, gp_seq, c, level, grplo, grphi, gpevent),
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gpnum)
-		__field(unsigned long, completed)
+		__field(unsigned long, gp_seq)
 		__field(unsigned long, c)
 		__field(u8, level)
 		__field(int, grplo)
@@ -122,8 +120,7 @@ TRACE_EVENT(rcu_future_grace_period,
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gpnum = gpnum;
-		__entry->completed = completed;
+		__entry->gp_seq = gp_seq;
 		__entry->c = c;
 		__entry->level = level;
 		__entry->grplo = grplo;
@@ -131,10 +128,9 @@ TRACE_EVENT(rcu_future_grace_period,
 		__entry->gpevent = gpevent;
 	),
 
-	TP_printk("%s %lu %lu %lu %u %d %d %s",
-		  __entry->rcuname, __entry->gpnum, __entry->completed,
-		  __entry->c, __entry->level, __entry->grplo, __entry->grphi,
-		  __entry->gpevent)
+	TP_printk("%s %lu %lu %u %d %d %s",
+		  __entry->rcuname, __entry->gp_seq, __entry->c, __entry->level,
+		  __entry->grplo, __entry->grphi, __entry->gpevent)
 );
 
 /*
@@ -755,7 +751,7 @@ TRACE_EVENT(rcu_barrier,
 #else /* #ifdef CONFIG_RCU_TRACE */
 
 #define trace_rcu_grace_period(rcuname, gp_seq, gpevent) do { } while (0)
-#define trace_rcu_future_grace_period(rcuname, gpnum, completed, c, \
+#define trace_rcu_future_grace_period(rcuname, gp_seq, c, \
 				      level, grplo, grphi, event) \
 				      do { } while (0)
 #define trace_rcu_grace_period_init(rcuname, gpnum, level, grplo, grphi, \
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 70e5d155042c..de4b7994ffc4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1552,9 +1552,8 @@ void rcu_cpu_stall_reset(void)
 static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 			      unsigned long c, const char *s)
 {
-	trace_rcu_future_grace_period(rdp->rsp->name, rnp->gpnum,
-				      rnp->completed, c, rnp->level,
-				      rnp->grplo, rnp->grphi, s);
+	trace_rcu_future_grace_period(rdp->rsp->name, rnp->gp_seq, c,
+				      rnp->level, rnp->grplo, rnp->grphi, s);
 }
 
 /*
@@ -2053,7 +2052,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 	/* Check for GP requests since above loop. */
 	rdp = this_cpu_ptr(rsp->rda);
 	if (ULONG_CMP_LT(rnp->gp_seq, rnp->gp_seq_needed)) {
-		trace_rcu_this_gp(rnp, rdp, rsp->completed - 1,
+		trace_rcu_this_gp(rnp, rdp, rnp->gp_seq_needed,
 				  TPS("CleanupMore"));
 		needgp = true;
 	}
-- 
2.17.1

