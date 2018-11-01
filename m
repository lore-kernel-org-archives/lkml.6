Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C40ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85402064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85402064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbeKAKNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 06:13:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59863 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbeKAKNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 06:13:47 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AD8A0FDDF38B2;
        Thu,  1 Nov 2018 09:12:57 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Thu, 1 Nov 2018
 09:12:56 +0800
Subject: Re: [BUG] Kernel BUG when mounting and then unmounting a fuzzed F2FS
 image
To:     Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <CAE5jQCfXKTdxPW2OKVyV9-49WqNmQT+mHsui3XXxDBJbkJ6=jA@mail.gmail.com>
 <d7fd18ae-ac93-2c1a-1f6a-21b3c5da8de7@huawei.com>
 <CAE5jQCdS5dfFBP7YxyJH-E6wM0pkJ=r4VXhepOuGJzcxBOL0EQ@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <10a2fd1d-4413-fca5-4c1a-cd2671b2bf42@huawei.com>
Date:   Thu, 1 Nov 2018 09:12:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAE5jQCdS5dfFBP7YxyJH-E6wM0pkJ=r4VXhepOuGJzcxBOL0EQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anatoly,

On 2018/10/31 19:06, Anatoly Trosinenko wrote:
> Hi Chao,
> 
> I have tested torvalds/master and it works OK with respect to this

Thanks for your test.

> test case. So please excuse me for disturbance.

It's okay, anyway, if there is any further problem, please let us know.

Thanks,

