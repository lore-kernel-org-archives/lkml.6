Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755601AbeEaQHQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:07:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755456AbeEaQHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:07:15 -0400
Date: Thu, 31 May 2018 12:07:12 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Alasdair Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] dm writecache: fix return value check in
 writecache_ctr()
Message-ID: <20180531160711.GB11300@redhat.com>
References: <1527767595-76082-1-git-send-email-weiyongjun1@huawei.com>
 <20180531160202.GA11300@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531160202.GA11300@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31 2018 at 12:02pm -0400,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Thu, May 31 2018 at  7:53am -0400,
> Wei Yongjun <weiyongjun1@huawei.com> wrote:
> 
> > Function dm_io_client_create() and dm_kcopyd_client_create() return
> > ERR_PTR() not NULL in case of error. The NULL test in the return value
> > check should be replaced with IS_ERR()
> > 
> > Fixes: 2105231db61b ("dm: add writecache target")
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > ---
> >  drivers/md/dm-writecache.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> > index 844c4fb..0b2b436 100644
> > --- a/drivers/md/dm-writecache.c
> > +++ b/drivers/md/dm-writecache.c
> > @@ -1872,9 +1872,10 @@ static int writecache_ctr(struct dm_target *ti, unsigned argc, char **argv)
> >  	}
> >  
> >  	wc->dm_io = dm_io_client_create();
> > -	if (!wc->dm_io) {
> > -		r = -ENOMEM;
> > +	if (IS_ERR(wc->dm_io)) {
> > +		r = PTR_ERR(wc->dm_io);
> >  		ti->error = "Unable to allocate dm-io client";
> > +		wc->dm_io = NULL;
> >  		goto bad;
> >  	}
> >  
> > @@ -2096,9 +2097,10 @@ static int writecache_ctr(struct dm_target *ti, unsigned argc, char **argv)
> >  		}
> >  
> >  		wc->dm_kcopyd = dm_kcopyd_client_create(&dm_kcopyd_throttle);
> > -		if (!wc->dm_kcopyd) {
> > -			r = -ENOMEM;
> > +		if (IS_ERR(wc->dm_kcopyd)) {
> > +			r = PTR_ERR(wc->dm_kcopyd);
> >  			ti->error = "Unable to allocate dm-kcopyd client";
> > +			wc->dm_kcopyd = NULL;
> >  			goto bad;
> >  		}
> > 
> 
> 
> Yes, I forgot to pull this in.. it got lost in the shuffle.  Mikulas had
> provided this same change (folded into a larger patch) yesterday, see:
> https://patchwork.kernel.org/patch/10439345/
> 
> I'll get this folded in ASAP.

Turns out I already did fold it in.  My push to linux-next just missed
today's tree.

So already taken care of.

Thanks for sending the patch though.

Mike
