Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4A5C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E1B24010
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E1B24010
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754557AbeFVKJG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:09:06 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:56108 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754366AbeFVKJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:09:03 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 12125909-1500050 
        for multiple; Fri, 22 Jun 2018 11:08:49 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Gustavo Padovan <gustavo@padovan.org>,
        "Akhil P Oommen" <akhilpo@codeaurora.org>, sumit.semwal@linaro.org,
        jcrouse@codeaurora.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <1529661856.7034.404.camel@padovan.org>
Cc:     linux-arm-msm@vger.kernel.org, smasetty@codeaurora.org
References: <1529660407-6266-1-git-send-email-akhilpo@codeaurora.org>
 <1529661856.7034.404.camel@padovan.org>
Message-ID: <152966212844.11773.6596589902326100250@mail.alporthouse.com>
User-Agent: alot/0.3.6
Subject: Re: [PATCH v2] dma-buf/fence: Take refcount on the module that owns the fence
Date:   Fri, 22 Jun 2018 11:08:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gustavo Padovan (2018-06-22 11:04:16)
> Hi Akhil,
> 
> On Fri, 2018-06-22 at 15:10 +0530, Akhil P Oommen wrote:
> > Each fence object holds function pointers of the module that
> > initialized
> > it. Allowing the module to unload before this fence's release is
> > catastrophic. So, keep a refcount on the module until the fence is
> > released.
> > 
> > Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
> > ---
> > Changes in v2:
> > - added description for the new function parameter.
> > 
> >  drivers/dma-buf/dma-fence.c | 16 +++++++++++++---
> >  include/linux/dma-fence.h   | 10 ++++++++--
> >  2 files changed, 21 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-
> > fence.c
> > index 4edb9fd..2aaa44e 100644
> > --- a/drivers/dma-buf/dma-fence.c
> > +++ b/drivers/dma-buf/dma-fence.c
> > @@ -18,6 +18,7 @@
> >   * more details.
> >   */
> >  
> > +#include <linux/module.h>
> >  #include <linux/slab.h>
> >  #include <linux/export.h>
> >  #include <linux/atomic.h>
> > @@ -168,6 +169,7 @@ void dma_fence_release(struct kref *kref)
> >  {
> >       struct dma_fence *fence =
> >               container_of(kref, struct dma_fence, refcount);
> > +     struct module *module = fence->owner;
> >  
> >       trace_dma_fence_destroy(fence);
> >  
> > @@ -178,6 +180,8 @@ void dma_fence_release(struct kref *kref)
> >               fence->ops->release(fence);
> >       else
> >               dma_fence_free(fence);
> > +
> > +     module_put(module);
> >  }
> >  EXPORT_SYMBOL(dma_fence_release);
> >  
> > @@ -541,6 +545,7 @@ struct default_wait_cb {
> >  
> >  /**
> >   * dma_fence_init - Initialize a custom fence.
> > + * @module:  [in]    the module that calls this API
> >   * @fence:   [in]    the fence to initialize
> >   * @ops:     [in]    the dma_fence_ops for operations on this
> > fence
> >   * @lock:    [in]    the irqsafe spinlock to use for locking
> > this fence
> > @@ -556,8 +561,9 @@ struct default_wait_cb {
> >   * to check which fence is later by simply using dma_fence_later.
> >   */
> >  void
> > -dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops
> > *ops,
> > -            spinlock_t *lock, u64 context, unsigned seqno)
> > +_dma_fence_init(struct module *module, struct dma_fence *fence,
> > +             const struct dma_fence_ops *ops, spinlock_t *lock,
> > +             u64 context, unsigned seqno)
> >  {
> >       BUG_ON(!lock);
> >       BUG_ON(!ops || !ops->wait || !ops->enable_signaling ||
> > @@ -571,7 +577,11 @@ struct default_wait_cb {
> >       fence->seqno = seqno;
> >       fence->flags = 0UL;
> >       fence->error = 0;
> > +     fence->owner = module;
> > +
> > +     if (!try_module_get(module))
> > +             fence->owner = NULL;
> >  
> >       trace_dma_fence_init(fence);
> >  }
> > -EXPORT_SYMBOL(dma_fence_init);
> > +EXPORT_SYMBOL(_dma_fence_init);
> 
> Do we still need to export the symbol, it won't be called from outside
> anymore? Other than that looks good to me:

There's a big drawback in that a module reference is often insufficient,
and that a reference on the driver (or whatever is required for the
lifetime of the fence) will already hold the module reference.

Considering that we want a few 100k fences in flight per second, is
there no other way to only export a fence with a module reference?
-Chris
