Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBF9C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74F821A0E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74F821A0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbeHFNzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:55:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730638AbeHFNzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:55:54 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76BeHj6094676
        for <linux-kernel@vger.kernel.org>; Mon, 6 Aug 2018 07:47:10 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kpkkvw4eb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 07:47:10 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 6 Aug 2018 12:47:08 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Aug 2018 12:47:04 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w76Bl3Q838994020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Aug 2018 11:47:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01F3B11C04C;
        Mon,  6 Aug 2018 14:47:12 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A11BD11C066;
        Mon,  6 Aug 2018 14:47:11 +0100 (BST)
Received: from localhost (unknown [9.152.212.144])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  6 Aug 2018 14:47:11 +0100 (BST)
Date:   Mon, 6 Aug 2018 13:47:02 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 1/1] rseq/selftests: add __rseq_abi misalignment check
References: <cover.thread-5c3a1c.your-ad-here.call-01533555685-ext-8699@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-5c3a1c.your-ad-here.call-01533555685-ext-8699@work.hours>
X-TM-AS-GCONF: 00
x-cbid: 18080611-0012-0000-0000-000002959375
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080611-0013-0000-0000-000020C79A3C
Message-Id: <patch-1.thread-5c3a1c.git-5c3a1ce06b75.your-ad-here.call-01533555685-ext-8699@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel rseq syscall expects that struct rseq is 32 bytes aligned and
returns EINVAL otherwise. Even though __rseq_abi is declared as static
and proper aligned attribute is present __rseq_abi is a part of thread
local storage. It turns out that on some platforms TLS itself is not
properly aligned (at least for threads created), which is a glibc nptl
bug and should be eventually fixed and backported. But in a meanwhile
add __rseq_abi misalignment check, which would detect this situation
and skip rseq test with some user friendly message.

glibc bug: https://sourceware.org/bugzilla/show_bug.cgi?id=23403

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 tools/testing/selftests/rseq/rseq.c           | 19 +++++++++++++++++++
 .../testing/selftests/rseq/run_param_test.sh  |  4 ++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 4847e97ed049..50b13318395a 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -64,6 +64,23 @@ static int sys_rseq(volatile struct rseq *rseq_abi, uint32_t rseq_len,
 	return syscall(__NR_rseq, rseq_abi, rseq_len, flags, sig);
 }
 
+/*
+ * rseq syscall might fail on some platforms due to wrong alignment of TLS
+ * variables:
+ * https://sourceware.org/bugzilla/show_bug.cgi?id=23403
+ *
+ * check if glibc bug is present and skip the test in this case
+ */
+static void assert_rseq_abi_aligned()
+{
+	if ((unsigned long)&__rseq_abi & (__alignof__(__rseq_abi) - 1)) {
+		fputs("__rseq_abi is not properly aligned, which is a known \n"
+		      "glibc nptl bug (https://sourceware.org/bugzilla/show_bug.cgi?id=23403).\n"
+		      "You need a fixed version of glibc to run this test.\n", stderr);
+		exit(4); /* skip this test */
+	}
+}
+
 int rseq_register_current_thread(void)
 {
 	int rc, ret = 0;
@@ -72,6 +89,7 @@ int rseq_register_current_thread(void)
 	signal_off_save(&oldset);
 	if (refcount++)
 		goto end;
+	assert_rseq_abi_aligned();
 	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq), 0, RSEQ_SIG);
 	if (!rc) {
 		assert(rseq_current_cpu_raw() >= 0);
@@ -94,6 +112,7 @@ int rseq_unregister_current_thread(void)
 	signal_off_save(&oldset);
 	if (--refcount)
 		goto end;
+	assert_rseq_abi_aligned();
 	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq),
 		      RSEQ_FLAG_UNREGISTER, RSEQ_SIG);
 	if (!rc)
diff --git a/tools/testing/selftests/rseq/run_param_test.sh b/tools/testing/selftests/rseq/run_param_test.sh
index 3acd6d75ff9f..56caf5e3de3e 100755
--- a/tools/testing/selftests/rseq/run_param_test.sh
+++ b/tools/testing/selftests/rseq/run_param_test.sh
@@ -34,9 +34,9 @@ function do_tests()
 	local i=0
 	while [ "$i" -lt "${#TEST_LIST[@]}" ]; do
 		echo "Running test ${TEST_NAME[$i]}"
-		./param_test ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} || exit 1
+		./param_test ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} || exit $?
 		echo "Running compare-twice test ${TEST_NAME[$i]}"
-		./param_test_compare_twice ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} || exit 1
+		./param_test_compare_twice ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} || exit $?
 		let "i++"
 	done
 }
-- 
2.18.0.13.gd42ae10

