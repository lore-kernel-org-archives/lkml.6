Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13141C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B541420878
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B541420878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbeH1SOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:14:25 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:39296 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH1SOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:14:25 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id UeNT1y00r3XaVaC06eNT1T; Tue, 28 Aug 2018 16:22:29 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fuet1-0008NG-SZ; Tue, 28 Aug 2018 16:22:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fuet1-00024y-Q0; Tue, 28 Aug 2018 16:22:27 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ARM: mm: Stop printing the virtual memory layout
Date:   Tue, 28 Aug 2018 16:22:25 +0200
Message-Id: <20180828142225.7941-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with
%p"), the virtual memory layout printed during boot up contains "ptrval"
instead of actual addresses:

    Memory: 501296K/524288K available (6144K kernel code, 528K rwdata, 1944K rodata, 1024K init, 7584K bss, 22992K reserved, 0K cma-reserved)
    Virtual kernel memory layout:
	vector  : 0xffff0000 - 0xffff1000   (   4 kB)
	fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
	vmalloc : 0xe0800000 - 0xff800000   ( 496 MB)
	lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
	modules : 0xbf000000 - 0xc0000000   (  16 MB)
	  .text : 0x(ptrval) - 0x(ptrval)   (7136 kB)
	  .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
	  .data : 0x(ptrval) - 0x(ptrval)   ( 529 kB)
	   .bss : 0x(ptrval) - 0x(ptrval)   (7585 kB)

Instead of changing the printing to "%px", and leaking virtual memory
layout information again, just remove the printing completely, cfr. e.g.
commits 071929dbdd865f77 ("arm64: Stop printing the virtual memory
layout") and  31833332f7987636 ("m68k/mm: Stop printing the virtual
memory layout").

All interesting information (actual section sizes) is already printed by
mem_init_print_info() just above anyway.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mm/init.c | 49 ----------------------------------------------
 1 file changed, 49 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 0cc8e04295a40dc1..e90422ae8adfa511 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -519,55 +519,6 @@ void __init mem_init(void)
 
 	mem_init_print_info(NULL);
 
-#define MLK(b, t) b, t, ((t) - (b)) >> 10
-#define MLM(b, t) b, t, ((t) - (b)) >> 20
-#define MLK_ROUNDUP(b, t) b, t, DIV_ROUND_UP(((t) - (b)), SZ_1K)
-
-	pr_notice("Virtual kernel memory layout:\n"
-			"    vector  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-#ifdef CONFIG_HAVE_TCM
-			"    DTCM    : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-			"    ITCM    : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-#endif
-			"    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-			"    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
-			"    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
-#ifdef CONFIG_HIGHMEM
-			"    pkmap   : 0x%08lx - 0x%08lx   (%4ld MB)\n"
-#endif
-#ifdef CONFIG_MODULES
-			"    modules : 0x%08lx - 0x%08lx   (%4ld MB)\n"
-#endif
-			"      .text : 0x%p" " - 0x%p" "   (%4td kB)\n"
-			"      .init : 0x%p" " - 0x%p" "   (%4td kB)\n"
-			"      .data : 0x%p" " - 0x%p" "   (%4td kB)\n"
-			"       .bss : 0x%p" " - 0x%p" "   (%4td kB)\n",
-
-			MLK(VECTORS_BASE, VECTORS_BASE + PAGE_SIZE),
-#ifdef CONFIG_HAVE_TCM
-			MLK(DTCM_OFFSET, (unsigned long) dtcm_end),
-			MLK(ITCM_OFFSET, (unsigned long) itcm_end),
-#endif
-			MLK(FIXADDR_START, FIXADDR_END),
-			MLM(VMALLOC_START, VMALLOC_END),
-			MLM(PAGE_OFFSET, (unsigned long)high_memory),
-#ifdef CONFIG_HIGHMEM
-			MLM(PKMAP_BASE, (PKMAP_BASE) + (LAST_PKMAP) *
-				(PAGE_SIZE)),
-#endif
-#ifdef CONFIG_MODULES
-			MLM(MODULES_VADDR, MODULES_END),
-#endif
-
-			MLK_ROUNDUP(_text, _etext),
-			MLK_ROUNDUP(__init_begin, __init_end),
-			MLK_ROUNDUP(_sdata, _edata),
-			MLK_ROUNDUP(__bss_start, __bss_stop));
-
-#undef MLK
-#undef MLM
-#undef MLK_ROUNDUP
-
 	/*
 	 * Check boundaries twice: Some fundamental inconsistencies can
 	 * be detected at build time already.
-- 
2.17.1

