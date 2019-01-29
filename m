Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C339FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8589621473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bKD66bcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfA2RgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:36:23 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44433 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfA2RgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:36:22 -0500
Received: by mail-qt1-f195.google.com with SMTP id n32so23104128qte.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 09:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3Piqb5EofmMzXo9nO96EpWaKq3Ak13kgDIRmFo9+iDA=;
        b=bKD66bcb5mRkabeTvN1z02N4ieZO5+ElIJKjnf6nD332/p7Al9hBb8Gs/lKQcV/unk
         S7KFDEqNAnV4FQpGYhLR8WvpbhPjRSsXqxYbWBCUjgmJeNwYGM3K2M7NXChtiU+ltGCw
         QXd9VP5Q5ccA71C0zjiSuX8u74AcZrju8XcrsWdaTDiqxjNK+oLeSIQb/gjCcza9yfZ+
         N88z2N4cYT/OYtjS0aMNnZxwRWFtrl/K4wp3ivIa7xNaDBp0qlzuajk4ir5fIm76OaSx
         mSLWxiqg9hP8td4MT34ESm1vlB3kr8lz/cpU/gFHXHLT1TtityRfbg5Pd9CY/iYn+v0X
         2RYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3Piqb5EofmMzXo9nO96EpWaKq3Ak13kgDIRmFo9+iDA=;
        b=BIaO3elG8KQf/ihUb1PD+/rVqMI/PQlxXC9XcU1hawi4wnyW4GkZlGBSkAsvIW0fK4
         1RMckMTJuPTWd7AS7WQ29luFHQ4XgVA8xcqQQQ7SxvRIP8/Ujcn3Fnzi2ETolkzZfwfA
         Gm+MyKTDrgEE6loXpcBwUds8YM1EXPs17uQkZtRGXAZrfLqfTegfpuYwTS+m5SmcpPsO
         dvXMTsA2TpSrkl5SjcwcJDNFElmXQWuMKB+XdkyR9HmY2SOZD73EubguO99h91h91DxB
         oywFI6R8OSeOtodl1gHUZeQW0WBj88vcxKKvlnj+AjuoZP7ZTjj3mYkkKAE1gH1Rc33L
         P1sQ==
X-Gm-Message-State: AJcUukfo8k23h1Zb5p5Q+sBVbTPhd3aSrqugjNLmOKsxbCy8vMcfqQOx
        /C21QrIb/aFJtjz9ZAaIehMgaQ==
X-Google-Smtp-Source: ALg8bN7K7+B5VgLVaZ/fhCJOW8dRCwpPA2XHoAy9ItqGtWsEjNWgVF2S/gaFzivAR801cLrJGZrrGQ==
X-Received: by 2002:a0c:8762:: with SMTP id 31mr25569378qvi.118.1548783381058;
        Tue, 29 Jan 2019 09:36:21 -0800 (PST)
Received: from ovpn-120-54.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c20sm12983567qtj.56.2019.01.29.09.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 09:36:20 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     ard.biesheuvel@linaro.org
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] efi/arm64: add a terminator for ptdump marker
Date:   Tue, 29 Jan 2019 12:36:00 -0500
Message-Id: <20190129173600.38856-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read efi_page_tables debugfs triggering an out-of-bounds access here,

arch/arm64/mm/dump.c: 282
if (addr >= st->marker[1].start_address) {

from,

arch/arm64/mm/dump.c: 331
note_page(st, addr, 2, pud_val(pud));

because st->marker++ is is called after "UEFI runtime end" which is the
last element in addr_marker[]. Therefore, add a terminator like the one
for kernel_page_tables, so it can be skipped to print out non-existent
markers.

 # cat /sys/kernel/debug/efi_page_tables
---[ UEFI runtime start ]---
0x0000000020000000-0x0000000020010000          64K PTE       RW NX SHD AF NG         UXN MEM/NORMAL
0x0000000020200000-0x0000000021340000       17664K PTE       RW NX SHD AF NG         UXN MEM/NORMAL
0x0000000021340000-0x0000000021350000          64K PTE       RW x  SHD AF NG         UXN MEM/NORMAL
0x0000000021350000-0x0000000021370000         128K PTE       RW NX SHD AF NG         UXN MEM/NORMAL
0x0000000021370000-0x0000000021380000          64K PTE       RW x  SHD AF NG         UXN MEM/NORMAL
0x0000000021380000-0x00000000213b0000         192K PTE       RW NX SHD AF NG         UXN MEM/NORMAL
0x00000000213b0000-0x0000000021490000         896K PTE       RW x  SHD AF NG         UXN MEM/NORMAL
0x0000000021490000-0x00000000214b0000         128K PTE       RW NX SHD AF NG         UXN MEM/NORMAL
0x00000000214b0000-0x00000000214e0000         192K PTE       RW x  SHD AF NG         UXN MEM/NORMAL
0x00000000214e0000-0x00000000214f0000          64K PTE       RW NX SHD AF NG         UXN MEM/NORMAL
0x00000000214f0000-0x0000000021540000         320K PTE       RW x  SHD AF NG         UXN MEM/NORMAL
0x0000000021540000-0x0000000021560000         128K PTE       RW NX SHD AF NG         UXN MEM/NORMAL
0x0000000021560000-0x0000000021580000         128K PTE       RW x  SHD AF NG         UXN MEM/NORMAL
0x0000000021580000-0x00000000215a0000         128K PTE       RW NX SHD AF NG         UXN MEM/NORMAL
0x00000000215a0000-0x00000000215d0000         192K PTE       RW x  SHD AF NG         UXN MEM/NORMAL
0x00000000215d0000-0x00000000215e0000          64K PTE       RW NX SHD AF NG         UXN MEM/NORMAL
0x00000000215e0000-0x0000000021600000         128K PTE       RW x  SHD AF NG         UXN MEM/NORMAL
0x0000000021600000-0x0000000021800000           2M PTE       RW NX SHD AF NG         UXN MEM/NORMAL
0x0000000021800000-0x0000000021840000         256K PTE       RW x  SHD AF NG         UXN MEM/NORMAL
0x0000000021840000-0x00000000218e0000         640K PTE       RW NX SHD AF NG         UXN MEM/NORMAL
0x00000000218e0000-0x0000000021900000         128K PTE       RW x  SHD AF NG         UXN MEM/NORMAL
0x0000000021900000-0x0000000021920000         128K PTE       RW NX SHD AF NG         UXN MEM/NORMAL
0x0000000021920000-0x0000000021950000         192K PTE       RW x  SHD AF NG         UXN MEM/NORMAL
0x0000000021950000-0x00000000219a0000         320K PTE       RW NX SHD AF NG         UXN DEVICE/nGnRE
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

Fixes: 9d80448ac92b ("efi/arm64: Add debugfs node to dump UEFI runtime
page tables")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/firmware/efi/arm-runtime.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 23ea1ed409d1..1d28fd933297 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -38,7 +38,8 @@ static struct ptdump_info efi_ptdump_info = {
 	.mm		= &efi_mm,
 	.markers	= (struct addr_marker[]){
 		{ 0,		"UEFI runtime start" },
-		{ DEFAULT_MAP_WINDOW_64, "UEFI runtime end" }
+		{ DEFAULT_MAP_WINDOW_64, "UEFI runtime end" },
+		{ -1,		NULL }
 	},
 	.base_addr	= 0,
 };
-- 
2.17.2 (Apple Git-113)

