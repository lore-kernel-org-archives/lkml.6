Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E082EC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB25925FB7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB25925FB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965046AbeFYRpI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:45:08 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:32947 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965000AbeFYRpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:45:03 -0400
Received: by mail-io0-f200.google.com with SMTP id s19-v6so12459256iog.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 10:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UZwoubkcDgxLbEon9fZt8GCwzXhKIZQNX/iG9bwOjSo=;
        b=kb+HPJEU3ubad+rHlpiQ/CdEo9El3BvCmUseoV8VxlwOCt3oWxUEzNit4B1FxfY3cr
         +i2EmWobcYTT+bCOV/JFtyBVvrm1h7Zq4W/CTgVZOEcOgeskA6HRNQpNGRrUTp0YO/AC
         PjBp3qvyEczRMpL0lqtRdWknMa57uSUZmagsY9upKHtDoFMlzjegcVoFR3yuzYba8Msa
         WANR/MvWXiQAcqhODvXqzZ/mt9jusDrQv67MHr/mnXIU6ptxx9BftoK6bW5Gw5qcM9Bc
         ynjhSY8yjHzlWWiPMgYvkF8u3Ry/FEvTwTvh4NLxJMeY9vC/nqcEVGcakikBsIiKBdoJ
         4yXw==
X-Gm-Message-State: APt69E2goYgahFAD7vOrx/62CRpzn2lO387M5gby9B79WzV7jadAU0uA
        2Z1SKT2gAkbv49kKvDX8uyJtoaq6vmjj3sttWiOxBuD3aZnD
X-Google-Smtp-Source: ADUXVKI/XY25pvrknCzdh7bbbcZQyuaV+zjiflGxoisPEjr/Hhkqd5ay7H797f4uHga5nSjc8ljEpkri0GhWv4WED71Ko+W/26hN
MIME-Version: 1.0
X-Received: by 2002:a02:8782:: with SMTP id t2-v6mr1316920jai.3.1529948702555;
 Mon, 25 Jun 2018 10:45:02 -0700 (PDT)
Date:   Mon, 25 Jun 2018 10:45:02 -0700
In-Reply-To: <0000000000002b532a056ebcb3eb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0c659056f7af058@google.com>
Subject: Re: WARNING: suspicious RCU usage in pid_task
From:   syzbot <syzbot+c2d4c3ae3fd90bbaf059@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dhowells@redhat.com,
        ebiederm@xmission.com, gs051095@gmail.com,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        pasha.tatashin@oracle.com, riel@redhat.com,
        rppt@linux.vnet.ibm.com, syzkaller-bugs@googlegroups.com,
        wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    6f0d349d922b Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c04304400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a63be0c83e84d370
dashboard link: https://syzkaller.appspot.com/bug?extid=c2d4c3ae3fd90bbaf059
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=14f0a814400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ce574c400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c2d4c3ae3fd90bbaf059@syzkaller.appspotmail.com

bpfilter: read fail -512

=============================
WARNING: suspicious RCU usage
4.18.0-rc2+ #117 Not tainted
-----------------------------
kernel/pid.c:323 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor106/7744:
  #0: 00000000bee82115 (bpfilter_lock){+.+.}, at:  
__bpfilter_process_sockopt+0x1c5/0x39b net/bpfilter/bpfilter_kern.c:67

stack backtrace:
CPU: 1 PID: 7744 Comm: syz-executor106 Not tainted 4.18.0-rc2+ #117
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  lockdep_rcu_suspicious+0x14a/0x153 kernel/locking/lockdep.c:4562
  pid_task+0x1ce/0x200 kernel/pid.c:322
  shutdown_umh.constprop.0+0x33/0x7c net/bpfilter/bpfilter_kern.c:29
  __stop_umh net/bpfilter/bpfilter_kern.c:41 [inline]
  __bpfilter_process_sockopt.cold.1+0x9b/0xa0 net/bpfilter/bpfilter_kern.c:81
  bpfilter_mbox_request+0x4d/0xb0 net/ipv4/bpfilter/sockopt.c:25
  bpfilter_ip_set_sockopt+0x33/0x40 net/ipv4/bpfilter/sockopt.c:31
  ip_setsockopt+0x124/0x140 net/ipv4/ip_sockglue.c:1250
  dccp_setsockopt+0x96/0xf0 net/dccp/proto.c:565
  sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3040
  __sys_setsockopt+0x1c5/0x3b0 net/socket.c:1947
  __do_sys_setsockopt net/socket.c:1958 [inline]
  __se_sys_setsockopt net/socket.c:1955 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1955
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44cdb9
Code: e8 6c bd 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb d2 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f63b04a8d18 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00000000006dfce4 RCX: 000000000044cdb9
RDX: 0000000000000040 RSI: 0000000000000000 RDI: 0000000000000027
RBP: 00000000006dfce0 R08: 0000000000000000 R09: 65732f636f72702f
R10: 0000000020000000 R11: 0000000000000246 R12: 00007f63b04a8d20
R13: 0100000000000000 R14: 6273752f7665642f R15: 0000000000000034

