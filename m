Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477E4C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7EB20663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359106;
	bh=UExXoIloiHdnlZhTCAe+BNZGJxmrWHvkotvr9T3mFAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tTQm8MMCORprsEmi7QBuBL7q+B4nxHWqWTSHX83yQwlgAYB+mr54sSYcVizSddLZJ
	 AGUlVbMCrhxnyGN/QDYOwDp4tt8WkgjwMhpOfDCdTQSEEqAxbDMnf9I1t/Lx6KNkEF
	 jVCRmwIqbq7+yVJ+gpZ6IsfQNPmkfL9BNaAUnQck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388139AbfAXTpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:45:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:45852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388143AbfAXTo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:44:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AACF218D4;
        Thu, 24 Jan 2019 19:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548359095;
        bh=UExXoIloiHdnlZhTCAe+BNZGJxmrWHvkotvr9T3mFAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MWII/irbECPJmpiYA0sB1mZv8/qI6++t6XgI4njW+83eI6UvdXKOG4kQY9ZFu1PhL
         lwfRrdOP5N2JqLZ0Byyjokkxwf//XoL/g0Xx8ShjAsS/Y6c51QHDIgvnRPI1LbVLJn
         Hgm+OLp9xieisYwSSq/KupzL009RdTxBxciBK3rQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@gmx.us>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 120/127] mm/memblock.c: skip kmemleak for kasan_init()
Date:   Thu, 24 Jan 2019 20:21:06 +0100
Message-Id: <20190124190217.044959535@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit fed84c78527009d4f799a3ed9a566502fa026d82 ]

Kmemleak does not play well with KASAN (tested on both HPE Apollo 70 and
Huawei TaiShan 2280 aarch64 servers).

After calling start_kernel()->setup_arch()->kasan_init(), kmemleak early
log buffer went from something like 280 to 260000 which caused kmemleak
disabled and crash dump memory reservation failed.  The multitude of
kmemleak_alloc() calls is from nested loops while KASAN is setting up full
memory mappings, so let early kmemleak allocations skip those
memblock_alloc_internal() calls came from kasan_init() given that those
early KASAN memory mappings should not reference to other memory.  Hence,
no kmemleak false positives.

kasan_init
  kasan_map_populate [1]
    kasan_pgd_populate [2]
      kasan_pud_populate [3]
        kasan_pmd_populate [4]
          kasan_pte_populate [5]
            kasan_alloc_zeroed_page
              memblock_alloc_try_nid
                memblock_alloc_internal
                  kmemleak_alloc

[1] for_each_memblock(memory, reg)
[2] while (pgdp++, addr = next, addr != end)
[3] while (pudp++, addr = next, addr != end && pud_none(READ_ONCE(*pudp)))
[4] while (pmdp++, addr = next, addr != end && pmd_none(READ_ONCE(*pmdp)))
[5] while (ptep++, addr = next, addr != end && pte_none(READ_ONCE(*ptep)))

Link: http://lkml.kernel.org/r/1543442925-17794-1-git-send-email-cai@gmx.us
Signed-off-by: Qian Cai <cai@gmx.us>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/mm/kasan_init.c |  2 +-
 include/linux/memblock.h   |  1 +
 mm/memblock.c              | 19 +++++++++++--------
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 63527e585aac..fcb2ca30b6f1 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -39,7 +39,7 @@ static phys_addr_t __init kasan_alloc_zeroed_page(int node)
 {
 	void *p = memblock_alloc_try_nid(PAGE_SIZE, PAGE_SIZE,
 					      __pa(MAX_DMA_ADDRESS),
-					      MEMBLOCK_ALLOC_ACCESSIBLE, node);
+					      MEMBLOCK_ALLOC_KASAN, node);
 	return __pa(p);
 }
 
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index aee299a6aa76..3ef3086ed52f 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -320,6 +320,7 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
 /* Flags for memblock allocation APIs */
 #define MEMBLOCK_ALLOC_ANYWHERE	(~(phys_addr_t)0)
 #define MEMBLOCK_ALLOC_ACCESSIBLE	0
+#define MEMBLOCK_ALLOC_KASAN		1
 
 /* We are using top down, so it is safe to use 0 here */
 #define MEMBLOCK_LOW_LIMIT 0
diff --git a/mm/memblock.c b/mm/memblock.c
index 81ae63ca78d0..f45a049532fe 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -262,7 +262,8 @@ phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
 	phys_addr_t kernel_end, ret;
 
 	/* pump up @end */
-	if (end == MEMBLOCK_ALLOC_ACCESSIBLE)
+	if (end == MEMBLOCK_ALLOC_ACCESSIBLE ||
+	    end == MEMBLOCK_ALLOC_KASAN)
 		end = memblock.current_limit;
 
 	/* avoid allocating the first page */
@@ -1412,13 +1413,15 @@ again:
 done:
 	ptr = phys_to_virt(alloc);
 
-	/*
-	 * The min_count is set to 0 so that bootmem allocated blocks
-	 * are never reported as leaks. This is because many of these blocks
-	 * are only referred via the physical address which is not
-	 * looked up by kmemleak.
-	 */
-	kmemleak_alloc(ptr, size, 0, 0);
+	/* Skip kmemleak for kasan_init() due to high volume. */
+	if (max_addr != MEMBLOCK_ALLOC_KASAN)
+		/*
+		 * The min_count is set to 0 so that bootmem allocated
+		 * blocks are never reported as leaks. This is because many
+		 * of these blocks are only referred via the physical
+		 * address which is not looked up by kmemleak.
+		 */
+		kmemleak_alloc(ptr, size, 0, 0);
 
 	return ptr;
 }
-- 
2.19.1



