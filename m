Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ACFC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7F220869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7F220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeJPU2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:28:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34560 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726718AbeJPU2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:28:03 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5FAB885A9F15C;
        Tue, 16 Oct 2018 20:37:43 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Tue, 16 Oct 2018
 20:37:34 +0800
Subject: Re: [PATCH v2] f2fs: cleanup dirty pages if recover failed
To:     Sheng Yong <shengyong1@huawei.com>, <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <f4867be0-7a93-b335-d278-211d5a2aa4c8@huawei.com>
 <20181012104926.244217-1-shengyong1@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b0203c4c-747e-3949-62df-e1644f11ad73@huawei.com>
Date:   Tue, 16 Oct 2018 20:37:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012104926.244217-1-shengyong1@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/12 18:49, Sheng Yong wrote:
> During recover, we will try to create new dentries for inodes with
> dentry_mark. But if the parent is missing (e.g. killed by fsck),
> recover will break. But those recovered dirty pages are not cleanup.
> This will hit f2fs_bug_on:
> 
> [   53.519566] F2FS-fs (loop0): Found nat_bits in checkpoint
> [   53.539354] F2FS-fs (loop0): recover_inode: ino = 5, name = file, inline = 3
> [   53.539402] F2FS-fs (loop0): recover_dentry: ino = 5, name = file, dir = 0, err = -2
> [   53.545760] F2FS-fs (loop0): Cannot recover all fsync data errno=-2
> [   53.546105] F2FS-fs (loop0): access invalid blkaddr:4294967295
> [   53.546171] WARNING: CPU: 1 PID: 1798 at fs/f2fs/checkpoint.c:163 f2fs_is_valid_blkaddr+0x26c/0x320
> [   53.546174] Modules linked in:
> [   53.546183] CPU: 1 PID: 1798 Comm: mount Not tainted 4.19.0-rc2+ #1
> [   53.546186] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> [   53.546191] RIP: 0010:f2fs_is_valid_blkaddr+0x26c/0x320
> [   53.546195] Code: 85 bb 00 00 00 48 89 df 88 44 24 07 e8 ad a8 db ff 48 8b 3b 44 89 e1 48 c7 c2 40 03 72 a9 48 c7 c6 e0 01 72 a9 e8 84 3c ff ff <0f> 0b 0f b6 44 24 07 e9 8a 00 00 00 48 8d bf 38 01 00 00 e8 7c a8
> [   53.546201] RSP: 0018:ffff88006c067768 EFLAGS: 00010282
> [   53.546208] RAX: 0000000000000000 RBX: ffff880068844200 RCX: ffffffffa83e1a33
> [   53.546211] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88006d51e590
> [   53.546215] RBP: 0000000000000005 R08: ffffed000daa3cb3 R09: ffffed000daa3cb3
> [   53.546218] R10: 0000000000000001 R11: ffffed000daa3cb2 R12: 00000000ffffffff
> [   53.546221] R13: ffff88006a1f8000 R14: 0000000000000200 R15: 0000000000000009
> [   53.546226] FS:  00007fb2f3646840(0000) GS:ffff88006d500000(0000) knlGS:0000000000000000
> [   53.546229] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   53.546234] CR2: 00007f0fd77f0008 CR3: 00000000687e6002 CR4: 00000000000206e0
> [   53.546237] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   53.546240] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   53.546242] Call Trace:
> [   53.546248]  f2fs_submit_page_bio+0x95/0x740
> [   53.546253]  read_node_page+0x161/0x1e0
> [   53.546271]  ? truncate_node+0x650/0x650
> [   53.546283]  ? add_to_page_cache_lru+0x12c/0x170
> [   53.546288]  ? pagecache_get_page+0x262/0x2d0
> [   53.546292]  __get_node_page+0x200/0x660
> [   53.546302]  f2fs_update_inode_page+0x4a/0x160
> [   53.546306]  f2fs_write_inode+0x86/0xb0
> [   53.546317]  __writeback_single_inode+0x49c/0x620
> [   53.546322]  writeback_single_inode+0xe4/0x1e0
> [   53.546326]  sync_inode_metadata+0x93/0xd0
> [   53.546330]  ? sync_inode+0x10/0x10
> [   53.546342]  ? do_raw_spin_unlock+0xed/0x100
> [   53.546347]  f2fs_sync_inode_meta+0xe0/0x130
> [   53.546351]  f2fs_fill_super+0x287d/0x2d10
> [   53.546367]  ? vsnprintf+0x742/0x7a0
> [   53.546372]  ? f2fs_commit_super+0x180/0x180
> [   53.546379]  ? up_write+0x20/0x40
> [   53.546385]  ? set_blocksize+0x5f/0x140
> [   53.546391]  ? f2fs_commit_super+0x180/0x180
> [   53.546402]  mount_bdev+0x181/0x200
> [   53.546406]  mount_fs+0x94/0x180
> [   53.546411]  vfs_kern_mount+0x6c/0x1e0
> [   53.546415]  do_mount+0xe5e/0x1510
> [   53.546420]  ? fs_reclaim_release+0x9/0x30
> [   53.546424]  ? copy_mount_string+0x20/0x20
> [   53.546428]  ? fs_reclaim_acquire+0xd/0x30
> [   53.546435]  ? __might_sleep+0x2c/0xc0
> [   53.546440]  ? ___might_sleep+0x53/0x170
> [   53.546453]  ? __might_fault+0x4c/0x60
> [   53.546468]  ? _copy_from_user+0x95/0xa0
> [   53.546474]  ? memdup_user+0x39/0x60
> [   53.546478]  ksys_mount+0x88/0xb0
> [   53.546482]  __x64_sys_mount+0x5d/0x70
> [   53.546495]  do_syscall_64+0x65/0x130
> [   53.546503]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   53.547639] ---[ end trace b804d1ea2fec893e ]---
> 
> So if recover fails, we need to drop all recovered data.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

