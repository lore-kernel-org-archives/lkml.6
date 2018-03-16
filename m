Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933313AbeCPC4v (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 22:56:51 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45625 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932617AbeCPC4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 22:56:49 -0400
X-Google-Smtp-Source: AG47ELsmBTXURYS5Ue39JvyqBmM/9vlcE8Dhpau4AhC6UOmDQTnjsetrN4iWs+PvbocrYMT05mnGEA==
From: Jia He <hejianet@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Gioh Kim <gi-oh.kim@profitbricks.com>, Daniel Vacek <neelx@redhat.com>,
        linux-kernel@vger.kernel.org, Jia He <hejianet@gmail.com>,
        Jia He <jia.he@hxt-semitech.com>
Subject: [PATCH] Revert "mm/memblock.c: hardcode the end_pfn being -1"
Date: Thu, 15 Mar 2018 19:56:06 -0700
Message-Id: <1521168966-5245-1-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 379b03b7fa05f7db521b7732a52692448a3c34fe.

Commit 864b75f9d6b0 ("mm/page_alloc: fix memmap_init_zone pageblock
alignment") introduced boot hang issues in arm/arm64 machines, so
Ard Biesheuvel reverted in commit 3e04040df6d4. But there is a
preparation patch for commit 864b75f9d6b0. So just revert it for
the sake of caution.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 mm/memblock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index b6ba6b7..5a9ca2a 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1107,7 +1107,7 @@ unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn,
 	struct memblock_type *type = &memblock.memory;
 	unsigned int right = type->cnt;
 	unsigned int mid, left = 0;
-	phys_addr_t addr = PFN_PHYS(++pfn);
+	phys_addr_t addr = PFN_PHYS(pfn + 1);
 
 	do {
 		mid = (right + left) / 2;
@@ -1118,15 +1118,15 @@ unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn,
 				  type->regions[mid].size))
 			left = mid + 1;
 		else {
-			/* addr is within the region, so pfn is valid */
-			return pfn;
+			/* addr is within the region, so pfn + 1 is valid */
+			return min(pfn + 1, max_pfn);
 		}
 	} while (left < right);
 
 	if (right == type->cnt)
-		return -1UL;
+		return max_pfn;
 	else
-		return PHYS_PFN(type->regions[right].base);
+		return min(PHYS_PFN(type->regions[right].base), max_pfn);
 }
 
 /**
-- 
2.7.4
