Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20681C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE7420870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfBBKbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 05:31:10 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39267 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfBBKbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 05:31:10 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x12AUvex3728557
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 2 Feb 2019 02:30:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x12AUu9b3728554;
        Sat, 2 Feb 2019 02:30:56 -0800
Date:   Sat, 2 Feb 2019 02:30:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qian Cai <tipbot@zytor.com>
Message-ID: <tip-74c953ca5f6b4d5f1daa1ef34f4317e15c1a2987@git.kernel.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org, tglx@linutronix.de, cai@lca.pw,
        ard.biesheuvel@linaro.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, ard.biesheuvel@linaro.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          peterz@infradead.org, cai@lca.pw
In-Reply-To: <20190202095017.13799-2-ard.biesheuvel@linaro.org>
References: <20190202095017.13799-2-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/urgent] efi/arm64: Fix debugfs crash by adding a
 terminator for ptdump marker
Git-Commit-ID: 74c953ca5f6b4d5f1daa1ef34f4317e15c1a2987
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

Commit-ID:  74c953ca5f6b4d5f1daa1ef34f4317e15c1a2987
Gitweb:     https://git.kernel.org/tip/74c953ca5f6b4d5f1daa1ef34f4317e15c1a2987
Author:     Qian Cai <cai@lca.pw>
AuthorDate: Sat, 2 Feb 2019 10:50:17 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 2 Feb 2019 11:27:29 +0100

efi/arm64: Fix debugfs crash by adding a terminator for ptdump marker

When reading 'efi_page_tables' debugfs triggers an out-of-bounds access here:

  arch/arm64/mm/dump.c: 282
  if (addr >= st->marker[1].start_address) {

called from:

  arch/arm64/mm/dump.c: 331
  note_page(st, addr, 2, pud_val(pud));

because st->marker++ is is called after "UEFI runtime end" which is the
last element in addr_marker[]. Therefore, add a terminator like the one
for kernel_page_tables, so it can be skipped to print out non-existent
markers.

Here's the KASAN bug report:

  # cat /sys/kernel/debug/efi_page_tables
  ---[ UEFI runtime start ]---
  0x0000000020000000-0x0000000020010000          64K PTE       RW NX SHD AF ...
  0x0000000020200000-0x0000000021340000       17664K PTE       RW NX SHD AF ...
  ...
  0x0000000021920000-0x0000000021950000         192K PTE       RW x  SHD AF ...
  0x0000000021950000-0x00000000219a0000         320K PTE       RW NX SHD AF ...
  ---[ UEFI runtime end ]---
  ---[ (null) ]---
  ---[ (null) ]---

   BUG: KASAN: global-out-of-bounds in note_page+0x1f0/0xac0
   Read of size 8 at addr ffff2000123f2ac0 by task read_all/42464
   Call trace:
    dump_backtrace+0x0/0x298
    show_stack+0x24/0x30
    dump_stack+0xb0/0xdc
    print_address_description+0x64/0x2b0
    kasan_report+0x150/0x1a4
    __asan_report_load8_noabort+0x30/0x3c
    note_page+0x1f0/0xac0
    walk_pgd+0xb4/0x244
    ptdump_walk_pgd+0xec/0x140
    ptdump_show+0x40/0x50
    seq_read+0x3f8/0xad0
    full_proxy_read+0x9c/0xc0
    __vfs_read+0xfc/0x4c8
    vfs_read+0xec/0x208
    ksys_read+0xd0/0x15c
    __arm64_sys_read+0x84/0x94
    el0_svc_handler+0x258/0x304
    el0_svc+0x8/0xc

  The buggy address belongs to the variable:
   __compound_literal.0+0x20/0x800

  Memory state around the buggy address:
   ffff2000123f2980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   ffff2000123f2a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fa
  >ffff2000123f2a80: fa fa fa fa 00 00 00 00 fa fa fa fa 00 00 00 00
                                            ^
   ffff2000123f2b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   ffff2000123f2b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0

[ ardb: fix up whitespace ]
[ mingo: fix up some moar ]

Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Fixes: 9d80448ac92b ("efi/arm64: Add debugfs node to dump UEFI runtime page tables")
Link: http://lkml.kernel.org/r/20190202095017.13799-2-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/arm-runtime.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 23ea1ed409d1..352bd2473162 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -37,8 +37,9 @@ extern u64 efi_system_table;
 static struct ptdump_info efi_ptdump_info = {
 	.mm		= &efi_mm,
 	.markers	= (struct addr_marker[]){
-		{ 0,		"UEFI runtime start" },
-		{ DEFAULT_MAP_WINDOW_64, "UEFI runtime end" }
+		{ 0,				"UEFI runtime start" },
+		{ DEFAULT_MAP_WINDOW_64,	"UEFI runtime end" },
+		{ -1,				NULL }
 	},
 	.base_addr	= 0,
 };
