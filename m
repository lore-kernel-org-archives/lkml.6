Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8B3E6C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EFA208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EFA208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935340AbeFMLcD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:32:03 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:44546 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935238AbeFMLcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:32:02 -0400
Received: by mail-it0-f72.google.com with SMTP id 202-v6so2213408itw.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 04:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=IBoRI2FJjw3oq/Hyhl0lPWkNY6ZindWm8wnTcmibsqw=;
        b=NxnR4zaojsn9fWvnFpZQDD7R3V9ztAUCmhQlgJUopFK+0BdgaEA80wKOJcd22sE9n0
         CM8OXfQwCPYUsSlp1LJp/zUyf9MUgdj+mZ34cl8TQWSBmxZaVjGrcvuTT9ALMzy8O6xd
         DXizYdpXvcKo1HOWRFsKU5nCr9fKpaD/kLTnhbaUtRgNAQPcZEr2+6X4n+aMhgnc8/lQ
         fy5YBi6kxog/SkBqWS6YHXZv6fBVWrbnZNCPNv++P+5CSRd90YdjOXP6JdnPgnge0spI
         ZLlkk18sbnMJUaCxGV6vC6GuKPU5ECE1fo0XjNkuUn1sVN0Dx8/06ykp6RreiZE6zPxB
         AH6Q==
X-Gm-Message-State: APt69E0KX6pH6htnk1jhNdXDkAA0z5wZBoIVbWxH3P9Wb0k1EwsR1SWC
        Ju6inJfF7xKPTkOq9CPzNig0crKG6zAYgnH71jNidMneIDxJ
X-Google-Smtp-Source: ADUXVKK3Y0W4OaN1hOg8RgCOygdos7KD+PGlAVQdPQZAZuQs698R/AqyJ98cm4muPTD2FKaaXrGgMQiUbqdxWaw+5tKNLItO+P8w
MIME-Version: 1.0
X-Received: by 2002:a6b:b242:: with SMTP id b63-v6mr1920623iof.47.1528889521747;
 Wed, 13 Jun 2018 04:32:01 -0700 (PDT)
Date:   Wed, 13 Jun 2018 04:32:01 -0700
In-Reply-To: <0000000000005abb37056e840d40@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d85140056e845443@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in crypto_morus640_decrypt_chunk
From:   syzbot <syzbot+1fafa9c4cf42df33f716@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    f0dc7f9c6dd9 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16685c1f800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9c20c48788d1c1
dashboard link: https://syzkaller.appspot.com/bug?extid=1fafa9c4cf42df33f716
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1122e4cf800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1794783f800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1fafa9c4cf42df33f716@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KASAN: slab-out-of-bounds in crypto_morus640_load_a  
crypto/morus640.c:111 [inline]
BUG: KASAN: slab-out-of-bounds in crypto_morus640_decrypt_chunk+0xcf8/0xd20  
crypto/morus640.c:278
Read of size 4 at addr ffff8801d76dc848 by task syz-executor575/4437

CPU: 1 PID: 4437 Comm: syz-executor575 Not tainted 4.17.0+ #84
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  crypto_morus640_load_a crypto/morus640.c:111 [inline]
  crypto_morus640_decrypt_chunk+0xcf8/0xd20 crypto/morus640.c:278
  crypto_morus640_process_crypt.isra.12+0x153/0x230 crypto/morus640.c:376
  crypto_morus640_crypt+0x42e/0x9f0 crypto/morus640.c:442
  crypto_morus640_decrypt+0x23e/0x3d0 crypto/morus640.c:485
  crypto_aead_decrypt include/crypto/aead.h:370 [inline]
  _aead_recvmsg crypto/algif_aead.c:315 [inline]
  aead_recvmsg+0x13cc/0x1ba0 crypto/algif_aead.c:334
  sock_recvmsg_nosec net/socket.c:818 [inline]
  sock_recvmsg+0xd0/0x110 net/socket.c:825
  ___sys_recvmsg+0x2b6/0x680 net/socket.c:2323
  __sys_recvmsg+0x112/0x260 net/socket.c:2372
  __do_sys_recvmsg net/socket.c:2382 [inline]
  __se_sys_recvmsg net/socket.c:2379 [inline]
  __x64_sys_recvmsg+0x78/0xb0 net/socket.c:2379
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43fef9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 6b 45 00 00 c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd6c88d3b8 EFLAGS: 00000207 ORIG_RAX: 000000000000002f
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fef9
RDX: 0000000000000000 RSI: 0000000020002840 RDI: 0000000000000004
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000207 R12: 0000000000401820
R13: 00000000004018b0 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 4437:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc mm/slab.c:3718 [inline]
  __kmalloc+0x14e/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:518 [inline]
  kzalloc include/linux/slab.h:706 [inline]
  skcipher_next_slow crypto/skcipher.c:253 [inline]
  skcipher_walk_next+0x750/0x1850 crypto/skcipher.c:357
  skcipher_walk_first+0x151/0x410 crypto/skcipher.c:442
  skcipher_walk_aead_common+0x7f8/0xbc0 crypto/skcipher.c:539
  skcipher_walk_aead_decrypt+0xc7/0x100 crypto/skcipher.c:572
  crypto_morus640_process_crypt.isra.12+0x9c/0x230 crypto/morus640.c:370
  crypto_morus640_crypt+0x42e/0x9f0 crypto/morus640.c:442
  crypto_morus640_decrypt+0x23e/0x3d0 crypto/morus640.c:485
  crypto_aead_decrypt include/crypto/aead.h:370 [inline]
  _aead_recvmsg crypto/algif_aead.c:315 [inline]
  aead_recvmsg+0x13cc/0x1ba0 crypto/algif_aead.c:334
  sock_recvmsg_nosec net/socket.c:818 [inline]
  sock_recvmsg+0xd0/0x110 net/socket.c:825
  ___sys_recvmsg+0x2b6/0x680 net/socket.c:2323
  __sys_recvmsg+0x112/0x260 net/socket.c:2372
  __do_sys_recvmsg net/socket.c:2382 [inline]
  __se_sys_recvmsg net/socket.c:2379 [inline]
  __x64_sys_recvmsg+0x78/0xb0 net/socket.c:2379
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 2800:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  single_release+0x8f/0xb0 fs/seq_file.c:609
  __fput+0x353/0x890 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1e4/0x290 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:192 [inline]
  exit_to_usermode_loop+0x302/0x360 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6ac/0x800 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801d76dc840
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 8 bytes inside of
  32-byte region [ffff8801d76dc840, ffff8801d76dc860)
The buggy address belongs to the page:
page:ffffea00075db700 count:1 mapcount:0 mapping:ffff8801da8001c0  
index:0xffff8801d76dcfc1
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801da801238 ffffea00075dcdc8 ffff8801da8001c0
raw: ffff8801d76dcfc1 ffff8801d76dc000 000000010000003b 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d76dc700: fb fb fb fb fc fc fc fc 00 00 fc fc fc fc fc fc
  ffff8801d76dc780: fb fb fb fb fc fc fc fc 00 00 fc fc fc fc fc fc
> ffff8801d76dc800: 00 00 00 00 fc fc fc fc 00 fc fc fc fc fc fc fc
                                               ^
  ffff8801d76dc880: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8801d76dc900: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
==================================================================

