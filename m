Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeB0CYc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 21:24:32 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54603 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751733AbeB0CYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 21:24:31 -0500
X-Google-Smtp-Source: AH8x227tOIicvjWr5ziVxu6pSKNayU+5F00Y2Q+NeupKZ6B+xT1G0jQGGRU/3VwWa/qP8TiX8+WyoQ==
From: Andrea Parri <parri.andrea@gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH] riscv/barrier: Define __smp_{store_release,load_acquire}
Date: Tue, 27 Feb 2018 03:24:11 +0100
Message-Id: <1519698251-19272-1-git-send-email-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce __smp_{store_release,load_acquire}, and rely on the generic
definitions for smp_{store_release,load_acquire}. This avoids the use
of full ("rw,rw") fences on SMP.

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 arch/riscv/include/asm/barrier.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
index 5510366d169ae..d4628e4b3a5ea 100644
--- a/arch/riscv/include/asm/barrier.h
+++ b/arch/riscv/include/asm/barrier.h
@@ -38,6 +38,21 @@
 #define __smp_rmb()	RISCV_FENCE(r,r)
 #define __smp_wmb()	RISCV_FENCE(w,w)
 
+#define __smp_store_release(p, v)					\
+do {									\
+	compiletime_assert_atomic_type(*p);				\
+	RISCV_FENCE(rw,w);						\
+	WRITE_ONCE(*p, v);						\
+} while (0)
+
+#define __smp_load_acquire(p)						\
+({									\
+	typeof(*p) ___p1 = READ_ONCE(*p);				\
+	compiletime_assert_atomic_type(*p);				\
+	RISCV_FENCE(r,rw);						\
+	___p1;								\
+})
+
 /*
  * This is a very specific barrier: it's currently only used in two places in
  * the kernel, both in the scheduler.  See include/linux/spinlock.h for the two
-- 
2.7.4
