Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7546FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF37206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfAIVIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:08:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50258 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726387AbfAIVH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:07:58 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09KoMLk019718
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:07:57 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwq5eus24-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:07:57 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:07:56 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:07:51 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09L7oLf18284652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:07:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CA33B206C;
        Wed,  9 Jan 2019 21:07:50 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A72DB2067;
        Wed,  9 Jan 2019 21:07:50 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:07:50 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id ED4EA16C63FC; Wed,  9 Jan 2019 13:07:49 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, willy@infradead.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-doc@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC LKMM 5/7] docs/memory-barriers.txt: Enforce heavy ordering for port I/O accesses
Date:   Wed,  9 Jan 2019 13:07:46 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109210706.GA27268@linux.ibm.com>
References: <20190109210706.GA27268@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0052-0000-0000-00000375B341
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010374; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144138; UDB=6.00595704; IPR=6.00924400;
 MB=3.00025055; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:07:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0053-0000-0000-00005F6789E0
Message-Id: <20190109210748.29074-5-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=963 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

David Laight explains:

  | A long time ago there was a document from Intel that said that
  | inb/outb weren't necessarily synchronised wrt memory accesses.
  | (Might be P-pro era). However no processors actually behaved that
  | way and more recent docs say that inb/outb are fully ordered.

This also reflects the situation on other architectures, the the port
accessor macros tend to be implemented in terms of readX/writeX.

Update Documentation/memory-barriers.txt to reflect reality.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <linux-arch@vger.kernel.org>
Cc: <linux-doc@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 Documentation/memory-barriers.txt | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 1c22b21ae922..a70104e2a087 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -2619,10 +2619,8 @@ functions:
      intermediary bridges (such as the PCI host bridge) may not fully honour
      that.
 
-     They are guaranteed to be fully ordered with respect to each other.
-
-     They are not guaranteed to be fully ordered with respect to other types of
-     memory and I/O operation.
+     They are guaranteed to be fully ordered with respect to each other and
+     also with respect to other types of memory and I/O operation.
 
  (*) readX(), writeX():
 
-- 
2.17.1

