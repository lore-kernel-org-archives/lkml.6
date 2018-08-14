Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96230C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168FB21711
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168FB21711
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbeHNKl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 06:41:28 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:50661 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727701AbeHNKl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 06:41:28 -0400
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.52 with ESMTP; 14 Aug 2018 16:55:24 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: kyeongdon.kim@lge.com
Received: from unknown (HELO localhost.localdomain) (10.168.176.142)
        by 156.147.1.121 with ESMTP; 14 Aug 2018 16:55:24 +0900
X-Original-SENDERIP: 10.168.176.142
X-Original-MAILFROM: kyeongdon.kim@lge.com
From:   Kyeongdon Kim <kyeongdon.kim@lge.com>
To:     aryabinin@virtuozzo.com, catalin.marinas@arm.com,
        glider@google.com, dvyukov@google.com
Cc:     will.deacon@arm.com, Jason@zx2c4.com, gregkh@linuxfoundation.org,
        mingo@kernel.org, peterz@infradead.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kyeongdon.kim@lge.com
Subject: [PATCH] arm64: lib: use c string functions for KASAN support
Date:   Tue, 14 Aug 2018 16:55:22 +0900
Message-Id: <1534233322-106271-1-git-send-email-kyeongdon.kim@lge.com>
X-Mailer: git-send-email 2.6.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assembly optimized string functions cannot detect KASan bug.
This might have been the intention of the original author.
(not too much important to catch)

But, I found the obvious uaf problem in strcmp() function.
 - in this case, using 32bit KASan patchset helps

Since I used c string function, I believe I could find this bug.
After using the patch, can see the report & backtrace the below:

==================================================================
BUG: KASAN: use-after-free in strcmp+0x1c/0x5c at addr ffffffc0ad313500
Read of size 1 by task swapper/0/1
CPU: 3 PID: 1 Comm: swapper/0 Tainted: G    B           4.9.77+ #1
Hardware name: Generic (DT) based system
Call trace:
[<ffffff880808aa7c>] dump_backtrace+0x0/0x2e0
[<ffffff880808ad70>] show_stack+0x14/0x1c
[<ffffff880848f5ec>] dump_stack+0x88/0xb0
[<ffffff8808275d3c>] kasan_object_err+0x24/0x7c
[<ffffff8808276164>] kasan_report+0x2f0/0x484
[<ffffff8808274c80>] __asan_load1+0x24/0x50
[<ffffff880849baec>] strcmp+0x1c/0x5c
[<ffffff88085ab734>] platform_match+0x40/0xe4
[<ffffff88085a8740>] __driver_attach+0x40/0x130
[<ffffff88085a573c>] bus_for_each_dev+0xc4/0xe0
[<ffffff88085a7afc>] driver_attach+0x30/0x3c
[<ffffff88085a7490>] bus_add_driver+0x2dc/0x328
[<ffffff88085a996c>] driver_register+0x118/0x160
[<ffffff88085ab0d8>] __platform_driver_register+0x7c/0x88
[<ffffff8809ad2430>] alarmtimer_init+0x154/0x1e4
[<ffffff88080832dc>] do_one_initcall+0x184/0x1a4
[<ffffff8809ac1080>] kernel_init_freeable+0x2ec/0x2f0
[<ffffff880907e0a8>] kernel_init+0x18/0x10c
[<ffffff8808082f00>] ret_from_fork+0x10/0x50
Object at ffffffc0ad313500, in cache kmalloc-64 size: 64
Allocated:
PID = 1
 save_stack_trace_tsk+0x0/0x194
 save_stack_trace+0x18/0x20
 kasan_kmalloc+0xa8/0x154
 kasan_slab_alloc+0x14/0x1c
 __kmalloc_track_caller+0x178/0x2a0
 kvasprintf+0x80/0x104
 kvasprintf_const+0xcc/0xd0
 kobject_set_name_vargs+0x54/0xd4
 dev_set_name+0x64/0x84
 of_device_make_bus_id+0xc4/0x140
 of_device_alloc+0x1e0/0x200
 of_platform_device_create_pdata+0x70/0xf4
 of_platform_bus_create+0x448/0x508
 of_platform_populate+0xf4/0x104
 of_platform_default_populate+0x20/0x28
 of_platform_default_populate_init+0x68/0x78
Freed:
PID = 1
 save_stack_trace_tsk+0x0/0x194
 save_stack_trace+0x18/0x20
 kasan_slab_free+0xa0/0x14c
 kfree+0x174/0x288
 kfree_const+0x2c/0x38
 kobject_rename+0x12c/0x160
 device_rename+0xa8/0x110
 mt_usb_probe+0x218/0x760
 platform_drv_probe+0x74/0xd0
 driver_probe_device+0x3d4/0x614
 __driver_attach+0xc8/0x130
 bus_for_each_dev+0xc4/0xe0
 driver_attach+0x30/0x3c
 bus_add_driver+0x2dc/0x328
 driver_register+0x118/0x160
 __platform_driver_register+0x7c/0x88
Memory state around the buggy address:
 ffffffc0ad313300: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffffffc0ad313400: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
>ffffffc0ad313500: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffffffc0ad313600: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
 ffffffc0ad313700: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

Signed-off-by: Kyeongdon Kim <kyeongdon.kim@lge.com>
---
 arch/arm64/include/asm/string.h | 2 ++
 arch/arm64/kernel/arm64ksyms.c  | 2 ++
 arch/arm64/lib/Makefile         | 8 +++++---
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/string.h b/arch/arm64/include/asm/string.h
index dd95d33..5c5219a 100644
--- a/arch/arm64/include/asm/string.h
+++ b/arch/arm64/include/asm/string.h
@@ -16,6 +16,7 @@
 #ifndef __ASM_STRING_H
 #define __ASM_STRING_H
 
+#if !defined(CONFIG_KASAN)
 #define __HAVE_ARCH_STRRCHR
 extern char *strrchr(const char *, int c);
 
@@ -33,6 +34,7 @@ extern __kernel_size_t strlen(const char *);
 
 #define __HAVE_ARCH_STRNLEN
 extern __kernel_size_t strnlen(const char *, __kernel_size_t);
+#endif
 
 #define __HAVE_ARCH_MEMCPY
 extern void *memcpy(void *, const void *, __kernel_size_t);
diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index d894a20..eb9bf20 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -44,12 +44,14 @@ EXPORT_SYMBOL(__arch_copy_in_user);
 EXPORT_SYMBOL(memstart_addr);
 
 	/* string / mem functions */
+#if !defined(CONFIG_KASAN)
 EXPORT_SYMBOL(strchr);
 EXPORT_SYMBOL(strrchr);
 EXPORT_SYMBOL(strcmp);
 EXPORT_SYMBOL(strncmp);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(strnlen);
+#endif
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memmove);
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 68755fd..aa2d457 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -2,9 +2,11 @@
 lib-y		:= clear_user.o delay.o copy_from_user.o		\
 		   copy_to_user.o copy_in_user.o copy_page.o		\
 		   clear_page.o memchr.o memcpy.o memmove.o memset.o	\
-		   memcmp.o strcmp.o strncmp.o strlen.o strnlen.o	\
-		   strchr.o strrchr.o tishift.o
-
+		   memcmp.o tishift.o
+ifndef CONFIG_KASAN
+lib-y		:= strcmp.o strncmp.o strlen.o strnlen.o	\
+		   strchr.o strrchr.o
+endif
 # Tell the compiler to treat all general purpose registers (with the
 # exception of the IP registers, which are already handled by the caller
 # in case of a PLT) as callee-saved, which allows for efficient runtime
-- 
2.6.2

