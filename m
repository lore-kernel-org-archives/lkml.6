Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CC9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFD52148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFD52148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbeKLEHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 23:07:19 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:41000 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbeKLEHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 23:07:18 -0500
Received: by mail-it1-f200.google.com with SMTP id s195-v6so10721880itc.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 10:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OISAwbk9jxUgcTTHBWnAi+5ujir48cobH1JO5BmfLF0=;
        b=ShxZNtdnkmayWXBmPHIfk5ugZgQJqWWZ3awEL7hV3COdU3rkCJRBtRMja1ehbEQCXt
         hx1c0PeNLjd2ExVsQioy4CxOfJEjY08Dmy4egFKN6lVGMTPJ3tJ0Gt11zQFDqjw+7vn3
         DDd32biMFIxeMHI4EUbs94bJHbEBGaOdl5QuBgH+ygC9JptefdwgrMdo7eQp/RMDJDeQ
         eXBrEXSHx2P85m6aaaD8YLnSS9pL6M24tDYKCFBaS4m+gXMol0J4I2Y+nIsK/TIaUbkp
         9EWKsQrumKbdnQd3o1QxkqkU61Y6RbAvYO+r+mLPRvLOn2rvfSfUc9tXWwTphKE9oGmw
         Z/qw==
X-Gm-Message-State: AGRZ1gK5/+NxcdJAUJd5cvjNiGXF671Nx7bbwSDajkwEt6sQSoDqFDCL
        ruVEAwRZQet0h4I1eQ3Nb2WpKbMkRgV9d/wkW1mJiJnBum4+
X-Google-Smtp-Source: AJdET5fJ1uaC+YHs9TLbnIdve/9mOQa+CwMsfbM8mkBC4l3o8LWRGBGyi6E/NRc2OXyvLX6Jx71b7AslhxdmCoTHjkeBHFwR/ngl
MIME-Version: 1.0
X-Received: by 2002:a24:5389:: with SMTP id n131-v6mr8549814itb.9.1541960283887;
 Sun, 11 Nov 2018 10:18:03 -0800 (PST)
Date:   Sun, 11 Nov 2018 10:18:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa9fb7057a679a42@google.com>
Subject: BUG: corrupted list in locks_delete_block
From:   syzbot <syzbot+13eb7470890c56ce3f37@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    442b8cea2477 Add linux-next specific files for 20181109
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12b1262b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f72bdb11df9fbe8
dashboard link: https://syzkaller.appspot.com/bug?extid=13eb7470890c56ce3f37
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107566a3400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b5fa2b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+13eb7470890c56ce3f37@syzkaller.appspotmail.com

list_del corruption. prev->next should be ffff8801c135f960, but was  
0000000000000007
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:53!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5972 Comm: syz-executor001 Not tainted  
4.20.0-rc1-next-20181109+ #110
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__list_del_entry_valid.cold.1+0x48/0x4a lib/list_debug.c:51
Code: fe 60 88 e8 72 9b d3 fd 0f 0b 48 89 de 48 c7 c7 40 00 61 88 e8 61 9b  
d3 fd 0f 0b 48 89 de 48 c7 c7 e0 ff 60 88 e8 50 9b d3 fd <0f> 0b 48 89 d9  
48 c7 c7 a0 00 61 88 e8 3f 9b d3 fd 0f 0b 48 89 f1
RSP: 0018:ffff8801c135f750 EFLAGS: 00010286
RAX: 0000000000000054 RBX: ffff8801c135f960 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8165ba15 RDI: 0000000000000005
RBP: ffff8801c135f768 R08: ffff8801c11ce080 R09: ffffed003b5e5020
R10: ffffed003b5e5020 R11: ffff8801daf28107 R12: ffff8801d945f3a0
R13: ffff8801d945f3a0 R14: 0000000000000000 R15: ffff8801c135f838
FS:  00007f96b449c700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000046aa40 CR3: 00000001b39ab000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __list_del_entry include/linux/list.h:117 [inline]
  list_del_init include/linux/list.h:159 [inline]
  __locks_delete_block fs/locks.c:683 [inline]
  locks_delete_block+0xce/0x3d0 fs/locks.c:716
  locks_mandatory_area+0x48b/0x6a0 fs/locks.c:1398
  rw_verify_area+0x2f2/0x360 fs/read_write.c:386
  do_iter_write+0x101/0x5f0 fs/read_write.c:954
  vfs_writev+0x1f1/0x360 fs/read_write.c:1004
  do_writev+0x11a/0x310 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev fs/read_write.c:1109 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446619
Code: e8 6c b4 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f96b449bda8 EFLAGS: 00000297 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00000000006dbc38 RCX: 0000000000446619
RDX: 0000000000000001 RSI: 0000000020000440 RDI: 0000000000000003
RBP: 00000000006dbc30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000297 R12: 00000000006dbc3c
R13: 2f30656c69662f2e R14: 64663d736e617274 R15: 00000000006dbd2c
Modules linked in:
---[ end trace efdc3057b60b19f3 ]---
RIP: 0010:__list_del_entry_valid.cold.1+0x48/0x4a lib/list_debug.c:51
Code: fe 60 88 e8 72 9b d3 fd 0f 0b 48 89 de 48 c7 c7 40 00 61 88 e8 61 9b  
d3 fd 0f 0b 48 89 de 48 c7 c7 e0 ff 60 88 e8 50 9b d3 fd <0f> 0b 48 89 d9  
48 c7 c7 a0 00 61 88 e8 3f 9b d3 fd 0f 0b 48 89 f1
RSP: 0018:ffff8801c135f750 EFLAGS: 00010286
RAX: 0000000000000054 RBX: ffff8801c135f960 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8165ba15 RDI: 0000000000000005
RBP: ffff8801c135f768 R08: ffff8801c11ce080 R09: ffffed003b5e5020
R10: ffffed003b5e5020 R11: ffff8801daf28107 R12: ffff8801d945f3a0
R13: ffff8801d945f3a0 R14: 0000000000000000 R15: ffff8801c135f838
FS:  00007f96b449c700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000046aa40 CR3: 00000001b39ab000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
