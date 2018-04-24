Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeDXXAS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 19:00:18 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35186 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeDXXAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 19:00:14 -0400
X-Google-Smtp-Source: AIpwx49q5XL1Jc+vQ5gyhune8uS7D7CNQa7Tb4orTmsQrqpFos654uh31+DLH2LOwOOTltgzFeaplg==
Date: Tue, 24 Apr 2018 16:00:11 -0700
From: Kees Cook <keescook@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rslib: Add missing includes and update EXPORTs
Message-ID: <20180424230011.GA27504@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After refactoring to pass down GFP_* flags, slab.h needed to be added and
the EXPORTs needed to be renamed. I also moved some end-of-file EXPORTs
to their respective functions as done already for the other functions in
rslib.

Reported-by: kbuild-all@01.org
Fixes: c80cb2004afe ("rslib: Add GFP aware init function")
Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
I added the slab header and fixed up EXPORTs which the same randconfig
noticed at link time after the compile-time failure got fixed.
---
 include/linux/rslib.h           | 1 +
 lib/reed_solomon/reed_solomon.c | 7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/rslib.h b/include/linux/rslib.h
index 0ae635bc6d5a..e7d92fae12f3 100644
--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -11,6 +11,7 @@
 #define _RSLIB_H_
 
 #include <linux/list.h>
+#include <linux/slab.h>
 
 /**
  * struct rs_codec - rs codec data
diff --git a/lib/reed_solomon/reed_solomon.c b/lib/reed_solomon/reed_solomon.c
index e705d9877e52..dfcf54242fb9 100644
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -193,6 +193,7 @@ void free_rs(struct rs_control *rs)
 	mutex_unlock(&rslistlock);
 	kfree(rs);
 }
+EXPORT_SYMBOL_GPL(free_rs);
 
 /**
  * init_rs_internal - Allocate rs control, find a matching codec or allocate a new one
@@ -289,6 +290,7 @@ struct rs_control *init_rs_gfp(int symsize, int gfpoly, int fcr, int prim,
 {
 	return init_rs_internal(symsize, gfpoly, NULL, fcr, prim, nroots, gfp);
 }
+EXPORT_SYMBOL_GPL(init_rs_gfp);
 
 /**
  * init_rs_non_canonical - Allocate rs control struct for fields with
@@ -308,6 +310,7 @@ struct rs_control *init_rs_non_canonical(int symsize, int (*gffunc)(int),
 	return init_rs_internal(symsize, 0, gffunc, fcr, prim, nroots,
 				GFP_KERNEL);
 }
+EXPORT_SYMBOL_GPL(init_rs_non_canonical);
 
 #ifdef CONFIG_REED_SOLOMON_ENC8
 /**
@@ -411,10 +414,6 @@ int decode_rs16(struct rs_control *rsc, uint16_t *data, uint16_t *par, int len,
 EXPORT_SYMBOL_GPL(decode_rs16);
 #endif
 
-EXPORT_SYMBOL_GPL(init_rs);
-EXPORT_SYMBOL_GPL(init_rs_non_canonical);
-EXPORT_SYMBOL_GPL(free_rs);
-
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Reed Solomon encoder/decoder");
 MODULE_AUTHOR("Phil Karn, Thomas Gleixner");
-- 
2.7.4


-- 
Kees Cook
Pixel Security
