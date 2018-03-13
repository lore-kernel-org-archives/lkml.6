Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932730AbeCMWuv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 18:50:51 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:39259 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932481AbeCMWut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 18:50:49 -0400
X-Google-Smtp-Source: AG47ELvAb9ZEjA2Gr/q4hQ8zRhS1QNNfZF2rWBgnN+R85gB2wr2Ttmrmz1rnHaeCAWXpfNw1FF/ToxOFzA7vCo3pMuk=
MIME-Version: 1.0
From: David Chen <tuxoko@gmail.com>
Date: Tue, 13 Mar 2018 15:50:47 -0700
Message-ID: <CAK1sfuYAQf0irGzGxusNg-PdqLSzJ6tSHMENG2Vp8gH1c0FG9w@mail.gmail.com>
Subject: blk_mq_freeze_queue hang and possible race in percpu-refcount
To: Tejun Heo <tj@kernel.org>, Shaohua Li <shli@fb.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

We recently hit an issue where several tasks hung in blk_mq_freeze_queue_wait.
All the task have the same stack trace as the one below, which is
doing fput on loop device.
Which is strange because the task should be no more than a open(2), a
couple pread(2),
and close(2) on a loop device.

====
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
zpool           D    0 32416  32156 0x00000080
ffff967e4b0a1740 ffff967e4b0a1740 ffff967dcdd50000 ffff967dcd8825c0
ffff967eafad9780 ffffb7ab84c5fd18 ffffffff938789dc 0000000000000286
0000000000000286 ffff967dcdd50000 ffff967ea7d691e8 ffff967ea6df2528
Call Trace:
[<ffffffff938789dc>] ? __schedule+0x21c/0x680
[<ffffffff93878e76>] schedule+0x36/0x80
[<ffffffff933d1cfc>] blk_mq_freeze_queue_wait+0x3c/0x90
[<ffffffff930ecd50>] ? prepare_to_wait_event+0x110/0x110
[<ffffffff933d3bda>] blk_mq_freeze_queue+0x1a/0x20
[<ffffffff935b9631>] lo_release+0x61/0x70
[<ffffffff9328c095>] __blkdev_put+0x225/0x280
[<ffffffff9328c8fc>] blkdev_put+0x4c/0x110
[<ffffffff9328ca75>] blkdev_close+0x25/0x30
[<ffffffff93253137>] __fput+0xe7/0x220
[<ffffffff932532ae>] ____fput+0xe/0x10
[<ffffffff930c53f3>] task_work_run+0x83/0xb0
[<ffffffff930a21e7>] exit_to_usermode_loop+0x66/0x92
[<ffffffff93003a95>] do_syscall_64+0x165/0x180
[<ffffffff9387d5ab>] entry_SYSCALL64_slow_path+0x25/0x25
====

I look into the percpu-refcount code, and found a place that might
have a race that might cause this.
Consider a concurrent percpu_ref_kill and percpu_ref_tryget_live:

====
CPU A                           CPU B
-----                           -----
percpu_ref_kill()               percpu_ref_tryget_live()
{
                                if (__ref_is_percpu())
  set __PERCPU_REF_DEAD;
  __percpu_ref_switch_mode();
   ^ sum up current percpu_count
                                this_cpu_inc(*percpu_count); <- this
increment got leaked.

====

So if later CPU B later does percpu_ref_put, it will cause ref->count
to drop to -1.
And thus causing the above hung task issue.

Do you think this theory is correct, or am I missing something?
Please tell me what do you think.

Thanks,
David