> 
> Best regards
> Anatoly
> 
> пн, 29 окт. 2018 г. в 14:14, Chao Yu <yuchao0@huawei.com>:
>>
>> Hi Anatoly,
>>
>> Could you please try pending v5.00rc1 or v4.20rc1, since in this round we
>> have fixed this issue with below commit:
>>
>> edc55aaf0d17 ("f2fs: avoid f2fs_bug_on if f2fs_get_meta_page_nofail got EIO")
>>
>> Thanks,
>>
>> On 2018/10/28 19:50, Anatoly Trosinenko wrote:
>>> Hello,
>>>
>>> When mounting and then unmounting a fuzzed F2FS image, a BUG is
>>> triggered at fs/f2fs/checkpoint.c:127.
>>>
>>> How to reproduce with kvm-xfstests:
>>> 1) Checkout v4.19, copy x86_64-config-4.14 to .config, perform `make
>>> olddefconfig`, then compile
>>> 2) Place the attached image (128M unpacked) to /tmp/kvm-xfstests-$USER
>>> 3) Inside the `kvm-xfstests shell` execute:
>>>
>>> root@kvm-xfstests:~# mount /vtmp
>>> root@kvm-xfstests:~# mount /vtmp/f2fs.img /mnt
>>> [   11.456857] F2FS-fs (loop0): Found nat_bits in checkpoint
>>> [   11.460360] F2FS-fs (loop0): Mounted with checkpoint version = 1c8a6001
>>> root@kvm-xfstests:~# umount /mnt
>>> [   14.592761] ------------[ cut here ]------------
>>> [   14.593218] kernel BUG at fs/f2fs/checkpoint.c:127!
>>> [   14.593739] invalid opcode: 0000 [#1] SMP PTI
>>> [   14.594129] CPU: 0 PID: 368 Comm: umount Not tainted 4.19.0-xfstests #1
>>> [   14.594710] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>>> BIOS 1.11.1-1ubuntu1 04/01/2014
>>> [   14.595497] RIP: 0010:f2fs_get_meta_page_nofail+0x41/0x50
>>> [   14.596030] Code: 00 00 4c 89 e6 48 89 ef e8 1c f3 ff ff 48 3d 00
>>> f0 ff ff 76 17 48 83 f8 fb 75 05 83 eb 01 75 dd 31 f6 48 89 ef e8 bf
>>> fe ff ff <0f> 0b 5b 5d 41 5c c3 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
>>> 31 d2
>>> [   14.597784] RSP: 0018:ffffb95ec095fad8 EFLAGS: 00010296
>>> [   14.598257] RAX: ffff9982b9d2d280 RBX: 0000000000000009 RCX: 0000000000000000
>>> [   14.598935] RDX: ffffffff00000001 RSI: 0000000000000007 RDI: 0000000000000246
>>> [   14.599608] RBP: ffff9982babe0000 R08: 00000004d0a24803 R09: 0000000000000001
>>> [   14.600286] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000001201aef
>>> [   14.600953] R13: ffff9982b9d14c00 R14: 00000000009008ef R15: 0000000000000001
>>> [   14.601625] FS:  0000000000000000(0000) GS:ffff9982bda00000(0063)
>>> knlGS:00000000f7bdab00
>>> [   14.602384] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
>>> [   14.602899] CR2: 0000000056c95460 CR3: 00000000785ea006 CR4: 0000000000360ef0
>>> [   14.603550] Call Trace:
>>> [   14.603779]  __flush_nat_entry_set+0x118/0x620
>>> [   14.604182]  f2fs_flush_nat_entries+0x239/0x290
>>> [   14.604585]  ? __submit_merged_write_cond+0xa7/0x200
>>> [   14.605026]  ? up_write+0x1c/0x80
>>> [   14.605324]  ? __submit_merged_write_cond+0xa7/0x200
>>> [   14.605764]  f2fs_write_checkpoint+0x45c/0x720
>>> [   14.606161]  f2fs_sync_fs+0xb9/0x1a0
>>> [   14.606482]  sync_filesystem+0x71/0x90
>>> [   14.606818]  generic_shutdown_super+0x22/0x100
>>> [   14.607214]  kill_block_super+0x21/0x50
>>> [   14.607558]  kill_f2fs_super+0x67/0xc0
>>> [   14.607893]  deactivate_locked_super+0x2f/0x70
>>> [   14.608292]  cleanup_mnt+0x3b/0x70
>>> [   14.608598]  task_work_run+0x9e/0xd0
>>> [   14.608919]  exit_to_usermode_loop+0xb7/0xc0
>>> [   14.609299]  do_fast_syscall_32+0x267/0x2f0
>>> [   14.609672]  entry_SYSENTER_compat+0x84/0x96
>>> [   14.610082] ---[ end trace d15a41554e67c0ec ]---
>>> [   14.610500] RIP: 0010:f2fs_get_meta_page_nofail+0x41/0x50
>>> [   14.610979] Code: 00 00 4c 89 e6 48 89 ef e8 1c f3 ff ff 48 3d 00
>>> f0 ff ff 76 17 48 83 f8 fb 75 05 83 eb 01 75 dd 31 f6 48 89 ef e8 bf
>>> fe ff ff <0f> 0b 5b 5d 41 5c c3 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
>>> 31 d2
>>> [   14.612632] RSP: 0018:ffffb95ec095fad8 EFLAGS: 00010296
>>> [   14.613096] RAX: ffff9982b9d2d280 RBX: 0000000000000009 RCX: 0000000000000000
>>> [   14.613720] RDX: ffffffff00000001 RSI: 0000000000000007 RDI: 0000000000000246
>>> [   14.614347] RBP: ffff9982babe0000 R08: 00000004d0a24803 R09: 0000000000000001
>>> [   14.614974] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000001201aef
>>> [   14.615610] R13: ffff9982b9d14c00 R14: 00000000009008ef R15: 0000000000000001
>>> [   14.616240] FS:  0000000000000000(0000) GS:ffff9982bda00000(0063)
>>> knlGS:00000000f7bdab00
>>> [   14.616949] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
>>> [   14.617457] CR2: 0000000056c95460 CR3: 00000000785ea006 CR4: 0000000000360ef0
>>> Segmentation fault
>>> root@kvm-xfstests:~#
>>>
>>> Best regards
>>> Anatoly
>>>
>>
> 
> .
> 

