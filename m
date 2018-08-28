Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5135BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE1F2087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE1F2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeH1TMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:12:12 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:40185 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1TMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:12:12 -0400
Received: by mail-io0-f197.google.com with SMTP id p22-v6so1637304ioh.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 08:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5zMISRJQe60hbMHBGYHI6NlOdGj/Q6DCgYwHCYO78Qg=;
        b=ZfiIkehUCYy7XSmFdSZcLnN+MrXGixhXbZibuNZ1wfRK8a1y4OP8QZZb5/x8CC0eE/
         CzUMDklwIodmjii/we3fdi4VcZWjgosEaqKlGDxTRFsef8LvGmsGJxxxZ8SivgmlDKn0
         /cHPx5gVOR0KkUeFTvMHXQ1HKk1hChRw4hfAQdUz8cNrgUdPDEr5Mttn1auxpVQ2Z4au
         iHW4ir24jfu87mYgtl4BQgM5gukVggRPUuAxgzIz4gIgeDNh7RNPhS1jOooh/fsRAVL3
         OJnLstfFHw/NHWGHodFFfX9UjNoHL1+onDmV4AhkKdLJsRk0JbkHURYbYUYzZ6CqlJR3
         Nb/w==
X-Gm-Message-State: APzg51AtX+IlmbGG4wLX0PQx3aasdwAn6dNufMgvdhU2So+krClDkWBC
        8uaY5JvHN8S0MckKOFtjXUWvE35aolHDOCYXAFxdOILNw+Gf
X-Google-Smtp-Source: ANB0VdZQrqfaP7lYM/BUAPvPENEqyT46958tpbOkJ2nootdOnRnrXNMu7/4eyxWC2TdUcaPTYOqckJvXQcQ0u0WNV09ThwW6dCFu
MIME-Version: 1.0
X-Received: by 2002:a02:7ec9:: with SMTP id g70-v6mr807924jae.20.1535469602706;
 Tue, 28 Aug 2018 08:20:02 -0700 (PDT)
Date:   Tue, 28 Aug 2018 08:20:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b9c4b0574806070@google.com>
Subject: WARNING: bad unlock balance in ucma_destroy_id
From:   syzbot <syzbot+4b628fcc748474003457@syzkaller.appspotmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        parav@mellanox.com, roland@purestorage.com, sean.hefty@intel.com,
        swise@opengridcomputing.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5b394b2ddf03 Linux 4.19-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117e0da6400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=49927b422dcf0b29
dashboard link: https://syzkaller.appspot.com/bug?extid=4b628fcc748474003457
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13351e2e400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4b628fcc748474003457@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0

=====================================
WARNING: bad unlock balance detected!
4.19.0-rc1+ #211 Not tainted
-------------------------------------
syz-executor0/6666 is trying to release lock (&file->mut) at:
[<ffffffff84c3796b>] ucma_destroy_id+0x2cb/0x550  
drivers/infiniband/core/ucma.c:624
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz-executor0/6666:
  #0: 00000000faad4ebe (&file->mut){+.+.}, at: ucma_destroy_id+0x26b/0x550  
drivers/infiniband/core/ucma.c:622

stack backtrace:
CPU: 0 PID: 6666 Comm: syz-executor0 Not tainted 4.19.0-rc1+ #211
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_unlock_imbalance_bug.cold.49+0xcc/0xd8 kernel/locking/lockdep.c:3465
  __lock_release kernel/locking/lockdep.c:3672 [inline]
  lock_release+0x76e/0x9f0 kernel/locking/lockdep.c:3920
  __mutex_unlock_slowpath+0x102/0x8c0 kernel/locking/mutex.c:1198
  mutex_unlock+0xd/0x10 kernel/locking/mutex.c:713
  ucma_destroy_id+0x2cb/0x550 drivers/infiniband/core/ucma.c:624
  ucma_write+0x336/0x420 drivers/infiniband/core/ucma.c:1680
  __vfs_write+0x117/0x9d0 fs/read_write.c:485
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f3d32b48c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f3d32b496d4 RCX: 0000000000457089
RDX: 0000000000000018 RSI: 0000000020000480 RDI: 0000000000000005
RBP: 0000000000930140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d7470 R14: 00000000004c17a8 R15: 0000000000000001


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
