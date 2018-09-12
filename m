Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6337BC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279FD2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279FD2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeIMCf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 22:35:27 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:44910 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbeIMCf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 22:35:27 -0400
Received: by mail-it0-f69.google.com with SMTP id b124-v6so5665353itb.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 14:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hyySvZzkO3TtLbZYFG/gsgGm8nMmt9+ZoSRQIVUcQXo=;
        b=DiSwCTy3CYpYh7turCjksSa3Zzeo22n+ePZQ3A0+KY1Ol0NwVxisIkeoDla3Z9tnE9
         MTbirfgot9R1KBjw+VId17hM8lHK33GJHOcHKDfjA2YRN6Aw89vjvapSSe+StG+Pt/G5
         NBX9+se/ufCzho/CTTg0gI0YkTi7G757WXlcIFSDE7ogYf87BrajFQ/24zKzkBNRrwNZ
         YWNeE1BGRRlf/BvXMjrqqGgYhrBqc1bBB7p2RTelABZa1lrk/PqGMvSEzX2lNUHvivvX
         26MOiTwdl7XnSoEx3fcOSY1wWSpj3qUPRMh3o9RlDLI/p1iX9uvtCbFUD5QrUnQIG4vH
         HwOg==
X-Gm-Message-State: APzg51B6noAtzk1mfs4S2opy6WaRci7zITwFTmL38ay/v+hvwcM3ldDe
        yb8Aq84M5VrqvWqJhySRuOsZOcjHw0zLJnGuiUrYN7TmMBs9
X-Google-Smtp-Source: ANB0VdZugx7OYv+7wqMElF01cgOz6ZPzVcIZWBIKmr6D3q7FCY5wFydmur85XAlLjh96F4Ff4qMshSmco9s5uVc5rVzN6gd7WYoo
MIME-Version: 1.0
X-Received: by 2002:a24:f5c1:: with SMTP id k184-v6mr3609160ith.7.1536787742665;
 Wed, 12 Sep 2018 14:29:02 -0700 (PDT)
Date:   Wed, 12 Sep 2018 14:29:02 -0700
In-Reply-To: <0000000000006cd9da0575ac7d9d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f48880575b3478d@google.com>
Subject: Re: KASAN: use-after-free Read in mqueue_get_tree
From:   syzbot <syzbot+fef0b74a3bf760a9ee85@syzkaller.appspotmail.com>
To:     arnd@arndb.de, dbueso@suse.de, dhowells@redhat.com,
        ebiederm@xmission.com, jhaws@sdl.usu.edu,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    7c1b097f27bf Add linux-next specific files for 20180912
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=117a33be400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5980033172920ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=fef0b74a3bf760a9ee85
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15904f71400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b37211400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fef0b74a3bf760a9ee85@syzkaller.appspotmail.com

sshd (5546) used greatest stack depth: 16872 bytes left
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KASAN: use-after-free in mqueue_get_tree+0x2ac/0x2e0 ipc/mqueue.c:362
Read of size 8 at addr ffff8801d88ce9c8 by task syz-executor123/5567

CPU: 1 PID: 5567 Comm: syz-executor123 Not tainted  
4.19.0-rc3-next-20180912+ #72
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  mqueue_get_tree+0x2ac/0x2e0 ipc/mqueue.c:362
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
RIP: 0033:0x44e547
Code: 00 00 00 b8 63 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 3d a0 fb ff c3  
66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 10 01 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 1d a0 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc80298538 EFLAGS: 00000217 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007ffc80298bc0 RCX: 000000000044e547
RDX: 0000000000000000 RSI: 00007ffc80298540 RDI: 0000000008000000
RBP: 585858582e72656c R08: 0000000000000000 R09: 0000000000000018
R10: 0000000000000000 R11: 0000000000000217 R12: 6c616b7a79732f2e
R13: 0000000000408a80 R14: 0000000000000000 R15: 0000000000000000

The buggy address belongs to the page:
page:ffffea0007623380 count:0 mapcount:0 mapping:0000000000000000  
index:0xffff8801d88ced00
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 dead000000000100 dead000000000200 0000000000000000
raw: ffff8801d88ced00 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d88ce880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff8801d88ce900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ffff8801d88ce980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                               ^
  ffff8801d88cea00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff8801d88cea80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================

