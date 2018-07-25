Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206B8C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E8F20895
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E8F20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388572AbeGYDx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 23:53:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727646AbeGYDx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 23:53:59 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6P2hXui047861
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 22:44:30 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kedmnc5wn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 22:44:28 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 24 Jul 2018 20:44:27 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Jul 2018 20:44:25 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6P2iOfO8782230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Jul 2018 19:44:24 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86BEF7805F;
        Tue, 24 Jul 2018 20:44:24 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CA0C7805E;
        Tue, 24 Jul 2018 20:44:22 -0600 (MDT)
Received: from morokweng.localdomain.com (unknown [9.85.159.138])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 24 Jul 2018 20:44:22 -0600 (MDT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH 3/3] userfaultfd: selftest: Report XFAIL if shmem doesn't support zeropage
Date:   Tue, 24 Jul 2018 23:42:09 -0300
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180725024209.32586-1-bauerman@linux.ibm.com>
References: <20180725024209.32586-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072502-0012-0000-0000-00001690D8E5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009424; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01065718; UDB=6.00547467; IPR=6.00843576;
 MB=3.00022308; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-25 02:44:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072502-0013-0000-0000-000053CAC391
Message-Id: <20180725024209.32586-4-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807250027
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

This is a real failure, but expected so signal that to the test harness:

  # ./userfaultfd shmem 10 10
  nr_pages: 160, nr_pages_per_cpu: 80
  bounces: 9, mode: rnd poll, UFFDIO_ZEROPAGE unsupported in shmem VMAs
  # echo $?
  2

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index bc9ec38fbc34..686fe96f617f 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -1115,6 +1115,14 @@ static int userfaultfd_stress(void)
 		expected_ioctls = uffd_test_ops->expected_ioctls;
 		if ((uffdio_register.ioctls & expected_ioctls) !=
 		    expected_ioctls) {
+			if (test_type == TEST_SHMEM &&
+			    (uffdio_register.ioctls & expected_ioctls) ==
+			    UFFD_API_RANGE_IOCTLS_BASIC) {
+				fprintf(stderr,
+					"UFFDIO_ZEROPAGE unsupported in shmem VMAs\n");
+				return KSFT_XFAIL;
+			}
+
 			fprintf(stderr,
 				"unexpected missing ioctl for anon memory\n");
 			return 1;

