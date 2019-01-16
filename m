Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAFDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254B2206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404407AbfAPNpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:45:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404378AbfAPNo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:44:59 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0GDfQdj113195
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:44:58 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q23br7599-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:44:57 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 16 Jan 2019 13:44:55 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 13:44:43 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0GDigZr52232384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 13:44:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B34AA405B;
        Wed, 16 Jan 2019 13:44:42 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F37B0A4054;
        Wed, 16 Jan 2019 13:44:37 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.226])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Jan 2019 13:44:37 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 16 Jan 2019 15:44:37 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Petr Mladek <pmladek@suse.com>, Rich Felker <dalias@libc.org>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        devicetree@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org,
        xen-devel@lists.xenproject.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 03/21] memblock: replace memblock_alloc_base(ANYWHERE) with memblock_phys_alloc
Date:   Wed, 16 Jan 2019 15:44:03 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011613-4275-0000-0000-000002FFFEE3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011613-4276-0000-0000-0000380E2037
Message-Id: <1547646261-32535-4-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=727 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The calls to memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ANYWHERE) and
memblock_phys_alloc(size, align) are equivalent as both try to allocate
'size' bytes with 'align' alignment anywhere in the memory and panic if hte
allocation fails.

The conversion is done using the following semantic patch:

@@
expression size, align;
@@
- memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ANYWHERE)
+ memblock_phys_alloc(size, align)

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/mm/init.c                   | 2 +-
 arch/sh/boards/mach-ap325rxa/setup.c | 2 +-
 arch/sh/boards/mach-ecovec24/setup.c | 4 ++--
 arch/sh/boards/mach-kfr2r09/setup.c  | 2 +-
 arch/sh/boards/mach-migor/setup.c    | 2 +-
 arch/sh/boards/mach-se/7724/setup.c  | 4 ++--
 arch/xtensa/mm/kasan_init.c          | 3 +--
 7 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 478ea8b..b76b90e 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -205,7 +205,7 @@ phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
 
 	BUG_ON(!arm_memblock_steal_permitted);
 
-	phys = memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, align);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 
diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index 8f234d04..d7ceab6 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -557,7 +557,7 @@ static void __init ap325rxa_mv_mem_reserve(void)
 	phys_addr_t phys;
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
-	phys = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, PAGE_SIZE);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 22b4106..a3901806 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -1480,12 +1480,12 @@ static void __init ecovec_mv_mem_reserve(void)
 	phys_addr_t phys;
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
-	phys = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, PAGE_SIZE);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 	ceu0_dma_membase = phys;
 
-	phys = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, PAGE_SIZE);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 	ceu1_dma_membase = phys;
diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 203d249..55bdf4a 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -631,7 +631,7 @@ static void __init kfr2r09_mv_mem_reserve(void)
 	phys_addr_t phys;
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
-	phys = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, PAGE_SIZE);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index f4ad33c..ba7eee6 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -630,7 +630,7 @@ static void __init migor_mv_mem_reserve(void)
 	phys_addr_t phys;
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
-	phys = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, PAGE_SIZE);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index fdbec22a..4696e10 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -965,12 +965,12 @@ static void __init ms7724se_mv_mem_reserve(void)
 	phys_addr_t phys;
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
-	phys = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, PAGE_SIZE);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 	ceu0_dma_membase = phys;
 
-	phys = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, PAGE_SIZE);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 	ceu1_dma_membase = phys;
diff --git a/arch/xtensa/mm/kasan_init.c b/arch/xtensa/mm/kasan_init.c
index 1734cda..48dbb03 100644
--- a/arch/xtensa/mm/kasan_init.c
+++ b/arch/xtensa/mm/kasan_init.c
@@ -52,8 +52,7 @@ static void __init populate(void *start, void *end)
 
 		for (k = 0; k < PTRS_PER_PTE; ++k, ++j) {
 			phys_addr_t phys =
-				memblock_alloc_base(PAGE_SIZE, PAGE_SIZE,
-						    MEMBLOCK_ALLOC_ANYWHERE);
+				memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 
 			set_pte(pte + j, pfn_pte(PHYS_PFN(phys), PAGE_KERNEL));
 		}
-- 
2.7.4

