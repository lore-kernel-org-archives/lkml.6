Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DE8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3295A206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732778AbfAKPxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:53:05 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:40302 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730850AbfAKPxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:53:04 -0500
Received: by mail-io1-f70.google.com with SMTP id u2so13170016iob.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 07:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=AcpVsEDylGy1S+ymg+s9qdHcQmlJiVSuBhqYwP7eklo=;
        b=hwf0VHk26ENY9VenFbLt7sUf/vNiPWAsaYjmOaEMkc+vrYajSPifR1DwKdUgme2Rsr
         J9lPxaCqZe8SFETESGRj8E7zOQ3+RRPsaO4Co4HEP5cB9fzD6DUoeY3SPPfu4KeW4OGX
         2WOjnat/MfEGZV9jcSaTYPnM1G6aaJfA/rLcPcvvGuaZZcFrHiwZLYiks0btx41WwJGw
         OZdBDVlWc/uJI2Yap6MuZcwSZMbmAUjmJzPtxWxoRhtH9eHRazbEHfhqa6Jxz8fDk7oX
         Cc278+7MEoOYbEDi0Ass8oBfSPsbxsN+z7DN+F4zfUc82qGNa855Es/N1SQpGE4khgre
         m61Q==
X-Gm-Message-State: AJcUukc+Hd259ruHa9iCss9m9+U5kZ6QKEyGsISG1pFv+cdURv85i+6x
        LKdylD/zntQrgrZx0nnarMlkn0Bveiv2MDh/LyYNXtkkqm02
X-Google-Smtp-Source: ALg8bN741FKwebGDVz43oBOqx5wYTIqfDzpdSmPLOCpItsP47Jbe7Ck2gSv/4SNblyi7DgtE5VhrUeyifSXaThWK/5Mlad9c0TxO
MIME-Version: 1.0
X-Received: by 2002:a24:15:: with SMTP id 21mr456574ita.27.1547221983457; Fri,
 11 Jan 2019 07:53:03 -0800 (PST)
Date:   Fri, 11 Jan 2019 07:53:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6788f057f30b0ac@google.com>
Subject: KASAN: use-after-free Read in seccomp_notify_release
From:   syzbot <syzbot+981c26489b2d1c6316ba@syzkaller.appspotmail.com>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        luto@amacapital.net, syzkaller-bugs@googlegroups.com,
        wad@chromium.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1bdbe2274920 Merge tag 'vfio-v5.0-rc2' of git://github.com..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=177ce96f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=edf1c3031097c304
dashboard link: https://syzkaller.appspot.com/bug?extid=981c26489b2d1c6316ba
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134c5b9f400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1263027b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+981c26489b2d1c6316ba@syzkaller.appspotmail.com

audit: type=1326 audit(1547207941.906:33): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj=_ pid=7929 comm="syz-executor201"  
exe="/root/syz-executor201062921" sig=31 arch=c000003e syscall=202 compat=0  
ip=0x446349 code=0x0
==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3556/0x4a30  
kernel/locking/lockdep.c:3215
Read of size 8 at addr ffff888098dd1280 by task syz-executor201/7925

CPU: 1 PID: 7925 Comm: syz-executor201 Not tainted 5.0.0-rc1+ #19
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
  __lock_acquire+0x3556/0x4a30 kernel/locking/lockdep.c:3215
  lock_acquire+0x1db/0x570 kernel/locking/lockdep.c:3841
  __mutex_lock_common kernel/locking/mutex.c:925 [inline]
  __mutex_lock+0x12f/0x1670 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  seccomp_notify_release+0x54/0x270 kernel/seccomp.c:979
  __fput+0x3c5/0xb10 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x1f4/0x2b0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x32a/0x3b0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x696/0x800 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x405451
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 94 17 00 00 c3 48  
83 ec 08 e8 6a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 b3 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffe221b1d60 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000405451
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 0000000000000003
RBP: 00000000000003e8 R08: 00000000000003e8 R09: 0000000000000000
R10: 00007ffe221b1d70 R11: 0000000000000293 R12: 00000000006dac3c
R13: 0000000000000002 R14: 000000000000002d R15: 00000000006dac30

Allocated by task 7934:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_kmalloc mm/kasan/common.c:496 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:469
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:504
  kmem_cache_alloc_trace+0x151/0x760 mm/slab.c:3609
  kmalloc include/linux/slab.h:545 [inline]
  kzalloc include/linux/slab.h:740 [inline]
  seccomp_prepare_filter kernel/seccomp.c:451 [inline]
  seccomp_prepare_user_filter kernel/seccomp.c:491 [inline]
  seccomp_set_mode_filter kernel/seccomp.c:1257 [inline]
  do_seccomp+0x941/0x2cc0 kernel/seccomp.c:1370
  __do_sys_seccomp kernel/seccomp.c:1389 [inline]
  __se_sys_seccomp kernel/seccomp.c:1386 [inline]
  __x64_sys_seccomp+0x73/0xb0 kernel/seccomp.c:1386
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 7934:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:458
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:466
  __cache_free mm/slab.c:3487 [inline]
  kfree+0xcf/0x230 mm/slab.c:3806
  seccomp_filter_free kernel/seccomp.c:565 [inline]
  seccomp_filter_free kernel/seccomp.c:561 [inline]
  seccomp_set_mode_filter kernel/seccomp.c:1311 [inline]
  do_seccomp+0xda3/0x2cc0 kernel/seccomp.c:1370
  __do_sys_seccomp kernel/seccomp.c:1389 [inline]
  __se_sys_seccomp kernel/seccomp.c:1386 [inline]
  __x64_sys_seccomp+0x73/0xb0 kernel/seccomp.c:1386
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff888098dd1200
  which belongs to the cache kmalloc-192 of size 192
The buggy address is located 128 bytes inside of
  192-byte region [ffff888098dd1200, ffff888098dd12c0)
The buggy address belongs to the page:
page:ffffea0002637440 count:1 mapcount:0 mapping:ffff88812c3f0040  
index:0xffff888098dd1e00
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea0002810748 ffffea0002614808 ffff88812c3f0040
raw: ffff888098dd1e00 ffff888098dd1000 000000010000000f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888098dd1180: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff888098dd1200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff888098dd1280: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                    ^
  ffff888098dd1300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888098dd1380: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
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
