Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3ED84C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99D220020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99D220020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935676AbeFMNrE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:47:04 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:58590 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935642AbeFMNrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:47:03 -0400
Received: by mail-it0-f71.google.com with SMTP id k129-v6so2417152itg.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 06:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kYyT30I/KkLN1eQg1MPcDCoovRRxpQAox8S0wj8hSh0=;
        b=dm76Nd0Wc/uRTutMj80vgHPivK9aYORaxIT0EERE0tXFQg2VFSjIKQxmmKqW6LmvUr
         eR54m0NejKfTmgChBM4YJGZ46GqkHErFhGNqthPNbd1o9NQwiqEIdkaTdBl3MCotDY2j
         PQUeJEzXIgjtrcfgOaPT6ltiIxMo+8kSvTta4cnMwMHt0tV+hdQYaiFBzQdu91CB4Riz
         ahBsS67iah2K37lMQe3D898yLjQTuRvLbl6TbDJHGaeHzfxQfbr0rwIP0TWFRgQnfwfR
         HBNdPAUoWjFofeXZMe3pg9uCff/hQxlty9LOGLtkPLUVBhgmxI4odrfB/8tSGB1vgPuM
         g/EA==
X-Gm-Message-State: APt69E0rRi5IK05V0i3BziJYWLX4ldF8CuBuX6oGa+jY+xPboDBtFF0g
        c2wYCaZjfmhennnR6x+mNvf3zGwFRBALqJWA+jc27mUwb9J4
X-Google-Smtp-Source: ADUXVKJbBmzHwB4O0mnlQKtPKvWJRYaak7JGFN2bWr7b9v5FvG5HFrOGPKQVQs2vtRQJyL4w+MuSHZqG2/lvaWjW6dOhgf1YMfOP
MIME-Version: 1.0
X-Received: by 2002:a24:4129:: with SMTP id x41-v6mr2082813ita.45.1528897622456;
 Wed, 13 Jun 2018 06:47:02 -0700 (PDT)
Date:   Wed, 13 Jun 2018 06:47:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af6530056e863794@google.com>
Subject: WARNING: bad unlock balance in ucma_event_handler
From:   syzbot <syzbot+e5579222b6a3edd96522@syzkaller.appspotmail.com>
To:     dasaratharaman.chandramouli@intel.com, dledford@redhat.com,
        jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com,
        roland@purestorage.com, sean.hefty@intel.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    73fcb1a370c7 Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d70827800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3b4e30da84ec1ed
dashboard link: https://syzkaller.appspot.com/bug?extid=e5579222b6a3edd96522
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=176daf97800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e7bd57800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e5579222b6a3edd96522@syzkaller.appspotmail.com


=====================================
WARNING: bad unlock balance detected!
4.17.0-rc5+ #58 Not tainted
-------------------------------------
kworker/u4:0/6 is trying to release lock (&file->mut) at:
[<ffffffff8593ecc0>] ucma_event_handler+0x780/0xff0  
drivers/infiniband/core/ucma.c:390
but there are no more locks to release!

other info that might help us debug this:
4 locks held by kworker/u4:0/6:
  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at:  
__write_once_size include/linux/compiler.h:215 [inline]
  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:40 [inline]
  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at: atomic_long_set  
include/asm-generic/atomic-long.h:57 [inline]
  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at: set_work_data  
kernel/workqueue.c:617 [inline]
  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at:  
process_one_work+0xaef/0x1b50 kernel/workqueue.c:2116
  #1:         (ptrval) ((work_completion)(&(&req->work)->work)){+.+.}, at:  
process_one_work+0xb46/0x1b50 kernel/workqueue.c:2120
  #2:         (ptrval) (&id_priv->handler_mutex){+.+.}, at:  
addr_handler+0xa6/0x3d0 drivers/infiniband/core/cma.c:2796
  #3:         (ptrval) (&file->mut){+.+.}, at:  
ucma_event_handler+0x10e/0xff0 drivers/infiniband/core/ucma.c:350

stack backtrace:
CPU: 1 PID: 6 Comm: kworker/u4:0 Not tainted 4.17.0-rc5+ #58
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: ib_addr process_one_req
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_unlock_imbalance_bug.cold.50+0xcc/0xd8 kernel/locking/lockdep.c:3484
  __lock_release kernel/locking/lockdep.c:3691 [inline]
  lock_release+0x77a/0xa10 kernel/locking/lockdep.c:3939
  __mutex_unlock_slowpath+0xeb/0x8a0 kernel/locking/mutex.c:1018
  mutex_unlock+0xd/0x10 kernel/locking/mutex.c:614
  ucma_event_handler+0x780/0xff0 drivers/infiniband/core/ucma.c:390
  addr_handler+0x2bd/0x3d0 drivers/infiniband/core/cma.c:2820
  process_one_req+0x2e8/0x750 drivers/infiniband/core/addr.c:616
  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
  kthread+0x345/0x410 kernel/kthread.c:240
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
