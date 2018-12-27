Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCDDC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 16:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B05206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 16:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbeL0QUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 11:20:09 -0500
Received: from app2.whu.edu.cn ([202.114.64.89]:33724 "EHLO whu.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727086AbeL0QUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 11:20:08 -0500
Received: from localhost (unknown [114.255.3.133])
        by email2 (Coremail) with SMTP id AgBjCgCHbzV5+yRc4uVxCQ--.60699S2;
        Fri, 28 Dec 2018 00:19:13 +0800 (CST)
From:   Peng Wang <rocking@whu.edu.cn>
To:     andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        ynorov@caviumnetworks.com, arnd@arndb.de, rocking@whu.edu.cn,
        courbet@google.com, osandov@fb.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] bitmap: Add bitmap_valloc(), bitmap_vzalloc() and bitmap_vfree()
Date:   Fri, 28 Dec 2018 00:18:29 +0800
Message-Id: <20181227161829.32177-1-rocking@whu.edu.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AgBjCgCHbzV5+yRc4uVxCQ--.60699S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry5AFy5CrW8uF4kAFWfuFg_yoW8ArW8pF
        s7KrnrKr4rW34jqr9rA3yrGFW3trs8J3Z7KF4xtry3uw12gF93Xr1fCas8tw15ArWDJF4x
        Ary3KF98CrWDXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVWU
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
        WxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUQVy7UUUU
        U==
X-CM-SenderInfo: qsqrijaqrviiqqxyq4lkxovvfxof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce bitmap alloc/free helpers when contiguous
memory is not necessary.

Signed-off-by: Peng Wang <rocking@whu.edu.cn>
---
 include/linux/bitmap.h |  3 +++
 lib/bitmap.c           | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index f58e97446abc..aaad1b33dfd5 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -111,6 +111,9 @@
 extern unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags);
 extern unsigned long *bitmap_zalloc(unsigned int nbits, gfp_t flags);
 extern void bitmap_free(const unsigned long *bitmap);
+extern unsigned long *bitmap_valloc(unsigned int nbits, gfp_t flags);
+extern unsigned long *bitmap_vzalloc(unsigned int nbits, gfp_t flags);
+extern void bitmap_vfree(const unsigned long *bitmap);
 
 /*
  * lib/bitmap.c provides these functions:
diff --git a/lib/bitmap.c b/lib/bitmap.c
index eead55aa7170..739597e436ad 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1139,6 +1139,25 @@ void bitmap_free(const unsigned long *bitmap)
 }
 EXPORT_SYMBOL(bitmap_free);
 
+unsigned long *bitmap_valloc(unsigned int nbits, gfp_t flags)
+{
+	return kvmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long),
+			     flags);
+}
+EXPORT_SYMBOL(bitmap_valloc);
+
+unsigned long *bitmap_vzalloc(unsigned int nbits, gfp_t flags)
+{
+	return bitmap_valloc(nbits, flags | __GFP_ZERO);
+}
+EXPORT_SYMBOL(bitmap_vzalloc);
+
+void bitmap_vfree(const unsigned long *bitmap)
+{
+	kvfree(bitmap);
+}
+EXPORT_SYMBOL(bitmap_vfree);
+
 #if BITS_PER_LONG == 64
 /**
  * bitmap_from_arr32 - copy the contents of u32 array of bits to bitmap
-- 
2.19.1

