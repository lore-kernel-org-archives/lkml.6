Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8ACC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA4220863
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA4220863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeK2JMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:12:51 -0500
Received: from mout.gmx.net ([212.227.17.22]:41733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbeK2JMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:12:51 -0500
Received: from qcai.nay.com ([66.187.233.206]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MBq8p-1gHRSI0LzD-00Aozw; Wed, 28
 Nov 2018 23:09:29 +0100
From:   Qian Cai <cai@gmx.us>
To:     akpm@linux-foundation.org
Cc:     catalin.marinas@arm.com, mhocko@suse.com, rppt@linux.vnet.ibm.com,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@gmx.us>
Subject: [PATCH v2] mm/memblock: skip kmemleak for kasan_init()
Date:   Wed, 28 Nov 2018 17:08:45 -0500
Message-Id: <1543442925-17794-1-git-send-email-cai@gmx.us>
X-Mailer: git-send-email 1.8.3.1
X-Provags-ID: V03:K1:clWatyOIPYUoktIn5wbNxbPsSilrzP7alGHChtGvQZbnccgKyCy
 HeuyOViFF3xpbZQNAuvtdxQS0LlHLXJktREluFhvA7tNW7XiA6OvDIkvWwjfIzc/k9rQDGC
 wDWOE3FdHKuO7BrFv2kjD06RyWUjlVLZoHhAaT2jz5hgBWUxyQ8Ozb4mGCZ1Di4td+xZlEU
 g1Ygod/phd/rEJ31Qlk6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W90VGldoDLM=:xtBpiRBdZ2RarN6fxC1wKB
 ydWxt6BZtdaOXG7gv6Ep1dVcbjuU+O+kajy0RbCkcb1lDKZpyxtop2iLveaPQv1CH7joCEAA9
 cVM0Xxw+j+imcTqWPWoOxBEmYSWc80YpwVoWDEhl7oULX2ng7WuWN5BECMnLDrVhAPfBLpv7I
 q6OBnByVgvAv35ERHFPUWplSC4Wb8kkizFC+v21qevhSYa0sYASG3ersEUEhxf+SsSekUE/yQ
 CCom/7DyBsiL0UuXanU9contfEHhIcl5poBnNWlEycVwVeIjiBPDhvsAiR9cAPDETEl9QUQwo
 By0poyuXVsE3OfQ6/NDM210pF98rYstqWCFIl/kBOiWCuo29bOx0Rurbqwn/I7IqCNIGGESFT
 VDq6yy2PyNNfzSR1iMjMk3sHn4KcAcIQNbtQG1cbpgjnJMSrg7Dc+6lK8g8OOSl2W+PXgT9sT
 oPO+z0zxAeBKTRgyT4KtGj4q8KMn3b1CThtpQBmEHhvxm4WGXQj1+KEQfUtII3+ODo7Yf1NAU
 LW9UWHo2NcvpHz8+1ztgSbCq3L3qWQuJqDT+65X5m5yT6vVpEvPaLxqqWzZt18y7bKViQg6zO
 yi2fyqULpHFVrqgNrtHdlHJJ+8xppCq8QPobBlMfU70+oaL5wA/LQjS08DjPJdx/yYgU8J/CL
 tajiEInnkm5pTzo/eMrbpGYXQLsmp4J/OeemgkG6rQ+6GuzZZmTuTrnm0twpwmPNSCf2mKPjG
 mF5XVB/beil7dNjIaFCBa7ThYHCw4DurtZt6L09vrQXWn1+QFYsGZvcONBMP/SNbRaRoR9Nte
 66IGsTxSukQ0Jg7nuim14KKYALF9zjer83QXcUgOQFsup7ETYRquN0/wx+8c6h29B6Szbql6X
 VZN3s+T08uiYpCdH+NReYBjkgQKH5MMx0SElI7HeQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kmemleak does not play well with KASAN (tested on both HPE Apollo 70 and
Huawei TaiShan 2280 aarch64 servers).

After calling start_kernel()->setup_arch()->kasan_init(), kmemleak early
log buffer went from something like 280 to 260000 which caused kmemleak
disabled and crash dump memory reservation failed. The multitude of
kmemleak_alloc() calls is from nested loops while KASAN is setting up
full memory mappings, so let early kmemleak allocations skip those
memblock_alloc_internal() calls came from kasan_init() given that those
early KASAN memory mappings should not reference to other memory.
Hence, no kmemleak false positives.

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

Signed-off-by: Qian Cai <cai@gmx.us>
---

Changes since v1:
* only skip memblock_alloc_internal() calls came from kasan_int().

 arch/arm64/mm/kasan_init.c |  2 +-
 include/linux/memblock.h   |  1 +
 mm/memblock.c              | 19 +++++++++++--------
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 63527e5..fcb2ca3 100644
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
index aee299a..3ef3086 100644
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
index 9a2d5ae..abb9f7f 100644
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
@@ -1412,13 +1413,15 @@ static void * __init memblock_alloc_internal(
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
1.8.3.1

