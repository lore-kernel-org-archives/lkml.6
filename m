Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbeCaWAm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 18:00:42 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34703 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbeCaWAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 18:00:41 -0400
X-Google-Smtp-Source: AIpwx48d7Wq+z2fCppTzMLPy30nN7cSnTFsadJPxQBCG/Oc9NZttk8CswngE6R4/AZ/89pnCdgCZaw==
Date: Sun, 1 Apr 2018 01:00:36 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: mingo@kernel.org, peterz@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] refcount: trim headers
Message-ID: <20180331220036.GA7676@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel.h is not needed, but compiler.h is.

mutex.h is not needed only a forward declaration of "struct mutex".

spinlock.h is not needed, spinlock_types.h is enough.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/include/asm/refcount.h |    1 +
 include/linux/refcount.h        |    7 ++++---
 lib/refcount.c                  |    2 ++
 3 files changed, 7 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/refcount.h
+++ b/arch/x86/include/asm/refcount.h
@@ -5,6 +5,7 @@
  * PaX/grsecurity.
  */
 #include <linux/refcount.h>
+#include <asm/bug.h>
 
 /*
  * This is the first portion of the refcount error handling, which lives in
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -3,9 +3,10 @@
 #define _LINUX_REFCOUNT_H
 
 #include <linux/atomic.h>
-#include <linux/mutex.h>
-#include <linux/spinlock.h>
-#include <linux/kernel.h>
+#include <linux/compiler.h>
+#include <linux/spinlock_types.h>
+
+struct mutex;
 
 /**
  * struct refcount_t - variant of atomic_t specialized for reference counts
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -35,7 +35,9 @@
  *
  */
 
+#include <linux/mutex.h>
 #include <linux/refcount.h>
+#include <linux/spinlock.h>
 #include <linux/bug.h>
 
 #ifdef CONFIG_REFCOUNT_FULL
