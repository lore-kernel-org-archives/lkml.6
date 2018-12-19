Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3DEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1353320989
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pk5rHhaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbeLSNXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:23:37 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40782 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbeLSNXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:23:36 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so9465865plq.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 05:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b2DFbvOdv2MJAs05SZzPfotgdcRg6VQ81iHyNmB6fq4=;
        b=pk5rHhaO98Ky2Mgblzh6OHTWBUeZFtPnMgwOtsqb/KM3TfIoXPbYbSyQSdMyPvjqtO
         8sgfOMdaS5XFKlhh9UoeqdpwVP38Qy4CzoJEWssR2lrtJnHM49HqEo2sodC3EBBBOqUn
         j2EvKBLEmYYjuPy/0w/swHeatbxjElfQ4UIe65YDJNSoyfpnzAn4S8XlAivjTTFNYT9l
         mNcNTlzmuX9ch28FzBg+mK8F85HHLR5sT/1yLWqCyvTMd4RDKswVoztbWlS/mEQr4IP1
         P/GqJUqrSCjpBiwaAc/xSNsITfImyuWd6gzFAul6Ps5HIeUE6z2b2UW/b2mqt7+U0ZCh
         J46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b2DFbvOdv2MJAs05SZzPfotgdcRg6VQ81iHyNmB6fq4=;
        b=ZoqhYIdnBAfSLmjFQtMw8IY4C+f31zIuE+iwkKIbq7xzYbEeMOtRH5rcs2X6FjGgAp
         foLDt7n0CC0qyAcc6l5Y4ccRHIxVdIWgXb+IwFAq6cdiLGRmR8N6MYiChtenM79w3b/z
         gh2H6TiQVDasxo8DoVJFUlEs/tRhaxSSDsnYauxe3Yktbe3Om3HA5taaetCWMyJheWKm
         b+TmgQ6/qVAcz/dlnYKaerMoMCKgU+Alo9Jr4jn0rbBPKmq+7X3PmTlVh2E8ZiTNdPZ5
         UzjQZg7d7l9kbR6dob7qf0b1Lf7Y/tNFQonO+tE37rk6gLco/OReTTNSIi4oXr0SxLcB
         iEMQ==
X-Gm-Message-State: AA+aEWaNWnWBEH48C+a31+uJrSsjCjaBpvkz7wn+ANkDnIiK9op0RfIv
        UBgR7j64o0/gdKzNcMlqzoM0/w==
X-Google-Smtp-Source: AFSGD/XUHo3xPiEokDnbsbvCqlYPfhJ11u87SE0qei9dS/yw+7p1Gg763OA0b+Se5c72vdH0PMx7wQ==
X-Received: by 2002:a17:902:8bc6:: with SMTP id r6mr20133835plo.67.1545225815695;
        Wed, 19 Dec 2018 05:23:35 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id h8sm19185066pgv.27.2018.12.19.05.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 05:23:34 -0800 (PST)
Subject: Re: KMSAN: kernel-infoleak in copy_page_to_iter (2)
To:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        bart.vanassche@wdc.com, matias.bjorling@wdc.com
Cc:     Andi Kleen <ak@linux.intel.com>, jack@suse.cz, jlayton@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        mawilcox@microsoft.com, mgorman@techsingularity.net,
        syzkaller-bugs@googlegroups.com
References: <00000000000016eb330575bd2fab@google.com>
 <CAG_fn=WwdgnCQ2fOw_LEXwv7Fdbmshxo57XJXNbfbawDndJZ_Q@mail.gmail.com>
 <CAG_fn=UjeL9BmAq+FDK01n4mH7ieQXpxkRRxAbDPd5UcC7eZPw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <06a3b403-7fe3-24fd-0ce2-9a604f3bbe62@kernel.dk>
