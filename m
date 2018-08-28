Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E184C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80CD2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80CD2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeH1VTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:19:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44622 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726996AbeH1VTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:19:07 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7SHJp0H097671
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:26:26 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m57a21guc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:26:26 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 28 Aug 2018 13:26:25 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 Aug 2018 13:26:23 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7SHQMbK52494508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Aug 2018 17:26:22 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 166A8112064;
        Tue, 28 Aug 2018 13:25:57 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28F1D112066;
        Tue, 28 Aug 2018 13:25:55 -0400 (EDT)
Received: from morokweng.localdomain.com (unknown [9.80.236.98])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 28 Aug 2018 13:25:54 -0400 (EDT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v3 0/4] userfaultfd: selftest: Improve behavior with older kernels
Date:   Tue, 28 Aug 2018 14:26:04 -0300
X-Mailer: git-send-email 2.14.4
X-TM-AS-GCONF: 00
x-cbid: 18082817-0040-0000-0000-000004668D7E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009628; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080161; UDB=6.00557147; IPR=6.00860145;
 MB=3.00022981; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-28 17:26:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082817-0041-0000-0000-0000086DA63B
Message-Id: <20180828172608.30075-1-bauerman@linux.ibm.com>
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

Hello,

This version of the series is unchanged from v2 except for the last patch
which is completely new, and is provided by Mike Rapoport.

Original series description:

> A tester ran the upstream selftest on a distro kernel and sounded the
> alarm when it reported failures for features which aren't included in
> that kernel.
> 
> This patch set improves the test behavior in that scenario.

Changes since v2:

- Added Mike Rapoport's Reviewed-by's and Acked-by's to patches 1-3. 
- Replaced patch 4/4 by the one provided by Mike Rapoport.

Changes since v1:

- Patch "userfaultfd: selftest: Skip test if userfaultfd() syscall
  not supported"
  - New patch, suggested by Mike Rapoport.

- Patch "userfaultfd: selftest: Skip test if a feature isn't supported"
  - Try running other tests even if one (or more) of them returns KSFT_SKIP.

- Patch "userfaultfd: selftest: Cope if shmem doesn't support zeropage"
  - Ignore lack of UFFDIO_ZEROPAGE in userfaultfd_events_test() and
    userfaultfd_stress().
  - Make userfaultfd_zeropage_test() return KSFT_SKIP if UFFDIO_ZEROPAGE
    isn't supported.

Mike Rapoport (1):
  userfaultfd: selftest: make supported range ioctl verification more
    robust

Thiago Jung Bauermann (3):
  userfaultfd: selftest: Fix checking of userfaultfd_open() result
  userfaultfd: selftest: Skip test if userfaultfd() syscall not
    supported
  userfaultfd: selftest: Skip test if a feature isn't supported

 tools/testing/selftests/vm/userfaultfd.c | 113 +++++++++++++++++++------------
 1 file changed, 69 insertions(+), 44 deletions(-)

