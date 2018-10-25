Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC36CECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02C320848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aef7TrC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02C320848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeJZAqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:46:20 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14830 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeJZAqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:46:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bd1eb7b0000>; Thu, 25 Oct 2018 09:12:43 -0700
Received: from HQMAIL103.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 25 Oct 2018 09:12:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 25 Oct 2018 09:12:53 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 25 Oct
 2018 16:12:53 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 25 Oct
 2018 16:12:53 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 25 Oct 2018 16:12:53 +0000
Received: from amhetre.nvidia.com (Not Verified[10.24.229.42]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bd1eb830000>; Thu, 25 Oct 2018 09:12:52 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <avanbrunt@nvidia.com>
CC:     <linux-kernel@vger.kernel.org>, <vdumpa@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [PATCH] arm64: Don't flush tlb while clearing the accessed bit
Date:   Thu, 25 Oct 2018 21:42:24 +0530
Message-ID: <1540483944-22718-1-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1540483963; bh=25Ge87mX5ncGi2CLTt5qJxGVgYDEqWGdY8NC/dTjaeA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=aef7TrC+LJuz9erS3H95if2hyWPHKQvKilPLO/bjC1Seo5xlOBnRvIIj+rGFhWJOh
         fiIMRreJ66kgpJqp4HtDgVzv7PDmqo9L0/c4JuSoV0t/3AXoRtKcGkvN/gtOYqOaj+
         UeIjebF7efrP7Se7YFkwOsT59keKIeFTjdaNvq+mDjbldjyaLEPk5hQrDdltRqurlZ
         V3dphZq4sdT3+oBP9WehGx17TQ6ZH/M8Iqk1VWDgR1h9Jq4RfG2/3hUUF0/uSNDERd
         3STJ0FH1swnyLovoSbPgYyaCidiqboLkKRSw3qeR9tWTSrlUjGcJuvdd1aFm1Vt3xH
         eqXecriEqBAZw==
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

Signed-off-by: Alex Van Brunt <avanbrunt@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 arch/arm64/include/asm/pgtable.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 2ab2031..42931f6 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -652,6 +652,13 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 	return __ptep_test_and_clear_young(ptep);
 }
 
+#define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
+static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
+					 unsigned long address, pte_t *ptep)
+{
+	return ptep_test_and_clear_young(vma, address, ptep);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
 static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
-- 
2.7.4

