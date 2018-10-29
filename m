Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDF4C46475
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 06:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732352082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 06:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cCX0XkJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732352082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbeJ2PSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 11:18:39 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8139 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729225AbeJ2PSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 11:18:38 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bd6a92e0000>; Sun, 28 Oct 2018 23:31:10 -0700
Received: from HQMAIL106.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 28 Oct 2018 23:31:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 28 Oct 2018 23:31:22 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 29 Oct
 2018 06:31:22 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Mon, 29 Oct 2018 06:31:22 +0000
Received: from amhetre.nvidia.com (Not Verified[10.24.229.42]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bd6a9380001>; Sun, 28 Oct 2018 23:31:21 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <avanbrunt@nvidia.com>
CC:     <linux-kernel@vger.kernel.org>, <vdumpa@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [PATCH V2] arm64: Don't flush tlb while clearing the accessed bit
Date:   Mon, 29 Oct 2018 11:59:59 +0530
Message-ID: <1540794599-30922-1-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1540794670; bh=kP6gRkxdVxPNw0KVZ/gw4PC00mKxd4cqx2ODoYa5Fso=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=cCX0XkJnodU6KQYn9O+YSaZQutJBpcJuz9VIAo6/mykkdf3MNuPuvwBWi6RGhxtAh
         dWqL4Ul8tMc4E6om6PE/gp24qEWDnsmG3nO82oBm2H627Tl9p3qIwsBEJ6HdIPy6s4
         RsT4FI7jkBWWyQO0pWESROX0QJVCibu3gAUou9hNM69/aO1EuECVT+ms3EylG3N2da
         0JTbxwa62hy53mVmwyts35s4fg4nPGpoiDYLWILeq1YNJ9IcNCdRk+kywb8fIkGfVt
         oFNcFODaSSdkU/b69lu5S5dnCK0b2rghC4I+wEL78Jh3p13hgr3Ql3JLS3CfvUJoRf
         SbPj2sqwfN00A==
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
corruption on ARM64. [It may cause incorrect page aging but chances of that
should be relatively low.]
In our case with this patch, speed of reading from fast NVMe/SSD through
PCIe got improved by 10% ~ 15% and writing got improved by 20% ~ 40%.
So for performance optimisation don't flush TLB when clearing the accessed
bit on ARM64.
x86 made the same optimization even though their TLB invalidate is much
faster as it doesn't broadcast to other CPUs.

Signed-off-by: Alex Van Brunt <avanbrunt@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
v2: Added comments about why flushing is not needed while clearing accessed bit

 arch/arm64/include/asm/pgtable.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 2ab2031..33e1940 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -652,6 +652,22 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 	return __ptep_test_and_clear_young(ptep);
 }
 
+#define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
+static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
+					 unsigned long address, pte_t *ptep)
+{
+	/*
+	 * Flushing a TLB is overhead on ARM64 as access flag faults don't get
+	 * translation table entries cached into TLB's. Flushing TLB is not
+	 * necessary for this. Clearing the accessed bit without flushing TLB
+	 * doesn't cause data corruption on ARM64.[ It may cause imcorrect page
+	 * aging but chances of this should be comparatively low. ]
+	 * So as a performance optimization don't flush the TLB when clearing
+	 * the accessed bit.
+	 */
+	return ptep_test_and_clear_young(vma, address, ptep);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
 static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
-- 
2.7.4

