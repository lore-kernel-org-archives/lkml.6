Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C03C46475
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944B520827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="arhp51z6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944B520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbeJ2SOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:14:46 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18427 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbeJ2SOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:14:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bd6d2530000>; Mon, 29 Oct 2018 02:26:43 -0700
Received: from HQMAIL108.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 29 Oct 2018 02:26:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 29 Oct 2018 02:26:56 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 29 Oct
 2018 09:26:55 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Mon, 29 Oct 2018 09:26:56 +0000
Received: from amhetre.nvidia.com (Not Verified[10.24.229.42]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bd6d25d0000>; Mon, 29 Oct 2018 02:26:55 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <avanbrunt@nvidia.com>
CC:     <linux-kernel@vger.kernel.org>, <vdumpa@nvidia.com>,
        <Snikam@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>
Subject: [PATCH V3] arm64: Don't flush tlb while clearing the accessed bit
Date:   Mon, 29 Oct 2018 14:55:58 +0530
Message-ID: <1540805158-618-1-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1540805203; bh=FS1bkL6DVpddE8b37EBRqC5NBqnYB3AwAjXcBjxeM68=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=arhp51z6aXvw5Hh68fopPGUfWKKwgmkk5C3iRBkHIDSNz7z/rpjMpIY2kTq9KKTsB
         GwAaWyZRKWIBHwG1TJZjk6tEhmbEupv9MTkEm4hE9lYxVe3Dzv5Bjs3EWsmaoMKjX4
         DniIHEIrWbtJ/BaQ26lYpqn5joe9Bm7xpPhaoJpgepLK7Xh89yoepv7LNh5y+Ri48n
         GB61YTUb37UXImi4jS9+2wraGiIsgnkoiNUp1CUrl94BpYantfN/70AtYDr9Xlv7MU
         Xiiv008sDMKHDXa2mrRg30RDOC/lbxpCKWMLqEZi0pfy6KP+vwzt/UKCZ1+rt4YMtr
         p2+1gwgqn9jKQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Van Brunt <avanbrunt@nvidia.com>

Accessed bit is used to age a page and in generic implementation there is
flush_tlb while clearing the accessed bit.
Flushing a TLB is overhead on ARM64 as access flag faults don't get
translation table entries cached into TLB's. Flushing TLB is not necessary
for this. Clearing the accessed bit without flushing TLB doesn't cause data
corruption on ARM64.
In our case with this patch, speed of reading from fast NVMe/SSD through
PCIe got improved by 10% ~ 15% and writing got improved by 20% ~ 40%.
So for performance optimisation don't flush TLB when clearing the accessed
bit on ARM64.
x86 made the same optimization even though their TLB invalidate is much
faster as it doesn't broadcast to other CPUs.
Please refer to:
'commit b13b1d2d8692 ("x86/mm: In the PTE swapout page reclaim case clear
the accessed bit instead of flushing the TLB")'

Signed-off-by: Alex Van Brunt <avanbrunt@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 arch/arm64/include/asm/pgtable.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 2ab2031..080d842 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -652,6 +652,26 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 	return __ptep_test_and_clear_young(ptep);
 }
 
+#define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
+static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
+					 unsigned long address, pte_t *ptep)
+{
+	/*
+	 * On ARM64 CPUs, clearing the accessed bit without a TLB flush
+	 * doesn't cause data corruption. [ It could cause incorrect
+	 * page aging and the (mistaken) reclaim of hot pages, but the
+	 * chance of that should be relatively low. ]
+	 *
+	 * So as a performance optimization don't flush the TLB when
+	 * clearing the accessed bit, it will eventually be flushed by
+	 * a context switch or a VM operation anyway. [ In the rare
+	 * event of it not getting flushed for a long time the delay
+	 * shouldn't really matter because there's no real memory
+	 * pressure for swapout to react to. ]
+	 */
+	return ptep_test_and_clear_young(vma, address, ptep);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
 static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
-- 
2.7.4

