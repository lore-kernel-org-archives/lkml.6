Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969B2C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB082088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB082088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeH1VTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:19:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727067AbeH1VTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:19:17 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7SHImZp065192
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:26:36 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m57nx8kns-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:26:36 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 28 Aug 2018 13:26:35 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 Aug 2018 13:26:33 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7SHQWuq23265328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Aug 2018 17:26:32 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 088BB112063;
        Tue, 28 Aug 2018 13:26:07 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34E82112062;
        Tue, 28 Aug 2018 13:26:05 -0400 (EDT)
Received: from morokweng.localdomain.com (unknown [9.80.236.98])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 28 Aug 2018 13:26:05 -0400 (EDT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v3 3/4] userfaultfd: selftest: Skip test if a feature isn't supported
Date:   Tue, 28 Aug 2018 14:26:07 -0300
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180828172608.30075-1-bauerman@linux.ibm.com>
References: <20180828172608.30075-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082817-0072-0000-0000-000003989CB5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009628; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080161; UDB=6.00557146; IPR=6.00860146;
 MB=3.00022981; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-28 17:26:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082817-0073-0000-0000-0000493B1AD4
Message-Id: <20180828172608.30075-4-bauerman@linux.ibm.com>
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

If userfaultfd runs on a system that doesn't support some feature it is
trying to test, it currently ends with error code 1 which indicates
test failure:

  # ./userfaultfd anon 10 10
  nr_pages: 160, nr_pages_per_cpu: 80
  bounces: 9, mode: rnd poll, userfaults: 7 59
  bounces: 8, mode: poll, userfaults: 0 0
  bounces: 7, mode: rnd racing ver, userfaults: 45 2
  bounces: 6, mode: racing ver, userfaults: 3 1
  bounces: 5, mode: rnd ver, userfaults: 55 32
  bounces: 4, mode: ver, userfaults: 69 0
  bounces: 3, mode: rnd racing, userfaults: 1 1
  bounces: 2, mode: racing, userfaults: 65 0
  bounces: 1, mode: rnd, userfaults: 44 1
  bounces: 0, mode:, userfaults: 3 2
  testing UFFDIO_ZEROPAGE: done.
  testing signal delivery: UFFDIO_API
  # echo $?
  1

Make each test return KSFT_SKIP instead, which is more accurate since it is
not a real test failure and try to run the other tests which may still
work:

  # ./userfaultfd anon 10 10
  nr_pages: 160, nr_pages_per_cpu: 80
  bounces: 9, mode: rnd poll, userfaults: 65 27
  bounces: 8, mode: poll, userfaults: 0 0
  bounces: 7, mode: rnd racing ver, userfaults: 60 29
  bounces: 6, mode: racing ver, userfaults: 58 1
  bounces: 5, mode: rnd ver, userfaults: 69 3
  bounces: 4, mode: ver, userfaults: 35 27
  bounces: 3, mode: rnd racing, userfaults: 44 0
  bounces: 2, mode: racing, userfaults: 40 25
  bounces: 1, mode: rnd, userfaults: 2 1
  bounces: 0, mode:, userfaults: 0 1
  testing UFFDIO_ZEROPAGE: done.
  testing signal delivery: UFFDIO_API: Invalid argument
  testing events (fork, remap, remove): userfaults: 160
  # echo $?
  0

While at it, also improve the error message of the ioctl(UFFDIO_API) call.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Acked-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 42 +++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index d728bd1cb33c..c84e44ddf314 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -647,8 +647,11 @@ static int userfaultfd_open(int features)
 	uffdio_api.api = UFFD_API;
 	uffdio_api.features = features;
 	if (ioctl(uffd, UFFDIO_API, &uffdio_api)) {
-		fprintf(stderr, "UFFDIO_API\n");
-		return 1;
+		int errnum = errno;
+
+		perror("UFFDIO_API");
+
+		return errnum == EINVAL ? KSFT_SKIP : 1;
 	}
 	if (uffdio_api.api != UFFD_API) {
 		fprintf(stderr, "UFFDIO_API error %Lu\n", uffdio_api.api);
@@ -854,6 +857,7 @@ static int userfaultfd_zeropage_test(void)
 {
 	struct uffdio_register uffdio_register;
 	unsigned long expected_ioctls;
+	int err;
 
 	printf("testing UFFDIO_ZEROPAGE: ");
 	fflush(stdout);
@@ -861,8 +865,10 @@ static int userfaultfd_zeropage_test(void)
 	if (uffd_test_ops->release_pages(area_dst))
 		return 1;
 
-	if (userfaultfd_open(0))
-		return 1;
+	err = userfaultfd_open(0);
+	if (err)
+		return err;
+
 	uffdio_register.range.start = (unsigned long) area_dst;
 	uffdio_register.range.len = nr_pages * page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
@@ -904,8 +910,10 @@ static int userfaultfd_events_test(void)
 
 	features = UFFD_FEATURE_EVENT_FORK | UFFD_FEATURE_EVENT_REMAP |
 		UFFD_FEATURE_EVENT_REMOVE;
-	if (userfaultfd_open(features))
-		return 1;
+	err = userfaultfd_open(features);
+	if (err)
+		return err;
+
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 
 	uffdio_register.range.start = (unsigned long) area_dst;
@@ -963,8 +971,9 @@ static int userfaultfd_sig_test(void)
 		return 1;
 
 	features = UFFD_FEATURE_EVENT_FORK|UFFD_FEATURE_SIGBUS;
-	if (userfaultfd_open(features))
-		return 1;
+	err = userfaultfd_open(features);
+	if (err)
+		return err;
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 
 	uffdio_register.range.start = (unsigned long) area_dst;
@@ -1029,8 +1038,9 @@ static int userfaultfd_stress(void)
 	if (!area_dst)
 		return 1;
 
-	if (userfaultfd_open(0))
-		return 1;
+	err = userfaultfd_open(0);
+	if (err)
+		return err;
 
 	count_verify = malloc(nr_pages * sizeof(unsigned long long));
 	if (!count_verify) {
@@ -1201,8 +1211,16 @@ static int userfaultfd_stress(void)
 		return err;
 
 	close(uffd);
-	return userfaultfd_zeropage_test() || userfaultfd_sig_test()
-		|| userfaultfd_events_test();
+
+	err = userfaultfd_zeropage_test();
+	if (err && err != KSFT_SKIP)
+		return err;
+
+	err = userfaultfd_sig_test();
+	if (err && err != KSFT_SKIP)
+		return err;
+
+	return userfaultfd_events_test();
 }
 
 /*

