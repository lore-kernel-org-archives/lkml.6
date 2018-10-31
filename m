Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454F9ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E61320664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E61320664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbeJaV6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:58:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728649AbeJaV6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:58:07 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9VCx4Ze094426
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 09:00:11 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nfbkxbsk3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 09:00:09 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Wed, 31 Oct 2018 13:00:06 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Oct 2018 13:00:04 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9VD03sn6816148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Oct 2018 13:00:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A548C11C05B;
        Wed, 31 Oct 2018 13:00:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FD1F11C054;
        Wed, 31 Oct 2018 13:00:03 +0000 (GMT)
Received: from mschwideX1.boeblingen.de.ibm.com (unknown [9.152.212.164])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 31 Oct 2018 13:00:03 +0000 (GMT)
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Li Wang <liwang@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 1/4] mm: make the __PAGETABLE_PxD_FOLDED defines non-empty
Date:   Wed, 31 Oct 2018 13:59:58 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540990801-4261-1-git-send-email-schwidefsky@de.ibm.com>
References: <1540990801-4261-1-git-send-email-schwidefsky@de.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18103113-0016-0000-0000-0000021CFB54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18103113-0017-0000-0000-0000327525EE
Message-Id: <1540990801-4261-2-git-send-email-schwidefsky@de.ibm.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-31_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810310109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the currently empty defines for __PAGETABLE_PMD_FOLDED,
__PAGETABLE_PUD_FOLDED and __PAGETABLE_P4D_FOLDED to return 1.
This makes it possible to use __is_defined() to test if the
preprocessor define exists.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/arm/include/asm/pgtable-2level.h    | 2 +-
 arch/m68k/include/asm/pgtable_mm.h       | 4 ++--
 arch/microblaze/include/asm/pgtable.h    | 2 +-
 arch/nds32/include/asm/pgtable.h         | 2 +-
 arch/parisc/include/asm/pgtable.h        | 2 +-
 include/asm-generic/4level-fixup.h       | 2 +-
 include/asm-generic/5level-fixup.h       | 2 +-
 include/asm-generic/pgtable-nop4d-hack.h | 2 +-
 include/asm-generic/pgtable-nop4d.h      | 2 +-
 include/asm-generic/pgtable-nopmd.h      | 2 +-
 include/asm-generic/pgtable-nopud.h      | 2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 92fd2c8..12659ce 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -10,7 +10,7 @@
 #ifndef _ASM_PGTABLE_2LEVEL_H
 #define _ASM_PGTABLE_2LEVEL_H
 
-#define __PAGETABLE_PMD_FOLDED
+#define __PAGETABLE_PMD_FOLDED 1
 
 /*
  * Hardware-wise, we have a two level page table structure, where the first
diff --git a/arch/m68k/include/asm/pgtable_mm.h b/arch/m68k/include/asm/pgtable_mm.h
index 6181e41..fe3ddd7 100644
--- a/arch/m68k/include/asm/pgtable_mm.h
+++ b/arch/m68k/include/asm/pgtable_mm.h
@@ -55,12 +55,12 @@
  */
 #ifdef CONFIG_SUN3
 #define PTRS_PER_PTE   16
-#define __PAGETABLE_PMD_FOLDED
+#define __PAGETABLE_PMD_FOLDED 1
 #define PTRS_PER_PMD   1
 #define PTRS_PER_PGD   2048
 #elif defined(CONFIG_COLDFIRE)
 #define PTRS_PER_PTE	512
-#define __PAGETABLE_PMD_FOLDED
+#define __PAGETABLE_PMD_FOLDED 1
 #define PTRS_PER_PMD	1
 #define PTRS_PER_PGD	1024
 #else
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index f64ebb9..e14b662 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -63,7 +63,7 @@ extern int mem_init_done;
 
 #include <asm-generic/4level-fixup.h>
 
