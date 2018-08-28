Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D59C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56212088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56212088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeH1VTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:19:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727067AbeH1VTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:19:11 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7SHIstn143569
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:26:32 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m586xq0u0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:26:31 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 28 Aug 2018 13:26:30 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 Aug 2018 13:26:26 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7SHQPcm41615436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Aug 2018 17:26:25 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 693F3112062;
        Tue, 28 Aug 2018 13:26:00 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85A4F112064;
        Tue, 28 Aug 2018 13:25:58 -0400 (EDT)
Received: from morokweng.localdomain.com (unknown [9.80.236.98])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 28 Aug 2018 13:25:58 -0400 (EDT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v3 1/4] userfaultfd: selftest: Fix checking of userfaultfd_open() result
Date:   Tue, 28 Aug 2018 14:26:05 -0300
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180828172608.30075-1-bauerman@linux.ibm.com>
References: <20180828172608.30075-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082817-0052-0000-0000-000003275025
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009627; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080161; UDB=6.00557147; IPR=6.00860145;
 MB=3.00022981; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-28 17:26:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082817-0053-0000-0000-00005DE25E03
Message-Id: <20180828172608.30075-2-bauerman@linux.ibm.com>
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
Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
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

