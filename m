Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 97140C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F50208BA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F50208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755239AbeFNMrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:47:22 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:53926 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754913AbeFNMrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:47:04 -0400
Received: by mail-it0-f70.google.com with SMTP id 189-v6so5118690ito.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 05:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6NuyjwBaQfElw9BhtFoecKwyP8OBUslE2xdtwGYDqbA=;
        b=dqTxKfJAlSDGgOgSMv6l2+XgleY0nKbWpPyEfwv/VDjVswGUEF5nxrC8gwlH9H2hQs
         Ls9/nRoEhefiQllkiMaPy4pichs8+G9DRneqC8/d4zmVi6x8Y07/bELizn+Xz0Ix06pn
         7Rp3m1t98P/ky21YRCACE+1PblfxL5XlFjWJsSo9AEx8YtBaSMcLSc+N6UZ8c+QDHVf7
         yETCviw56gVNepPrV/r0z3wBPPHCpZyiGREcmXw9nBGFYBXnKYwmR7GCRAFUAnYzAaHz
         YjwzAVR+8Opm/bGcIFVXCJGOhfXQxVeDF9ydXJAhu4HMLHT9UEYg4SuiWlpyaCQgZa5r
         jnOA==
X-Gm-Message-State: APt69E3YA6F1wAAXWEOwWAsmNLYm/1fGP4l5lW4VhMtURa2ab2xHTUyr
        3CKp6G2727cCH6iqyMwxEqCuwr16o6eC2B37hGPtk00+O+Ql
X-Google-Smtp-Source: ADUXVKLgr1AeAJ3NOd5sMgHgEXPt86bN1NajFwzr5dPSQs68B/Dzq5GT7hYOx+pFg0xdrbYg1etjMcLMpD5P0Qt6DeK8v5Mt+wgq
MIME-Version: 1.0
X-Received: by 2002:a02:948d:: with SMTP id x13-v6mr432861jah.45.1528980423389;
 Thu, 14 Jun 2018 05:47:03 -0700 (PDT)
Date:   Thu, 14 Jun 2018 05:47:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000013b0d056e997fec@google.com>
Subject: WARNING in sk_stream_kill_queues (3)
From:   syzbot <syzbot+13e1ee9caeab5a9abc62@syzkaller.appspotmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pombredanne@nexb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    81c310582f0e kmsan: unpoison virtio input buffers when add..
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=1747c21f800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=848e40757852af3e
dashboard link: https://syzkaller.appspot.com/bug?extid=13e1ee9caeab5a9abc62
compiler:       clang version 7.0.0 (trunk 334104)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=105f5eaf800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b15b6f800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+13e1ee9caeab5a9abc62@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 4964 at net/core/stream.c:206  
sk_stream_kill_queues+0x944/0x970 net/core/stream.c:206
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 4964 Comm: syz-executor457 Not tainted 4.17.0+ #6
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:113
  panic+0x3d0/0x990 kernel/panic.c:184
  __warn+0x40f/0x580 kernel/panic.c:536
  report_bug+0x72a/0x880 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  do_error_trap+0x1c1/0x620 arch/x86/kernel/traps.c:298
  do_invalid_op+0x46/0x50 arch/x86/kernel/traps.c:317
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:sk_stream_kill_queues+0x944/0x970 net/core/stream.c:206
RSP: 0018:ffff8801a867f368 EFLAGS: 00010293
RAX: ffffffff87dbf654 RBX: 0000000000000813 RCX: ffff8801ab7bd7c0
RDX: 0000000000000000 RSI: aaaaaaaaaaaab000 RDI: ffffea0000000000
RBP: ffff8801a867f3e8 R08: 0000000000000000 R09: 0000000000000002
R10: ffff8801a66d3a00 R11: ffffffff88c44c40 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000813
  inet_csk_destroy_sock+0x2a4/0x5d0 net/ipv4/inet_connection_sock.c:833
  tcp_close+0xe37/0x18f0 net/ipv4/tcp.c:2323
  tls_sk_proto_close+0xc2f/0xcd0 net/tls/tls_main.c:291
  inet_release+0x249/0x2b0 net/ipv4/af_inet.c:427
  inet6_release+0xaf/0x100 net/ipv6/af_inet6.c:460
  sock_release net/socket.c:594 [inline]
  sock_close+0xeb/0x310 net/socket.c:1149
  __fput+0x458/0xa30 fs/file_table.c:209
  ____fput+0x37/0x40 fs/file_table.c:243
  task_work_run+0x22e/0x2b0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x110e/0x3930 kernel/exit.c:867
  do_group_exit+0x1a0/0x360 kernel/exit.c:970
  get_signal+0x1405/0x1ec0 kernel/signal.c:2482
  do_signal+0xb8/0x1d20 arch/x86/kernel/signal.c:810
  exit_to_usermode_loop arch/x86/entry/common.c:162 [inline]
  prepare_exit_to_usermode+0x271/0x3a0 arch/x86/entry/common.c:196
  syscall_return_slowpath+0xe9/0x710 arch/x86/entry/common.c:265
  do_syscall_64+0x1ad/0x230 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x447ce9
RSP: 002b:00007feb54132d98 EFLAGS: 00000212 ORIG_RAX: 000000000000002c
RAX: 0000000000008000 RBX: 00000000006dec5c RCX: 0000000000447ce9
RDX: 00000000fffffdef RSI: 00000000200005c0 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000020000000 R09: 000000000000001c
R10: 0000000000000000 R11: 0000000000000212 R12: 00000000006dec58
R13: 0100000000000000 R14: 00007feb541339c0 R15: 000000000000000c
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
