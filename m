Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE3EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01184206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfAIVur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:50:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727070AbfAIVuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:50:19 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09LnS9D055470
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:50:18 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pwru0rxy5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:50:17 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:50:17 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:50:11 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LoAPH21758002
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:50:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B517B205F;
        Wed,  9 Jan 2019 21:50:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 698D1B2064;
        Wed,  9 Jan 2019 21:50:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:50:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3D22C16C63E5; Wed,  9 Jan 2019 13:50:10 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 05/10] rcutorture/nolibc: Fix the clobbered registers in the MIPS syscall definition
Date:   Wed,  9 Jan 2019 13:50:03 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109214944.GA5610@linux.ibm.com>
References: <20190109214944.GA5610@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0040-0000-0000-000004AF3829
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144152; UDB=6.00593882; IPR=6.00924415;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:50:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0041-0000-0000-000008BA3CB7
Message-Id: <20190109215008.6401-5-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=854 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <w@1wt.eu>

A last-minute checkpatch cleanup caused most of list of clobbered
registers to be lost in the MIPS syscall definition. Although this code
is not yet used on MIPS, it is nevertheless better to fix it before it
does get used.

Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/testing/selftests/rcutorture/bin/nolibc.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/nolibc.h b/tools/testing/selftests/rcutorture/bin/nolibc.h
index f98f5b92d3eb..e8687cd24b8c 100644
--- a/tools/testing/selftests/rcutorture/bin/nolibc.h
+++ b/tools/testing/selftests/rcutorture/bin/nolibc.h
@@ -1006,7 +1006,7 @@ struct sys_stat_struct {
 		: "=r"(_num), "=r"(_arg4)                                     \
 		: "r"(_num)                                                   \
 		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-									      \
+		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
@@ -1025,7 +1025,7 @@ struct sys_stat_struct {
 		: "0"(_num),                                                  \
 		  "r"(_arg1)                                                  \
 		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-									      \
+		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
@@ -1045,7 +1045,7 @@ struct sys_stat_struct {
 		: "0"(_num),                                                  \
 		  "r"(_arg1), "r"(_arg2)                                      \
 		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-									      \
+		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
@@ -1066,7 +1066,7 @@ struct sys_stat_struct {
 		: "0"(_num),                                                  \
 		  "r"(_arg1), "r"(_arg2), "r"(_arg3)                          \
 		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-									      \
+		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
@@ -1087,7 +1087,7 @@ struct sys_stat_struct {
 		: "0"(_num),                                                  \
 		  "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4)              \
 		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-									      \
+		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
@@ -1110,7 +1110,7 @@ struct sys_stat_struct {
 		: "0"(_num),                                                  \
 		  "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5)  \
 		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-									      \
+		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
 	);                                                                    \
 	_arg4 ? -_num : _num;                                                 \
 })
-- 
2.17.1

