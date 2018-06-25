Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34392C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23AB2625C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23AB2625C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755801AbeFYW4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:56:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60590 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755128AbeFYWz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:55:59 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PMmqXZ057605
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:55:59 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ju96r8q4v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:55:58 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 18:55:58 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 18:55:52 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PMtqpD6357272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 22:55:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB763B205F;
        Mon, 25 Jun 2018 18:55:46 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99DDAB206A;
        Mon, 25 Jun 2018 18:55:46 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 18:55:46 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EB4B616CA099; Mon, 25 Jun 2018 15:57:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH tip/core/rcu 5/5] torture: Keep old-school dmesg format
Date:   Mon, 25 Jun 2018 15:57:55 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625225735.GA11793@linux.vnet.ibm.com>
References: <20180625225735.GA11793@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062522-2213-0000-0000-000002BFD89F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052304; UDB=6.00539450; IPR=6.00830229;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-25 22:55:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062522-2214-0000-0000-00005A9B6F34
Message-Id: <20180625225755.12839-5-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=617 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds "#define pr_fmt(fmt) fmt" to the torture-test files
in order to keep the current dmesg format.  Once Joe's commits have
hit mainline, these definitions will be changed in order to automatically
generate the dmesg line prefix that the scripts expect.  This will have
the beneficial side-effect of allowing printk() formats to be used more
widely and of shortening some pr_*() lines.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Joe Perches <joe@perches.com>
---
 kernel/locking/locktorture.c | 3 +++
 kernel/rcu/rcuperf.c         | 3 +++
 kernel/rcu/rcutorture.c      | 3 +++
 kernel/torture.c             | 3 +++
 4 files changed, 12 insertions(+)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 4a2e13870a9b..57bef4fbfb31 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -21,6 +21,9 @@
  *          Davidlohr Bueso <dave@stgolabs.net>
  *	Based on kernel/rcu/torture.c.
  */
+
+#define pr_fmt(fmt) fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/kthread.h>
diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index fb8094848906..df29119b2013 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -19,6 +19,9 @@
  *
  * Authors: Paul E. McKenney <paulmck@us.ibm.com>
  */
+
+#define pr_fmt(fmt) fmt
+
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index a5540bd831c4..5604bfac8df4 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -22,6 +22,9 @@
  *
  * See also:  Documentation/RCU/torture.txt
  */
+
+#define pr_fmt(fmt) fmt
+
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/kernel/torture.c b/kernel/torture.c
index 840fd33c1cda..1ac24a826589 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -20,6 +20,9 @@
  * Author: Paul E. McKenney <paulmck@us.ibm.com>
  *	Based on kernel/rcu/torture.c.
  */
+
+#define pr_fmt(fmt) fmt
+
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-- 
2.17.1

