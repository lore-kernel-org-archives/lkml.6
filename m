Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeCNEEt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 00:04:49 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42025 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbeCNEEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 00:04:48 -0400
X-Google-Smtp-Source: AG47ELucB4v1hpcS/j8P31SwzOkj+t1YyH5InABxAEApKqVDncVTjRGgub5TD71n9KpfQZ4QjtQF4w==
From: Deepa Dinamani <deepa.kernel@gmail.com>
To: arnd@arndb.de, tglx@linutronix.de, john.stultz@linaro.org
Cc: linux-kernel@vger.kernel.org, y2038@lists.linaro.org
Subject: [PATCH v5 01/10] compat: Make compat helpers independent of CONFIG_COMPAT
Date: Tue, 13 Mar 2018 21:03:24 -0700
Message-Id: <20180314040333.3291-2-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180314040333.3291-1-deepa.kernel@gmail.com>
References: <20180314040333.3291-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many of the compat time syscalls are also repurposed as 32 bit
native syscalls to provide backward compatibility while adding
new y2038 safe sycalls.
Enabling the helpers makes this possible.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 include/linux/compat.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 16c3027074a2..bdf1908a392e 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -8,8 +8,6 @@
 
 #include <linux/types.h>
 
-#ifdef CONFIG_COMPAT
-
 #include <linux/stat.h>
 #include <linux/param.h>	/* for HZ */
 #include <linux/sem.h>
@@ -20,9 +18,11 @@
 #include <linux/uaccess.h>
 #include <linux/unistd.h>
 
+#ifdef CONFIG_COMPAT
 #include <asm/compat.h>
 #include <asm/siginfo.h>
 #include <asm/signal.h>
+#endif
 
 #ifndef COMPAT_USE_64BIT_TIME
 #define COMPAT_USE_64BIT_TIME 0
@@ -59,6 +59,8 @@
 	}								\
 	static inline long C_SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 
+#ifdef CONFIG_COMPAT
+
 #ifndef compat_user_stack_pointer
 #define compat_user_stack_pointer() current_user_stack_pointer()
 #endif
@@ -891,7 +893,9 @@ static inline struct compat_timeval ns_to_compat_timeval(s64 nsec)
 #else /* !CONFIG_COMPAT */
 
 #define is_compat_task() (0)
+#ifndef in_compat_syscall
 static inline bool in_compat_syscall(void) { return false; }
+#endif
 
 #endif /* CONFIG_COMPAT */
 
-- 
2.14.1
