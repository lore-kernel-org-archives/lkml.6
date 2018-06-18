Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198A3C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E99208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E99208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933847AbeFRNKJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:10:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:48585 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932585AbeFRNKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:10:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 06:10:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,239,1526367600"; 
   d="scan'208";a="47943424"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jun 2018 06:10:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8A3CD212; Mon, 18 Jun 2018 16:10:04 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
        Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/5] bitmap: Add bitmap_alloc(), bitmap_zalloc() and bitmap_free()
Date:   Mon, 18 Jun 2018 16:10:01 +0300
Message-Id: <20180618131003.88110-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618131003.88110-1-andriy.shevchenko@linux.intel.com>
References: <20180618131003.88110-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of code become ugly because of open coding allocations for bitmaps.

Introduce three helpers to allow users be more clear of intention
and keep their code neat.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/bitmap.h |  8 ++++++++
 lib/bitmap.c           | 19 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 1ee46f492267..acf5e8df3504 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -104,6 +104,14 @@
  * contain all bit positions from 0 to 'bits' - 1.
  */
 
+/*
+ * Allocation and deallocation of bitmap.
+ * Provided in lib/bitmap.c to avoid circular dependency.
+ */
+extern unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags);
+extern unsigned long *bitmap_zalloc(unsigned int nbits, gfp_t flags);
+extern void bitmap_free(const unsigned long *bitmap);
+
 /*
  * lib/bitmap.c provides these functions:
  */
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 33e95cd359a2..09acf2fd6a35 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -13,6 +13,7 @@
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/kernel.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
 
@@ -1125,6 +1126,24 @@ void bitmap_copy_le(unsigned long *dst, const unsigned long *src, unsigned int n
 EXPORT_SYMBOL(bitmap_copy_le);
 #endif
 
+unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags)
+{
+	return kmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long), flags);
+}
+EXPORT_SYMBOL(bitmap_alloc);
+
+unsigned long *bitmap_zalloc(unsigned int nbits, gfp_t flags)
+{
+	return bitmap_alloc(nbits, flags | __GFP_ZERO);
+}
+EXPORT_SYMBOL(bitmap_zalloc);
+
+void bitmap_free(const unsigned long *bitmap)
+{
+	kfree(bitmap);
+}
+EXPORT_SYMBOL(bitmap_free);
+
 #if BITS_PER_LONG == 64
 /**
  * bitmap_from_arr32 - copy the contents of u32 array of bits to bitmap
-- 
2.17.1

