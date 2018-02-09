Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751096AbeBII1J (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 03:27:09 -0500
Received: from mga11.intel.com ([192.55.52.93]:14584 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbeBII1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 03:27:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,482,1511856000";
   d="scan'208";a="26018399"
From: Wei Wang <wei.w.wang@intel.com>
To: linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org
Subject: [PATCH] mm/page_poison: move PAGE_POISON to page_poison.c
Date: Fri,  9 Feb 2018 16:08:14 +0800
Message-Id: <1518163694-27155-1-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PAGE_POISON macro is used in page_poison.c only, so avoid exporting
it. Also remove the "mm/debug-pagealloc.c" related comment, which is
obsolete.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/poison.h | 7 -------
 mm/page_poison.c       | 6 ++++++
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/poison.h b/include/linux/poison.h
index 15927eb..348bf67 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -30,13 +30,6 @@
  */
 #define TIMER_ENTRY_STATIC	((void *) 0x300 + POISON_POINTER_DELTA)
 
-/********** mm/debug-pagealloc.c **********/
-#ifdef CONFIG_PAGE_POISONING_ZERO
-#define PAGE_POISON 0x00
-#else
-#define PAGE_POISON 0xaa
-#endif
-
 /********** mm/page_alloc.c ************/
 
 #define TAIL_MAPPING	((void *) 0x400 + POISON_POINTER_DELTA)
diff --git a/mm/page_poison.c b/mm/page_poison.c
index e83fd44..8aaf076 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -7,6 +7,12 @@
 #include <linux/poison.h>
 #include <linux/ratelimit.h>
 
+#ifdef CONFIG_PAGE_POISONING_ZERO
+#define PAGE_POISON 0x00
+#else
+#define PAGE_POISON 0xaa
+#endif
+
 static bool want_page_poisoning __read_mostly;
 
 static int early_page_poison_param(char *buf)
-- 
2.7.4
