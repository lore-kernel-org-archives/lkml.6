Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95284ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 22:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4697B21473
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 22:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4697B21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbeIXECS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 00:02:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59296 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725741AbeIXECS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 00:02:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 045A4C057F9F;
        Sun, 23 Sep 2018 22:03:13 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F7768BE1C;
        Sun, 23 Sep 2018 22:03:06 +0000 (UTC)
Date:   Mon, 24 Sep 2018 06:03:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        syzbot 
        <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>,
        syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>
Subject: Re: [PATCH v3 (resend)] block/loop: Serialize ioctl operations.
Message-ID: <20180923220300.GA12589@ming.t460p>
References: <1537009136-4839-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1af79300-cb04-36e3-a650-168a5942161f@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1af79300-cb04-36e3-a650-168a5942161f@i-love.sakura.ne.jp>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sun, 23 Sep 2018 22:03:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 09:39:02PM +0900, Tetsuo Handa wrote:
> Hello, Ming Lei.
> 
> I'd like to hear your comment on this patch regarding the ordering of
> stopping kernel thread.
> 
>   > In order to enforce this strategy, this patch inversed
>   > loop_reread_partitions() and loop_unprepare_queue() in loop_clr_fd().
>   > I don't know whether it breaks something, but I don't have testcases.
> 
> Until 3.19, kthread_stop(lo->lo_thread) was called before
> ioctl_by_bdev(bdev, BLKRRPART, 0) is called.
> During 4.0 to 4.3, the loop module was using "kloopd" workqueue.
> But since 4.4, loop_reread_partitions(lo, bdev) is called before
> loop_unprepare_queue(lo) is called. And this patch is trying to change to
> call loop_unprepare_queue() before loop_reread_partitions() is called.
> Is there some reason we need to preserve current ordering?

IMO, both the two orders are fine, and what matters is that 'lo->lo_state'
is updated before loop_reread_partitions(), then any IO from loop_reread_partitions
will be failed, so it shouldn't be a big deal wrt. the order between
loop_reread_partitions() and loop_unprepare_queue().

Thanks,
Ming
