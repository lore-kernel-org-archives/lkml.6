Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB44FC6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB5520831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB5520831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeKBJ7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 05:59:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeKBJ7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 05:59:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4CF23082AEE;
        Fri,  2 Nov 2018 00:53:55 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 021C15D961;
        Fri,  2 Nov 2018 00:53:49 +0000 (UTC)
Date:   Fri, 2 Nov 2018 08:53:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: Re: [LKP] a518560778 [ 16.132179] BUG: KASAN: null-ptr-deref in
 brd_alloc
Message-ID: <20181102005344.GD24769@ming.t460p>
References: <20181102001957.GE24195@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102001957.GE24195@shao2-debian>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 02 Nov 2018 00:53:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 08:19:57AM +0800, kernel test robot wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-linus
> 
> commit a5185607787e030fcb0009194d3b12f8bcca59d6
> Author:     Ming Lei <ming.lei@redhat.com>
> AuthorDate: Wed Oct 31 16:40:50 2018 +0800
> Commit:     Jens Axboe <axboe@kernel.dk>
> CommitDate: Wed Oct 31 08:43:09 2018 -0600
> 
>     block: brd: associate with queue until adding disk
>     
>     brd_free() may be called in failure path on one brd instance without
>     the disk being added yet, so release handler of gendisk may free the
>     associated request_queue early and cause the following use-after-free[1].
>     
>     This patch fixes this issue by associating gendisk with request_queue
>     just before adding disk.
>     
>     [1] KASAN: use-after-free Read in del_timer_syncNon-volatile memory driver v1.3
>     Linux agpgart interface v0.103
>     [drm] Initialized vgem 1.0.0 20120112 for virtual device on minor 0
>     usbcore: registered new interface driver udl
>     ==================================================================
>     BUG: KASAN: use-after-free in __lock_acquire+0x36d9/0x4c20
>     kernel/locking/lockdep.c:3218
>     Read of size 8 at addr ffff8801d1b6b540 by task swapper/0/1
>     
>     CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0+ #88
>     Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>     Google 01/01/2011
>     Call Trace:
>       __dump_stack lib/dump_stack.c:77 [inline]
>       dump_stack+0x244/0x39d lib/dump_stack.c:113
>       print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
>       kasan_report_error mm/kasan/report.c:354 [inline]
>       kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
>       __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>       __lock_acquire+0x36d9/0x4c20 kernel/locking/lockdep.c:3218
>       lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
>       del_timer_sync+0xb7/0x270 kernel/time/timer.c:1283
>       blk_cleanup_queue+0x413/0x710 block/blk-core.c:809
>       brd_free+0x5d/0x71 drivers/block/brd.c:422
>       brd_init+0x2eb/0x393 drivers/block/brd.c:518
>       do_one_initcall+0x145/0x957 init/main.c:890
>       do_initcall_level init/main.c:958 [inline]
>       do_initcalls init/main.c:966 [inline]
>       do_basic_setup init/main.c:984 [inline]
>       kernel_init_freeable+0x5c6/0x6b9 init/main.c:1148
>       kernel_init+0x11/0x1ae init/main.c:1068
>       ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:350
>     
>     Reported-by: syzbot+3701447012fe951dabb2@syzkaller.appspotmail.com
>     Signed-off-by: Ming Lei <ming.lei@redhat.com>
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>

Sorry, my fault.

Jens, I just sent you V2 which fixes this issue, could you drop V1 from
your for-linus and apply V2 against it?


Thanks,
Ming
