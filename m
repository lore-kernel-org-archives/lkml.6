Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753950AbeDAV2W (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 17:28:22 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:44892 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeDAV2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 17:28:20 -0400
X-Google-Smtp-Source: AIpwx48xvAXeZxQfJNmAuXUI6S1OCFByg3adXHzJjhDYfdF+3lJagWaXtRb0DIWMhgDwHuNsP0qh2g==
Date: Mon, 2 Apr 2018 00:28:16 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 34/45] C++: Fix up use of LIST_POISON*
Message-ID: <20180401212816.GA25507@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -	entry->next = LIST_POISON1;
> -	entry->prev = LIST_POISON2;
> +	entry->next = static_cast<struct list_head *>(LIST_POISON1);
> +	entry->prev = static_cast<struct list_head *>(LIST_POISON2);

There is a better way ;-)

--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -2,6 +2,22 @@
 #ifndef _LINUX_POISON_H
 #define _LINUX_POISON_H
 
+class POISON {
+	unsigned long p;
+
+public:
+	explicit POISON(unsigned long val)
+		: p{val}
+	{
+	}
+
+	template<typename T>
+	operator T*() const
+	{
+		return p;
+	}
+};
+
 /********** include/linux/list.h **********/
 
 /*
@@ -20,15 +36,15 @@
  * under normal circumstances, used to verify that nobody uses
  * non-initialized list entries.
  */
-#define LIST_POISON1  ((void *) 0x100 + POISON_POINTER_DELTA)
-#define LIST_POISON2  ((void *) 0x200 + POISON_POINTER_DELTA)
+#define LIST_POISON1  POISON{0x100UL + POISON_POINTER_DELTA}
+#define LIST_POISON2  POISON{0x200UL + POISON_POINTER_DELTA}
 
 /********** include/linux/timer.h **********/
 /*
  * Magic number "tsta" to indicate a static timer initializer
  * for the object debugging code.
  */
-#define TIMER_ENTRY_STATIC	((void *) 0x300 + POISON_POINTER_DELTA)
+#define TIMER_ENTRY_STATIC	POISON{0x300UL + POISON_POINTER_DELTA}
 
 /********** mm/debug-pagealloc.c **********/
 #ifdef CONFIG_PAGE_POISONING_ZERO
@@ -39,7 +55,7 @@
 
 /********** mm/page_alloc.c ************/
 
-#define TAIL_MAPPING	((void *) 0x400 + POISON_POINTER_DELTA)
+#define TAIL_MAPPING	POISON{0x400UL + POISON_POINTER_DELTA}
 
 /********** mm/slab.c **********/
 /*
@@ -81,7 +97,7 @@
 /********** kernel/mutexes **********/
 #define MUTEX_DEBUG_INIT	0x11
 #define MUTEX_DEBUG_FREE	0x22
-#define MUTEX_POISON_WW_CTX	((void *) 0x500 + POISON_POINTER_DELTA)
+#define MUTEX_POISON_WW_CTX	POISON{0x500UL + POISON_POINTER_DELTA}
 
 /********** lib/flex_array.c **********/
 #define FLEX_ARRAY_FREE	0x6c	/* for use-after-free poisoning */
