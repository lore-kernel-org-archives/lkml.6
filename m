Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeEBKas (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 06:30:48 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:30912 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbeEBKap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 06:30:45 -0400
To: dvyukov@google.com
Cc: ebiggers3@gmail.com,
        syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in blkdev_reread_part
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <CACT4Y+bGjnajib6P4a0SxYkNUJpg_x8abEkec8AR+oBmC=-QUQ@mail.gmail.com>
        <20171105201834.GA8126@zzz.localdomain>
        <201804162302.GBI43737.OLFSOFQHVJMFtO@I-love.SAKURA.ne.jp>
        <201804202306.FGC05220.OOJFMFOSFHtLQV@I-love.SAKURA.ne.jp>
        <CACT4Y+Y3M2kB0YWhwD04NkL1-iNHPuDfDDf9BLoPD3GZ6Gg-Yw@mail.gmail.com>
In-Reply-To: <CACT4Y+Y3M2kB0YWhwD04NkL1-iNHPuDfDDf9BLoPD3GZ6Gg-Yw@mail.gmail.com>
Message-Id: <201805021930.CBE82399.QFHtOOJFMVFOSL@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Wed, 2 May 2018 19:30:33 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote:
> > syzbot is reporting various bugs which involve /dev/loopX.
> > Two of them
> >
> >   INFO: rcu detected stall in lo_ioctl
> >   https://syzkaller.appspot.com/bug?id=7b49fb610af9cca78c24e9f796f2e8b0d5573997
> >
> >   general protection fault in lo_ioctl (2)
> >   https://syzkaller.appspot.com/bug?id=f3cfe26e785d85f9ee259f385515291d21bd80a3
> 
> /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
> 
> Now there is a repro for this one. I've pushed it to kernel mailing lists:
> 
> https://groups.google.com/d/msg/syzkaller-bugs/c8KUcTAzTvA/3o_7g6-tAwAJ

OK, thanks. But among loop related reports, this will be a dup of
"INFO: rcu detected stall in blkdev_ioctl" which already has C reproducer.
Should we merge them?

  INFO: rcu detected stall in blkdev_ioctl
  https://syzkaller.appspot.com/bug?id=1f7b710f4110f225aed1f4263ec2b98b8dbd472e

  general protection fault in lo_ioctl (2)
  https://syzkaller.appspot.com/bug?id=f3cfe26e785d85f9ee259f385515291d21bd80a3
  #syz dup: INFO: rcu detected stall in blkdev_ioctl

  INFO: rcu detected stall in lo_compat_ioctl
  https://syzkaller.appspot.com/bug?id=6299555c4e252b53f7a2ae2b8216cc9456c56ac0
  #syz dup: INFO: rcu detected stall in blkdev_ioctl

  INFO: rcu detected stall in lo_ioctl
  https://syzkaller.appspot.com/bug?id=7b49fb610af9cca78c24e9f796f2e8b0d5573997
  #syz dup: INFO: rcu detected stall in blkdev_ioctl

  INFO: task hung in lo_ioctl
  https://syzkaller.appspot.com/bug?id=608144371e7fc2cb6285b9ed871fb1eb817a61ce

  INFO: task hung in lo_open (2)
  https://syzkaller.appspot.com/bug?id=1f93b57f496d969efb9fb24167f6f9de5ee068fd

  possible deadlock in blkdev_reread_part
  https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d15889

  INFO: task hung in loop_control_ioctl
  https://syzkaller.appspot.com/bug?id=61fe32c77ea00412c5149bd34649a65b7f672b5e

  WARNING in sysfs_remove_group
  https://syzkaller.appspot.com/bug?id=3f86c0edf75c86d2633aeb9dd69eccc70bc7e90b

> 
> > suggest that loop module is not thread safe. The former suggests that
> > l->lo_backing_file is forming circular loop and the latter suggests that
> > l->lo_backing_file became NULL.
