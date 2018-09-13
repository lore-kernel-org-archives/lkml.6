Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9973BC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EBF20861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EBF20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeIMLBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 07:01:01 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:56375 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeIMLBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 07:01:00 -0400
Received: by mail-io1-f69.google.com with SMTP id a3-v6so3132431iod.23
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 22:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mO/mbV/lyCO4ho5Nedxx0wcTsQMjCNvEV1dbAL1ukKo=;
        b=dAujigMvl4RQ+4Nt5XS4m8efhDAtoU1E4XXI7cYzpOtB1fND5ggOu/7i3wyrciCyIe
         LwcS7w7qIGYxFE+4gO2eVAq+pXYtRVXj4extePrMzgKERspIdSYkCr4YGNQtFYiaQgvN
         v1uUQ2iPbW+N+PuLZ7MRJqktfwhyMKcUagFpbKkY7tl0ISrOSVOM0WeT2aKMcU74z+2g
         Yb8/B54xTu/XE16niA8oSTSIVbUKAHV4FlDrT/q5XmEwb5c8gQAiQylkPd8emoiQ7A8V
         fFKis/yk1Kv4jtp6kY9QDeGCYvcmY/dtd1nZnjgz7sZmMuwuLXR0Yh36ze3HVrj1qs8H
         1/Aw==
X-Gm-Message-State: APzg51BWBHoAlur02N6f88srXzyAHft/hJG+jztvSRwPBPaB0wktetSr
        5LNc2FK8ct8SRapoZYZa3iVA4Ln3CD8BzBxZKqg4rsohHSCQ
X-Google-Smtp-Source: ANB0Vdamgc1xXEmN36JV2c643kZttJMEW5mV4rXCFGHvm4Nkj1M8B9lu6I+zlUGu0VFoV53relDoJt31qbBEHOu+OlQLmF4SDD25
MIME-Version: 1.0
X-Received: by 2002:a6b:c94f:: with SMTP id z76-v6mr4504815iof.13.1536817982628;
 Wed, 12 Sep 2018 22:53:02 -0700 (PDT)
Date:   Wed, 12 Sep 2018 22:53:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f06cae0575ba5158@google.com>
Subject: KASAN: global-out-of-bounds Read in mqueue_get_tree
From:   syzbot <syzbot+8a81fb3d40f8c58aa8e2@syzkaller.appspotmail.com>
To:     arnd@arndb.de, dbueso@suse.de, dhowells@redhat.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7c1b097f27bf Add linux-next specific files for 20180912
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=152fcd49400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5980033172920ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=8a81fb3d40f8c58aa8e2
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140a53da400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b0c6ae400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8a81fb3d40f8c58aa8e2@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KASAN: global-out-of-bounds in mqueue_get_tree+0x2a2/0x2e0  
ipc/mqueue.c:362
Read of size 8 at addr ffffffff885cef68 by task syz-executor013/5545

CPU: 0 PID: 5545 Comm: syz-executor013 Not tainted  
4.19.0-rc3-next-20180912+ #72
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c4 lib/dump_stack.c:113
  print_address_description.cold.8+0x58/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  mqueue_get_tree+0x2a2/0x2e0 ipc/mqueue.c:362
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1787
  mq_create_mount+0xe3/0x190 ipc/mqueue.c:415
  mq_init_ns+0x15a/0x210 ipc/mqueue.c:1621
  create_ipc_ns ipc/namespace.c:58 [inline]
  copy_ipcs+0x3d2/0x580 ipc/namespace.c:84
  create_new_namespaces+0x376/0x900 kernel/nsproxy.c:87
  unshare_nsproxy_namespaces+0xc3/0x1f0 kernel/nsproxy.c:206
  ksys_unshare+0x79c/0x10b0 kernel/fork.c:2535
  __do_sys_unshare kernel/fork.c:2603 [inline]
  __se_sys_unshare kernel/fork.c:2601 [inline]
  __x64_sys_unshare+0x31/0x40 kernel/fork.c:2601
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446257
Code: 00 00 00 b8 63 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 dd d7 fb ff c3  
66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 10 01 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bd d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe2677e8e8 EFLAGS: 00000217 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007ffe2677f450 RCX: 0000000000446257
RDX: 0000000000000000 RSI: 00007ffe2677e8f0 RDI: 0000000008000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000018
R10: 0000000000000000 R11: 0000000000000217 R12: 0000000000403ea0
R13: 0000000000403f30 R14: 0000000000000000 R15: 0000000000000000

The buggy address belongs to the variable:
  ipcns_operations+0x68/0xa00

Memory state around the buggy address:
  ffffffff885cee00: fa fa fa fa 00 00 00 00 00 02 fa fa fa fa fa fa
  ffffffff885cee80: 00 00 00 01 fa fa fa fa 04 fa fa fa fa fa fa fa
> ffffffff885cef00: 00 00 00 00 00 00 00 00 fa fa fa fa 03 fa fa fa
                                                           ^
  ffffffff885cef80: fa fa fa fa 07 fa fa fa fa fa fa fa 00 03 fa fa
  ffffffff885cf000: fa fa fa fa 00 fa fa fa fa fa fa fa 00 04 fa fa
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
