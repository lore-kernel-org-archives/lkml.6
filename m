Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC038C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30B82085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbfAUPXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:23:00 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:60294 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbfAUPW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:22:59 -0500
Received: from ramsan ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id T3Nw1z00L3XaVaC013NwxV; Mon, 21 Jan 2019 16:22:57 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1glbPc-0003yf-8s; Mon, 21 Jan 2019 16:22:56 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1glbPc-0007Zk-6K; Mon, 21 Jan 2019 16:22:56 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Guan Xuetao <gxt@pku.edu.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] unicore32: Stop printing the virtual memory layout
Date:   Mon, 21 Jan 2019 16:22:54 +0100
Message-Id: <20190121152254.29079-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with
%p"), the virtual memory layout printed during boot up contains "ptrval"
instead of actual addresses.

Instead of changing the printing to "%px", and leaking virtual memory
layout information again, just remove the printing completely, cfr. e.g.
commits 071929dbdd865f77 ("arm64: Stop printing the virtual memory
layout") and  31833332f7987636 ("m68k/mm: Stop printing the virtual
memory layout").

All interesting information (actual section sizes) is already printed by
mem_init_print_info() just above anyway.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
v2:
  - Add Reviewed-by,
  - Rebased on top of memblock conversion.
---
 arch/unicore32/mm/init.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/unicore32/mm/init.c b/arch/unicore32/mm/init.c
index 85ef2c62409034ff..74b6a2e29809a8b0 100644
--- a/arch/unicore32/mm/init.c
+++ b/arch/unicore32/mm/init.c
@@ -274,30 +274,6 @@ void __init mem_init(void)
 	memblock_free_all();
 
 	mem_init_print_info(NULL);
-	printk(KERN_NOTICE "Virtual kernel memory layout:\n"
-		"    vector  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-		"    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
-		"    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
-		"    modules : 0x%08lx - 0x%08lx   (%4ld MB)\n"
-		"      .init : 0x%p" " - 0x%p" "   (%4d kB)\n"
-		"      .text : 0x%p" " - 0x%p" "   (%4d kB)\n"
-		"      .data : 0x%p" " - 0x%p" "   (%4d kB)\n",
-
-		VECTORS_BASE, VECTORS_BASE + PAGE_SIZE,
-		DIV_ROUND_UP(PAGE_SIZE, SZ_1K),
-		VMALLOC_START, VMALLOC_END,
-		DIV_ROUND_UP((VMALLOC_END - VMALLOC_START), SZ_1M),
-		PAGE_OFFSET, (unsigned long)high_memory,
-		DIV_ROUND_UP(((unsigned long)high_memory - PAGE_OFFSET), SZ_1M),
-		MODULES_VADDR, MODULES_END,
-		DIV_ROUND_UP((MODULES_END - MODULES_VADDR), SZ_1M),
-
-		__init_begin, __init_end,
-		DIV_ROUND_UP((__init_end - __init_begin), SZ_1K),
-		_stext, _etext,
-		DIV_ROUND_UP((_etext - _stext), SZ_1K),
-		_sdata, _edata,
-		DIV_ROUND_UP((_edata - _sdata), SZ_1K));
 
 	BUILD_BUG_ON(TASK_SIZE				> MODULES_VADDR);
 	BUG_ON(TASK_SIZE				> MODULES_VADDR);
-- 
2.17.1

