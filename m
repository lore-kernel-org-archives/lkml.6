Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeCVT62 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 15:58:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36352 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbeCVT61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 15:58:27 -0400
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 1/4] decompression: Rename malloc and free
Date: Thu, 22 Mar 2018 12:58:16 -0700
Message-Id: <20180322195819.24271-2-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180322195819.24271-1-willy@infradead.org>
References: <20180322195819.24271-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Rename the trivial malloc and free implementations to tmalloc and tfree
to avoid a namespace collision with an in-kernel free() function.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 include/linux/decompress/mm.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/decompress/mm.h b/include/linux/decompress/mm.h
index 868e9eacd69e..0ac62b025c1b 100644
--- a/include/linux/decompress/mm.h
+++ b/include/linux/decompress/mm.h
@@ -31,7 +31,7 @@
 STATIC_RW_DATA unsigned long malloc_ptr;
 STATIC_RW_DATA int malloc_count;
 
-static void *malloc(int size)
+static void *tmalloc(int size)
 {
 	void *p;
 
@@ -52,15 +52,17 @@ static void *malloc(int size)
 	return p;
 }
 
-static void free(void *where)
+static void tfree(void *where)
 {
 	malloc_count--;
 	if (!malloc_count)
 		malloc_ptr = free_mem_ptr;
 }
 
-#define large_malloc(a) malloc(a)
-#define large_free(a) free(a)
+#define malloc(a) tmalloc(a)
+#define free(a) tfree(a)
+#define large_malloc(a) tmalloc(a)
+#define large_free(a) tfree(a)
 
 #define INIT
 
-- 
2.16.2
