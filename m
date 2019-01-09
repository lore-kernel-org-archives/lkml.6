Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14D1C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD1B206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfAIVl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:41:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59348 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727166AbfAIVlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:41:52 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09Ld8d8027157
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:41:51 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pwru0rp5k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:41:51 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:41:50 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:41:45 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LfiFB24379514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:41:44 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C850DB206B;
        Wed,  9 Jan 2019 21:41:44 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9771EB2066;
        Wed,  9 Jan 2019 21:41:44 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:41:44 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 29A1816C6405; Wed,  9 Jan 2019 13:41:44 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 7/8] rcu: Add sparse check to rcu_assign_pointer()
Date:   Wed,  9 Jan 2019 13:41:41 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109214115.GA2835@linux.ibm.com>
References: <20190109214115.GA2835@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0060-0000-0000-000002F64125
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144149; UDB=6.00595711; IPR=6.00924411;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:41:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0061-0000-0000-000047DC77C2
Message-Id: <20190109214142.4428-7-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

The rcu_assign_pointer() function currently doesn't do any sparse checking
on the assigned-to pointer.  So its possible that a pointer that is
not __rcu annotated is assigned with rcu_assign_pointer without sparse
complaints.  Because rcu_dereference() already does such checking,
this commit makes rcu_assign_pointer() to do the same. The extra
error could be helpful in cases where an RCU pointer is assigned with
rcu_assign_pointer() but not annotated with __rcu.

This doesn't generate any code in the normal case because __CHECKER__ is
defined only in the context of sparse.

This commit also renames rcu_dereference_sparse() to rcu_check_parse()
since the checking now happens not only during derereferencing but also
during assignment.

Test: Introduced an rcu_assign_pointer in code and checked the output of
sparse with and without this change. The change correctly causes sparse
to throw an error.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 include/linux/rcupdate.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index b4e99639d6d4..0bb5d906bff3 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -309,16 +309,16 @@ static inline void rcu_preempt_sleep_check(void) { }
  */
 
 #ifdef __CHECKER__
-#define rcu_dereference_sparse(p, space) \
+#define rcu_check_sparse(p, space) \
 	((void)(((typeof(*p) space *)p) == p))
 #else /* #ifdef __CHECKER__ */
-#define rcu_dereference_sparse(p, space)
+#define rcu_check_sparse(p, space)
 #endif /* #else #ifdef __CHECKER__ */
 
 #define __rcu_access_pointer(p, space) \
 ({ \
 	typeof(*p) *_________p1 = (typeof(*p) *__force)READ_ONCE(p); \
-	rcu_dereference_sparse(p, space); \
+	rcu_check_sparse(p, space); \
 	((typeof(*p) __force __kernel *)(_________p1)); \
 })
 #define __rcu_dereference_check(p, c, space) \
@@ -326,13 +326,13 @@ static inline void rcu_preempt_sleep_check(void) { }
 	/* Dependency order vs. p above. */ \
 	typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
 	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
-	rcu_dereference_sparse(p, space); \
+	rcu_check_sparse(p, space); \
 	((typeof(*p) __force __kernel *)(________p1)); \
 })
 #define __rcu_dereference_protected(p, c, space) \
 ({ \
 	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
-	rcu_dereference_sparse(p, space); \
+	rcu_check_sparse(p, space); \
 	((typeof(*p) __force __kernel *)(p)); \
 })
 #define rcu_dereference_raw(p) \
@@ -382,6 +382,7 @@ static inline void rcu_preempt_sleep_check(void) { }
 #define rcu_assign_pointer(p, v)					      \
 ({									      \
 	uintptr_t _r_a_p__v = (uintptr_t)(v);				      \
+	rcu_check_sparse(p, __rcu);				      \
 									      \
 	if (__builtin_constant_p(v) && (_r_a_p__v) == (uintptr_t)NULL)	      \
 		WRITE_ONCE((p), (typeof(p))(_r_a_p__v));		      \
@@ -785,7 +786,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  */
 #define RCU_INIT_POINTER(p, v) \
 	do { \
-		rcu_dereference_sparse(p, __rcu); \
+		rcu_check_sparse(p, __rcu); \
 		WRITE_ONCE(p, RCU_INITIALIZER(v)); \
 	} while (0)
 
-- 
2.17.1

