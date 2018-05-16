Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeEPPek (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:34:40 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33822 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbeEPPei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:34:38 -0400
X-Google-Smtp-Source: AB8JxZp7Ikt5iNXjRZkPWg7z+KvQnaOael131pnxZmu3WMd7Gl10A5s+vFaoknXYXWXWMF9IBvGbFw==
From: Alexander Potapenko <glider@google.com>
To: akpm@linux-foundation.org, dvyukov@google.com, aryabinin@virtuozzo.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/stackdepot.c: use a non-instrumented version of memcpy()
Date: Wed, 16 May 2018 17:34:34 +0200
Message-Id: <20180516153434.24479-1-glider@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stackdepot used to call memcpy(), which compiler tools normally
instrument, therefore every lookup used to unnecessarily call instrumented
code.  This is somewhat ok in the case of KASAN, but under KMSAN a lot of
time was spent in the instrumentation.

(A similar change has been previously committed for memcmp())

Signed-off-by: Alexander Potapenko <glider@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 lib/stackdepot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index e513459a5601..d48c744fa750 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -140,7 +140,7 @@ static struct stack_record *depot_alloc_stack(unsigned long *entries, int size,
 	stack->handle.slabindex = depot_index;
 	stack->handle.offset = depot_offset >> STACK_ALLOC_ALIGN;
 	stack->handle.valid = 1;
-	memcpy(stack->entries, entries, size * sizeof(unsigned long));
+	__memcpy(stack->entries, entries, size * sizeof(unsigned long));
 	depot_offset += required_size;
 
 	return stack;
-- 
2.17.0.441.gb46fe60e1d-goog
