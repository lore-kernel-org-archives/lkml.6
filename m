Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D079ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DFC208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0DFC208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbeGPSdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:33:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728550AbeGPScW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:32:22 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6GHxErf066663
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 14:03:49 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k9073r86b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 14:03:49 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 16 Jul 2018 14:03:48 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Jul 2018 14:03:43 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6GI3gfu62718192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jul 2018 18:03:42 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7630B2072;
        Mon, 16 Jul 2018 14:03:35 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B847AB2068;
        Mon, 16 Jul 2018 14:03:35 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 16 Jul 2018 14:03:35 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1F80416C3EC6; Mon, 16 Jul 2018 11:06:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 01/14] tools/memory-model: Add litmus test for full multicopy atomicity
Date:   Mon, 16 Jul 2018 11:05:52 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716180540.GA14222@linux.vnet.ibm.com>
References: <20180716180540.GA14222@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18071618-0052-0000-0000-0000030F19F9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009375; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01061730; UDB=6.00545095; IPR=6.00839634;
 MB=3.00022159; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-16 18:03:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071618-0053-0000-0000-00005D629988
Message-Id: <20180716180605.16115-1-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=768 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807160205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a litmus test suggested by Alan Stern that is forbidden
on fully multicopy atomic systems, but allowed on other-multicopy and
on non-multicopy atomic systems.  For reference, s390 is fully multicopy
atomic, x86 and ARMv8 are other-multicopy atomic, and ARMv7 and powerpc
are non-multicopy atomic.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 tools/memory-model/litmus-tests/README        |  9 ++++++
 .../SB+rfionceonce-poonceonces.litmus         | 32 +++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus

diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 17eb9a8c222d..00140aaf58b7 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -111,6 +111,15 @@ SB+mbonceonces.litmus
 SB+poonceonces.litmus
 	As above, but without the smp_mb() invocations.
 
+SB+rfionceonce-poonceonces.litmus
+	This litmus test demonstrates that LKMM is not fully multicopy
+	atomic.  (Neither is it other multicopy atomic.)  This litmus test
+	also demonstrates the "locations" debugging aid, which designates
+	additional registers and locations to be printed out in the dump
+	of final states in the herd7 output.  Without the "locations"
+	statement, only those registers and locations mentioned in the
+	"exists" clause will be printed.
+
 S+poonceonces.litmus
 	As below, but without the smp_wmb() and acquire load.
 
diff --git a/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus b/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
new file mode 100644
index 000000000000..04a16603660b
--- /dev/null
+++ b/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
@@ -0,0 +1,32 @@
+C SB+rfionceonce-poonceonces
+
+(*
+ * Result: Sometimes
+ *
+ * This litmus test demonstrates that LKMM is not fully multicopy atomic.
+ *)
+
+{}
+
+P0(int *x, int *y)
+{
+	int r1;
+	int r2;
+
+	WRITE_ONCE(*x, 1);
+	r1 = READ_ONCE(*x);
+	r2 = READ_ONCE(*y);
+}
+
+P1(int *x, int *y)
+{
+	int r3;
+	int r4;
+
+	WRITE_ONCE(*y, 1);
+	r3 = READ_ONCE(*y);
+	r4 = READ_ONCE(*x);
+}
+
+locations [0:r1; 1:r3; x; y] (* Debug aid: Print things not in "exists". *)
+exists (0:r2=0 /\ 1:r4=0)
-- 
2.17.1

