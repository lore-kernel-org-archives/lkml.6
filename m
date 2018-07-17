Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2C2ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2ED520C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2ED520C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731625AbeGQNzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:55:42 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:37783 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731470AbeGQNzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:55:42 -0400
Received: by mail-it0-f70.google.com with SMTP id r10-v6so1099551itc.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 06:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=EancMxKEfDdc5IRhD4O7OScDy32q4eXtPCzfjufYvQE=;
        b=JBWmDcztLUuE9JoJd9tyKu5GTW9EwtqXAXNjkisIZgJF5c0872CgdRkX1NSwoaY9bE
         ijA542SC6RjMIj7P0MqReolGnRdcSvo/m1SdqolFY/yAOjO0HVsvvLhebq4d2bVdQ8iB
         KFgAjmyVtoXXzAn30kqeSg5HDzpkmh5LeJ10OZNeX1K2Av1ocVAbVDB0NaDbPez/4aKS
         0uIxNgCej7nnugEHWYkUNeMEJSt6J8QHGC6SOChl1FyHo4S/qjVG/d0tjKOAo+RvQvuk
         +OpG5en54TPyFc/n/RPG7Ca12w6JLys4JDgikdLahHXkF4+pW1mK2CQLN2Alp93iudf5
         cc4g==
X-Gm-Message-State: AOUpUlFLDGDZjXc2KKH8Lsh1iIfppwr8k2q6MaUJGzGuxvAZvSi7FLe7
        xQy45tqvSrwMC0dJaKT/ZeLSc6sGqQjNd9tIczOkv6w5lcF/
X-Google-Smtp-Source: AAOMgpcJTiKp1V7PyS15abIy17mAznJ/sot+ylFEnmw0JrIy+5Rjoevp/NdbVvR9ZIZVsKbuylH4jUSCixwq1eV2iMveIedLkqLt
MIME-Version: 1.0
X-Received: by 2002:a24:6253:: with SMTP id d80-v6mr724203itc.23.1531833782815;
 Tue, 17 Jul 2018 06:23:02 -0700 (PDT)
Date:   Tue, 17 Jul 2018 06:23:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ae01e057131d872@google.com>
Subject: KMSAN: uninit-value in copy_siginfo_to_user
From:   syzbot <syzbot+ab504332a376ca03331e@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, ebiederm@xmission.com, ldv@altlinux.org,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        oleg@redhat.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8fc8ecd1c58a kmsan: unpoison regs in arch_uprobe_exception..
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=1758708f800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9fa436d3ae606638
dashboard link: https://syzkaller.appspot.com/bug?extid=ab504332a376ca03331e
compiler:       clang version 7.0.0 (trunk 332596)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=170eeed7800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ab504332a376ca03331e@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KMSAN: uninit-value in copy_siginfo_to_user+0x383/0x1270  
kernel/signal.c:2870
CPU: 1 PID: 4746 Comm: syz-executor0 Not tainted 4.17.0-rc5+ #103
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:113
  kmsan_report+0x149/0x260 mm/kmsan/kmsan.c:1084
  __msan_warning_32+0x6e/0xc0 mm/kmsan/kmsan_instr.c:686
  copy_siginfo_to_user+0x383/0x1270 kernel/signal.c:2870
  ptrace_peek_siginfo kernel/ptrace.c:741 [inline]
  ptrace_request+0x1d6a/0x20e0 kernel/ptrace.c:912
  arch_ptrace+0x1f6/0x1230 arch/x86/kernel/ptrace.c:877
  __do_sys_ptrace kernel/ptrace.c:1145 [inline]
  __se_sys_ptrace+0x309/0x850 kernel/ptrace.c:1110
  __x64_sys_ptrace+0x11e/0x170 kernel/ptrace.c:1110
  do_syscall_64+0x152/0x230 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x455a09
RSP: 002b:00007ffc971089c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000065
RAX: ffffffffffffffda RBX: 0000000000acf914 RCX: 0000000000455a09
RDX: 0000000000730004 RSI: 0000000000000001 RDI: 0000000000004209
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000558 R14: 00000000006fd0e0 R15: 000000000000b0fe

Local variable description: ----kiov@ptrace_request
Variable was created at:
  ptrace_request+0x194/0x20e0 kernel/ptrace.c:885
  arch_ptrace+0x1f6/0x1230 arch/x86/kernel/ptrace.c:877
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
