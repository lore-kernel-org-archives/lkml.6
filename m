Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABFDC00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E0621873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ItGXDQJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfB0RcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:32:01 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32887 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfB0RcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:32:00 -0500
Received: by mail-qk1-f195.google.com with SMTP id x9so10367501qkf.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 09:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hHOFyrwpvydWZWAGP6U/o0hZfnIdyhgSbo6ZXDL9wn0=;
        b=ItGXDQJUi8BRiSGj0pyl/Kn/YqJ5yf8lpj/i2XXCdbi4r6RjSt7DYHoS3qwPzwI38S
         cMt4ZvJUnP2O5ZoALi4sip/uocmzwODpeMJA2MQdjz2aHcucKeHvti+pLxzzJFjY4v7R
         0299Nk5/xQQ0hQ835FJNv9CWKfK3YiQCraqePUSb9rkm86alLI5fdzOcIOzwCE0WsnLH
         lU4YSw8Ryozy6wWjRfpZS9B4Myjv8VfS1gCK8H4148RZFin6T1tUzhQRV1AmG5bKZNkJ
         dGlUJfDoBwVTHSXrt8cfhuGma9VmXAkw2WvHXPU8ec+Rv4mBIASAm17EHJy8ogZa+2Ql
         bJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hHOFyrwpvydWZWAGP6U/o0hZfnIdyhgSbo6ZXDL9wn0=;
        b=c/FWY8Gcx7h2TI1aLxUTw2j74imAYz95j0qSQ1Fxezan5Jn+w8QYtbOvMK8vh222tS
         07epXhNk2q6ro/blpicTKsefHxX2lG8m1j4ExWjX5H8gFtsd1MUgJq9X4gF8YAocyn5Q
         DzZQIz6fWlS7my6y49HZ5QxWj0nJJtG6QIMW2IBqSZo0B+C9uKqd7OOe6mRtI/U/Pqt8
         H6dtfYlk01ECDBYbmBf4g+oG4ZNuSzyz4dfnbeP3WiwRdHNVj4yw4wGgvDCrR93rbpCF
         kUpTKouNK8kFUakuZo6mGEyUasU6DH6vIPJU3wHIbunUZAuDwPBVsNQ58BFsmFq1WqOt
         O+GQ==
X-Gm-Message-State: APjAAAVNjqTIzCLxQiDMy5TH3aP6nHGDirpNUFTa1INPRyR3ELHY64qb
        VhxIhtGBI4Z2AlQoLPrRNofWSXeiwTc=
X-Google-Smtp-Source: AHgI3IYWMSSx9Xalb1WB5XlJJM4CY4wMH21644s0iZYtwCOYjPJzMh8Q3vkWlhUhWuYZIeiy2M0D5Q==
X-Received: by 2002:a37:d1d2:: with SMTP id o79mr3196699qkl.98.1551288719613;
        Wed, 27 Feb 2019 09:31:59 -0800 (PST)
Received: from Qians-MBP.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y11sm14233372qky.2.2019.02.27.09.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 09:31:59 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v3] mm/page_ext: fix an imbalance with kmemleak
Date:   Wed, 27 Feb 2019 12:31:47 -0500
Message-Id: <20190227173147.75650-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After offlined a memory block, kmemleak scan will trigger a crash, as it
encounters a page ext address that has already been freed during memory
offlining. At the beginning in alloc_page_ext(), it calls
kmemleak_alloc(), but it does not call kmemleak_free() in
free_page_ext().

