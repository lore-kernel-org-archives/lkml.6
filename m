Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1934CC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 22:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0EB217BD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 22:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0EB217BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbeHCX7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 19:59:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40482 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732106AbeHCX7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 19:59:31 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w73Ls4c6008313
        for <linux-kernel@vger.kernel.org>; Fri, 3 Aug 2018 18:01:22 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kmudxg8tq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 18:01:21 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Fri, 3 Aug 2018 16:01:21 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 Aug 2018 16:01:19 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w73M1ItZ8585558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Aug 2018 15:01:18 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 873AE78060;
        Fri,  3 Aug 2018 16:01:18 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A35CB78067;
        Fri,  3 Aug 2018 16:01:16 -0600 (MDT)
Received: from morokweng.localdomain.com (unknown [9.85.156.5])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 Aug 2018 16:01:16 -0600 (MDT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v2 4/4] userfaultfd: selftest: Cope if shmem doesn't support zeropage
Date:   Fri,  3 Aug 2018 19:00:46 -0300
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180803220046.4019-1-bauerman@linux.ibm.com>
References: <20180803220046.4019-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18080322-0012-0000-0000-000016970ED4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009479; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01069606; UDB=6.00550093; IPR=6.00848260;
 MB=3.00022492; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-03 22:01:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080322-0013-0000-0000-000053E8A075
Message-Id: <20180803220046.4019-5-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-03_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808030236
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If userfaultfd runs on a system that doesn't support UFFDIO_ZEROPAGE for
shared memory, it currently ends with error code 1 which indicates test
failure:

  # ./userfaultfd shmem 10 10
  nr_pages: 160, nr_pages_per_cpu: 80
  bounces: 9, mode: rnd poll, unexpected missing ioctl for anon memory
  # echo $?
  1

Change userfaultfd_zeropage_test() to return KSFT_SKIP to indicate that
the test is being skipped.

Also change userfaultfd_events_test() and userfaultfd_stress() to ignore
the missing UFFDIO_ZEROPAGE bit from the list of supported ioctls since
these tests don't require that feature.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 36 +++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index c84e44ddf314..00f1ca663d67 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -852,6 +852,16 @@ static int uffdio_zeropage(int ufd, unsigned long offset)
 	return __uffdio_zeropage(ufd, offset, false);
 }
 
+/* Tells whether the kernel doesn't support ZEROPAGE on shared memory VMAs. */
+static bool shmem_without_zeropage_support(unsigned long expected_ioctls,
+					   unsigned long supported_ioctls)
+{
+	/* Turn off ZEROPAGE bit from expected_ioctls. */
+	expected_ioctls &= ~(1 << _UFFDIO_ZEROPAGE);
+
+	return test_type == TEST_SHMEM && supported_ioctls == expected_ioctls;
+}
+
 /* exercise UFFDIO_ZEROPAGE */
 static int userfaultfd_zeropage_test(void)
 {
@@ -877,10 +887,20 @@ static int userfaultfd_zeropage_test(void)
 
 	expected_ioctls = uffd_test_ops->expected_ioctls;
 	if ((uffdio_register.ioctls & expected_ioctls) !=
-	    expected_ioctls)
+	    expected_ioctls) {
+		close(uffd);
+
+		if (shmem_without_zeropage_support(expected_ioctls,
+						   uffdio_register.ioctls)) {
+			fprintf(stderr,
+				"UFFDIO_ZEROPAGE unsupported in shmem VMAs\n");
+			return KSFT_SKIP;
+		}
+
 		fprintf(stderr,
-			"unexpected missing ioctl for anon memory\n"),
-			exit(1);
+			"unexpected missing ioctl for anon memory\n");
+		return 1;
+	}
 
 	if (uffdio_zeropage(uffd, 0)) {
 		if (my_bcmp(area_dst, zeropage, page_size))
@@ -924,7 +944,10 @@ static int userfaultfd_events_test(void)
 
 	expected_ioctls = uffd_test_ops->expected_ioctls;
 	if ((uffdio_register.ioctls & expected_ioctls) !=
-	    expected_ioctls)
+	    expected_ioctls &&
+	    /* No need for zeropage support in this test, so ignore it. */
+	    !shmem_without_zeropage_support(expected_ioctls,
+					    uffdio_register.ioctls))
 		fprintf(stderr,
 			"unexpected missing ioctl for anon memory\n"),
 			exit(1);
@@ -1117,7 +1140,10 @@ static int userfaultfd_stress(void)
 		}
 		expected_ioctls = uffd_test_ops->expected_ioctls;
 		if ((uffdio_register.ioctls & expected_ioctls) !=
-		    expected_ioctls) {
+		    expected_ioctls &&
+		    /* No need for zeropage support in this test, so ignore it. */
+		    !shmem_without_zeropage_support(expected_ioctls,
+						    uffdio_register.ioctls)) {
 			fprintf(stderr,
 				"unexpected missing ioctl for anon memory\n");
 			return 1;

