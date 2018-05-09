Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935628AbeEIUDW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 16:03:22 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38379 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935599AbeEIUCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 16:02:40 -0400
X-Google-Smtp-Source: AB8JxZpkQqIb9eJY14jlKD49wRZJ4IJ0EoyY/Sia3/Cmp3rWRTUWRz3M1DXkqe+eXuD3SAhJE2fMhQ==
From: Kees Cook <keescook@chromium.org>
To: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: [PATCH v2 5/6] mm: Use overflow helpers in kvmalloc()
Date: Wed,  9 May 2018 13:02:22 -0700
Message-Id: <20180509200223.22451-6-keescook@chromium.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509200223.22451-1-keescook@chromium.org>
References: <20180509200223.22451-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of open-coded multiplication and bounds checking, use the new
overflow helper. Additionally prepare for vmalloc() users to add
array_size()-family helpers in the future.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/mm.h      | 7 +++++--
 include/linux/vmalloc.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1ac1f06a4be6..7cb1c6a6bf82 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -25,6 +25,7 @@
 #include <linux/err.h>
 #include <linux/page_ref.h>
 #include <linux/memremap.h>
+#include <linux/overflow.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -560,10 +561,12 @@ static inline void *kvzalloc(size_t size, gfp_t flags)
 
 static inline void *kvmalloc_array(size_t n, size_t size, gfp_t flags)
 {
-	if (size != 0 && n > SIZE_MAX / size)
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(n, size, &bytes)))
 		return NULL;
 
-	return kvmalloc(n * size, flags);
+	return kvmalloc(bytes, flags);
 }
 
 extern void kvfree(const void *addr);
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 1e5d8c392f15..398e9c95cd61 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -8,6 +8,7 @@
 #include <linux/llist.h>
 #include <asm/page.h>		/* pgprot_t */
 #include <linux/rbtree.h>
+#include <linux/overflow.h>
 
 struct vm_area_struct;		/* vma defining user mapping in mm_types.h */
 struct notifier_block;		/* in notifier.h */
-- 
2.17.0