-#define __PAGETABLE_PMD_FOLDED
+#define __PAGETABLE_PMD_FOLDED 1
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
diff --git a/arch/nds32/include/asm/pgtable.h b/arch/nds32/include/asm/pgtable.h
index d3e19a5..9f52db9 100644
--- a/arch/nds32/include/asm/pgtable.h
+++ b/arch/nds32/include/asm/pgtable.h
@@ -4,7 +4,7 @@
 #ifndef _ASMNDS32_PGTABLE_H
 #define _ASMNDS32_PGTABLE_H
 
-#define __PAGETABLE_PMD_FOLDED
+#define __PAGETABLE_PMD_FOLDED 1
 #include <asm-generic/4level-fixup.h>
 #include <asm-generic/sizes.h>
 
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index b941ac7..c7bb74e 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -111,7 +111,7 @@ static inline void purge_tlb_entries(struct mm_struct *mm, unsigned long addr)
 #if CONFIG_PGTABLE_LEVELS == 3
 #define BITS_PER_PMD	(PAGE_SHIFT + PMD_ORDER - BITS_PER_PMD_ENTRY)
 #else
-#define __PAGETABLE_PMD_FOLDED
+#define __PAGETABLE_PMD_FOLDED 1
 #define BITS_PER_PMD	0
 #endif
 #define PTRS_PER_PMD    (1UL << BITS_PER_PMD)
diff --git a/include/asm-generic/4level-fixup.h b/include/asm-generic/4level-fixup.h
index 89f3b03..e3667c9 100644
--- a/include/asm-generic/4level-fixup.h
+++ b/include/asm-generic/4level-fixup.h
@@ -3,7 +3,7 @@
 #define _4LEVEL_FIXUP_H
 
 #define __ARCH_HAS_4LEVEL_HACK
-#define __PAGETABLE_PUD_FOLDED
+#define __PAGETABLE_PUD_FOLDED 1
 
 #define PUD_SHIFT			PGDIR_SHIFT
 #define PUD_SIZE			PGDIR_SIZE
diff --git a/include/asm-generic/5level-fixup.h b/include/asm-generic/5level-fixup.h
index 9c2e070..73474bb 100644
--- a/include/asm-generic/5level-fixup.h
+++ b/include/asm-generic/5level-fixup.h
@@ -3,7 +3,7 @@
 #define _5LEVEL_FIXUP_H
 
 #define __ARCH_HAS_5LEVEL_HACK
-#define __PAGETABLE_P4D_FOLDED
+#define __PAGETABLE_P4D_FOLDED 1
 
 #define P4D_SHIFT			PGDIR_SHIFT
 #define P4D_SIZE			PGDIR_SIZE
diff --git a/include/asm-generic/pgtable-nop4d-hack.h b/include/asm-generic/pgtable-nop4d-hack.h
index 0c34215..1d6dd38 100644
--- a/include/asm-generic/pgtable-nop4d-hack.h
+++ b/include/asm-generic/pgtable-nop4d-hack.h
@@ -5,7 +5,7 @@
 #ifndef __ASSEMBLY__
 #include <asm-generic/5level-fixup.h>
 
-#define __PAGETABLE_PUD_FOLDED
+#define __PAGETABLE_PUD_FOLDED 1
 
 /*
  * Having the pud type consist of a pgd gets the size right, and allows
diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index 1a29b2a..04cb913 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -4,7 +4,7 @@
 
 #ifndef __ASSEMBLY__
 
-#define __PAGETABLE_P4D_FOLDED
+#define __PAGETABLE_P4D_FOLDED 1
 
 typedef struct { pgd_t pgd; } p4d_t;
 
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index f35f6e8..b85b827 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -8,7 +8,7 @@
 
 struct mm_struct;
 
-#define __PAGETABLE_PMD_FOLDED
+#define __PAGETABLE_PMD_FOLDED 1
 
 /*
  * Having the pmd type consist of a pud gets the size right, and allows
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index e950b9c..9bef475 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -9,7 +9,7 @@
 #else
 #include <asm-generic/pgtable-nop4d.h>
 
-#define __PAGETABLE_PUD_FOLDED
+#define __PAGETABLE_PUD_FOLDED 1
 
 /*
  * Having the pud type consist of a p4d gets the size right, and allows
-- 
2.7.4

