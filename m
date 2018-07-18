Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4B4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EED62075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EED62075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbeGRLFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:05:52 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58882 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeGRLFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:05:51 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6IASZrM041412;
        Wed, 18 Jul 2018 19:28:36 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Wed, 18 Jul 2018 19:28:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6IASUqt041402
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 18 Jul 2018 19:28:35 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: INFO: task hung in generic_file_write_iter
To:     syzbot <syzbot+9933e4476f365f5d5a1b@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, Michal Hocko <mhocko@kernel.org>
References: <0000000000009ce88d05714242a8@google.com>
Cc:     ak@linux.intel.com, jack@suse.cz, jlayton@redhat.com,
        linux-kernel@vger.kernel.org, mawilcox@microsoft.com,
        syzkaller-bugs@googlegroups.com, tim.c.chen@linux.intel.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <4b349bff-8ad4-6410-250d-593b13d8d496@I-love.SAKURA.ne.jp>
Date:   Wed, 18 Jul 2018 19:28:26 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0000000000009ce88d05714242a8@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/18 17:58, syzbot wrote:
> mmap: syz-executor7 (10902) uses deprecated remap_file_pages() syscall. See Documentation/vm/remap_file_pages.rst.

There are many reports which are stalling inside __getblk_gfp().
And there is horrible comment for __getblk_gfp():

  /*
   * __getblk_gfp() will locate (and, if necessary, create) the buffer_head
   * which corresponds to the passed block_device, block and size. The
   * returned buffer has its reference count incremented.
   *
   * __getblk_gfp() will lock up the machine if grow_dev_page's
   * try_to_free_buffers() attempt is failing.  FIXME, perhaps?
   */

This report is stalling after mount() completed and process used remap_file_pages().
I think that we might need to use debug printk(). But I don't know what to examine.

> CPU: 1 PID: 10863 Comm: syz-executor0 Not tainted 4.18.0-rc5+ #151
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:__sanitizer_cov_trace_pc+0x3f/0x50 kernel/kcov.c:106
> Code: e2 00 01 1f 00 48 8b 75 08 75 2b 8b 90 90 12 00 00 83 fa 02 75 20 48 8b 88 98 12 00 00 8b 80 94 12 00 00 48 8b 11 48 83 c2 01 <48> 39 d0 76 07 48 89 34 d1 48 89 11 5d c3 0f 1f 00 55 40 0f b6 d6
> RSP: 0018:ffff8801913be760 EFLAGS: 00000216
> RAX: 0000000000040000 RBX: ffff88018e06b348 RCX: ffffc90001e34000
> RDX: 0000000000040000 RSI: ffffffff81d44df2 RDI: 0000000000000007
> RBP: ffff8801913be760 R08: ffff8801b465c540 R09: ffffed003b5e46d6
> R10: 0000000000000003 R11: 0000000000000006 R12: dffffc0000000000
> R13: 0000000000000042 R14: 0000000000000001 R15: 0000000000000020
> FS:  00007f53ece9c700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000119f218 CR3: 00000001ba743000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  init_page_buffers+0x3e2/0x530 fs/buffer.c:904
>  grow_dev_page fs/buffer.c:947 [inline]
>  grow_buffers fs/buffer.c:1009 [inline]
>  __getblk_slow fs/buffer.c:1036 [inline]
>  __getblk_gfp+0x906/0xb10 fs/buffer.c:1313
>  __bread_gfp+0x2d/0x310 fs/buffer.c:1347
>  sb_bread include/linux/buffer_head.h:307 [inline]
>  fat12_ent_bread+0x14e/0x3d0 fs/fat/fatent.c:75
>  fat_ent_read_block fs/fat/fatent.c:441 [inline]
>  fat_alloc_clusters+0x8ce/0x16e0 fs/fat/fatent.c:489
>  fat_add_cluster+0x7a/0x150 fs/fat/inode.c:101
>  __fat_get_block fs/fat/inode.c:148 [inline]
>  fat_get_block+0x375/0xaf0 fs/fat/inode.c:183
>  __block_write_begin_int+0x50d/0x1b00 fs/buffer.c:1958
>  __block_write_begin fs/buffer.c:2008 [inline]
>  block_write_begin+0xda/0x370 fs/buffer.c:2067
>  cont_write_begin+0x569/0x860 fs/buffer.c:2417
>  fat_write_begin+0x8d/0x120 fs/fat/inode.c:229
>  generic_perform_write+0x3ae/0x6c0 mm/filemap.c:3139
>  __generic_file_write_iter+0x26e/0x630 mm/filemap.c:3264
>  generic_file_write_iter+0x438/0x870 mm/filemap.c:3292
>  call_write_iter include/linux/fs.h:1793 [inline]
>  new_sync_write fs/read_write.c:474 [inline]
>  __vfs_write+0x6c6/0x9f0 fs/read_write.c:487
>  __kernel_write+0x10c/0x380 fs/read_write.c:506
>  do_acct_process+0x1148/0x1660 kernel/acct.c:520
>  acct_pin_kill+0x2e/0x100 kernel/acct.c:174
>  pin_kill+0x29f/0xb60 fs/fs_pin.c:50
>  acct_on+0x63b/0x8b0 kernel/acct.c:254
>  __do_sys_acct kernel/acct.c:286 [inline]
>  __se_sys_acct kernel/acct.c:273 [inline]
>  __x64_sys_acct+0xc2/0x1f0 kernel/acct.c:273
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe

