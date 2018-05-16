Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752420AbeEPVOz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 17:14:55 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40470 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeEPVOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 17:14:54 -0400
X-Google-Smtp-Source: AB8JxZpcets5304Fp5Cg4LY7hpyh03ypoDn3zZbTCheqxHyT9PsstcgHsqp/W63qZr1oV3U3Q56A8g==
From: Shakeel Butt <shakeelb@google.com>
To: Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Cc: Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: [PATCH v2] mm: save two stranding bit in gfp_mask
Date: Wed, 16 May 2018 14:14:39 -0700
Message-Id: <20180516211439.177440-1-shakeelb@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

___GFP_COLD and ___GFP_OTHER_NODE were removed but their bits were
stranded. Fill the gaps by moving the existing gfp masks around.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
---
Changelog since v1:
- Moved couple of gfp masks instead of sliding all.

 include/linux/gfp.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 1a4582b44d32..036846fc00a6 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -24,6 +24,7 @@ struct vm_area_struct;
 #define ___GFP_HIGH		0x20u
 #define ___GFP_IO		0x40u
 #define ___GFP_FS		0x80u
+#define ___GFP_WRITE		0x100u
 #define ___GFP_NOWARN		0x200u
 #define ___GFP_RETRY_MAYFAIL	0x400u
 #define ___GFP_NOFAIL		0x800u
@@ -36,11 +37,10 @@ struct vm_area_struct;
 #define ___GFP_THISNODE		0x40000u
 #define ___GFP_ATOMIC		0x80000u
 #define ___GFP_ACCOUNT		0x100000u
-#define ___GFP_DIRECT_RECLAIM	0x400000u
-#define ___GFP_WRITE		0x800000u
-#define ___GFP_KSWAPD_RECLAIM	0x1000000u
+#define ___GFP_DIRECT_RECLAIM	0x200000u
+#define ___GFP_KSWAPD_RECLAIM	0x400000u
 #ifdef CONFIG_LOCKDEP
-#define ___GFP_NOLOCKDEP	0x2000000u
+#define ___GFP_NOLOCKDEP	0x800000u
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
@@ -205,7 +205,7 @@ struct vm_area_struct;
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
 /* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (25 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT (23 + IS_ENABLED(CONFIG_LOCKDEP))
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /*
-- 
2.17.0.441.gb46fe60e1d-goog
