Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ1LxOzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 10BFE60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932142AbeFFEjp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 00:39:45 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41124 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932113AbeFFEjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 00:39:42 -0400
X-Google-Smtp-Source: ADUXVKKUXIMfOb4Qj0Ah0fhEFbIvAU/+dK1Bw2MH73G6LAHXVxP93KsJokQZbZZXn4ku+L1G/XZRCg==
From: Jun Yao <yaojun8558363@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        robin.murphy@arm.com, labbott@redhat.com,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH v3 2/3] arm64/mm: introduce variable to save new swapper_pg_dir address
Date: Wed,  6 Jun 2018 12:39:20 +0800
Message-Id: <20180606043921.19851-3-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180606043921.19851-1-yaojun8558363@gmail.com>
References: <20180606043921.19851-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for migrating swapper_pg_dir, introduce new_swapper_pg_dir
to save virtual address of swapper_pg_dir.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/include/asm/mmu_context.h | 2 +-
 arch/arm64/include/asm/pgtable.h     | 1 +
 arch/arm64/mm/kasan_init.c           | 2 +-
 arch/arm64/mm/mmu.c                  | 2 ++
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 3eddb871f251..481c2d16adeb 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -57,7 +57,7 @@ static inline void cpu_set_reserved_ttbr0(void)
 
 static inline void cpu_switch_mm(pgd_t *pgd, struct mm_struct *mm)
 {
-	BUG_ON(pgd == swapper_pg_dir);
+	BUG_ON(pgd == new_swapper_pg_dir);
 	cpu_set_reserved_ttbr0();
 	cpu_do_switch_mm(virt_to_phys(pgd),mm);
 }
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 519ab5581b08..2bda899dcf22 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -723,6 +723,7 @@ extern pgd_t swapper_pg_end[];
 extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
 extern pgd_t tramp_pg_dir[PTRS_PER_PGD];
 extern volatile phys_addr_t __pa_swapper_pg_dir;
+extern pgd_t *new_swapper_pg_dir;
 
 /*
  * Encode and decode a swap entry:
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index dd4f28c19165..08bcaae4725e 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -197,7 +197,7 @@ void __init kasan_init(void)
 	 * tmp_pg_dir used to keep early shadow mapped until full shadow
 	 * setup will be finished.
 	 */
-	memcpy(tmp_pg_dir, swapper_pg_dir, sizeof(tmp_pg_dir));
+	memcpy(tmp_pg_dir, new_swapper_pg_dir, sizeof(tmp_pg_dir));
 	dsb(ishst);
 	cpu_replace_ttbr1(__pa_symbol(tmp_pg_dir));
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d518e27792ef..94056e064c6f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -62,6 +62,8 @@ EXPORT_SYMBOL(kimage_voffset);
 volatile phys_addr_t __section(".mmuoff.data.read")
 __pa_swapper_pg_dir;
 
+pgd_t *new_swapper_pg_dir = swapper_pg_dir;
+
 /*
  * Empty_zero_page is a special page that is used for zero-initialized data
  * and COW.
-- 
2.17.0
