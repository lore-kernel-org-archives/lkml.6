Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5EDC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D5F2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D5F2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933528AbeGJN6Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:58:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933330AbeGJN6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:58:24 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6ADtQoN111126
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 09:58:23 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k4u61g6bq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 09:58:23 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Tue, 10 Jul 2018 14:58:21 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Jul 2018 14:58:19 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6ADwITC33226798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Jul 2018 13:58:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B07311C05E;
        Tue, 10 Jul 2018 16:58:41 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A42511C04C;
        Tue, 10 Jul 2018 16:58:40 +0100 (BST)
Received: from localhost.localdomain (unknown [9.195.22.129])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Jul 2018 16:58:39 +0100 (BST)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com,
        ravi.bangoria@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH 0/5] perf: Fixes for callchain ip handling and related tests
Date:   Tue, 10 Jul 2018 19:28:12 +0530
X-Mailer: git-send-email 2.14.4
X-TM-AS-GCONF: 00
x-cbid: 18071013-0028-0000-0000-000002DA12B6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071013-0029-0000-0000-00002391B44B
Message-Id: <cover.1530724939.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-10_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807100151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two patches fix the callchain ip filtering mechanism for
powerpc from skipping entries unecessarily by checking the status of
a function's return address in the stack.

The third patch fixes a shell test that fails on powerpc due to a
mismatch in the expected perf script output.

The fourth and fifth patches are generic fixes for the same shell
test.

--

Hi Arnaldo,

This series has fixes for the inet_pton shell test and depends
on the following patches from Kim Phillips:

[1] https://lkml.org/lkml/2018/6/29/570
[2] https://lkml.org/lkml/2018/6/29/568

I did see that you had replied saying that you have applied
these patches to your tree but I still do not see the changes
in the 'perf/core' and 'perf/urgent' branches. Assuming that
you would be pushing these changes, I applied Kim's patches
to my local tree manually before I started working on this
series.

--

Sandipan Das (5):
  perf powerpc: Fix callchain ip filtering
  perf powerpc: Fix callchain ip filtering when return address is in a
    register
  perf tests: Fix record+probe_libc_inet_pton.sh for powerpc64
  perf tests: Fix record+probe_libc_inet_pton.sh to ensure cleanups
  perf tests: Fix record+probe_libc_inet_pton.sh when event exists

 tools/perf/arch/powerpc/util/skip-callchain-idx.c  | 10 ++++--
 .../tests/shell/record+probe_libc_inet_pton.sh     | 36 +++++++++++++++++++---
 2 files changed, 38 insertions(+), 8 deletions(-)

-- 
2.14.4

