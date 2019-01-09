Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EE1C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C65220685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfAIVhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:37:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726314AbfAIVho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:37:44 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09LSkFS025063
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:37:43 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwnayj2ep-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:37:42 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:37:42 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:37:38 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09Lbb3D18284572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:37:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 292FFB206A;
        Wed,  9 Jan 2019 21:37:37 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A247B2066;
        Wed,  9 Jan 2019 21:37:37 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:37:36 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D08C716C63C9; Wed,  9 Jan 2019 13:37:36 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 2/3] doc: CPU-hotplug notifiers cannot invoke synchronize_srcu() or srcu_barrier()
Date:   Wed,  9 Jan 2019 13:37:34 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109213302.GA1723@linux.ibm.com>
References: <20190109213302.GA1723@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0068-0000-0000-0000038006FD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144148; UDB=6.00595710; IPR=6.00924410;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:37:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0069-0000-0000-00004712285C
Message-Id: <20190109213735.3405-2-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SRCU's synchronize_srcu() may not be invoked from CPU-hotplug notifiers,
due to the fact that SRCU grace periods make use of timers and the
possibility of timers being temporarily stranded on the outgoing CPU.
This stranding of timers means that timers posted to the outgoing CPU
will not fire until late in the CPU-hotplug process.  The problem is
that if a notifier is waiting on an SRCU grace period, that grace period
is waiting on a timer, and that timer is stranded on the outgoing CPU,
then the notifier will never be awakened, in other words, deadlock has
occurred.  This same situation of course also prohibits srcu_barrier()
from being invoked from CPU-hotplug notifiers.

This commit therefore updates the requirements to include this restriction.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 .../RCU/Design/Requirements/Requirements.html | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
index 9fca73e03a98..5a9238a2883c 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.html
+++ b/Documentation/RCU/Design/Requirements/Requirements.html
@@ -3099,7 +3099,7 @@ If you block forever in one of a given domain's SRCU read-side critical
 sections, then that domain's grace periods will also be blocked forever.
 Of course, one good way to block forever is to deadlock, which can
 happen if any operation in a given domain's SRCU read-side critical
-section can block waiting, either directly or indirectly, for that domain's
+section can wait, either directly or indirectly, for that domain's
 grace period to elapse.
 For example, this results in a self-deadlock:
 
@@ -3139,12 +3139,18 @@ API, which, in combination with <tt>srcu_read_unlock()</tt>,
 guarantees a full memory barrier.
 
 <p>
-Also unlike other RCU flavors, SRCU's callbacks-wait function
-<tt>srcu_barrier()</tt> may be invoked from CPU-hotplug notifiers,
-though this is not necessarily a good idea.
-The reason that this is possible is that SRCU is insensitive
-to whether or not a CPU is online, which means that <tt>srcu_barrier()</tt>
-need not exclude CPU-hotplug operations.
+Also unlike other RCU flavors, <tt>synchronize_srcu()</tt> may <b>not</b>
+be invoked from CPU-hotplug notifiers, due to the fact that SRCU grace
+periods make use of timers and the possibility of timers being temporarily
+&ldquo;stranded&rdquo; on the outgoing CPU.
+This stranding of timers means that timers posted to the outgoing CPU
+will not fire until late in the CPU-hotplug process.
+The problem is that if a notifier is waiting on an SRCU grace period,
+that grace period is waiting on a timer, and that timer is stranded on the
+outgoing CPU, then the notifier will never be awakened, in other words,
+deadlock has occurred.
+This same situation of course also prohibits <tt>srcu_barrier()</tt>
+from being invoked from CPU-hotplug notifiers.
 
 <p>
 SRCU also differs from other RCU flavors in that SRCU's expedited and
-- 
2.17.1

