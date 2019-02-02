Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D12C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4A9218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sh1RBmnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfBBJuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:50:25 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46626 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfBBJuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 04:50:24 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so7438572edt.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 01:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R+6Qx6LlK+oa0EcGtAL6rI/CIQsyyTb8/pI1FynUKyQ=;
        b=Sh1RBmnEJ/JwExIqmCl/Ei46LH3LdrBIAZGLSFVsVGaCCGVXd98rLOXJJK6cwry5bZ
         6WqKZW/KBSg4iA3euljZ0ssN0ykPaXvwSySE1oWo6OH7dCqSXkXhbsCyINdbq9QVrPhn
         1VZjz/BBSGnrdhd8cgFvugS7crCP/w606dCM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R+6Qx6LlK+oa0EcGtAL6rI/CIQsyyTb8/pI1FynUKyQ=;
        b=Vh1QON4ctJn4Zj9CUKDJQhlN1Ezk19Iv6FJzpOfXMiqRESuqYETil/aKfQhMK52Zvy
         P1gnlI/QevxNyYfw6QKZH41j3ZNGgnpOGh3ZNoAveIm1AmRvbmD6Fd3XuZdEZU+c9yGK
         OsfZd+IuCcVcgMbzFtsrQUZQUHxyRVSIrp8oJWViZlkcj2PhTKOgZZsTEPhzivBuUE3r
         39wtPDqWmyD5cBKkMrFjtWrAcFSWsq1AW+qdbXUEd5IqhOWjprVoXz7X4toQ5xh2+wA7
         pPRIOfjhnMXqF+QhJveG2viQTHibi609U7Kg4LjT7OSemF7XAX2P3JjbNp6M+zTGM9BM
         ROMQ==
X-Gm-Message-State: AJcUukfrmVvUWKgKczP0B+C3/Uv8aCgUJMELAYng4H80qPmo+NtOY5/0
        qGUhgVnBHqb6ERIuWrgisY78OQ==
X-Google-Smtp-Source: ALg8bN4B2uoP8l2M2UYHT5nxtESFAX9GllQZbv54EflEnb9LVoeC4RxRdU777rM0O3W9jNGFuZX4Xg==
X-Received: by 2002:a17:906:6c09:: with SMTP id j9mr31591703ejr.28.1549101022911;
        Sat, 02 Feb 2019 01:50:22 -0800 (PST)
Received: from mba13.c.hoisthospitality.com ([109.236.135.164])
        by smtp.gmail.com with ESMTPSA id a4sm59231eje.66.2019.02.02.01.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 01:50:22 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH 1/1] efi/arm64: add a terminator for ptdump marker
Date:   Sat,  2 Feb 2019 10:50:17 +0100
Message-Id: <20190202095017.13799-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190202095017.13799-1-ard.biesheuvel@linaro.org>
References: <20190202095017.13799-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>

Reading efi_page_tables debugfs triggers an out-of-bounds access here,

  arch/arm64/mm/dump.c: 282
  if (addr >= st->marker[1].start_address) {

called from,

  arch/arm64/mm/dump.c: 331
  note_page(st, addr, 2, pud_val(pud));

because st->marker++ is is called after "UEFI runtime end" which is the
last element in addr_marker[]. Therefore, add a terminator like the one
for kernel_page_tables, so it can be skipped to print out non-existent
markers.

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

  [12126.163970] BUG: KASAN: global-out-of-bounds in note_page+0x1f0/0xac0
  [12126.170404] Read of size 8 at addr ffff2000123f2ac0 by task read_all/42464
  [12126.199520] Call trace:
  [12126.201972]  dump_backtrace+0x0/0x298
  [12126.205627]  show_stack+0x24/0x30
  [12126.208944]  dump_stack+0xb0/0xdc
  [12126.212258]  print_address_description+0x64/0x2b0
  [12126.216954]  kasan_report+0x150/0x1a4
  [12126.220610]  __asan_report_load8_noabort+0x30/0x3c
  [12126.225392]  note_page+0x1f0/0xac0
  [12126.228786]  walk_pgd+0xb4/0x244
  [12126.232005]  ptdump_walk_pgd+0xec/0x140
  [12126.235833]  ptdump_show+0x40/0x50
  [12126.239237]  seq_read+0x3f8/0xad0
  [12126.242548]  full_proxy_read+0x9c/0xc0
  [12126.246290]  __vfs_read+0xfc/0x4c8
  [12126.249684]  vfs_read+0xec/0x208
  [12126.252904]  ksys_read+0xd0/0x15c
  [12126.256210]  __arm64_sys_read+0x84/0x94
  [12126.260048]  el0_svc_handler+0x258/0x304
  [12126.263963]  el0_svc+0x8/0xc
  [12126.266834]
  [12126.268317] The buggy address belongs to the variable:
  [12126.273458]  __compound_literal.0+0x20/0x800
  [12126.277718]
  [12126.279201] Memory state around the buggy address:
  [12126.283987]  ffff2000123f2980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  [12126.291200]  ffff2000123f2a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fa
  [12126.298412] >ffff2000123f2a80: fa fa fa fa 00 00 00 00 fa fa fa fa 00 00 00 00
  [12126.305624]                                            ^
  [12126.310927]  ffff2000123f2b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  [12126.318140]  ffff2000123f2b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0

Fixes: 9d80448ac92b ("efi/arm64: Add debugfs node to dump UEFI runtime page tables")
Signed-off-by: Qian Cai <cai@lca.pw>
[ardb: fix up whitespace]
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
-- 
2.17.1

