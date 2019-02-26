Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176F9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC869217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551167764;
	bh=oaSitftUCVxkF7EYoFrqpc5wRKouepSbT2shulJhD8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RN4hor/cZINq4BlKB43vKN+1ly0iNZplTE7T7qqbapNVBpxpRT/wd0SCpRp8Fu51a
	 fbC5ViFzgBs5BjsFMd+vktGlWG/4OsMj4dNwXpL9sQQHMzosuWKe85D7pBA3QWPqeH
	 Mu2OsMCzEPDymgLyJnIvRXCnJr4JElP0I0gNyWOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfBZH4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:56:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbfBZH4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:56:02 -0500
Received: from sol.localdomain (c-107-3-167-184.hsd1.ca.comcast.net [107.3.167.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 473912173C;
        Tue, 26 Feb 2019 07:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551167761;
        bh=oaSitftUCVxkF7EYoFrqpc5wRKouepSbT2shulJhD8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NeJSmi2Se+jNB/PYbmonl8SOzL+s5F7Fy/GdadPkV2wcNTu8/QDACypuoTK94yAXc
         D/rkXvZbEj/lgejbRD16YW9b/muHpOUY+JU1HLNY0EvKTNxFvrpfqsfZHVfwJILTHq
         dEWr8d/RbhtwHumhO+axZ0J3ciikTeoIQpcxjRIM=
Date:   Mon, 25 Feb 2019 23:55:59 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+c45f79b4e5e940da28a9@syzkaller.appspotmail.com>
Cc:     aviadye@mellanox.com, borisp@mellanox.com, davejwatson@fb.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in tls_tx_records
Message-ID: <20190226075559.GF676@sol.localdomain>
References: <000000000000dfb5720576ee2873@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000dfb5720576ee2873@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 06:09:03AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    1042caa79e93 net-ipv4: remove 2 always zero parameters fro..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13fff711400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6da69433212d7e87
> dashboard link: https://syzkaller.appspot.com/bug?extid=c45f79b4e5e940da28a9
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c45f79b4e5e940da28a9@syzkaller.appspotmail.com
> 
> EXT4-fs (sda1): resizing filesystem from 524032 to 6 blocks
> EXT4-fs warning (device sda1): ext4_resize_fs:1930: can't shrink FS - resize
> aborted
> EXT4-fs (sda1): resizing filesystem from 524032 to 6 blocks
> EXT4-fs warning (device sda1): ext4_resize_fs:1930: can't shrink FS - resize
> aborted
> ==================================================================
> BUG: KASAN: use-after-free in tls_tx_records+0x8b0/0x980
> net/tls/tls_sw.c:365
> Read of size 8 at addr ffff8801ce46e040 by task syz-executor3/28575
> 
> CPU: 0 PID: 28575 Comm: syz-executor3 Not tainted 4.19.0-rc5+ #235
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  tls_tx_records+0x8b0/0x980 net/tls/tls_sw.c:365
>  tls_sw_free_resources_tx+0x1ec/0xd20 net/tls/tls_sw.c:1552
>  tls_sk_proto_close+0x605/0x750 net/tls/tls_main.c:278
>  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:428
>  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:458
>  __sock_release+0xd7/0x250 net/socket.c:579
>  sock_close+0x19/0x20 net/socket.c:1141
>  __fput+0x385/0xa30 fs/file_table.c:278
>  ____fput+0x15/0x20 fs/file_table.c:309
>  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
>  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
>  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457579
> Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f2ccaa3bc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000457579
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2ccaa3c6d4
> R13: 00000000004ef912 R14: 00000000004cc460 R15: 00000000ffffffff
> 
> Allocated by task 28575:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
>  __do_kmalloc mm/slab.c:3718 [inline]
>  __kmalloc+0x14e/0x760 mm/slab.c:3727
>  kmalloc include/linux/slab.h:518 [inline]
>  kzalloc include/linux/slab.h:707 [inline]
>  get_rec+0x147/0x630 net/tls/tls_sw.c:653
>  tls_sw_sendmsg+0x47e/0x17a0 net/tls/tls_sw.c:727
>  inet_sendmsg+0x1a1/0x690 net/ipv4/af_inet.c:798
>  sock_sendmsg_nosec net/socket.c:621 [inline]
>  sock_sendmsg+0xd5/0x120 net/socket.c:631
>  __sys_sendto+0x3d7/0x670 net/socket.c:1788
>  __do_sys_sendto net/socket.c:1800 [inline]
>  __se_sys_sendto net/socket.c:1796 [inline]
>  __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1796
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Freed by task 23411:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kfree+0xcf/0x230 mm/slab.c:3813
>  tls_encrypt_done+0x221/0x610 net/tls/tls_sw.c:417
>  aead_request_complete include/crypto/internal/aead.h:75 [inline]
>  pcrypt_aead_serial+0x7b/0xb0 crypto/pcrypt.c:123
>  padata_serial_worker+0x4c6/0x760 kernel/padata.c:349
>  process_one_work+0xc90/0x1b90 kernel/workqueue.c:2153
>  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
>  kthread+0x35a/0x420 kernel/kthread.c:246
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
> 
> The buggy address belongs to the object at ffff8801ce46e040
>  which belongs to the cache kmalloc-2048 of size 2048
> The buggy address is located 0 bytes inside of
>  2048-byte region [ffff8801ce46e040, ffff8801ce46e840)
> The buggy address belongs to the page:
> page:ffffea0007391b80 count:1 mapcount:0 mapping:ffff8801da800c40 index:0x0
> compound_mapcount: 0
> flags: 0x2fffc0000008100(slab|head)
> raw: 02fffc0000008100 ffffea00071b4f88 ffffea0007344f88 ffff8801da800c40
> raw: 0000000000000000 ffff8801ce46e040 0000000100000003 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801ce46df00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8801ce46df80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > ffff8801ce46e000: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
>                                            ^
>  ffff8801ce46e080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801ce46e100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> 

(As with the other reports of this...)

AFAICS this was fixed by this commit:

	commit d829e9c4112b52f4f00195900fd4c685f61365ab
	Author: Daniel Borkmann <daniel@iogearbox.net>
	Date:   Sat Oct 13 02:45:59 2018 +0200

	    tls: convert to generic sk_msg interface

So telling syzbot:

#syz fix: tls: convert to generic sk_msg interface

The issue was that described in this comment in tls_sw_sendmsg():

                /* Open records defined only if successfully copied, otherwise
                 * we would trim the sg but not reset the open record frags.
                 */
                tls_ctx->pending_open_record_frags = true;

Basically, on sendmsg() to a TLS socket, if the message buffer was partially
unmapped, a TLS record would be marked as pending (and then tried to be sent at
sock_release() time) even though it had actually been discarded.

- Eric
