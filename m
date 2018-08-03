Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7571FC4646D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 22:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FB7217B4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 22:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28FB7217B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbeHCX7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 19:59:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729968AbeHCX7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 19:59:16 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w73Ls3bY008270
        for <linux-kernel@vger.kernel.org>; Fri, 3 Aug 2018 18:01:08 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kmudxg8j8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 18:01:07 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Fri, 3 Aug 2018 16:01:07 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 Aug 2018 16:01:04 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w73M14Gw6488410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Aug 2018 15:01:04 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E42EA7805E;
        Fri,  3 Aug 2018 16:01:03 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4C2878067;
        Fri,  3 Aug 2018 16:01:01 -0600 (MDT)
Received: from morokweng.localdomain.com (unknown [9.85.156.5])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 Aug 2018 16:01:01 -0600 (MDT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v2 0/4] userfaultfd: selftest: Improve behavior with older kernels
Date:   Fri,  3 Aug 2018 19:00:42 -0300
X-Mailer: git-send-email 2.14.4
X-TM-AS-GCONF: 00
x-cbid: 18080322-0016-0000-0000-00000913571B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009479; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01069606; UDB=6.00550094; IPR=6.00848261;
 MB=3.00022492; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-03 22:01:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080322-0017-0000-0000-00003FDE5969
Message-Id: <20180803220046.4019-1-bauerman@linux.ibm.com>
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

Hello,

A tester ran the upstream selftest on a distro kernel and sounded the alarm when
it reported failures for features which aren't included in that kernel.

This patch set improves the test behavior in that scenario.

Changes since v1:

- Patch "userfaultfd: selftest: Skip test if userfaultfd() syscall
  not supported"
  - New patch, suggested by Mke Rapoport.

- Patch "userfaultfd: selftest: Skip test if a feature isn't supported"
  - Try running other tests even if one (or more) of them returns KSFT_SKIP.

- Patch "userfaultfd: selftest: Cope if shmem doesn't support zeropage"
  - Ignore lack of UFFDIO_ZEROPAGE in userfaultfd_events_test() and
    userfaultfd_stress().
  - Make userfaultfd_zeropage_test() return KSFT_SKIP if UFFDIO_ZEROPAGE
    isn't supported.

Thiago Jung Bauermann (4):
  userfaultfd: selftest: Fix checking of userfaultfd_open() result
  userfaultfd: selftest: Skip test if userfaultfd() syscall not
    supported
  userfaultfd: selftest: Skip test if a feature isn't supported
  userfaultfd: selftest: Cope if shmem doesn't support zeropage

 tools/testing/selftests/vm/userfaultfd.c | 86 ++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 20 deletions(-)

