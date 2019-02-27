Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084FBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AFF20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbfB0Riy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:38:54 -0500
Received: from foss.arm.com ([217.140.101.70]:37632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727400AbfB0Riy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:38:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8509A78;
        Wed, 27 Feb 2019 09:38:53 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC7E13F703;
        Wed, 27 Feb 2019 09:38:52 -0800 (PST)
Date:   Wed, 27 Feb 2019 17:38:50 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_ext: fix an imbalance with kmemleak
Message-ID: <20190227173849.GG125513@arrakis.emea.arm.com>
References: <20190227173147.75650-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227173147.75650-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 12:31:47PM -0500, Qian Cai wrote:
> After offlined a memory block, kmemleak scan will trigger a crash, as it
> encounters a page ext address that has already been freed during memory
> offlining. At the beginning in alloc_page_ext(), it calls
> kmemleak_alloc(), but it does not call kmemleak_free() in
> free_page_ext().
> 
> BUG: unable to handle kernel paging request at ffff888453d00000
> PGD 128a01067 P4D 128a01067 PUD 128a04067 PMD 47e09e067 PTE 800ffffbac2ff060
> Oops: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
> CPU: 1 PID: 1594 Comm: bash Not tainted 5.0.0-rc8+ #15
> Hardware name: HP ProLiant DL180 Gen9/ProLiant DL180 Gen9, BIOS U20 10/25/2017
> RIP: 0010:scan_block+0xb5/0x290
> Code: 85 6e 01 00 00 48 b8 00 00 30 f5 81 88 ff ff 48 39 c3 0f 84 5b 01
> 00 00 48 89 d8 48 c1 e8 03 42 80 3c 20 00 0f 85 87 01 00 00 <4c> 8b 3b
> e8 f3 0c fa ff 4c 39 3d 0c 6b 4c 01 0f 87 08 01 00 00 4c
> RSP: 0018:ffff8881ec57f8e0 EFLAGS: 00010082
> RAX: 0000000000000000 RBX: ffff888453d00000 RCX: ffffffffa61e5a54
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888453d00000
> RBP: ffff8881ec57f920 R08: fffffbfff4ed588d R09: fffffbfff4ed588c
> R10: fffffbfff4ed588c R11: ffffffffa76ac463 R12: dffffc0000000000
> R13: ffff888453d00ff9 R14: ffff8881f80cef48 R15: ffff8881f80cef48
> FS:  00007f6c0e3f8740(0000) GS:ffff8881f7680000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff888453d00000 CR3: 00000001c4244003 CR4: 00000000001606a0
> Call Trace:
>  scan_gray_list+0x269/0x430
>  kmemleak_scan+0x5a8/0x10f0
>  kmemleak_write+0x541/0x6ca
>  full_proxy_write+0xf8/0x190
>  __vfs_write+0xeb/0x980
>  vfs_write+0x15a/0x4f0
>  ksys_write+0xd2/0x1b0
>  __x64_sys_write+0x73/0xb0
>  do_syscall_64+0xeb/0xaaa
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f6c0dad73b8
> Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 f3 0f 1e fa
> 48 8d 05 65 63 2d 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <48> 3d 00
> f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
> RSP: 002b:00007ffd5b863cb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f6c0dad73b8
> RDX: 0000000000000005 RSI: 000055a9216e1710 RDI: 0000000000000001
> RBP: 000055a9216e1710 R08: 000000000000000a R09: 00007ffd5b863840
> R10: 000000000000000a R11: 0000000000000246 R12: 00007f6c0dda9780
> R13: 0000000000000005 R14: 00007f6c0dda4740 R15: 0000000000000005
> Modules linked in: nls_iso8859_1 nls_cp437 vfat fat kvm_intel kvm
> irqbypass efivars ip_tables x_tables xfs sd_mod ahci libahci igb
> i2c_algo_bit libata i2c_core dm_mirror dm_region_hash dm_log dm_mod
> efivarfs
> CR2: ffff888453d00000
> ---[ end trace ccf646c7456717c5 ]---
> RIP: 0010:scan_block+0xb5/0x290
> Code: 85 6e 01 00 00 48 b8 00 00 30 f5 81 88 ff ff 48 39 c3 0f 84 5b 01
> 00 00 48 89 d8 48 c1 e8 03 42 80 3c 20 00 0f 85 87 01 00 00 <4c> 8b 3b
> e8 f3 0c fa ff 4c 39 3d 0c 6b 4c 01 0f 87 08 01 00 00 4c
> RSP: 0018:ffff8881ec57f8e0 EFLAGS: 00010082
> RAX: 0000000000000000 RBX: ffff888453d00000 RCX: ffffffffa61e5a54
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888453d00000
> RBP: ffff8881ec57f920 R08: fffffbfff4ed588d R09: fffffbfff4ed588c
> R10: fffffbfff4ed588c R11: ffffffffa76ac463 R12: dffffc0000000000
> R13: ffff888453d00ff9 R14: ffff8881f80cef48 R15: ffff8881f80cef48
> FS:  00007f6c0e3f8740(0000) GS:ffff8881f7680000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff888453d00000 CR3: 00000001c4244003 CR4: 00000000001606a0
> Kernel panic - not syncing: Fatal exception
> Shutting down cpus with NMI
> Kernel Offset: 0x24c00000 from 0xffffffff81000000 (relocation range:
> 0xffffffff80000000-0xffffffffbfffffff)
> ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
