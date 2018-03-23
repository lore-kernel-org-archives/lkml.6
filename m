Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbeCWA4E (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 20:56:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751821AbeCWAzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 20:55:54 -0400
From: jglisse@redhat.com
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
Subject: [PATCH 12/15] mm/hmm: move hmm_pfns_clear() closer to where it is use
Date: Thu, 22 Mar 2018 20:55:24 -0400
Message-Id: <20180323005527.758-13-jglisse@redhat.com>
In-Reply-To: <20180323005527.758-1-jglisse@redhat.com>
References: <20180323005527.758-1-jglisse@redhat.com>
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
index c287fbbbf088..05b49a5d6674 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -340,14 +340,6 @@ static int hmm_pfns_bad(unsigned long addr,
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
@@ -506,6 +498,14 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
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
