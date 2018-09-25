Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47210C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB0D2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB0D2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbeIYOMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 10:12:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:46360 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726320AbeIYOMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 10:12:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 19D50B0F6;
        Tue, 25 Sep 2018 08:06:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 724791E3615; Tue, 25 Sep 2018 10:06:22 +0200 (CEST)
Date:   Tue, 25 Sep 2018 10:06:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        syzbot 
        <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>,
        syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>
Subject: Re: [PATCH v4] block/loop: Serialize ioctl operations.
Message-ID: <20180925080622.GA6567@quack2.suse.cz>
References: <1537009136-4839-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1af79300-cb04-36e3-a650-168a5942161f@i-love.sakura.ne.jp>
 <20180923220300.GA12589@ming.t460p>
 <ba535251-c206-6242-3e6d-a4ed825c8114@i-love.sakura.ne.jp>
 <20180924184734.GH28775@quack2.suse.cz>
 <70de0609-c9f5-1747-93dc-fc4d693f1c27@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70de0609-c9f5-1747-93dc-fc4d693f1c27@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25-09-18 06:06:56, Tetsuo Handa wrote:
> On 2018/09/25 3:47, Jan Kara wrote:
> >> +/*
> >> + * unlock_loop - Unlock loop_mutex as needed.
> >> + *
> >> + * Explicitly call this function before calling fput() or blkdev_reread_part()
> >> + * in order to avoid circular lock dependency. After this function is called,
> >> + * current thread is no longer allowed to access "struct loop_device" memory,
> >> + * for another thread would access that memory as soon as loop_mutex is held.
> >> + */
> >> +static void unlock_loop(void)
> >> +{
> >> +	if (loop_mutex_owner == current) {
> > 
> > Urgh, why this check? Conditional locking / unlocking is evil so it has to
> > have *very* good reasons and there is not any explanation here. So far I
> > don't see a reason why this is needed at all.
> 
> Yeah, this is why Jens hates this patch. But any alternative?

So can you explain why this conditional locking is really necessary?

> >> @@ -630,7 +669,12 @@ static void loop_reread_partitions(struct loop_device *lo,
> >> +	unlock_loop();
> > 
> > Unlocking in loop_reread_partitions() makes the locking rules ugly. And
> > unnecessarily AFAICT. Can't we just use lo_refcnt to protect us against
> > loop_clr_fd() and freeing of 'lo' structure itself?
> 
> Really? I think that just elevating lo->lo_refcnt will cause another lockdep
> warning because __blkdev_reread_part() requires bdev->bd_mutex being held.
> Don't we need to drop the lock in order to solve original lockdep warning at [2] ?

Yes, you have to drop the lo_ctl_mutex before calling
loop_reread_partitions(). But AFAICS all places calling loop_reread_part()
are called from ioctl where we are sure the device is open and thus
lo_refcnt is > 0. So in these places calling loop_reread_partitions()
without lo_ctl_mutex should be fine. The only exception is lo_clr_fd() that
can get called from __lo_release() - and I think we can protect that case
against LOOP_CTL_REMOVE (it cannot really race with anything else) by
keeping lo_state at Lo_rundown until after loop_reread_partitions() has
finished.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
