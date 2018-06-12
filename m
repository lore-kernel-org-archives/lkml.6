Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 31862C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFB6208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAFB6208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934291AbeFLP57 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:57:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:52926 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933439AbeFLP55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:57:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5840CAF94;
        Tue, 12 Jun 2018 15:57:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 74E511E0516; Tue, 12 Jun 2018 17:57:54 +0200 (CEST)
Date:   Tue, 12 Jun 2018 17:57:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
Message-ID: <20180612155754.x5k2yndh5t6wlmpy@quack2.suse.cz>
References: <CACT4Y+Y7Mj1JngLst1aRHDhURXQMn-eTjyPFjDdGAT0ZV-dHrw@mail.gmail.com>
 <CACT4Y+bBfwpcP2h0URpqwiNMQ5SFJdPDHThUu2xetmrxgC+3BQ@mail.gmail.com>
 <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
 <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
 <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
 <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
 <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz>
 <20180611160131.GQ1351649@devbig577.frc2.facebook.com>
 <20180611162920.mwapvuqotvhkntt3@quack2.suse.cz>
 <20180611172053.GR1351649@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611172053.GR1351649@devbig577.frc2.facebook.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11-06-18 10:20:53, Tejun Heo wrote:
> Hello,
> 
> On Mon, Jun 11, 2018 at 06:29:20PM +0200, Jan Kara wrote:
> > > Would something like the following work or am I missing the point
> > > entirely?
> > 
> > I was pondering the same solution for a while but I think it won't work.
> > The problem is that e.g. wb_memcg_offline() could have already removed
> > wb from the radix tree but it is still pending in bdi->wb_list
> > (wb_shutdown() has not run yet) and so we'd drop reference we didn't get.
> 
> Yeah, right, so the root cause is that we're walking the wb_list while
> holding lock and expecting the object to stay there even after lock is
> released.  Hmm... we can use a mutex to synchronize the two
> destruction paths.  It's not like they're hot paths anyway.

Hmm, do you mean like having a per-bdi or even a global mutex that would
protect whole wb_shutdown()? Yes, that should work and we could get rid of
WB_shutting_down bit as well with that. Just it seems a bit strange to
introduce a mutex only to synchronize these two shutdown paths - usually
locks protect data structures and in this case we have cgwb_lock for
that so it looks like a duplication from a first look.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
