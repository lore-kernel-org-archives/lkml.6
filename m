Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752402AbeBHTNj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 14:13:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752185AbeBHTNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 14:13:37 -0500
Date: Thu, 8 Feb 2018 21:13:36 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kurz <groug@kaod.org>
Cc: v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ron Minnich <rminnich@sandia.gov>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [V9fs-developer] [PATCH] 9p/trans_virtio: discard zero-length
 reply
Message-ID: <20180208211248-mutt-send-email-mst@kernel.org>
References: <151665492548.14372.18325892476788349632.stgit@bahia.lan>
 <20180208185232.46fca063@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208185232.46fca063@bahia.lan>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I've queued it.

On Thu, Feb 08, 2018 at 06:52:32PM +0100, Greg Kurz wrote:
> Ping ?
> 
> Michael,
> 
> Since this is virtio code and you have acked the QEMU part of the fix already,
> would you be kind enough to take this through your tree ?
> 
> Cheers,
> 
> --
> Greg
> 
> On Mon, 22 Jan 2018 22:02:05 +0100
> Greg Kurz <groug@kaod.org> wrote:
> 
> > When a 9p request is successfully flushed, the server is expected to just
> > mark it as used without sending a 9p reply (ie, without writing data into
> > the buffer). In this case, virtqueue_get_buf() will return len == 0 and
> > we must not report a REQ_STATUS_RCVD status to the client, otherwise the
> > client will erroneously assume the request has not been flushed.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  net/9p/trans_virtio.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> > index 0845aad4ba51..ca08c72ef4de 100644
> > --- a/net/9p/trans_virtio.c
> > +++ b/net/9p/trans_virtio.c
> > @@ -171,7 +171,8 @@ static void req_done(struct virtqueue *vq)
> >  		spin_unlock_irqrestore(&chan->lock, flags);
> >  		/* Wakeup if anyone waiting for VirtIO ring space. */
> >  		wake_up(chan->vc_wq);
> > -		p9_client_cb(chan->client, req, REQ_STATUS_RCVD);
> > +		if (len)
> > +			p9_client_cb(chan->client, req, REQ_STATUS_RCVD);
> >  	}
> >  }
> >  
> > 
> > 
> > ------------------------------------------------------------------------------
> > Check out the vibrant tech community on one of the world's most
> > engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> > _______________________________________________
> > V9fs-developer mailing list
> > V9fs-developer@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/v9fs-developer
