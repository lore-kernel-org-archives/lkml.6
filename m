Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDF9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C1520685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C1520685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbeJaV6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:58:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728930AbeJaV6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:58:04 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9VCx6U4010459
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 09:00:08 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nfbxu2vnk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 09:00:08 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Wed, 31 Oct 2018 13:00:06 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Oct 2018 13:00:03 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9VD02WO41091274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Oct 2018 13:00:02 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50C0811C04C;
        Wed, 31 Oct 2018 13:00:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A44B11C050;
        Wed, 31 Oct 2018 13:00:02 +0000 (GMT)
Received: from mschwideX1.boeblingen.de.ibm.com (unknown [9.152.212.164])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 31 Oct 2018 13:00:01 +0000 (GMT)
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Li Wang <liwang@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 0/4] pgtable bytes mis-accounting v3
Date:   Wed, 31 Oct 2018 13:59:57 +0100
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18103113-0028-0000-0000-000003109524
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18103113-0029-0000-0000-000023CCC563
Message-Id: <1540990801-4261-1-git-send-email-schwidefsky@de.ibm.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-31_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=592 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810310109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

version #3 of the fix for the pgtable_bytes mis-accounting problem
on s390. Three times is a charm..

Changes v2 -> v3:

 - Add a fourth patch to redefine __PAGETABLE_PxD_FOLDED as non-empty

 - Move mm_pxd_folded() to include/asm-generic/pgtable.h and use
    __is_defined() again with the redefined __PAGETABLE_PxD_FOLDED

 - Add a missing mm_inc_nr_puds() in arch/s390/mm/pgalloc.c

Changes v1 -> v2:

 - Split the patch into three parts, one patch to add the mm_pxd_folded
    helpers, one patch to use to the helpers in mm_[dec|inc]_nr_[pmds|puds]
       and finally the fix for s390.

 - Drop the use of __is_defined, it does not work with the
    __PAGETABLE_PxD_FOLDED defines

 - Do not change the basic #ifdef'ery in mm.h, just add the calls
    to mm_pxd_folded to the pgtable_bytes accounting functions. This
       fixes the compile error on alpha (and potentially on other archs).

Martin Schwidefsky (4):
  mm: make the __PAGETABLE_PxD_FOLDED defines non-empty
  mm: introduce mm_[p4d|pud|pmd]_folded
  mm: add mm_pxd_folded checks to pgtable_bytes accounting functions
  s390/mm: fix mis-accounting of pgtable_bytes

 arch/arm/include/asm/pgtable-2level.h    |  2 +-
 arch/m68k/include/asm/pgtable_mm.h       |  4 ++--
 arch/microblaze/include/asm/pgtable.h    |  2 +-
 arch/nds32/include/asm/pgtable.h         |  2 +-
 arch/parisc/include/asm/pgtable.h        |  2 +-
 arch/s390/include/asm/mmu_context.h      |  5 -----
 arch/s390/include/asm/pgalloc.h          |  6 +++---
 arch/s390/include/asm/pgtable.h          | 18 ++++++++++++++++++
 arch/s390/include/asm/tlb.h              |  6 +++---
 arch/s390/mm/pgalloc.c                   |  1 +
 include/asm-generic/4level-fixup.h       |  2 +-
 include/asm-generic/5level-fixup.h       |  2 +-
 include/asm-generic/pgtable-nop4d-hack.h |  2 +-
 include/asm-generic/pgtable-nop4d.h      |  2 +-
 include/asm-generic/pgtable-nopmd.h      |  2 +-
 include/asm-generic/pgtable-nopud.h      |  2 +-
 include/asm-generic/pgtable.h            | 16 ++++++++++++++++
 include/linux/mm.h                       |  8 ++++++++
 18 files changed, 61 insertions(+), 23 deletions(-)

-- 
2.7.4

