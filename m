Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA09FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9326420657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfANNIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:08:30 -0500
Received: from mail.aixigo.de ([5.145.142.10]:37567 "EHLO mail.aixigo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfANNIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:08:30 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jan 2019 08:08:29 EST
Received: from srvvm01.ac.aixigo.de (mail.ac.aixigo.de [172.19.96.11])
        by gate5a.ac.aixigo.de (OpenSMTPD) with ESMTPS id 6b857c23 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 14 Jan 2019 14:01:48 +0100 (CET)
Received: from dpcl082.ac.aixigo.de (dpcl082.ac.aixigo.de [172.19.97.128])
        by srvvm01.ac.aixigo.de (8.15.2/8.15.2/Debian-8) with ESMTP id x0ED1lLe3113704;
        Mon, 14 Jan 2019 14:01:47 +0100
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Harald Dunkel <harald.dunkel@aixigo.de>
Subject: 4.20.1: BUG: unable to handle kernel paging request at
 0000100000000008
Message-ID: <fd58236d-a939-ec7b-b666-706f6853c49d@aixigo.de>
Date:   Mon, 14 Jan 2019 14:01:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.2 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

my server stumbled over this last night:

Jan 13 19:03:15 sylvester kernel: [272280.820190] BUG: unable to handle kernel paging request at 0000100000000008
Jan 13 19:03:15 sylvester kernel: [272280.820198] PGD 0 P4D 0
Jan 13 19:03:15 sylvester kernel: [272280.820203] Oops: 0000 [#1] PREEMPT SMP PTI
Jan 13 19:03:15 sylvester kernel: [272280.820207] CPU: 3 PID: 46 Comm: kswapd0 Not tainted 4.20.1-raw #1
Jan 13 19:03:15 sylvester kernel: [272280.820211] Hardware name:  /DH67CF, BIOS BLH6710H.86A.0125.2011.0705.1517 07/05/2011
Jan 13 19:03:15 sylvester kernel: [272280.820219] RIP: 0010:find_get_entries+0xed/0x240
Jan 13 19:03:15 sylvester kernel: [272280.820223] Code: 4e 4e 00 48 89 c2 48 85 d2 0f 84 91 00 00 00 48 81 fa 02 04 00 00 0f 84 a3 00 00 00 48 81 fa 06 04 00 00 74 ca f6
Jan 13 19:03:15 sylvester kernel: [272280.820230] RSP: 0018:ffffc90000fdb9c8 EFLAGS: 00010246
Jan 13 19:03:15 sylvester kernel: [272280.820234] RAX: 0000100000000000 RBX: 000000000000000f RCX: 0000000000000000
Jan 13 19:03:15 sylvester kernel: [272280.820238] RDX: 0000100000000000 RSI: 0000000000000680 RDI: ffffffffffffffc0
Jan 13 19:03:15 sylvester kernel: [272280.820242] RBP: 0000000000000002 R08: ffff8880a98b7d80 R09: 0000000000000000
Jan 13 19:03:15 sylvester kernel: [272280.820246] R10: 000000000000004b R11: ffffc90000fdb9c8 R12: ffffffffffffffff
Jan 13 19:03:15 sylvester kernel: [272280.820250] R13: ffffc90000fdbae0 R14: ffffc90000fdba60 R15: 0000000000000000
Jan 13 19:03:15 sylvester kernel: [272280.820255] FS:  0000000000000000(0000) GS:ffff888217980000(0000) knlGS:0000000000000000
Jan 13 19:03:15 sylvester kernel: [272280.820259] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jan 13 19:03:15 sylvester kernel: [272280.820263] CR2: 0000100000000008 CR3: 000000000200a003 CR4: 00000000000606e0
Jan 13 19:03:15 sylvester kernel: [272280.820268] Call Trace:
Jan 13 19:03:15 sylvester kernel: [272280.820276]  pagevec_lookup_entries+0x15/0x20
Jan 13 19:03:15 sylvester kernel: [272280.820280]  truncate_inode_pages_range+0xc5/0x810
Jan 13 19:03:15 sylvester kernel: [272280.820289]  ? ___cache_free+0x2c/0x2f0
Jan 13 19:03:15 sylvester kernel: [272280.820296]  ? jbd2_journal_release_jbd_inode+0x105/0x130 [jbd2]
Jan 13 19:03:15 sylvester kernel: [272280.820301]  ? iput+0x1e9/0x210
Jan 13 19:03:15 sylvester kernel: [272280.820305]  ? __inode_wait_for_writeback+0x7a/0xe0
Jan 13 19:03:15 sylvester kernel: [272280.820319]  ext4_evict_inode+0x52/0x5d0 [ext4]
Jan 13 19:03:15 sylvester kernel: [272280.820325]  evict+0xbf/0x190
Jan 13 19:03:15 sylvester kernel: [272280.820328]  dispose_list+0x30/0x40
Jan 13 19:03:15 sylvester kernel: [272280.820332]  prune_icache_sb+0x4d/0x70
Jan 13 19:03:15 sylvester kernel: [272280.820337]  super_cache_scan+0x121/0x1a0
Jan 13 19:03:15 sylvester kernel: [272280.820342]  do_shrink_slab+0x136/0x2d0
Jan 13 19:03:15 sylvester kernel: [272280.820346]  shrink_slab+0x22a/0x290
Jan 13 19:03:15 sylvester kernel: [272280.820351]  ? __mod_node_page_state+0x64/0xa0
Jan 13 19:03:15 sylvester kernel: [272280.820354]  shrink_node+0xe1/0x450
Jan 13 19:03:15 sylvester kernel: [272280.820358]  kswapd+0x3f9/0x740
Jan 13 19:03:15 sylvester kernel: [272280.820362]  ? mem_cgroup_shrink_node+0x1b0/0x1b0
Jan 13 19:03:15 sylvester kernel: [272280.820367]  kthread+0x111/0x130
Jan 13 19:03:15 sylvester kernel: [272280.820371]  ? kthread_create_worker_on_cpu+0x60/0x60
Jan 13 19:03:15 sylvester kernel: [272280.820376]  ret_from_fork+0x35/0x40
Jan 13 19:03:15 sylvester kernel: [272280.820380] Modules linked in: cpuid fuse btrfs xor zstd_compress raid6_pq zstd_decompress xxhash ufs hfsplus ntfs vfat msdos fat j
Jan 13 19:03:15 sylvester kernel: [272280.820423]  scsi_mod mfd_core usbcore e1000e
Jan 13 19:03:15 sylvester kernel: [272280.820452] CR2: 0000100000000008
Jan 13 19:03:15 sylvester kernel: [272280.820456] ---[ end trace b383b200f5d976a9 ]---
Jan 13 19:03:15 sylvester kernel: [272280.820461] RIP: 0010:find_get_entries+0xed/0x240
Jan 13 19:03:15 sylvester kernel: [272280.820465] Code: 4e 4e 00 48 89 c2 48 85 d2 0f 84 91 00 00 00 48 81 fa 02 04 00 00 0f 84 a3 00 00 00 48 81 fa 06 04 00 00 74 ca f6
Jan 13 19:03:15 sylvester kernel: [272280.820472] RSP: 0018:ffffc90000fdb9c8 EFLAGS: 00010246


I have opened https://bugzilla.kernel.org/show_bug.cgi?id=202257, providing
kernel.log and config file.

Is there anything else I could do to help tracking down this problem?


Regards
Harri