BUG: unable to handle kernel paging request at ffff888453d00000
PGD 128a01067 P4D 128a01067 PUD 128a04067 PMD 47e09e067 PTE 800ffffbac2ff060
Oops: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
CPU: 1 PID: 1594 Comm: bash Not tainted 5.0.0-rc8+ #15
Hardware name: HP ProLiant DL180 Gen9/ProLiant DL180 Gen9, BIOS U20 10/25/2017
RIP: 0010:scan_block+0xb5/0x290
Code: 85 6e 01 00 00 48 b8 00 00 30 f5 81 88 ff ff 48 39 c3 0f 84 5b 01
00 00 48 89 d8 48 c1 e8 03 42 80 3c 20 00 0f 85 87 01 00 00 <4c> 8b 3b
e8 f3 0c fa ff 4c 39 3d 0c 6b 4c 01 0f 87 08 01 00 00 4c
RSP: 0018:ffff8881ec57f8e0 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffff888453d00000 RCX: ffffffffa61e5a54
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888453d00000
RBP: ffff8881ec57f920 R08: fffffbfff4ed588d R09: fffffbfff4ed588c
R10: fffffbfff4ed588c R11: ffffffffa76ac463 R12: dffffc0000000000
R13: ffff888453d00ff9 R14: ffff8881f80cef48 R15: ffff8881f80cef48
FS:  00007f6c0e3f8740(0000) GS:ffff8881f7680000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888453d00000 CR3: 00000001c4244003 CR4: 00000000001606a0
Call Trace:
 scan_gray_list+0x269/0x430
 kmemleak_scan+0x5a8/0x10f0
 kmemleak_write+0x541/0x6ca
 full_proxy_write+0xf8/0x190
 __vfs_write+0xeb/0x980
 vfs_write+0x15a/0x4f0
 ksys_write+0xd2/0x1b0
 __x64_sys_write+0x73/0xb0
 do_syscall_64+0xeb/0xaaa
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f6c0dad73b8
Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 f3 0f 1e fa
48 8d 05 65 63 2d 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <48> 3d 00
f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
RSP: 002b:00007ffd5b863cb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f6c0dad73b8
RDX: 0000000000000005 RSI: 000055a9216e1710 RDI: 0000000000000001
RBP: 000055a9216e1710 R08: 000000000000000a R09: 00007ffd5b863840
R10: 000000000000000a R11: 0000000000000246 R12: 00007f6c0dda9780
R13: 0000000000000005 R14: 00007f6c0dda4740 R15: 0000000000000005
Modules linked in: nls_iso8859_1 nls_cp437 vfat fat kvm_intel kvm
irqbypass efivars ip_tables x_tables xfs sd_mod ahci libahci igb
i2c_algo_bit libata i2c_core dm_mirror dm_region_hash dm_log dm_mod
efivarfs
CR2: ffff888453d00000
---[ end trace ccf646c7456717c5 ]---
RIP: 0010:scan_block+0xb5/0x290
Code: 85 6e 01 00 00 48 b8 00 00 30 f5 81 88 ff ff 48 39 c3 0f 84 5b 01
00 00 48 89 d8 48 c1 e8 03 42 80 3c 20 00 0f 85 87 01 00 00 <4c> 8b 3b
e8 f3 0c fa ff 4c 39 3d 0c 6b 4c 01 0f 87 08 01 00 00 4c
RSP: 0018:ffff8881ec57f8e0 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffff888453d00000 RCX: ffffffffa61e5a54
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888453d00000
RBP: ffff8881ec57f920 R08: fffffbfff4ed588d R09: fffffbfff4ed588c
R10: fffffbfff4ed588c R11: ffffffffa76ac463 R12: dffffc0000000000
R13: ffff888453d00ff9 R14: ffff8881f80cef48 R15: ffff8881f80cef48
FS:  00007f6c0e3f8740(0000) GS:ffff8881f7680000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888453d00000 CR3: 00000001c4244003 CR4: 00000000001606a0
Kernel panic - not syncing: Fatal exception
Shutting down cpus with NMI
Kernel Offset: 0x24c00000 from 0xffffffff81000000 (relocation range:
0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: Fatal exception ]---

Signed-off-by: Qian Cai <cai@lca.pw>
---

v3: place kmemleak_free() before free_pages_exact() to avoid a small window
    where the address has been freed but kmemleak not informed pointed out by
    Catalin.

v2: move kmemleak_free() into free_page_ext() as there is no need to call
    kmemleak_free() in the vfree() case.

 mm/page_ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page_ext.c b/mm/page_ext.c
index 8c78b8d45117..f116431c3dee 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -273,6 +273,7 @@ static void free_page_ext(void *addr)
 		table_size = get_entry_size() * PAGES_PER_SECTION;
 
 		BUG_ON(PageReserved(page));
+		kmemleak_free(addr);
 		free_pages_exact(addr, table_size);
 	}
 }
-- 
2.17.2 (Apple Git-113)

