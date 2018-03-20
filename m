Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeCTCCD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:02:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752084AbeCTCAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:00:49 -0400
From: jglisse@redhat.com
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
Subject: [PATCH 12/15] mm/hmm: move hmm_pfns_clear() closer to where it is use
Date: Mon, 19 Mar 2018 22:00:34 -0400
Message-Id: <20180320020038.3360-13-jglisse@redhat.com>
In-Reply-To: <20180320020038.3360-1-jglisse@redhat.com>
References: <20180320020038.3360-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Move hmm_pfns_clear() closer to where it is use to make it clear it
is not use by page table walkers.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Mark Hairgrove <mhairgrove@nvidia.com>
---
 mm/hmm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index b4b8b89ee7bb..52cdceb35733 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -316,14 +316,6 @@ static int hmm_pfns_bad(unsigned long addr,
 	return 0;
 }
 
-static void hmm_pfns_clear(uint64_t *pfns,
-			   unsigned long addr,
-			   unsigned long end)
-{
-	for (; addr < end; addr += PAGE_SIZE, pfns++)
-		*pfns = 0;
-}
-
 /*
  * hmm_vma_walk_hole() - handle a range lacking valid pmd or pte(s)
  * @start: range virtual start address (inclusive)
@@ -482,6 +474,14 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	return 0;
 }
 
+static void hmm_pfns_clear(uint64_t *pfns,
+			   unsigned long addr,
+			   unsigned long end)
+{
+	for (; addr < end; addr += PAGE_SIZE, pfns++)
+		*pfns = 0;
+}
+
 static void hmm_pfns_special(struct hmm_range *range)
 {
 	unsigned long addr = range->start, i = 0;
-- 
2.14.3
