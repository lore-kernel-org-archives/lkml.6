Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeBHN2e (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:28:34 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:45749 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752010AbeBHN23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:28:29 -0500
X-Google-Smtp-Source: AH8x226jyagcahjttizZS/cWsCfVOYA6avZuwGFJcSXfj5d3Vu99icTXqpiQjS9r+Rpb9vJcnFxhguLfttvNATSiiAk=
MIME-Version: 1.0
In-Reply-To: <20180208092839.ebe5rk6mtvkk5da4@quack2.suse.cz>
References: <001a11447070ac6fcb0564a08cb1@google.com> <20180207155229.GC10945@tassilo.jf.intel.com>
 <20180208092839.ebe5rk6mtvkk5da4@quack2.suse.cz>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 8 Feb 2018 14:28:08 +0100
Message-ID: <CACT4Y+ZTNDhEhAAP2PYRH5WxEeEM0xHdp4UKqtNaWhU6w4sj_g@mail.gmail.com>
Subject: Re: INFO: task hung in sync_blockdev
To: Jan Kara <jack@suse.cz>
Cc: Andi Kleen <ak@linux.intel.com>,
        syzbot <syzbot+283c3c447181741aea28@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, jlayton@redhat.com,
        LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>, rgoldwyn@suse.com,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 8, 2018 at 10:28 AM, Jan Kara <jack@suse.cz> wrote:
> On Wed 07-02-18 07:52:29, Andi Kleen wrote:
>> >  #0:  (&bdev->bd_mutex){+.+.}, at: [<0000000040269370>]
>> > __blkdev_put+0xbc/0x7f0 fs/block_dev.c:1757
>> > 1 lock held by blkid/19199:
>> >  #0:  (&bdev->bd_mutex){+.+.}, at: [<00000000b4dcaa18>]
>> > __blkdev_get+0x158/0x10e0 fs/block_dev.c:1439
>> >  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<0000000033edf9f2>]
>> > n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
>> > 1 lock held by syz-executor5/19330:
>> >  #0:  (&bdev->bd_mutex){+.+.}, at: [<00000000b4dcaa18>]
>> > __blkdev_get+0x158/0x10e0 fs/block_dev.c:1439
>> > 1 lock held by syz-executor5/19331:
>> >  #0:  (&bdev->bd_mutex){+.+.}, at: [<00000000b4dcaa18>]
>> > __blkdev_get+0x158/0x10e0 fs/block_dev.c:1439
>>
>> It seems multiple processes deadlocked on the bd_mutex.
>> Unfortunately there's no backtrace for the lock acquisitions,
>> so it's hard to see the exact sequence.
>
> Well, all in the report points to a situation where some IO was submitted
> to the block device and never completed (more exactly it took longer than
> those 120s to complete that IO). It would need more digging into the
> syzkaller program to find out what kind of device that was and possibly why
> the IO took so long to complete...


Would a traceback of all task stacks help in this case?
What I've seen in several "task hung" reports is that the CPU
traceback is not showing anything useful. So perhaps it should be
changed to task traceback? Or it would not help either?
