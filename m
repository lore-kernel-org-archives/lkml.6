Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5123AC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1275B20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1275B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934303AbeFRNXM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:23:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933517AbeFRNXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:23:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8E87401DE60;
        Mon, 18 Jun 2018 13:23:09 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 79A24111F3B6;
        Mon, 18 Jun 2018 13:23:07 +0000 (UTC)
Date:   Mon, 18 Jun 2018 09:23:07 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND] x86: optimize memcpy_flushcache
Message-ID: <20180618132306.GA25431@redhat.com>
References: <20180519052503.325953342@debian.vm>
 <20180519052631.730455475@debian.vm>
 <CAPcyv4jpY0x7kZtT+afAKnHKy8Uy1AC_N_QM7RrELSj_0iNrRw@mail.gmail.com>
 <20180524182013.GA59755@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524182013.GA59755@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 18 Jun 2018 13:23:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 18 Jun 2018 13:23:09 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'msnitzer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v2] x86: optimize memcpy_flushcache

In the context of constant short length stores to persistent memory,
memcpy_flushcache suffers from a 2% performance degradation compared to
explicitly using the "movnti" instruction.

Optimize 4, 8, and 16 byte memcpy_flushcache calls to explicitly use the
movnti instruction with inline assembler.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 arch/x86/include/asm/string_64.h | 28 +++++++++++++++++++++++++++-
 arch/x86/lib/usercopy_64.c       |  4 ++--
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 533f74c300c2..aaba83478cdc 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -147,7 +147,33 @@ memcpy_mcsafe(void *dst, const void *src, size_t cnt)
 
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 #define __HAVE_ARCH_MEMCPY_FLUSHCACHE 1
-void memcpy_flushcache(void *dst, const void *src, size_t cnt);
+void __memcpy_flushcache(void *dst, const void *src, size_t cnt);
+static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
+{
+	if (__builtin_constant_p(cnt)) {
+		switch (cnt) {
+		case 4:
+			asm volatile("movntil %1, %0"
+				     : "=m" (*(u32 *)dst)
+				     : "r" (*(u32 *)src));
+			return;
+		case 8:
+			asm volatile("movntiq %1, %0"
+				     : "=m" (*(u64 *)dst)
+				     : "r" (*(u64 *)src));
+			return;
+		case 16:
+			asm volatile("movntiq %1, %0"
+				     : "=m" (*(u64 *)dst)
+				     : "r" (*(u64 *)src));
+			asm volatile("movntiq %1, %0"
+				     : "=m" (*(u64 *)(dst + 8))
+				     : "r" (*(u64 *)(src + 8)));
+			return;
+		}
+	}
+	__memcpy_flushcache(dst, src, cnt);
+}
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index 75d3776123cc..26f515aa3529 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -133,7 +133,7 @@ long __copy_user_flushcache(void *dst, const void __user *src, unsigned size)
 	return rc;
 }
 
-void memcpy_flushcache(void *_dst, const void *_src, size_t size)
+void __memcpy_flushcache(void *_dst, const void *_src, size_t size)
 {
 	unsigned long dest = (unsigned long) _dst;
 	unsigned long source = (unsigned long) _src;
@@ -196,7 +196,7 @@ void memcpy_flushcache(void *_dst, const void *_src, size_t size)
 		clean_cache_range((void *) dest, size);
 	}
 }
-EXPORT_SYMBOL_GPL(memcpy_flushcache);
+EXPORT_SYMBOL_GPL(__memcpy_flushcache);
 
 void memcpy_page_flushcache(char *to, struct page *page, size_t offset,
 		size_t len)
-- 
2.15.0

