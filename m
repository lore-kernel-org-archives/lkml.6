Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55192C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091A22088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091A22088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbeGYD6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 23:58:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52656 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727353AbeGYD6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 23:58:51 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6P2mfrd126487
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 22:49:21 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2keatc4335-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 22:49:20 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 24 Jul 2018 20:44:20 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Jul 2018 20:44:18 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6P2iHpu11862414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Jul 2018 19:44:17 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89D9578060;
        Tue, 24 Jul 2018 20:44:17 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2E6C7805E;
        Tue, 24 Jul 2018 20:44:15 -0600 (MDT)
Received: from morokweng.localdomain.com (unknown [9.85.159.138])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 24 Jul 2018 20:44:15 -0600 (MDT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH 1/3] userfaultfd: selftest: Fix checking of userfaultfd_open() result
Date:   Tue, 24 Jul 2018 23:42:07 -0300
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180725024209.32586-1-bauerman@linux.ibm.com>
References: <20180725024209.32586-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072502-0016-0000-0000-0000090CFFBA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009424; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01065718; UDB=6.00547467; IPR=6.00843577;
 MB=3.00022308; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-25 02:44:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072502-0017-0000-0000-00003FC04DED
Message-Id: <20180725024209.32586-2-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807250028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the userfaultfd test is run on a kernel with CONFIG_USERFAULTFD=n, it
will report that the system call is not available yet go ahead and continue
anyway:

  # ./userfaultfd anon 30 1
  nr_pages: 480, nr_pages_per_cpu: 120
  userfaultfd syscall not available in this kernel
  bounces: 0, mode:, register failure

This is because userfaultfd_open() returns 0 on success and 1 on error but
all callers assume that it returns < 0 on error.

Since the convention of the test as a whole is the one used by
userfault_open(), fix its callers instead. Now the test behaves correctly:

  # ./userfaultfd anon 30 1
  nr_pages: 480, nr_pages_per_cpu: 120
  userfaultfd syscall not available in this kernel

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 7b8171e3128a..e4099afe7557 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -859,7 +859,7 @@ static int userfaultfd_zeropage_test(void)
 	if (uffd_test_ops->release_pages(area_dst))
 		return 1;
 
-	if (userfaultfd_open(0) < 0)
+	if (userfaultfd_open(0))
 		return 1;
 	uffdio_register.range.start = (unsigned long) area_dst;
 	uffdio_register.range.len = nr_pages * page_size;
@@ -902,7 +902,7 @@ static int userfaultfd_events_test(void)
 
 	features = UFFD_FEATURE_EVENT_FORK | UFFD_FEATURE_EVENT_REMAP |
 		UFFD_FEATURE_EVENT_REMOVE;
-	if (userfaultfd_open(features) < 0)
+	if (userfaultfd_open(features))
 		return 1;
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 
@@ -961,7 +961,7 @@ static int userfaultfd_sig_test(void)
 		return 1;
 
 	features = UFFD_FEATURE_EVENT_FORK|UFFD_FEATURE_SIGBUS;
-	if (userfaultfd_open(features) < 0)
+	if (userfaultfd_open(features))
 		return 1;
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 
@@ -1027,7 +1027,7 @@ static int userfaultfd_stress(void)
 	if (!area_dst)
 		return 1;
 
-	if (userfaultfd_open(0) < 0)
+	if (userfaultfd_open(0))
 		return 1;
 
 	count_verify = malloc(nr_pages * sizeof(unsigned long long));

