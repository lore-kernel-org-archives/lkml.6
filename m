Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id x+5qA16jHlvRUwAAmS7hNA
	; Mon, 11 Jun 2018 16:29:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D8E2E607BB; Mon, 11 Jun 2018 16:29:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 643A560541;
	Mon, 11 Jun 2018 16:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 643A560541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933564AbeFKQ30 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 12:29:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:47729 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932363AbeFKQ3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 12:29:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 543A2ACF0;
        Mon, 11 Jun 2018 16:29:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 25EE51E04CC; Mon, 11 Jun 2018 18:29:20 +0200 (CEST)
Date: Mon, 11 Jun 2018 18:29:20 +0200
From: Jan Kara <jack@suse.cz>
To: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
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
Message-ID: <20180611162920.mwapvuqotvhkntt3@quack2.suse.cz>
References: <CACT4Y+byRRtCA9B9bPG9mjrf3UY3OsGeBsoh8dZ0T+V6tKpTHg@mail.gmail.com>
 <201806080231.w582VIRn021009@www262.sakura.ne.jp>
 <CACT4Y+Y7Mj1JngLst1aRHDhURXQMn-eTjyPFjDdGAT0ZV-dHrw@mail.gmail.com>
 <CACT4Y+bBfwpcP2h0URpqwiNMQ5SFJdPDHThUu2xetmrxgC+3BQ@mail.gmail.com>
 <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
 <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
 <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
 <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
 <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz>
 <20180611160131.GQ1351649@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611160131.GQ1351649@devbig577.frc2.facebook.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11-06-18 09:01:31, Tejun Heo wrote:
> Hello,
> 
> On Mon, Jun 11, 2018 at 11:12:48AM +0200, Jan Kara wrote:
> > However this is wrong and so is the patch. The problem is in
> > cgwb_bdi_unregister() which does cgwb_kill() and thus drops bdi's
> > reference to wb structures before going through the list of wbs again and
> > calling wb_shutdown() on each of them. The writeback structures we are
> > accessing at this point can be already freed in principle like:
> > 
> > CPU1				CPU2
> > 				cgwb_bdi_unregister()
> > 				  cgwb_kill(*slot);
> > 
> > cgwb_release()
> >   queue_work(cgwb_release_wq, &wb->release_work);
> > cgwb_release_workfn()
> > 				  wb = list_first_entry(&bdi->wb_list, ...)
> > 				  spin_unlock_irq(&cgwb_lock);
> >   wb_shutdown(wb);
> >   ...				
> >   kfree_rcu(wb, rcu);
> > 				  wb_shutdown(wb); -> oops use-after-free
> > 
> > I'm not 100% sure how to fix this. wb structures can be at various phases of
> > shutdown (or there may be other external references still existing) when we
> > enter cgwb_bdi_unregister() so I think adding a way for cgwb_bdi_unregister()
> > to wait for standard wb shutdown path to finish is the most robust way.
> > What do you think about attached patch Tejun? So far only compile tested...
> > 
> > Possible problem with it is that now cgwb_bdi_unregister() will wait for
> > all wb references to be dropped so it adds some implicit dependencies to
> > bdi shutdown path. 
> 
> Would something like the following work or am I missing the point
> entirely?

I was pondering the same solution for a while but I think it won't work.
The problem is that e.g. wb_memcg_offline() could have already removed
wb from the radix tree but it is still pending in bdi->wb_list
(wb_shutdown() has not run yet) and so we'd drop reference we didn't get.

								Honza
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 347cc83..359cacd 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -715,14 +715,19 @@ static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
>  	WARN_ON(test_bit(WB_registered, &bdi->wb.state));
>  
>  	spin_lock_irq(&cgwb_lock);
> -	radix_tree_for_each_slot(slot, &bdi->cgwb_tree, &iter, 0)
> -		cgwb_kill(*slot);
> +	radix_tree_for_each_slot(slot, &bdi->cgwb_tree, &iter, 0) {
> +		struct bdi_writeback *wb = *slot;
> +
> +		wb_get(wb);
> +		cgwb_kill(wb);
> +	}
>  
>  	while (!list_empty(&bdi->wb_list)) {
>  		wb = list_first_entry(&bdi->wb_list, struct bdi_writeback,
>  				      bdi_node);
>  		spin_unlock_irq(&cgwb_lock);
>  		wb_shutdown(wb);
> +		wb_put(wb);
>  		spin_lock_irq(&cgwb_lock);
>  	}
>  	spin_unlock_irq(&cgwb_lock);
> 
> 
> -- 
> tejun
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
