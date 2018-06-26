Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AC6C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719AA262F4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719AA262F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964813AbeFZAHQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:07:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934309AbeFZAHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:04 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q03lvm028068
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:03 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96utt60-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:03 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:01 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:57 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06usj19005796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 848D6B2066;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6415CB206A;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6B4A416CA0A7; Mon, 25 Jun 2018 17:09:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 22/40] rcu: Convert rcu_grace_period_init tracepoint to gp_seq
Date:   Mon, 25 Jun 2018 17:08:41 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0072-0000-0000-000003746090
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052327; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0073-0000-0000-0000487C5221
Message-Id: <20180626000859.23572-22-paulmck@linux.vnet.ibm.com>
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

This commit makes the rcu_grace_period_init tracepoint use gp_seq instead
of ->gpnum.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/trace/events/rcu.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 286047d22314..892016ad0647 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -142,14 +142,14 @@ TRACE_EVENT(rcu_future_grace_period,
  */
 TRACE_EVENT(rcu_grace_period_init,
 
-	TP_PROTO(const char *rcuname, unsigned long gpnum, u8 level,
+	TP_PROTO(const char *rcuname, unsigned long gp_seq, u8 level,
 		 int grplo, int grphi, unsigned long qsmask),
 
-	TP_ARGS(rcuname, gpnum, level, grplo, grphi, qsmask),
+	TP_ARGS(rcuname, gp_seq, level, grplo, grphi, qsmask),
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gpnum)
+		__field(unsigned long, gp_seq)
 		__field(u8, level)
 		__field(int, grplo)
 		__field(int, grphi)
@@ -158,7 +158,7 @@ TRACE_EVENT(rcu_grace_period_init,
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gpnum = gpnum;
+		__entry->gp_seq = gp_seq;
 		__entry->level = level;
 		__entry->grplo = grplo;
 		__entry->grphi = grphi;
@@ -166,7 +166,7 @@ TRACE_EVENT(rcu_grace_period_init,
 	),
 
 	TP_printk("%s %lu %u %d %d %lx",
-		  __entry->rcuname, __entry->gpnum, __entry->level,
+		  __entry->rcuname, __entry->gp_seq, __entry->level,
 		  __entry->grplo, __entry->grphi, __entry->qsmask)
 );
 
@@ -754,7 +754,7 @@ TRACE_EVENT(rcu_barrier,
 #define trace_rcu_future_grace_period(rcuname, gp_seq, c, \
 				      level, grplo, grphi, event) \
 				      do { } while (0)
-#define trace_rcu_grace_period_init(rcuname, gpnum, level, grplo, grphi, \
+#define trace_rcu_grace_period_init(rcuname, gp_seq, level, grplo, grphi, \
 				    qsmask) do { } while (0)
 #define trace_rcu_exp_grace_period(rcuname, gqseq, gpevent) \
 	do { } while (0)
-- 
2.17.1

