Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754538AbeBGPwp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:52:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:59346 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754377AbeBGPwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:52:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,473,1511856000";
   d="scan'208";a="199409973"
Date: Wed, 7 Feb 2018 07:52:29 -0800
From: Andi Kleen <ak@linux.intel.com>
To: syzbot <syzbot+283c3c447181741aea28@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, aryabinin@virtuozzo.com, jack@suse.cz,
        jlayton@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, mingo@kernel.org, rgoldwyn@suse.com,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org
Subject: Re: INFO: task hung in sync_blockdev
Message-ID: <20180207155229.GC10945@tassilo.jf.intel.com>
References: <001a11447070ac6fcb0564a08cb1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a11447070ac6fcb0564a08cb1@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  #0:  (&bdev->bd_mutex){+.+.}, at: [<0000000040269370>]
> __blkdev_put+0xbc/0x7f0 fs/block_dev.c:1757
> 1 lock held by blkid/19199:
>  #0:  (&bdev->bd_mutex){+.+.}, at: [<00000000b4dcaa18>]
> __blkdev_get+0x158/0x10e0 fs/block_dev.c:1439
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<0000000033edf9f2>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 1 lock held by syz-executor5/19330:
>  #0:  (&bdev->bd_mutex){+.+.}, at: [<00000000b4dcaa18>]
> __blkdev_get+0x158/0x10e0 fs/block_dev.c:1439
> 1 lock held by syz-executor5/19331:
>  #0:  (&bdev->bd_mutex){+.+.}, at: [<00000000b4dcaa18>]
> __blkdev_get+0x158/0x10e0 fs/block_dev.c:1439

It seems multiple processes deadlocked on the bd_mutex. 
Unfortunately there's no backtrace for the lock acquisitions,
so it's hard to see the exact sequence.

It seems lockdep is already active, so it's likely not
just an ordering violation, but something else.

-Andi
