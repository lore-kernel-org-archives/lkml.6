Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752672AbeFDHcH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752167AbeFDG7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:59:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>
Subject: [PATCH 4.9 07/29] radix tree test suite: Remove types.h
Date: Mon,  4 Jun 2018 08:58:03 +0200
Message-Id: <20180604065802.454111781@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065802.157744637@linuxfoundation.org>
References: <20180604065802.157744637@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox <mawilcox@microsoft.com>

commit 12ea65390bd5a46f8a70f068eb0d48922576a781 upstream.

Move the pieces we still need to tools/include and update a few implicit
includes.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
[ Just take the tools/include/linux/* portions of this patch - gregkh]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/include/linux/compiler.h |    4 ++++
 tools/include/linux/spinlock.h |    5 +++++
 2 files changed, 9 insertions(+)

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
--- /dev/null
+++ b/tools/include/linux/spinlock.h
@@ -0,0 +1,5 @@
+#define spinlock_t		pthread_mutex_t
+#define DEFINE_SPINLOCK(x)	pthread_mutex_t x = PTHREAD_MUTEX_INITIALIZER;
+
+#define spin_lock_irqsave(x, f)		(void)f, pthread_mutex_lock(x)
+#define spin_unlock_irqrestore(x, f)	(void)f, pthread_mutex_unlock(x)
