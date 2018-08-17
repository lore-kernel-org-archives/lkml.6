Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA93C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F21021868
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F21021868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeHQLkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 07:40:36 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:47007 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeHQLkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 07:40:36 -0400
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.51 with ESMTP; 17 Aug 2018 17:38:04 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: kyeongdon.kim@lge.com
Received: from unknown (HELO localhost.localdomain) (10.168.176.142)
        by 156.147.1.126 with ESMTP; 17 Aug 2018 17:38:03 +0900
X-Original-SENDERIP: 10.168.176.142
X-Original-MAILFROM: kyeongdon.kim@lge.com
From:   Kyeongdon Kim <kyeongdon.kim@lge.com>
To:     aryabinin@virtuozzo.com, catalin.marinas@arm.com,
        will.deacon@arm.com, glider@google.com, dvyukov@google.com
Cc:     Jason@zx2c4.com, robh@kernel.org, ard.biesheuvel@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        kyeongdon.kim@lge.com
Subject: [PATCH] arm64: kasan: add interceptors for strcmp/strncmp functions
Date:   Fri, 17 Aug 2018 17:37:55 +0900
Message-Id: <1534495075-82167-1-git-send-email-kyeongdon.kim@lge.com>
X-Mailer: git-send-email 2.6.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch declares strcmp/strncmp as weak symbols.
(2 of them are the most used string operations)

Original functions declared as weak symbols and
strong ones in mm/kasan/kasan.c could replace them.

Assembly optimized strcmp/strncmp functions cannot detect KASan bug.
But, now we can detect them.

==================================================================
BUG: KASAN: use-after-free in platform_match+0x1c/0x5c at addr ffffffc0ad313500
Read of size 1 by task swapper/0/1
CPU: 3 PID: 1 Comm: swapper/0 Tainted: G    B           4.9.77+ #1
Hardware name: Generic (DT) based system
Call trace:
 dump_backtrace+0x0/0x2e0
 show_stack+0x14/0x1c
 dump_stack+0x88/0xb0
 kasan_object_err+0x24/0x7c
 kasan_report+0x2f0/0x484
 check_memory_region+0x20/0x14c
 strcmp+0x1c/0x5c
 platform_match+0x40/0xe4
 __driver_attach+0x40/0x130
 bus_for_each_dev+0xc4/0xe0
 driver_attach+0x30/0x3c
 bus_add_driver+0x2dc/0x328
 driver_register+0x118/0x160
 __platform_driver_register+0x7c/0x88
 alarmtimer_init+0x154/0x1e4
 do_one_initcall+0x184/0x1a4
 kernel_init_freeable+0x2ec/0x2f0
 kernel_init+0x18/0x10c
 ret_from_fork+0x10/0x50

Signed-off-by: Kyeongdon Kim <kyeongdon.kim@lge.com>
---
 arch/arm64/include/asm/string.h |  4 ++++
 arch/arm64/kernel/arm64ksyms.c  |  2 ++
 arch/arm64/kernel/image.h       |  2 ++
 arch/arm64/lib/strcmp.S         |  3 +++
 arch/arm64/lib/strncmp.S        |  3 +++
 mm/kasan/kasan.c                | 15 +++++++++++++++
 6 files changed, 29 insertions(+)

diff --git a/arch/arm64/include/asm/string.h b/arch/arm64/include/asm/string.h
index dd95d33..d546605 100644
--- a/arch/arm64/include/asm/string.h
+++ b/arch/arm64/include/asm/string.h
@@ -24,9 +24,11 @@ extern char *strchr(const char *, int c);
 
 #define __HAVE_ARCH_STRCMP
 extern int strcmp(const char *, const char *);
+extern int __strcmp(const char *, const char *);
 
 #define __HAVE_ARCH_STRNCMP
 extern int strncmp(const char *, const char *, __kernel_size_t);
+extern int __strncmp(const char *, const char *, __kernel_size_t);
 
 #define __HAVE_ARCH_STRLEN
 extern __kernel_size_t strlen(const char *);
