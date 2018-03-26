Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752346AbeCZVad (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:30:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752209AbeCZVaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 17:30:17 -0400
From: jglisse@redhat.com
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 2/2] mm/hmm: clarify fault logic for device private memory
Date: Mon, 26 Mar 2018 17:30:09 -0400
Message-Id: <20180326213009.2460-3-jglisse@redhat.com>
In-Reply-To: <20180326213009.2460-1-jglisse@redhat.com>
References: <20180326213009.2460-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Campbell <rcampbell@nvidia.com>

For device private memory caller of hmm_vma_fault() want to be able to
carefully control fault behavior. Update logic to only fault on device
private entry if explicitly requested.

Before this patch a read only device private CPU page table entry would
fault if caller requested write permission without the device private
flag set (in caller's flag fault request). After this patch it will only
fault if the device private flag is also set.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
Cc: Mark Hairgrove <mhairgrove@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
 mm/hmm.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index ba912da1c1a1..398d0214be66 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -390,18 +390,22 @@ static inline void hmm_pte_need_fault(const struct hmm_vma_walk *hmm_vma_walk,
 	/* We aren't ask to do anything ... */
 	if (!(pfns & range->flags[HMM_PFN_VALID]))
 		return;
+	/* If this is device memory than only fault if explicitly requested */
+	if ((cpu_flags & range->flags[HMM_PFN_DEVICE_PRIVATE])) {
+		/* Do we fault on device memory ? */
+		if (pfns & range->flags[HMM_PFN_DEVICE_PRIVATE]) {
+			*write_fault = pfns & range->flags[HMM_PFN_WRITE];
+			*fault = true;
+		}
+		return;
+	}
+
 	/* If CPU page table is not valid then we need to fault */
-	*fault = cpu_flags & range->flags[HMM_PFN_VALID];
+	*fault = !(cpu_flags & range->flags[HMM_PFN_VALID]);
 	/* Need to write fault ? */
 	if ((pfns & range->flags[HMM_PFN_WRITE]) &&
 	    !(cpu_flags & range->flags[HMM_PFN_WRITE])) {
-		*fault = *write_fault = false;
-		return;
-	}
-	/* Do we fault on device memory ? */
-	if ((pfns & range->flags[HMM_PFN_DEVICE_PRIVATE]) &&
-	    (cpu_flags & range->flags[HMM_PFN_DEVICE_PRIVATE])) {
-		*write_fault = pfns & range->flags[HMM_PFN_WRITE];
+		*write_fault = true;
 		*fault = true;
 	}
 }
-- 
2.14.3