Date:   Wed, 19 Dec 2018 06:23:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAG_fn=UjeL9BmAq+FDK01n4mH7ieQXpxkRRxAbDPd5UcC7eZPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 3:23 AM, Alexander Potapenko wrote:
> On Thu, Sep 13, 2018 at 11:23 AM Alexander Potapenko <glider@google.com> wrote:
>>
>> On Thu, Sep 13, 2018 at 11:18 AM syzbot
>> <syzbot+2dcfeaf8cb49b05e8f1a@syzkaller.appspotmail.com> wrote:
>>>
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    123906095e30 kmsan: introduce kmsan_interrupt_enter()/kmsa..
>>> git tree:       https://github.com/google/kmsan.git/master
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1249fcb8400000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=848e40757852af3e
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=2dcfeaf8cb49b05e8f1a
>>> compiler:       clang version 7.0.0 (trunk 334104)
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116ef050400000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122870ff800000
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+2dcfeaf8cb49b05e8f1a@syzkaller.appspotmail.com
>>>
>>> random: sshd: uninitialized urandom read (32 bytes read)
>>> ==================================================================
>>> BUG: KMSAN: kernel-infoleak in copyout lib/iov_iter.c:140 [inline]
>>> BUG: KMSAN: kernel-infoleak in copy_page_to_iter_iovec lib/iov_iter.c:212
>>> [inline]
>>> BUG: KMSAN: kernel-infoleak in copy_page_to_iter+0x754/0x1b70
>>> lib/iov_iter.c:716
>>> CPU: 0 PID: 4516 Comm: blkid Not tainted 4.17.0+ #9
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>>> Google 01/01/2011
>>> Call Trace:
>>>   __dump_stack lib/dump_stack.c:77 [inline]
>>>   dump_stack+0x185/0x1d0 lib/dump_stack.c:113
>>>   kmsan_report+0x188/0x2a0 mm/kmsan/kmsan.c:1125
>>>   kmsan_internal_check_memory+0x17e/0x1f0 mm/kmsan/kmsan.c:1238
>>>   kmsan_copy_to_user+0x7a/0x160 mm/kmsan/kmsan.c:1261
>>>   copyout lib/iov_iter.c:140 [inline]
>>>   copy_page_to_iter_iovec lib/iov_iter.c:212 [inline]
>>>   copy_page_to_iter+0x754/0x1b70 lib/iov_iter.c:716
>>>   generic_file_buffered_read mm/filemap.c:2185 [inline]
>>>   generic_file_read_iter+0x2ef8/0x44d0 mm/filemap.c:2362
>>>   blkdev_read_iter+0x20d/0x280 fs/block_dev.c:1930
>>>   call_read_iter include/linux/fs.h:1778 [inline]
>>>   new_sync_read fs/read_write.c:406 [inline]
>>>   __vfs_read+0x775/0x9d0 fs/read_write.c:418
>>>   vfs_read+0x36c/0x6b0 fs/read_write.c:452
>>>   ksys_read fs/read_write.c:578 [inline]
>>>   __do_sys_read fs/read_write.c:588 [inline]
>>>   __se_sys_read fs/read_write.c:586 [inline]
>>>   __x64_sys_read+0x1bf/0x3e0 fs/read_write.c:586
>>>   do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:287
>>>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> RIP: 0033:0x7fdeff68f310
>>> RSP: 002b:00007ffe999660b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>>> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fdeff68f310
>>> RDX: 0000000000000100 RSI: 0000000001e78df8 RDI: 0000000000000003
>>> RBP: 0000000001e78dd0 R08: 0000000000000028 R09: 0000000001680000
>>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000001e78030
>>> R13: 0000000000000100 R14: 0000000001e78080 R15: 0000000001e78de8
>>>
>>> Uninit was created at:
>>>   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:282 [inline]
>>>   kmsan_alloc_meta_for_pages+0x161/0x3a0 mm/kmsan/kmsan.c:819
>>>   kmsan_alloc_page+0x82/0xe0 mm/kmsan/kmsan.c:889
>>>   __alloc_pages_nodemask+0xf7b/0x5cc0 mm/page_alloc.c:4402
>>>   alloc_pages_current+0x6b1/0x970 mm/mempolicy.c:2093
>>>   alloc_pages include/linux/gfp.h:494 [inline]
>>>   __page_cache_alloc+0x95/0x320 mm/filemap.c:946
>>>   pagecache_get_page+0x52b/0x1450 mm/filemap.c:1577
>>>   grab_cache_page_write_begin+0x10d/0x190 mm/filemap.c:3089
>>>   block_write_begin+0xf9/0x3a0 fs/buffer.c:2068
>>>   blkdev_write_begin+0xf5/0x110 fs/block_dev.c:584
>>>   generic_perform_write+0x438/0x9d0 mm/filemap.c:3139
>>>   __generic_file_write_iter+0x43b/0xa10 mm/filemap.c:3264
>>>   blkdev_write_iter+0x3a8/0x5f0 fs/block_dev.c:1910
>>>   do_iter_readv_writev+0x81c/0xa20 include/linux/fs.h:1778
>>>   do_iter_write+0x30d/0xd50 fs/read_write.c:959
>>>   vfs_writev fs/read_write.c:1004 [inline]
>>>   do_writev+0x3be/0x820 fs/read_write.c:1039
>>>   __do_sys_writev fs/read_write.c:1112 [inline]
>>>   __se_sys_writev fs/read_write.c:1109 [inline]
>>>   __x64_sys_writev+0xe1/0x120 fs/read_write.c:1109
>>>   do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:287
>>>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>
>>> Bytes 4-255 of 256 are uninitialized
>>> Memory access starts at ffff8801b9903000
>>> ==================================================================
>> This particular report was caused by the repro program writing a byte
>> to /dev/nullb0 and /sbin/blkid reading from that device in the
>> background.
>> But it turns out that simply running `cat /dev/nullb0` already prints
>> uninitialized kernel memory.
>> Is this the intended behavior of the null block driver?
> A friendly ping, this bug is still reproducible on syzbot.

Does this fix it?


diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 62c9654b9ce8..08808c572692 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -655,7 +655,7 @@ static struct nullb_page *null_alloc_page(gfp_t gfp_flags)
 	if (!t_page)
 		goto out;
 
-	t_page->page = alloc_pages(gfp_flags, 0);
+	t_page->page = alloc_pages(gfp_flags | __GFP_ZERO, 0);
 	if (!t_page->page)
 		goto out_freepage;
 

-- 
Jens Axboe