@@ -67,6 +69,8 @@ void memcpy_flushcache(void *dst, const void *src, size_t cnt);
 #define memcpy(dst, src, len) __memcpy(dst, src, len)
 #define memmove(dst, src, len) __memmove(dst, src, len)
 #define memset(s, c, n) __memset(s, c, n)
+#define strcmp(cs, ct) __strcmp(cs, ct)
+#define strncmp(cs, ct, n) __strncmp(cs, ct, n)
 
 #ifndef __NO_FORTIFY
 #define __NO_FORTIFY /* FORTIFY_SOURCE uses __builtin_memcpy, etc. */
diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index d894a20..10b1164 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -50,6 +50,8 @@ EXPORT_SYMBOL(strcmp);
 EXPORT_SYMBOL(strncmp);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(strnlen);
+EXPORT_SYMBOL(__strcmp);
+EXPORT_SYMBOL(__strncmp);
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memmove);
diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
index a820ed0..5ef7a57 100644
--- a/arch/arm64/kernel/image.h
+++ b/arch/arm64/kernel/image.h
@@ -110,6 +110,8 @@ __efistub___flush_dcache_area	= KALLSYMS_HIDE(__pi___flush_dcache_area);
 __efistub___memcpy		= KALLSYMS_HIDE(__pi_memcpy);
 __efistub___memmove		= KALLSYMS_HIDE(__pi_memmove);
 __efistub___memset		= KALLSYMS_HIDE(__pi_memset);
+__efistub___strcmp		= KALLSYMS_HIDE(__pi_strcmp);
+__efistub___strncmp		= KALLSYMS_HIDE(__pi_strncmp);
 #endif
 
 __efistub__text			= KALLSYMS_HIDE(_text);
diff --git a/arch/arm64/lib/strcmp.S b/arch/arm64/lib/strcmp.S
index 471fe61..0dffef7 100644
--- a/arch/arm64/lib/strcmp.S
+++ b/arch/arm64/lib/strcmp.S
@@ -60,6 +60,8 @@ tmp3		.req	x9
 zeroones	.req	x10
 pos		.req	x11
 
+.weak strcmp
+ENTRY(__strcmp)
 ENTRY(strcmp)
 	eor	tmp1, src1, src2
 	mov	zeroones, #REP8_01
@@ -232,3 +234,4 @@ CPU_BE(	orr	syndrome, diff, has_nul )
 	sub	result, data1, data2, lsr #56
 	ret
 ENDPIPROC(strcmp)
+ENDPROC(__strcmp)
diff --git a/arch/arm64/lib/strncmp.S b/arch/arm64/lib/strncmp.S
index e267044..b2648c7 100644
--- a/arch/arm64/lib/strncmp.S
+++ b/arch/arm64/lib/strncmp.S
@@ -64,6 +64,8 @@ limit_wd	.req	x13
 mask		.req	x14
 endloop		.req	x15
 
+.weak strncmp
+ENTRY(__strncmp)
 ENTRY(strncmp)
 	cbz	limit, .Lret0
 	eor	tmp1, src1, src2
@@ -308,3 +310,4 @@ CPU_BE( orr	syndrome, diff, has_nul )
 	mov	result, #0
 	ret
 ENDPIPROC(strncmp)
+ENDPROC(__strncmp)
diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index c3bd520..eae43e6 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -304,7 +304,22 @@ void *memcpy(void *dest, const void *src, size_t len)
 
 	return __memcpy(dest, src, len);
 }
+#undef strcmp
+int strcmp(const char *cs, const char *ct)
+{
+	check_memory_region((unsigned long)cs, 1, false, _RET_IP_);
+	check_memory_region((unsigned long)ct, 1, false, _RET_IP_);
 
+	return __strcmp(cs, ct);
+}
+#undef strncmp
+int strncmp(const char *cs, const char *ct, size_t len)
+{
+	check_memory_region((unsigned long)cs, len, false, _RET_IP_);
+	check_memory_region((unsigned long)ct, len, false, _RET_IP_);
+
+	return __strncmp(cs, ct, len);
+}
 void kasan_alloc_pages(struct page *page, unsigned int order)
 {
 	if (likely(!PageHighMem(page)))
-- 
2.6.2

