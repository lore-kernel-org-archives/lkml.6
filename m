Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983E9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733FB20896
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfANNAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:00:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbfANNAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:00:05 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EBC1BC057F3B;
        Mon, 14 Jan 2019 13:00:02 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BDEA5D75F;
        Mon, 14 Jan 2019 12:59:50 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Laura Abbott <labbott@redhat.com>,
        Greg Hackmann <ghackmann@android.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH v2 7/9] arm64: kdump: No need to mark crashkernel pages manually PG_reserved
Date:   Mon, 14 Jan 2019 13:59:01 +0100
Message-Id: <20190114125903.24845-8-david@redhat.com>
In-Reply-To: <20190114125903.24845-1-david@redhat.com>
References: <20190114125903.24845-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 14 Jan 2019 13:00:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crashkernel is reserved via memblock_reserve(). memblock_free_all()
will call free_low_memory_core_early(), which will go over all reserved
memblocks, marking the pages as PG_reserved.

So manually marking pages as PG_reserved is not necessary, they are
already in the desired state (otherwise they would have been handed over
to the buddy as free pages and bad things would happen).

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Greg Hackmann <ghackmann@android.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: CHANDAN VN <chandan.vn@samsung.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/arm64/kernel/machine_kexec.c |  2 +-
 arch/arm64/mm/init.c              | 27 ---------------------------
 2 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 6f0587b5e941..66b5d697d943 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -321,7 +321,7 @@ void crash_post_resume(void)
  * but does not hold any data of loaded kernel image.
  *
  * Note that all the pages in crash dump kernel memory have been initially
- * marked as Reserved in kexec_reserve_crashkres_pages().
+ * marked as Reserved as memory was allocated via memblock_reserve().
  *
  * In hibernation, the pages which are Reserved and yet "nosave" are excluded
  * from the hibernation iamge. crash_is_nosave() does thich check for crash
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 7205a9085b4d..c38976b70069 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -118,35 +118,10 @@ static void __init reserve_crashkernel(void)
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
 }
-
-static void __init kexec_reserve_crashkres_pages(void)
-{
-#ifdef CONFIG_HIBERNATION
-	phys_addr_t addr;
-	struct page *page;
-
-	if (!crashk_res.end)
-		return;
-
-	/*
-	 * To reduce the size of hibernation image, all the pages are
-	 * marked as Reserved initially.
-	 */
-	for (addr = crashk_res.start; addr < (crashk_res.end + 1);
-			addr += PAGE_SIZE) {
-		page = phys_to_page(addr);
-		SetPageReserved(page);
-	}
-#endif
-}
 #else
 static void __init reserve_crashkernel(void)
 {
 }
-
-static void __init kexec_reserve_crashkres_pages(void)
-{
-}
 #endif /* CONFIG_KEXEC_CORE */
 
 #ifdef CONFIG_CRASH_DUMP
@@ -586,8 +561,6 @@ void __init mem_init(void)
 	/* this will put all unused low memory onto the freelists */
 	memblock_free_all();
 
-	kexec_reserve_crashkres_pages();
-
 	mem_init_print_info(NULL);
 
 	/*
-- 
2.17.2

