Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423277AbeE1LGa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423237AbeE1LGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:06:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Jeff Layton <jlayton@redhat.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Kostya Serebryany <kcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 055/272] kasan: fix invalid-free test crashing the kernel
Date: Mon, 28 May 2018 12:01:28 +0200
Message-Id: <20180528100245.516786022@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Konovalov <andreyknvl@google.com>

[ Upstream commit 91c93ed07f04f5b32a30321d522d8ca9504745bf ]

When an invalid-free is triggered by one of the KASAN tests, the object
doesn't actually get freed.  This later leads to a BUG failure in
kmem_cache_destroy that checks that there are no allocated objects in
the cache that is being destroyed.

Fix this by calling kmem_cache_free with the proper object address after
the call that triggers invalid-free.

Link: http://lkml.kernel.org/r/286eaefc0a6c3fa9b83b87e7d6dc0fbb5b5c9926.1519924383.git.andreyknvl@google.com
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Nick Terrell <terrelln@fb.com>
Cc: Chris Mason <clm@fb.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Luis R . Rodriguez" <mcgrof@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Jeff Layton <jlayton@redhat.com>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc: Kostya Serebryany <kcc@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/test_kasan.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -567,7 +567,15 @@ static noinline void __init kmem_cache_i
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
 
