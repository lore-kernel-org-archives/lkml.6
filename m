Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFF2C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9AA12086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AA12086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeIKLUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:20:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38051 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeIKLUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:20:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8B6MJtI2135873
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 23:22:19 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8B6MJQe2135870;
        Mon, 10 Sep 2018 23:22:19 -0700
Date:   Mon, 10 Sep 2018 23:22:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mikulas Patocka <tipbot@zytor.com>
Message-ID: <tip-02101c45ec5b19d607af7372680f5259050b4e9c@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de, mpatocka@redhat.com, snitzer@redhat.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        dan.j.williams@intel.com, dm-devel@redhat.com
Reply-To: peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de,
          mpatocka@redhat.com, snitzer@redhat.com, mingo@kernel.org,
          dm-devel@redhat.com, linux-kernel@vger.kernel.org,
          dan.j.williams@intel.com, torvalds@linux-foundation.org
In-Reply-To: <alpine.LRH.2.02.1808081720460.24747@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808081720460.24747@file01.intranet.prod.int.rdu2.redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/asm: Optimize memcpy_flushcache()
Git-Commit-ID: 02101c45ec5b19d607af7372680f5259050b4e9c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  02101c45ec5b19d607af7372680f5259050b4e9c
Gitweb:     https://git.kernel.org/tip/02101c45ec5b19d607af7372680f5259050b4e9c
Author:     Mikulas Patocka <mpatocka@redhat.com>
AuthorDate: Wed, 8 Aug 2018 17:22:16 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 15:17:12 +0200

x86/asm: Optimize memcpy_flushcache()

I use memcpy_flushcache() in my persistent memory driver for metadata
updates, there are many 8-byte and 16-byte updates and it turns out that
the overhead of memcpy_flushcache causes 2% performance degradation
compared to "movnti" instruction explicitly coded using inline assembler.

The tests were done on a Skylake processor with persistent memory emulated
using the "memmap" kernel parameter. dd was used to copy data to the
dm-writecache target.

This patch recognizes memcpy_flushcache calls with constant short length
and turns them into inline assembler - so that I don't have to use inline
assembler in the driver.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: device-mapper development <dm-devel@redhat.com>
Link: http://lkml.kernel.org/r/alpine.LRH.2.02.1808081720460.24747@file01.intranet.prod.int.rdu2.redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/string_64.h | 20 +++++++++++++++++++-
 arch/x86/lib/usercopy_64.c       |  4 ++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index d33f92b9fa22..7ad41bfcc16c 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -149,7 +149,25 @@ memcpy_mcsafe(void *dst, const void *src, size_t cnt)
 
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 #define __HAVE_ARCH_MEMCPY_FLUSHCACHE 1
-void memcpy_flushcache(void *dst, const void *src, size_t cnt);
+void __memcpy_flushcache(void *dst, const void *src, size_t cnt);
+static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
+{
+	if (__builtin_constant_p(cnt)) {
+		switch (cnt) {
+			case 4:
+				asm ("movntil %1, %0" : "=m"(*(u32 *)dst) : "r"(*(u32 *)src));
+				return;
+			case 8:
+				asm ("movntiq %1, %0" : "=m"(*(u64 *)dst) : "r"(*(u64 *)src));
+				return;
+			case 16:
+				asm ("movntiq %1, %0" : "=m"(*(u64 *)dst) : "r"(*(u64 *)src));
+				asm ("movntiq %1, %0" : "=m"(*(u64 *)(dst + 8)) : "r"(*(u64 *)(src + 8)));
+				return;
+		}
+	}
+	__memcpy_flushcache(dst, src, cnt);
+}
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index 9c5606d88f61..c50a1d815a37 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -153,7 +153,7 @@ long __copy_user_flushcache(void *dst, const void __user *src, unsigned size)
 	return rc;
 }
 
-void memcpy_flushcache(void *_dst, const void *_src, size_t size)
+void __memcpy_flushcache(void *_dst, const void *_src, size_t size)
 {
 	unsigned long dest = (unsigned long) _dst;
 	unsigned long source = (unsigned long) _src;
@@ -216,7 +216,7 @@ void memcpy_flushcache(void *_dst, const void *_src, size_t size)
 		clean_cache_range((void *) dest, size);
 	}
 }
-EXPORT_SYMBOL_GPL(memcpy_flushcache);
+EXPORT_SYMBOL_GPL(__memcpy_flushcache);
 
 void memcpy_page_flushcache(char *to, struct page *page, size_t offset,
 		size_t len)
