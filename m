Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4674C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779EE2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779EE2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeH1VTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:19:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727067AbeH1VTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:19:15 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7SHIlSi045181
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:26:34 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m58p8wk2r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:26:34 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 28 Aug 2018 13:26:33 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 Aug 2018 13:26:30 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7SHQTqB46989338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Aug 2018 17:26:29 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF38011206B;
        Tue, 28 Aug 2018 13:26:03 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF001112062;
        Tue, 28 Aug 2018 13:26:01 -0400 (EDT)
Received: from morokweng.localdomain.com (unknown [9.80.236.98])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 28 Aug 2018 13:26:01 -0400 (EDT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v3 2/4] userfaultfd: selftest: Skip test if userfaultfd() syscall not supported
Date:   Tue, 28 Aug 2018 14:26:06 -0300
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180828172608.30075-1-bauerman@linux.ibm.com>
References: <20180828172608.30075-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082817-0068-0000-0000-00000330E879
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009627; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080161; UDB=6.00557146; IPR=6.00860146;
 MB=3.00022981; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-28 17:26:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082817-0069-0000-0000-0000458B7965
Message-Id: <20180828172608.30075-3-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=712 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808280173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there's no point in doing anything in this case, immediately exit the
process.

And take the opportunity to improve the error message.

Before:

  # ./userfaultfd shmem 10 10
  nr_pages: 160, nr_pages_per_cpu: 40
  userfaultfd syscall not available in this kernel
  # echo $?
  1

After:

  # ./userfaultfd shmem 10 10
  nr_pages: 160, nr_pages_per_cpu: 40
  userfaultfd syscall not available in this kernel: Function not implemented
  # echo $?
  4

Suggested-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Acked-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index e4099afe7557..d728bd1cb33c 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -636,9 +636,11 @@ static int userfaultfd_open(int features)
 
 	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
 	if (uffd < 0) {
-		fprintf(stderr,
-			"userfaultfd syscall not available in this kernel\n");
-		return 1;
+		int errnum = errno;
+
+		perror("userfaultfd syscall not available in this kernel");
+
+		exit(errnum == ENOSYS ? KSFT_SKIP : 1);
 	}
 	uffd_flags = fcntl(uffd, F_GETFD, NULL);
 

