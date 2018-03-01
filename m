Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033378AbeCARQJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:16:09 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55513 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032860AbeCARPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:15:51 -0500
X-Google-Smtp-Source: AG47ELvBj/WHMunz8tWsb2wkGgu3j3ouvPK/4lxX7dcVnBunLF1aOq52zcrbg7GhZTvHs9HZAagVeA==
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
Subject: [PATCH 2/2] kasan: disallow compiler to optimize away memset in tests
Date: Thu,  1 Mar 2018 18:15:43 +0100
Message-Id: <105ec9a308b2abedb1a0d1fdced0c22d765e4732.1519924383.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
In-Reply-To: <cover.1519924383.git.andreyknvl@google.com>
References: <cover.1519924383.git.andreyknvl@google.com>
In-Reply-To: <cover.1519924383.git.andreyknvl@google.com>
References: <cover.1519924383.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A compiler can optimize away memset calls by replacing them with mov
instructions. There are KASAN tests, that specifically test that KASAN
correctly handles memset calls, we don't want this optimization to
happen.

The solution is to add -fno-builtin flag to test_kasan.ko

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Makefile b/lib/Makefile
index a90d4fcd748f..9c940c4c0593 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_TEST_FIRMWARE) += test_firmware.o
 obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
 obj-$(CONFIG_TEST_HASH) += test_hash.o test_siphash.o
 obj-$(CONFIG_TEST_KASAN) += test_kasan.o
+CFLAGS_test_kasan.o += -fno-builtin
 obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
 obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
 obj-$(CONFIG_TEST_LKM) += test_module.o
-- 
2.16.2.395.g2e18187dfd-goog
