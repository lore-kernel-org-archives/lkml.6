Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76959C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 03:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41ADE20865
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 03:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41ADE20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeJKLSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 07:18:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726047AbeJKLSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 07:18:34 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9B3mr2d004433
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 23:53:16 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n1wcku6g5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 23:53:16 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 10 Oct 2018 21:53:16 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 10 Oct 2018 21:53:12 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9B3rBwl23134458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Oct 2018 20:53:11 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6738978064;
        Wed, 10 Oct 2018 21:53:11 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09BCD78067;
        Wed, 10 Oct 2018 21:53:08 -0600 (MDT)
Received: from skywalker.ibmuc.com (unknown [9.85.73.187])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 10 Oct 2018 21:53:08 -0600 (MDT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 0/5] NestMMU pte upgrade workaround for mprotect and autonuma
Date:   Thu, 11 Oct 2018 09:22:42 +0530
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 18101103-0016-0000-0000-0000093F5F92
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009857; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01100919; UDB=6.00569641; IPR=6.00880964;
 MB=3.00023702; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-11 03:53:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101103-0017-0000-0000-000040A9328D
Message-Id: <20181011035247.30687-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=421 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can upgrade pte access (R -> RW transition) via mprotect or autonuma. We need
to make sure we follow the recommended pte update sequence as outlined in
commit: bd5050e38aec ("powerpc/mm/radix: Change pte relax sequence to handle nest MMU hang")
for such updates. This patch series do that.

Aneesh Kumar K.V (5):
  mm: Update ptep_modify_prot_start/commit to take vm_area_struct as arg
  mm: update ptep_modify_prot_commit to take old pte value as arg
  arch/powerpc/mm: Nest MMU workaround for mprotect/autonuma RW upgrade.
  mm/hugetlb: Add prot_modify_start/commit sequence for hugetlb update
  arch/powerpc/mm/hugetlb: NestMMU workaround for hugetlb mprotect RW
    upgrade

 arch/powerpc/include/asm/book3s/64/hugetlb.h |  8 +++++
 arch/powerpc/include/asm/book3s/64/pgtable.h | 18 ++++++++++
 arch/powerpc/include/asm/hugetlb.h           |  2 +-
 arch/powerpc/mm/hugetlbpage.c                | 35 ++++++++++++++++++++
 arch/powerpc/mm/pgtable-book3s64.c           | 34 +++++++++++++++++++
 arch/s390/include/asm/pgtable.h              |  5 +--
 arch/s390/mm/pgtable.c                       |  8 +++--
 arch/x86/include/asm/paravirt.h              |  9 +++--
 fs/proc/task_mmu.c                           |  8 +++--
 include/asm-generic/pgtable.h                | 10 +++---
 include/linux/hugetlb.h                      | 18 ++++++++++
 mm/hugetlb.c                                 |  8 +++--
 mm/memory.c                                  |  8 ++---
 mm/mprotect.c                                |  6 ++--
 14 files changed, 150 insertions(+), 27 deletions(-)

-- 
2.17.1

