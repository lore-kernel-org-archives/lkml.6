Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeFAIb3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:31:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:39795 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750968AbeFAIbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:31:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,465,1520924400";
   d="scan'208";a="233516141"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] bitmap: Add bitmap_alloc(), bitmap_zalloc() and bitmap_free()
Date: Fri,  1 Jun 2018 11:31:18 +0300
Message-Id: <20180601083120.40352-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of code become ugly because of open coding allocations for bitmaps.

Introduce three helpers to allow users be more clear of intention
and keep their code neat.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/bitmap.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 1ee46f492267..845822425393 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -6,6 +6,7 @@
 
 #include <linux/types.h>
 #include <linux/bitops.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
 
@@ -104,6 +105,21 @@
  * contain all bit positions from 0 to 'bits' - 1.
  */
 
+static inline unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags)
+{
+	return kmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long), flags);
+}
+
+static inline unsigned long *bitmap_zalloc(unsigned int nbits, gfp_t flags)
+{
+	return kcalloc(BITS_TO_LONGS(nbits), sizeof(unsigned long), flags);
+}
+
+static inline void bitmap_free(const unsigned long *bitmap)
+{
+	kfree(bitmap);
+}
+
 /*
  * lib/bitmap.c provides these functions:
  */
-- 
2.17.0
