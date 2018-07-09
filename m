Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A24C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB82208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB82208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754479AbeGIF6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 01:58:05 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:55933 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbeGIF6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 01:58:03 -0400
Received: by mail-it0-f72.google.com with SMTP id k13-v6so13238285ite.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 22:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LWbKoylBybQIN0Rr49FQXlti6kaqhi33si41gmAnQgQ=;
        b=fxorQ7+O6LksZ/AUSescN9AU1HP3m3xeV0NXjX6e19/k+DAzaGCDLdJJ3k48O0Fto9
         Gf4kWnIY8EWLNuGfGiVKiPhRbpzCA6anlLVGP1NE7nTQEzIlasdQ4QeEjRQgIms/1GVD
         nzTZP5Cf7JNOgOoObAr7+pgU6JCPMKpsRKQ3ATh70MiWA4ItGe6HCpUWE1J0cZGXSfom
         vkLsQO2WraZq587sis8onkkMWnW0z0VHoXWaPog4EVZVRooIgVCqZ/O8N/OHTZxDbOxK
         zwvUIi0xvTkVCudSjQb2WBHsD8+eGChYF3Qj9qlyQrFGYlB0B37/H8t8IMRX+u2ZtxX8
         ARyQ==
X-Gm-Message-State: APt69E3HyzsWEfUeKEHcMUqWdwIQ/4U165/qMxGaXJEFvovpXuCvFzcc
        A0as8Qxxd4AdwhUnMHRXaF2tmaAU+fSRzNdJGCvALyxuulCG
X-Google-Smtp-Source: AAOMgpfgFARuWVyTXqb4bVD4So2kYkls3Z6lru/FR81/jtXYqyiDZKJ0Te2utcPkX6YjE9jeIjFbrLSVs537t7IKndrkL5+qVr5U
MIME-Version: 1.0
X-Received: by 2002:a02:2341:: with SMTP id u62-v6mr8819685jau.34.1531115882578;
 Sun, 08 Jul 2018 22:58:02 -0700 (PDT)
Date:   Sun, 08 Jul 2018 22:58:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a927105708ab2d9@google.com>
Subject: KMSAN: uninit-value in unix_find_other
From:   syzbot <syzbot+75d51fe5bf4ebe988518@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dh.herrmann@gmail.com, dvlasenk@redhat.com,
        ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org,
        matthew@mjdsystems.ca, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tklauser@distanz.ch,
        viro@zeniv.linux.org.uk, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a00de5aa4da3 kmsan: delete some dead code
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=165aa6d0400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3fd30f86ca205e8
dashboard link: https://syzkaller.appspot.com/bug?extid=75d51fe5bf4ebe988518
compiler:       clang version 7.0.0 (trunk 334104)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=128012c2400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1221462c400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+75d51fe5bf4ebe988518@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KMSAN: uninit-value in __unix_find_socket_byname  
net/unix/af_unix.c:280 [inline]
BUG: KMSAN: uninit-value in unix_find_socket_byname net/unix/af_unix.c:303  
[inline]
BUG: KMSAN: uninit-value in unix_find_other+0x315/0xc60  
net/unix/af_unix.c:932
CPU: 1 PID: 4574 Comm: syz-executor354 Not tainted 4.17.0+ #22
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:113
  kmsan_report+0x188/0x2a0 mm/kmsan/kmsan.c:990
  __msan_warning_32+0x70/0xc0 mm/kmsan/kmsan_instr.c:640
  __unix_find_socket_byname net/unix/af_unix.c:280 [inline]
  unix_find_socket_byname net/unix/af_unix.c:303 [inline]
  unix_find_other+0x315/0xc60 net/unix/af_unix.c:932
  unix_stream_connect+0x84e/0x26b0 net/unix/af_unix.c:1241
  p9_fd_create_unix+0x36b/0x5f0 net/9p/trans_fd.c:1019
  p9_client_create+0x1333/0x20e0 net/9p/client.c:1065
  v9fs_session_init+0x313/0x2830 fs/9p/v9fs.c:405
  v9fs_mount+0x107/0x11b0 fs/9p/vfs_super.c:135
  mount_fs+0x29b/0x780 fs/super.c:1277
  vfs_kern_mount+0x222/0x990 fs/namespace.c:1037
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0xca5/0x4ed0 fs/namespace.c:2848
  ksys_mount+0x32e/0x3d0 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0x157/0x1c0 fs/namespace.c:3075
  do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x4400d9
RSP: 002b:00007fff30dec578 EFLAGS: 00000217 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00000000004400d9
RDX: 00000000200000c0 RSI: 0000000020000040 RDI: 0000000020000000
RBP: 00000000006ca018 R08: 0000000020000100 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000217 R12: 0000000000401960
R13: 00000000004019f0 R14: 0000000000000000 R15: 0000000000000000

Local variable description: ----sun_server@p9_fd_create_unix
Variable was created at:
  p9_fd_create_unix+0x7a/0x5f0 net/9p/trans_fd.c:996
  p9_client_create+0x1333/0x20e0 net/9p/client.c:1065
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
