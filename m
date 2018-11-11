Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DC4C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CD920871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CD920871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbeKLFvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:51:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57604 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729696AbeKLFvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:51:18 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJx9jn075860
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:01:50 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2npdvs99a1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:01:49 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 20:01:49 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 20:01:44 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABK1hhp26673400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 20:01:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5E92B2070;
        Sun, 11 Nov 2018 20:01:43 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1669B2065;
        Sun, 11 Nov 2018 20:01:43 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 20:01:43 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D70C916C5D5F; Sun, 11 Nov 2018 12:01:44 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 3/8] rcutorture: Make initrd/init execute in userspace
Date:   Sun, 11 Nov 2018 12:01:38 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111200127.GA9511@linux.ibm.com>
References: <20181111200127.GA9511@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111120-0072-0000-0000-000003C6F49F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116024; UDB=6.00577118; IPR=6.00896125;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 20:01:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111120-0073-0000-0000-00004A134E9E
Message-Id: <20181111200143.10177-3-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

Currently, the initrd/init script and executable remain blocked almost
all the time.  However, it is necessary to test nohz_full userspace
execution, which both variants of initrd/init fail to do.  This commit
therefore causes initrd/init to spend about a millisecond per second
executing in userspace.

Reported-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 .../selftests/rcutorture/bin/mkinitrd.sh      | 43 +++++++++++++++++--
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
index 87a87ffeaa85..b48c504edfe1 100755
--- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
+++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
@@ -39,9 +39,22 @@ mkdir $T
 
 cat > $T/init << '__EOF___'
 #!/bin/sh
+# Run in userspace a few milliseconds every second.  This helps to
+# exercise the NO_HZ_FULL portions of RCU.
 while :
 do
-	sleep 1000000
+	q=
+	for i in \
+		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
+		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
+		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
+		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
+		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
+		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a
+	do
+		q="$q $i"
+	done
+	sleep 1
 done
 __EOF___
 
@@ -70,15 +83,37 @@ mkdir initrd
 cd initrd
 cat > init.c << '___EOF___'
 #include <unistd.h>
+#include <sys/time.h>
+
+volatile unsigned long delaycount;
 
 int main(int argc, int argv[])
 {
-	for (;;)
-		sleep(1000*1000*1000); /* One gigasecond is ~30 years. */
+	int i;
+	struct timeval tv;
+	struct timeval tvb;
+
+	for (;;) {
+		sleep(1);
+		/* Need some userspace time. */
+		if (gettimeofday(&tvb, NULL))
+			continue;
+		do {
+			for (i = 0; i < 1000 * 100; i++)
+				delaycount = i * i;
+			if (gettimeofday(&tv, NULL))
+				break;
+			tv.tv_sec -= tvb.tv_sec;
+			if (tv.tv_sec > 1)
+				break;
+			tv.tv_usec += tv.tv_sec * 1000 * 1000;
+			tv.tv_usec -= tvb.tv_usec;
+		} while (tv.tv_usec < 1000);
+	}
 	return 0;
 }
 ___EOF___
-gcc -static -Os -o init init.c
+cc -static -Os -o init init.c
 strip init
 rm init.c
 echo "Done creating a statically linked C-language initrd"
-- 
2.17.1

