Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA36FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E842088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E842088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeH1VTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:19:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44030 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727067AbeH1VTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:19:20 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7SHIlB7030589
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:26:39 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m57d69cyt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:26:39 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 28 Aug 2018 13:26:38 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 Aug 2018 13:26:36 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7SHQZ4t22282272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Aug 2018 17:26:35 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62C46112063;
        Tue, 28 Aug 2018 13:26:10 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FFDC112066;
        Tue, 28 Aug 2018 13:26:08 -0400 (EDT)
Received: from morokweng.localdomain.com (unknown [9.80.236.98])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 28 Aug 2018 13:26:08 -0400 (EDT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v3 4/4] userfaultfd: selftest: make supported range ioctl verification more robust
Date:   Tue, 28 Aug 2018 14:26:08 -0300
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180828172608.30075-1-bauerman@linux.ibm.com>
References: <20180828172608.30075-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082817-0052-0000-0000-000003275028
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009627; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080161; UDB=6.00557147; IPR=6.00860145;
 MB=3.00022981; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-28 17:26:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082817-0053-0000-0000-00005DE25E1B
Message-Id: <20180828172608.30075-5-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808280173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.vnet.ibm.com>

When userfaultfd tests runs on older kernel that does not support
UFFDIO_ZEROPAGE for shared memory it fails at the ioctl verification.

Split out the verification that supported ioctls are superset of the
expected ioctls and relax the checks for UFFDIO_ZEROPAGE for shared memory
areas.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 63 +++++++++++++++++---------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index c84e44ddf314..676cbedff3db 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -271,6 +271,32 @@ static int my_bcmp(char *str1, char *str2, size_t n)
 	return 0;
 }
 
+static int verify_ioctls(unsigned long supported_ioctls)
+{
+	unsigned long expected_ioctls = uffd_test_ops->expected_ioctls;
+
+	if ((supported_ioctls & expected_ioctls) == expected_ioctls)
+		return 0;
+
+	/*
+	 * For older kernels shared memory may not have UFFDIO_ZEROPAGE.
+	 * In this case we just mask it out from the
+	 * expected_ioctls. The userfaultfd_zeropage_test will then
+	 * verify that an attempt to use UFFDIO_ZEROPAGE returns
+	 * EINVAL
+	 */
+	if (test_type == TEST_SHMEM) {
+		expected_ioctls &= ~(1 << _UFFDIO_ZEROPAGE);
+		if ((supported_ioctls & expected_ioctls) == expected_ioctls) {
+			uffd_test_ops->expected_ioctls = expected_ioctls;
+			return 0;
+		}
+	}
+
+	fprintf(stderr, "unexpected missing ioctl\n");
+	return 1;
+}
+
 static void *locking_thread(void *arg)
 {
 	unsigned long cpu = (unsigned long) arg;
@@ -856,7 +882,6 @@ static int uffdio_zeropage(int ufd, unsigned long offset)
 static int userfaultfd_zeropage_test(void)
 {
 	struct uffdio_register uffdio_register;
-	unsigned long expected_ioctls;
 	int err;
 
 	printf("testing UFFDIO_ZEROPAGE: ");
@@ -875,12 +900,8 @@ static int userfaultfd_zeropage_test(void)
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 		fprintf(stderr, "register failure\n"), exit(1);
 
-	expected_ioctls = uffd_test_ops->expected_ioctls;
-	if ((uffdio_register.ioctls & expected_ioctls) !=
-	    expected_ioctls)
-		fprintf(stderr,
-			"unexpected missing ioctl for anon memory\n"),
-			exit(1);
+	if (verify_ioctls(uffdio_register.ioctls))
+		return 1;
 
 	if (uffdio_zeropage(uffd, 0)) {
 		if (my_bcmp(area_dst, zeropage, page_size))
@@ -895,7 +916,6 @@ static int userfaultfd_zeropage_test(void)
 static int userfaultfd_events_test(void)
 {
 	struct uffdio_register uffdio_register;
-	unsigned long expected_ioctls;
 	unsigned long userfaults;
 	pthread_t uffd_mon;
 	int err, features;
@@ -922,12 +942,8 @@ static int userfaultfd_events_test(void)
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 		fprintf(stderr, "register failure\n"), exit(1);
 
-	expected_ioctls = uffd_test_ops->expected_ioctls;
-	if ((uffdio_register.ioctls & expected_ioctls) !=
-	    expected_ioctls)
-		fprintf(stderr,
-			"unexpected missing ioctl for anon memory\n"),
-			exit(1);
+	if (verify_ioctls(uffdio_register.ioctls))
+		return 1;
 
 	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, NULL))
 		perror("uffd_poll_thread create"), exit(1);
@@ -957,7 +973,6 @@ static int userfaultfd_events_test(void)
 static int userfaultfd_sig_test(void)
 {
 	struct uffdio_register uffdio_register;
-	unsigned long expected_ioctls;
 	unsigned long userfaults;
 	pthread_t uffd_mon;
 	int err, features;
@@ -982,12 +997,8 @@ static int userfaultfd_sig_test(void)
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 		fprintf(stderr, "register failure\n"), exit(1);
 
-	expected_ioctls = uffd_test_ops->expected_ioctls;
-	if ((uffdio_register.ioctls & expected_ioctls) !=
-	    expected_ioctls)
-		fprintf(stderr,
-			"unexpected missing ioctl for anon memory\n"),
-			exit(1);
+	if (verify_ioctls(uffdio_register.ioctls))
+		return 1;
 
 	if (faulting_process(1))
 		fprintf(stderr, "faulting process failed\n"), exit(1);
@@ -1088,8 +1099,6 @@ static int userfaultfd_stress(void)
 
 	err = 0;
 	while (bounces--) {
-		unsigned long expected_ioctls;
-
 		printf("bounces: %d, mode:", bounces);
 		if (bounces & BOUNCE_RANDOM)
 			printf(" rnd");
@@ -1115,13 +1124,9 @@ static int userfaultfd_stress(void)
 			fprintf(stderr, "register failure\n");
 			return 1;
 		}
-		expected_ioctls = uffd_test_ops->expected_ioctls;
-		if ((uffdio_register.ioctls & expected_ioctls) !=
-		    expected_ioctls) {
-			fprintf(stderr,
-				"unexpected missing ioctl for anon memory\n");
+
+		if (verify_ioctls(uffdio_register.ioctls))
 			return 1;
-		}
 
 		if (area_dst_alias) {
 			uffdio_register.range.start = (unsigned long)

