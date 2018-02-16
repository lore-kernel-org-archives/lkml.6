Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751333AbeBPT3l (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:29:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:50718 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751138AbeBPT2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:28:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="18296884"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Tobin C. Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/7] lib/vsprintf: Replace ' ' with '_' before crng is ready
Date: Fri, 16 Feb 2018 21:28:02 +0200
Message-Id: <20180216192806.68914-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180216192806.68914-1-andriy.shevchenko@linux.intel.com>
References: <20180216192806.68914-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shunyong Yang <shunyong.yang@hxt-semitech.com>

Before crng is ready, output of "%p" composes of "(ptrval)" and
left padding spaces for alignment as no random address can be
generated. This seems a little strange when default string width
is larger than strlen("(ptrval)").

For example, when irq domain names are built with "%p", the nodes
under /sys/kernel/debug/irq/domains like this on AArch64 system,

[root@y irq]# ls domains/
default                   irqchip@        (ptrval)-2
irqchip@        (ptrval)-4  \_SB_.TCS0.QIC1  \_SB_.TCS0.QIC3
irqchip@        (ptrval)  irqchip@        (ptrval)-3
\_SB_.TCS0.QIC0             \_SB_.TCS0.QIC2

The name "irqchip@        (ptrval)-2" is not so readable in console
output.

This patch replaces space with readable "=" when output needs padding.
Following is the output after applying the patch,

[root@y domains]# ls
default                   irqchip@(____ptrval____)-2
irqchip@(____ptrval____)-4  \_SB_.TCS0.QIC1  \_SB_.TCS0.QIC3
irqchip@(____ptrval____)  irqchip@(____ptrval____)-3  \_SB_.TCS0.QIC0
\_SB_.TCS0.QIC2

There is same problem in some subsystem's dmesg output. Moreover,
someone may call "%p" in a similar case. In addition, the timing of
crng initialization done may vary on different system. So, the change
is made in vsprintf.c.

Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index b6d254723828..360e751305bf 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1696,12 +1696,13 @@ early_initcall(initialize_ptr_random);
 /* Maps a pointer to a 32 bit unique identifier. */
 static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
 {
+	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
 	unsigned long hashval;
 
 	if (unlikely(!have_filled_random_ptr_key)) {
 		spec.field_width = 2 * sizeof(ptr);
 		/* string length must be less than default_width */
-		return string(buf, end, "(ptrval)", spec);
+		return string(buf, end, str, spec);
 	}
 
 #ifdef CONFIG_64BIT
-- 
2.15.1
