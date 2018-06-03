Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeFCM1r (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:27:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751354AbeFCM1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:27:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 07/29] radix tree test suite: Remove types.h
Date: Sun,  3 Jun 2018 14:26:30 +0200
Message-Id: <20180603122652.17453-8-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180603122652.17453-1-gregkh@linuxfoundation.org>
References: <20180603122652.17453-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

commit 12ea65390bd5a46f8a70f068eb0d48922576a781 upstream.

Move the pieces we still need to tools/include and update a few implicit
includes.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
[ Just take the tools/include/linux/* portions of this patch - gregkh]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/include/linux/compiler.h | 4 ++++
 tools/include/linux/spinlock.h | 5 +++++
 2 files changed, 9 insertions(+)
 create mode 100644 tools/include/linux/spinlock.h

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 6326ede9aece..8de163b17c0d 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -25,6 +25,8 @@
 #endif
 
 #define __user
+#define __rcu
+#define __read_mostly
 
 #ifndef __attribute_const__
 # define __attribute_const__
@@ -54,6 +56,8 @@
 # define unlikely(x)		__builtin_expect(!!(x), 0)
 #endif
 
+#define uninitialized_var(x) x = *(&(x))
+
 #define ACCESS_ONCE(x) (*(volatile typeof(x) *)&(x))
 
 #include <linux/types.h>
diff --git a/tools/include/linux/spinlock.h b/tools/include/linux/spinlock.h
new file mode 100644
index 000000000000..58397dcb19d6
--- /dev/null
+++ b/tools/include/linux/spinlock.h
@@ -0,0 +1,5 @@
+#define spinlock_t		pthread_mutex_t
+#define DEFINE_SPINLOCK(x)	pthread_mutex_t x = PTHREAD_MUTEX_INITIALIZER;
+
+#define spin_lock_irqsave(x, f)		(void)f, pthread_mutex_lock(x)
+#define spin_unlock_irqrestore(x, f)	(void)f, pthread_mutex_unlock(x)
-- 
2.17.1
