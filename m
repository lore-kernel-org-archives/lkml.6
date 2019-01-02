Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F991C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6300A218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfABOkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 09:40:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:52760 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726855AbfABOkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 09:40:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0CEB3ACB1;
        Wed,  2 Jan 2019 14:40:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 215BE1E1588; Wed,  2 Jan 2019 15:40:15 +0100 (CET)
Date:   Wed, 2 Jan 2019 15:40:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+9933e4476f365f5d5a1b@syzkaller.appspotmail.com>,
        linux-mm@kvack.org, mgorman@techsingularity.net,
        Michal Hocko <mhocko@kernel.org>, ak@linux.intel.com,
        jlayton@redhat.com, linux-kernel@vger.kernel.org,
        mawilcox@microsoft.com, syzkaller-bugs@googlegroups.com,
        tim.c.chen@linux.intel.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: INFO: task hung in generic_file_write_iter
Message-ID: <20190102144015.GA23089@quack2.suse.cz>
References: <0000000000009ce88d05714242a8@google.com>
 <4b349bff-8ad4-6410-250d-593b13d8d496@I-love.SAKURA.ne.jp>
 <9b9fcdda-c347-53ee-fdbb-8a7d11cf430e@I-love.SAKURA.ne.jp>
 <20180720130602.f3d6dc4c943558875a36cb52@linux-foundation.org>
 <a2df1f24-f649-f5d8-0b2d-66d45b6cb61f@i-love.sakura.ne.jp>
 <20180806100928.x7anab3c3y5q4ssa@quack2.suse.cz>
 <e8a23623-feaf-7730-5492-b329cb0daa21@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8a23623-feaf-7730-5492-b329cb0daa21@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 28-12-18 22:34:13, Tetsuo Handa wrote:
> On 2018/08/06 19:09, Jan Kara wrote:
> > On Tue 31-07-18 00:07:22, Tetsuo Handa wrote:
> >> On 2018/07/21 5:06, Andrew Morton wrote:
> >>> On Fri, 20 Jul 2018 19:36:23 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> >>>
> >>>>>
> >>>>> This report is stalling after mount() completed and process used remap_file_pages().
> >>>>> I think that we might need to use debug printk(). But I don't know what to examine.
> >>>>>
> >>>>
> >>>> Andrew, can you pick up this debug printk() patch?
> >>>> I guess we can get the result within one week.
> >>>
> >>> Sure, let's toss it in -next for a while.
> >>>
> >>>> >From 8f55e00b21fefffbc6abd9085ac503c52a302464 Mon Sep 17 00:00:00 2001
> >>>> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >>>> Date: Fri, 20 Jul 2018 19:29:06 +0900
> >>>> Subject: [PATCH] fs/buffer.c: add debug print for __getblk_gfp() stall problem
> >>>>
> >>>> Among syzbot's unresolved hung task reports, 18 out of 65 reports contain
> >>>> __getblk_gfp() line in the backtrace. Since there is a comment block that
> >>>> says that __getblk_gfp() will lock up the machine if try_to_free_buffers()
> >>>> attempt from grow_dev_page() is failing, let's start from checking whether
> >>>> syzbot is hitting that case. This change will be removed after the bug is
> >>>> fixed.
> >>>
> >>> I'm not sure that grow_dev_page() is hanging.  It has often been
> >>> suspected, but always is proven innocent.  Lets see.
> >>
> >> syzbot reproduced this problem ( https://syzkaller.appspot.com/text?tag=CrashLog&x=11f2fc44400000 ) .
> >> It says that grow_dev_page() is returning 1 but __find_get_block() is failing forever. Any idea?
> > 
> > Looks like some kind of a race where device block size gets changed while
> > getblk() runs (and creates buffers for underlying page). I don't have time
> > to nail it down at this moment can have a look into it later unless someone
> > beats me to it.
> 
> I feel that the frequency of hitting this problem was decreased
> by merging loop module's ioctl() serialization patches. But this
> problem is still there, and syzbot got a new line in
> https://syzkaller.appspot.com/text?tag=CrashLog&x=177f889f400000 .
> 
>   [  615.881781] __loop_clr_fd: partition scan of loop5 failed (rc=-22)
>   [  619.059920] syz-executor4(2193): getblk(): executed=cd bh_count=0 bh_state=29
>   [  622.069808] syz-executor4(2193): getblk(): executed=9 bh_count=0 bh_state=0
>   [  625.080013] syz-executor4(2193): getblk(): executed=9 bh_count=0 bh_state=0
>   [  628.089900] syz-executor4(2193): getblk(): executed=9 bh_count=0 bh_state=0
> 
> I guess that loop module is somehow related to this problem.

I had a look into this and the only good explanation for this I have is
that sb->s_blocksize is different from (1 << sb->s_bdev->bd_inode->i_blkbits).
If that would happen, we'd get exactly the behavior syzkaller observes
because grow_buffers() would populate different page than
__find_get_block() then looks up.

However I don't see how that's possible since the filesystem has the block
device open exclusively and blkdev_bszset() makes sure we also have
exclusive access to the block device before changing the block device size.
So changing block device block size after filesystem gets access to the
device should be impossible. 

Anyway, could you perhaps add to your debug patch a dump of 'size' passed
to __getblk_slow() and bdev->bd_inode->i_blkbits? That should tell us
whether my theory is right or not. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
