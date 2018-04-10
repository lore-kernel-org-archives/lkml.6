Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753989AbeDJN14 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:27:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752584AbeDJN1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:27:54 -0400
Date: Tue, 10 Apr 2018 16:27:51 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
        syzkaller-bugs@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/2] vhost: fix vhost_vq_access_ok() log check
Message-ID: <20180410162522-mutt-send-email-mst@kernel.org>
References: <20180410052630.11270-1-stefanha@redhat.com>
 <20180410052630.11270-2-stefanha@redhat.com>
 <20180410161905-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410161905-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 04:22:35PM +0300, Michael S. Tsirkin wrote:
> On Tue, Apr 10, 2018 at 01:26:29PM +0800, Stefan Hajnoczi wrote:
> > Commit d65026c6c62e7d9616c8ceb5a53b68bcdc050525 ("vhost: validate log
> > when IOTLB is enabled") introduced a regression.  The logic was
> > originally:
> > 
> >   if (vq->iotlb)
> >       return 1;
> >   return A && B;
> > 
> > After the patch the short-circuit logic for A was inverted:
> > 
> >   if (A || vq->iotlb)
> >       return A;
> >   return B;
> > 
> > This patch fixes the regression by rewriting the checks in the obvious
> > way, no longer returning A when vq->iotlb is non-NULL (which is hard to
> > understand).
> > 
> > Reported-by: syzbot+65a84dde0214b0387ccd@syzkaller.appspotmail.com
> > Cc: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> This patch only makes sense after patch 2/2 is applied.
> Otherwise the logic seems reversed below.
> 
> Can you pls squash these two?

Oh, in fact the patch is ok. This just goes to show
that patch 2/2 is useful. But squashing is not required.
Sorry about the noise.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Fixes: d65026c6c ("vhost: validate log when IOTLB is enabled")

probably stable material since patch it fixes was queued to stable?


> > ---
> >  drivers/vhost/vhost.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 5320039671b7..93fd0c75b0d8 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -1244,10 +1244,12 @@ static int vq_log_access_ok(struct vhost_virtqueue *vq,
> >  /* Caller should have vq mutex and device mutex */
> >  int vhost_vq_access_ok(struct vhost_virtqueue *vq)
> >  {
> > -	int ret = vq_log_access_ok(vq, vq->log_base);
> > +	if (!vq_log_access_ok(vq, vq->log_base))
> > +		return 0;
> >  
> > -	if (ret || vq->iotlb)
> > -		return ret;
> > +	/* Access validation occurs at prefetch time with IOTLB */
> > +	if (vq->iotlb)
> > +		return 1;
> >  
> >  	return vq_access_ok(vq, vq->num, vq->desc, vq->avail, vq->used);
> >  }
> > -- 
> > 2.14.3
