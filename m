Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D67C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC7B2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC7B2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbeLLLLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:11:32 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:37681 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeLLLLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:11:06 -0500
Received: by mail-it1-f200.google.com with SMTP id y86so5502040ita.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 03:11:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XkPimnGdW2bMa327rOljYHPDTYYSd4OaAOKVMiZ48D8=;
        b=f+S8SRqq5ZM6c+yRbYh61xMFDA2AhpFBbrzC7vX3k7wF9MQKsLpyzfDJDa4nDm4SJw
         rSNDkNX+mofrfpZDZfUD0kKIAw3FYQuZAgoouRvFDzry/BssmRnCLO7gULiGtdzXIbda
         6Vn+viuND81k9FbKTcBteVuazCUPlKJHpmrXOlyvgG3/USomlpUYwm9SRGZdNVIVfdLG
         45Tx7UvX5tTCD5ZR7dlDUETL3B3iZBZQjChDYRrafWX5ITJ41sC3AmdIQuwLtbWc4Oz6
         ejsRiR6daT04CLqJyZOhlyWFDytTJYp8ytjHu5dkaeKsuTyugB8f6W4kcPtQDdKWPQOc
         aW1Q==
X-Gm-Message-State: AA+aEWYNuDpZp0MUG//VuXD/0YsmbWAb+qi1MqQf5kVJww097uujuBPY
        uInjsTNWk5zo8bgloKi3lYFXgrpXq0Dka4CO91N7kzP9oyiV
X-Google-Smtp-Source: AFSGD/X9XtHcqPws/dSts4fFBrOM2r+f8UZZtePvIg6Jwl1NByNF3ACxFv815+oePJ3m5PgNvWa0JtpN6G4U0vEsCLPFLQgKzOKx
MIME-Version: 1.0
X-Received: by 2002:a02:b807:: with SMTP id o7mr16238370jam.23.1544613064980;
 Wed, 12 Dec 2018 03:11:04 -0800 (PST)
Date:   Wed, 12 Dec 2018 03:11:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000dbf4a057cd1418b@google.com>
Subject: KASAN: use-after-free Read in tipc_group_cong
From:   syzbot <syzbot+9845fed98688e01f431e@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f5d582777bcb Merge branch 'for-linus' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1705d525400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
dashboard link: https://syzkaller.appspot.com/bug?extid=9845fed98688e01f431e
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101b6ba3400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9845fed98688e01f431e@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
audit: type=1400 audit(1544592509.246:38): avc:  denied  { associate } for   
pid=6204 comm="syz-executor5" name="syz5"  
scontext=unconfined_u:object_r:unlabeled_t:s0  
tcontext=system_u:object_r:unlabeled_t:s0 tclass=filesystem permissive=1
==================================================================
BUG: KASAN: use-after-free in tipc_group_find_dest net/tipc/group.c:255  
[inline]
BUG: KASAN: use-after-free in tipc_group_cong+0x566/0x5d0  
net/tipc/group.c:416
Read of size 8 at addr ffff8881c59f5000 by task syz-executor4/10565

CPU: 1 PID: 10565 Comm: syz-executor4 Not tainted 4.20.0-rc6+ #151
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  tipc_group_find_dest net/tipc/group.c:255 [inline]
  tipc_group_cong+0x566/0x5d0 net/tipc/group.c:416
  tipc_send_group_anycast+0x9bb/0xc80 net/tipc/socket.c:972
  __tipc_sendmsg+0x12b1/0x1d40 net/tipc/socket.c:1309
  tipc_sendmsg+0x50/0x70 net/tipc/socket.c:1272
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457679
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f813d748c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457679
RDX: 0000000000000000 RSI: 00000000200006c0 RDI: 0000000000000005
RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f813d7496d4
R13: 00000000004c44dd R14: 00000000004d74c8 R15: 00000000ffffffff

Allocated by task 10551:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:546 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  tipc_group_create+0x152/0xa70 net/tipc/group.c:171
  tipc_sk_join net/tipc/socket.c:2829 [inline]
  tipc_setsockopt+0x2d1/0xd70 net/tipc/socket.c:2944
  __sys_setsockopt+0x1ba/0x3c0 net/socket.c:1902
  __do_sys_setsockopt net/socket.c:1913 [inline]
  __se_sys_setsockopt net/socket.c:1910 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1910
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 10567:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  tipc_group_delete+0x2e4/0x3f0 net/tipc/group.c:227
  tipc_sk_leave+0x113/0x220 net/tipc/socket.c:2863
  tipc_setsockopt+0x97d/0xd70 net/tipc/socket.c:2947
  __sys_setsockopt+0x1ba/0x3c0 net/socket.c:1902
  __do_sys_setsockopt net/socket.c:1913 [inline]
  __se_sys_setsockopt net/socket.c:1910 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1910
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881c59f5000
  which belongs to the cache kmalloc-192 of size 192
The buggy address is located 0 bytes inside of
  192-byte region [ffff8881c59f5000, ffff8881c59f50c0)
The buggy address belongs to the page:
page:ffffea0007167d40 count:1 mapcount:0 mapping:ffff8881da800040 index:0x0
flags: 0x2fffc0000000200(slab)
raw: 02fffc0000000200 ffffea0007160488 ffffea00071aff08 ffff8881da800040
raw: 0000000000000000 ffff8881c59f5000 0000000100000010 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881c59f4f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881c59f4f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8881c59f5000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                    ^
  ffff8881c59f5080: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8881c59f5100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
