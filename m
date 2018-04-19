Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753503AbeDSRqT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 13:46:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752924AbeDSRqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 13:46:18 -0400
Date: Thu, 19 Apr 2018 20:46:17 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio_ring: switch to dma_XX barriers for rpmsg
Message-ID: <20180419204017-mutt-send-email-mst@kernel.org>
References: <1524159181-351878-1-git-send-email-mst@redhat.com>
 <5047d08c-9f9e-2902-d425-1fac849ce5b4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5047d08c-9f9e-2902-d425-1fac849ce5b4@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 07:39:21PM +0200, Paolo Bonzini wrote:
> On 19/04/2018 19:35, Michael S. Tsirkin wrote:
> > virtio is using barriers to order memory accesses, thus
> > dma_wmb/rmb is a good match.
> > 
> > Build-tested on x86: Before
> > 
> > [mst@tuck linux]$ size drivers/virtio/virtio_ring.o
> >    text    data     bss     dec     hex filename
> >   11392     820       0   12212    2fb4 drivers/virtio/virtio_ring.o
> > 
> > After
> > mst@tuck linux]$ size drivers/virtio/virtio_ring.o
> >    text    data     bss     dec     hex filename
> >   11284     820       0   12104    2f48 drivers/virtio/virtio_ring.o
> > 
> > Cc: Ohad Ben-Cohen <ohad@wizery.com>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: linux-remoteproc@vger.kernel.org
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > It's good in theory, but could one of RPMSG maintainers please review
> > and ack this patch? Or even better test it?
> > 
> > All these barriers are useless on Intel anyway ...
> 
> This should be okay, but I wonder if there should be a virtio_wmb(...)
> or an "if (weak_barriers) wmb()" before the "writel" in vm_notify
> (drivers/virtio/virtio_mmio.c).
> 
> Thanks,
> 
> Paolo

That one uses weak barriers AFAIK.

IIUC you mean rproc_virtio_notify.

I suspect it works because specific kick callbacks have a barrier internally.


> > 
> >  include/linux/virtio_ring.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> > index bbf3252..fab0213 100644
> > --- a/include/linux/virtio_ring.h
> > +++ b/include/linux/virtio_ring.h
> > @@ -35,7 +35,7 @@ static inline void virtio_rmb(bool weak_barriers)
> >  	if (weak_barriers)
> >  		virt_rmb();
> >  	else
> > -		rmb();
> > +		dma_rmb();
> >  }
> >  
> >  static inline void virtio_wmb(bool weak_barriers)
> > @@ -43,7 +43,7 @@ static inline void virtio_wmb(bool weak_barriers)
> >  	if (weak_barriers)
> >  		virt_wmb();
> >  	else
> > -		wmb();
> > +		dma_wmb();
> >  }
> >  
> >  static inline void virtio_store_mb(bool weak_barriers,
> > 
