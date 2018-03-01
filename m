Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033355AbeCARPy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:15:54 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37490 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033327AbeCARPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:15:50 -0500
X-Google-Smtp-Source: AG47ELs4yQ9SwzV1i85/PNn31OUcXlv9CnoPCwXKF8JnkbmdJ3cYYOnA6sKFIFTyv4Vw1GwSc5jaWg==
From: Andrey Konovalov <andreyknvl@google.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Jeff Layton <jlayton@redhat.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Cc: Kostya Serebryany <kcc@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 1/2] kasan: fix invalid-free test crashing the kernel
Date: Thu,  1 Mar 2018 18:15:42 +0100
Message-Id: <286eaefc0a6c3fa9b83b87e7d6dc0fbb5b5c9926.1519924383.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
In-Reply-To: <cover.1519924383.git.andreyknvl@google.com>
References: <cover.1519924383.git.andreyknvl@google.com>
In-Reply-To: <cover.1519924383.git.andreyknvl@google.com>
References: <cover.1519924383.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an invalid-free is triggered by one of the KASAN tests, the object
doesn't actually get freed. This later leads to a BUG failure in
kmem_cache_destroy that checks that there are no allocated objects in the
cache that is being destroyed. Fix this by calling kmem_cache_free with
the proper object address after the call that triggers invalid-free.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 98854a64b014..ec657105edbf 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -567,7 +567,15 @@ static noinline void __init kmem_cache_invalid_free(void)
 		return;
 	}
 
+	/* Trigger invalid free, the object doesn't get freed */
 	kmem_cache_free(cache, p + 1);
+
+	/*
+	 * Properly free the object to prevent the "Objects remaining in
+	 * test_cache on __kmem_cache_shutdown" BUG failure.
+	 */
+	kmem_cache_free(cache, p);
+
 	kmem_cache_destroy(cache);
 }
 
-- 
2.16.2.395.g2e18187dfd-goog
