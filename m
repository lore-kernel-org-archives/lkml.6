Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEE2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459C62630A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459C62630A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935128AbeFZAJT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:09:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934600AbeFZAHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:06 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q03tYr119281
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:06 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96p2vjv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:06 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:04 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06vcS5439884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77142B207A;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4826CB2070;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8034216CA0A9; Mon, 25 Jun 2018 17:09:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 26/40] rcu: Convert rcu_fqs tracepoint to ->gp_seq
Date:   Mon, 25 Jun 2018 17:08:45 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0072-0000-0000-000003746095
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052327; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0073-0000-0000-0000487C522B
Message-Id: <20180626000859.23572-26-paulmck@linux.vnet.ibm.com>
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

This commit makes the rcu_fqs tracepoint use ->gp_seq instead of ->gpnum.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/trace/events/rcu.h | 12 ++++++------
 kernel/rcu/tree.c          |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index ac4d9d4a1ebf..7d3650cc9d30 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -398,26 +398,26 @@ TRACE_EVENT(rcu_quiescent_state_report,
  */
 TRACE_EVENT(rcu_fqs,
 
-	TP_PROTO(const char *rcuname, unsigned long gpnum, int cpu, const char *qsevent),
+	TP_PROTO(const char *rcuname, unsigned long gp_seq, int cpu, const char *qsevent),
 
-	TP_ARGS(rcuname, gpnum, cpu, qsevent),
+	TP_ARGS(rcuname, gp_seq, cpu, qsevent),
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gpnum)
+		__field(unsigned long, gp_seq)
 		__field(int, cpu)
 		__field(const char *, qsevent)
 	),
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gpnum = gpnum;
+		__entry->gp_seq = gp_seq;
 		__entry->cpu = cpu;
 		__entry->qsevent = qsevent;
 	),
 
 	TP_printk("%s %lu %d %s",
-		  __entry->rcuname, __entry->gpnum,
+		  __entry->rcuname, __entry->gp_seq,
 		  __entry->cpu, __entry->qsevent)
 );
 
@@ -766,7 +766,7 @@ TRACE_EVENT(rcu_barrier,
 #define trace_rcu_quiescent_state_report(rcuname, gp_seq, mask, qsmask, level, \
 					 grplo, grphi, gp_tasks) do { } \
 	while (0)
-#define trace_rcu_fqs(rcuname, gpnum, cpu, qsevent) do { } while (0)
+#define trace_rcu_fqs(rcuname, gp_seq, cpu, qsevent) do { } while (0)
 #define trace_rcu_dyntick(polarity, oldnesting, newnesting, dyntick) do { } while (0)
 #define trace_rcu_callback(rcuname, rhp, qlen_lazy, qlen) do { } while (0)
 #define trace_rcu_kfree_callback(rcuname, rhp, offset, qlen_lazy, qlen) \
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index dcd185078132..43ba06abf081 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1111,7 +1111,7 @@ static int dyntick_save_progress_counter(struct rcu_data *rdp)
 {
 	rdp->dynticks_snap = rcu_dynticks_snap(rdp->dynticks);
 	if (rcu_dynticks_in_eqs(rdp->dynticks_snap)) {
-		trace_rcu_fqs(rdp->rsp->name, rdp->gpnum, rdp->cpu, TPS("dti"));
+		trace_rcu_fqs(rdp->rsp->name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rdp->mynode, rdp);
 		return 1;
 	}
@@ -1161,7 +1161,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	 * of the current RCU grace period.
 	 */
 	if (rcu_dynticks_in_eqs_since(rdp->dynticks, rdp->dynticks_snap)) {
-		trace_rcu_fqs(rdp->rsp->name, rdp->gpnum, rdp->cpu, TPS("dti"));
+		trace_rcu_fqs(rdp->rsp->name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rdp->dynticks_fqs++;
 		rcu_gpnum_ovf(rnp, rdp);
 		return 1;
@@ -1178,7 +1178,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	if (time_after(jiffies, rdp->rsp->gp_start + jtsq) &&
 	    READ_ONCE(rdp->rcu_qs_ctr_snap) != per_cpu(rcu_dynticks.rcu_qs_ctr, rdp->cpu) &&
 	    rcu_seq_current(&rdp->gp_seq) == rnp->gp_seq && !rdp->gpwrap) {
-		trace_rcu_fqs(rdp->rsp->name, rdp->gpnum, rdp->cpu, TPS("rqc"));
+		trace_rcu_fqs(rdp->rsp->name, rdp->gp_seq, rdp->cpu, TPS("rqc"));
 		rcu_gpnum_ovf(rnp, rdp);
 		return 1;
 	} else if (time_after(jiffies, rdp->rsp->gp_start + jtsq)) {
@@ -1188,7 +1188,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 
 	/* Check for the CPU being offline. */
 	if (!(rdp->grpmask & rcu_rnp_online_cpus(rnp))) {
-		trace_rcu_fqs(rdp->rsp->name, rdp->gpnum, rdp->cpu, TPS("ofl"));
+		trace_rcu_fqs(rdp->rsp->name, rdp->gp_seq, rdp->cpu, TPS("ofl"));
 		rdp->offline_fqs++;
 		rcu_gpnum_ovf(rnp, rdp);
 		return 1;
-- 
2.17.1

