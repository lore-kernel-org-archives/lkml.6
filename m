Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7ADC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BABB206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfAIVH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:07:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725730AbfAIVH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:07:57 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09Kn37F067874
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:07:56 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pwn7psfep-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:07:56 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:07:55 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:07:51 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09L7oeI21889220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:07:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33650B2068;
        Wed,  9 Jan 2019 21:07:50 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15469B2064;
        Wed,  9 Jan 2019 21:07:50 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:07:50 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DD46416C63D3; Wed,  9 Jan 2019 13:07:49 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, willy@infradead.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC LKMM 2/7] tools/memory-model: Refactor some RCU relations
Date:   Wed,  9 Jan 2019 13:07:43 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109210706.GA27268@linux.ibm.com>
References: <20190109210706.GA27268@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0060-0000-0000-000002F63E38
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010374; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144138; UDB=6.00595704; IPR=6.00924400;
 MB=3.00025055; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:07:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0061-0000-0000-000047DC65BC
Message-Id: <20190109210748.29074-2-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

In preparation for adding support for SRCU, refactor the definitions
of rcu-fence, rcu-rscsi, rcu-link, and rb by moving the po and po?
terms from the first two to the second two.  An rcu-gp relation is
added; it is equivalent to gp with the po and po? terms removed.

This is necessary because for SRCU, we will have to use the loc
relation to check that the terms at the start and end of each disjunct
in the definition of rcu-fence refer to the same srcu_struct
location.  If these terms are hidden behind po and po?, there's no way
to carry out this check.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Tested-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 tools/memory-model/linux-kernel.cat | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index ab9de9c1234b..b8e6197f05af 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -91,32 +91,37 @@ acyclic pb as propagation
 (*******)
 
 (*
- * Effect of read-side critical section proceeds from the rcu_read_lock()
- * onward on the one hand and from the rcu_read_unlock() backwards on the
+ * Effects of read-side critical sections proceed from the rcu_read_unlock()
+ * backwards on the one hand, and from the rcu_read_lock() forwards on the
  * other hand.
+ *
+ * In the definition of rcu-fence below, the po term at the left-hand side
+ * of each disjunct and the po? term at the right-hand end have been factored
+ * out.  They have been moved into the definitions of rcu-link and rb.
  *)
-let rcu-rscsi = po ; rcu-rscs^-1 ; po?
+let rcu-gp = [Sync-rcu]		(* Compare with gp *)
+let rcu-rscsi = rcu-rscs^-1
 
 (*
  * The synchronize_rcu() strong fence is special in that it can order not
  * one but two non-rf relations, but only in conjunction with an RCU
  * read-side critical section.
  *)
-let rcu-link = hb* ; pb* ; prop
+let rcu-link = po? ; hb* ; pb* ; prop ; po
 
 (*
  * Any sequence containing at least as many grace periods as RCU read-side
  * critical sections (joined by rcu-link) acts as a generalized strong fence.
  *)
-let rec rcu-fence = gp |
-	(gp ; rcu-link ; rcu-rscsi) |
-	(rcu-rscsi ; rcu-link ; gp) |
-	(gp ; rcu-link ; rcu-fence ; rcu-link ; rcu-rscsi) |
-	(rcu-rscsi ; rcu-link ; rcu-fence ; rcu-link ; gp) |
+let rec rcu-fence = rcu-gp |
+	(rcu-gp ; rcu-link ; rcu-rscsi) |
+	(rcu-rscsi ; rcu-link ; rcu-gp) |
+	(rcu-gp ; rcu-link ; rcu-fence ; rcu-link ; rcu-rscsi) |
+	(rcu-rscsi ; rcu-link ; rcu-fence ; rcu-link ; rcu-gp) |
 	(rcu-fence ; rcu-link ; rcu-fence)
 
 (* rb orders instructions just as pb does *)
-let rb = prop ; rcu-fence ; hb* ; pb*
+let rb = prop ; po ; rcu-fence ; po? ; hb* ; pb*
 
 irreflexive rb as rcu
 
-- 
2.17.1

