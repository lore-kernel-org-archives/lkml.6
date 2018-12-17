Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF835C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A592133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388609AbeLQSQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:16:35 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48553 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbeLQSQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:16:34 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBHIFrR32560039
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Dec 2018 10:15:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBHIFrRr2560036;
        Mon, 17 Dec 2018 10:15:53 -0800
Date:   Mon, 17 Dec 2018 10:15:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qian Cai <tipbot@zytor.com>
Message-ID: <tip-a0fc5578f1d63ba6e80d9509991b4c14f6eaf488@git.kernel.org>
Cc:     ard.biesheuvel@linaro.org, luto@kernel.org, cai@gmx.us,
        riel@surriel.com, dave.hansen@linux.intel.com,
        torvalds@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de,
        tglx@linutronix.de, xypron.glpk@gmx.de
Reply-To: dave.hansen@linux.intel.com, torvalds@linux-foundation.org,
          mingo@kernel.org, ard.biesheuvel@linaro.org, luto@kernel.org,
          cai@gmx.us, riel@surriel.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org,
          xypron.glpk@gmx.de, hpa@zytor.com
In-Reply-To: <20181217180214.9436-2-ard.biesheuvel@linaro.org>
References: <20181217180214.9436-2-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/urgent] efi: Let kmemleak ignore false positives
Git-Commit-ID: a0fc5578f1d63ba6e80d9509991b4c14f6eaf488
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

Commit-ID:  a0fc5578f1d63ba6e80d9509991b4c14f6eaf488
Gitweb:     https://git.kernel.org/tip/a0fc5578f1d63ba6e80d9509991b4c14f6eaf488
Author:     Qian Cai <cai@gmx.us>
AuthorDate: Mon, 17 Dec 2018 19:02:13 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Dec 2018 19:12:47 +0100

efi: Let kmemleak ignore false positives

Address this kmemleak false positive :

  unreferenced object 0xffff8096c1acf580 (size 128):
    comm "swapper/63", pid 0, jiffies 4294937418 (age 1201.230s)
    hex dump (first 32 bytes):
      80 87 b5 c1 96 00 00 00 00 00 cc c2 16 00 00 00  ................
      00 00 01 00 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b  ........kkkkkkkk
    backtrace:
      [<000000001d2549ba>] kmem_cache_alloc_trace+0x430/0x500
      [<0000000093a6dfab>] efi_mem_reserve_persistent+0x50/0xf8
      [<000000000a730828>] its_cpu_init_lpis+0x394/0x4b8
      [<00000000edf04e07>] its_cpu_init+0x104/0x150
      [<000000004d0342c5>] gic_starting_cpu+0x34/0x40
      [<000000005d9da772>] cpuhp_invoke_callback+0x228/0x1d68
      [<0000000061eace9b>] notify_cpu_starting+0xc0/0x118
      [<0000000048bc2dc5>] secondary_start_kernel+0x23c/0x3b0
      [<0000000015137d6a>] 0xffffffffffffffff

  efi_mem_reserve_persistent+0x50/0xf8:
  kmalloc at include/linux/slab.h:546
  (inlined by) efi_mem_reserve_persistent at drivers/firmware/efi/efi.c:979

It's allocated by this line:

  rsv = kmalloc(sizeof(*rsv), GFP_ATOMIC);

Kmemleak has a known limitation that can only track pointers in the kernel
virtual space. Hence, it will report false positives due to "rsv" will only
reference to other physical addresses:

  rsv->next = efi_memreserve_root->next;
  efi_memreserve_root->next = __pa(rsv);

So tell kmemleak to ignore the 'rsv' object.

 [ mingo: Improved the changelog. ]

Signed-off-by: Qian Cai <cai@gmx.us>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20181217180214.9436-2-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/efi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 415849bab233..7fcfe8a7ae98 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -31,6 +31,7 @@
 #include <linux/acpi.h>
 #include <linux/ucs2_string.h>
 #include <linux/memblock.h>
+#include <linux/kmemleak.h>
 
 #include <asm/early_ioremap.h>
 
@@ -1000,6 +1001,8 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 	if (!rsv)
 		return -ENOMEM;
 
+	kmemleak_ignore(rsv);
+
 	rsv->base = addr;
 	rsv->size = size;
 
