Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D217C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5212625B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5212625B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755729AbeFYW4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:56:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755131AbeFYWz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:55:59 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PMmquh019224
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:55:59 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ju96qgqmj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:55:58 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 18:55:58 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 18:55:52 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PMtpgZ6357720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 22:55:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0070B206E;
        Mon, 25 Jun 2018 18:55:46 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8ED48B2066;
        Mon, 25 Jun 2018 18:55:46 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 18:55:46 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DFEE616CA097; Mon, 25 Jun 2018 15:57:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 3/5] rcutorture: Make kvm-find-errors.sh find close calls
Date:   Mon, 25 Jun 2018 15:57:53 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625225735.GA11793@linux.vnet.ibm.com>
References: <20180625225735.GA11793@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062522-0068-0000-0000-0000030E11A3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052304; UDB=6.00539450; IPR=6.00830229;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-25 22:55:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062522-0069-0000-0000-000044CEE1A4
Message-Id: <20180625225755.12839-3-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although warnings about close calls are printed by kvm-recheck.sh,
kvm-find-errors.sh currently ignores them.  This could easily result
in someone failing to investigate close calls, so this commit makes
them visible to kvm-find-errors.sh.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh | 1 +
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh     | 1 +
 tools/testing/selftests/rcutorture/bin/parse-console.sh   | 7 +++++++
 3 files changed, 9 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
index 477ecb1293ab..0fa8a61ccb7b 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
@@ -70,4 +70,5 @@ else
 	else
 		print_warning $nclosecalls "Reader Batch close calls in" $(($dur/60)) minute run: $i
 	fi
+	echo $nclosecalls "Reader Batch close calls in" $(($dur/60)) minute run: $i > $i/console.log.rcu.diags
 fi
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index c27e97824163..c9bab57a77eb 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -39,6 +39,7 @@ do
 			head -1 $resdir/log
 		fi
 		TORTURE_SUITE="`cat $i/../TORTURE_SUITE`"
+		rm -f $i/console.log.*.diags
 		kvm-recheck-${TORTURE_SUITE}.sh $i
 		if test -f "$i/console.log"
 		then
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 17293436f551..84933f6aed77 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -163,6 +163,13 @@ then
 	print_warning Summary: $summary
 	cat $T.diags >> $file.diags
 fi
+for i in $file.*.diags
+do
+	if test -f "$i"
+	then
+		cat $i >> $file.diags
+	fi
+done
 if ! test -s $file.diags
 then
 	rm -f $file.diags
-- 
2.17.1

