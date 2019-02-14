Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA74C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDEF218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="haog/nuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437905AbfBNVQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:16:55 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36049 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437841AbfBNVQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:16:55 -0500
Received: by mail-it1-f194.google.com with SMTP id h6so16842110itl.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 13:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GvPYFe28/mAoQO+bY6nMt8BakmTEWjcsUcqZny6LKyY=;
        b=haog/nuWNwVzMoU13+bJ0VOVleco8VrScsofzKVQriJp/kpIegpS08FgzPJW6MCcMM
         umb1am7jn04ZVfp/yOI5y2yZNIPu/vejkxNHZoUsN71HWLQEH7YIx7zv4pBqIcXovU3w
         JPZM6QRRB7y782DQnTFoAEKXvcAWCZ+X6byTykTsL+dfSL7xz/fpbcUiIBhrukUyvjLi
         g4eVuY6/2Kdj7uMouqF364Lq2Wvvx9u7FnZJDVv0fv6MtPkEGYCwZRV4qimeeXmvzRZw
         7OEpCUNx91DhVAacamw53xKewe0hTNal7SlZMnIezgIODwSu4C+aoijN+x+caBgPcoxZ
         /odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GvPYFe28/mAoQO+bY6nMt8BakmTEWjcsUcqZny6LKyY=;
        b=XY/HD4D8Qtyfefi1r/cucLGCVjRJ39/jla/tjhsVFm74nMQSkC+D5uWdhcNYOM9Cn9
         QhH11JHbKY8uaH+is9HiGh0NFkvdgx+0VXVNH+o9M17G+xyG1OT3mOjfITNmpJOaUMgG
         cy7dmQOQ0Ld6Srvz6VfM0But1zkfL6ESmlQ4W6BQCXgbs11rg7IU8zDiG8k4ZghoIvTc
         7+4/c2dKYOKj9CVsYUM/mmIGwFiZsbFmBVqJF3cs/iL+6mG8p3Rp+eD6jiirH57B2Mzk
         6b4vdTrb0EKJqfrDIEsQ9YHZAbGfu0ndvfw9JG28nmS2/QxMf5OMbAqn/2RMC941vXPp
         aDkg==
X-Gm-Message-State: AHQUAuav+8RRkRLVe71f48Ypzv/EqqymVnR+An4xNZYUP7ooMMvoIjuY
        O13h3SHXnjHU8aYxkYnv2rZXMg==
X-Google-Smtp-Source: AHgI3IYCX5V8B/n/JHfBn5gh5KmKCeTbBeku15y0Wkk318G3E77K2o5/6CJ6L2HV9dr2oRQlrIFuFg==
X-Received: by 2002:a24:9a84:: with SMTP id l126mr3836833ite.77.1550179014078;
        Thu, 14 Feb 2019 13:16:54 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id h2sm1491498itk.0.2019.02.14.13.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 13:16:53 -0800 (PST)
From:   Yu Zhao <yuzhao@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH] arm64: mm: enable per pmd page table lock
Date:   Thu, 14 Feb 2019 14:16:42 -0700
Message-Id: <20190214211642.2200-1-yuzhao@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch from per mm_struct to per pmd page table lock by enabling
ARCH_ENABLE_SPLIT_PMD_PTLOCK. This provides better granularity for
large system.

I'm not sure if there is contention on mm->page_table_lock. Given
the option comes at no cost (apart from initializing more spin
locks), why not enable it now.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/arm64/Kconfig               |  3 +++
 arch/arm64/include/asm/pgalloc.h | 12 +++++++++++-
 arch/arm64/include/asm/tlb.h     |  5 ++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d366127..104325a1ffc3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -872,6 +872,9 @@ config ARCH_WANT_HUGE_PMD_SHARE
 config ARCH_HAS_CACHE_LINE_SIZE
 	def_bool y
 
+config ARCH_ENABLE_SPLIT_PMD_PTLOCK
+	def_bool y
+
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	---help---
diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 52fa47c73bf0..dabba4b2c61f 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -33,12 +33,22 @@
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return (pmd_t *)__get_free_page(PGALLOC_GFP);
+	struct page *page;
+
+	page = alloc_page(PGALLOC_GFP);
+	if (!page)
+		return NULL;
+	if (!pgtable_pmd_page_ctor(page)) {
+		__free_page(page);
+		return NULL;
+	}
+	return page_address(page);
 }
 
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmdp)
 {
 	BUG_ON((unsigned long)pmdp & (PAGE_SIZE-1));
+	pgtable_pmd_page_dtor(virt_to_page(pmdp));
 	free_page((unsigned long)pmdp);
 }
 
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 106fdc951b6e..4e3becfed387 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -62,7 +62,10 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 				  unsigned long addr)
 {
-	tlb_remove_table(tlb, virt_to_page(pmdp));
+	struct page *page = virt_to_page(pmdp);
+
+	pgtable_pmd_page_dtor(page);
+	tlb_remove_table(tlb, page);
 }
 #endif
 
-- 
2.21.0.rc0.258.g878e2cd30e-goog

