Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09292C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAD125562
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cbuWjKIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACAD125562
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753183AbeFYHvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:51:17 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38929 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeFYHvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:51:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id w14-v6so4774075eds.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 00:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q7PEhcD724tyDk8zGnmBVTS+MMusqUwdhdsShWcsGiA=;
        b=cbuWjKIYw+F8frHVY/nerZTIt7/dwAqo2Gz6mKHXlorH1a7+EEddvz4qVyF/6C1oQA
         rDr6rDe/CVC86/pTggca5O9ZCsHXL5Zj1ObwUowO3WDi2BIlsEtVYmmjQaMe8otEzAPW
         RzaiMV4cBW1BtSJZsjAgz0g9CEeef7dKK4yNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Q7PEhcD724tyDk8zGnmBVTS+MMusqUwdhdsShWcsGiA=;
        b=gUfMprUFh+yxXn7J6GmoDam812Qev1GFnTzNaudKKQHnt4nMqq0dZbzkVAjC/hvaJo
         xzLmDN5xxQU/F9BJiEUok/18/ErNVZOxDsLYqzJAsTIwChBa8OJbCNuI7g4erg3Qo7PI
         E/jZzwqlAInHgG1Vv7x6URAcUx2tuUYnFAT045PAanGPUSvuTOD3Wz+Qor6sNN+9fdq7
         FNhNK/VhG701OgIFwi6NelfCyX2TsXaW8a4NlUuOAXr3nmOV7olxJrwmks4A/Gar7QwX
         EWeX0W8X7Es9EY3lSijdzB8f3NlL8A6lLOZyJ+wQVLl41nnYBKJrIP7rGlxoNMHvKROF
         4wXQ==
X-Gm-Message-State: APt69E17yKkt2mIuT8Dlvw99lmy2FBA07hZiHgpnrf6vXEfUf5uIaK6Z
        2C9yrsz2VkiiOMPtuYUqqVdmng==
X-Google-Smtp-Source: ADUXVKIG9i9CiPR0+Rsw3PYyvwI8SDzLAmhJF2YTGqoq6uXyIPJqpPiqUx570FENQuV0CnQGo2Q2AA==
X-Received: by 2002:a50:992a:: with SMTP id k39-v6mr10340019edb.45.1529913073167;
        Mon, 25 Jun 2018 00:51:13 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-109.fiber7.init7.net. [212.51.149.109])
        by smtp.gmail.com with ESMTPSA id x11-v6sm9766803edb.39.2018.06.25.00.51.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 00:51:12 -0700 (PDT)
Date:   Mon, 25 Jun 2018 09:50:40 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        sumit.semwal@linaro.org, jcrouse@codeaurora.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, smasetty@codeaurora.org
Subject: Re: [PATCH v2] dma-buf/fence: Take refcount on the module that owns
 the fence
Message-ID: <20180625075040.GK2958@phenom.ffwll.local>
Mail-Followup-To: Chris Wilson <chris@chris-wilson.co.uk>,
        Gustavo Padovan <gustavo@padovan.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>, sumit.semwal@linaro.org,
        jcrouse@codeaurora.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        smasetty@codeaurora.org
References: <1529660407-6266-1-git-send-email-akhilpo@codeaurora.org>
 <1529661856.7034.404.camel@padovan.org>
 <152966212844.11773.6596589902326100250@mail.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152966212844.11773.6596589902326100250@mail.alporthouse.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 11:08:48AM +0100, Chris Wilson wrote:
> Quoting Gustavo Padovan (2018-06-22 11:04:16)
> > Hi Akhil,
> > 
> > On Fri, 2018-06-22 at 15:10 +0530, Akhil P Oommen wrote:
> > > Each fence object holds function pointers of the module that
> > > initialized
> > > it. Allowing the module to unload before this fence's release is
> > > catastrophic. So, keep a refcount on the module until the fence is
> > > released.
> > > 
> > > Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
> > > ---
> > > Changes in v2:
> > > - added description for the new function parameter.
> > > 
> > >  drivers/dma-buf/dma-fence.c | 16 +++++++++++++---
> > >  include/linux/dma-fence.h   | 10 ++++++++--
> > >  2 files changed, 21 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-
> > > fence.c
> > > index 4edb9fd..2aaa44e 100644
> > > --- a/drivers/dma-buf/dma-fence.c
> > > +++ b/drivers/dma-buf/dma-fence.c
> > > @@ -18,6 +18,7 @@
> > >   * more details.
> > >   */
> > >  
> > > +#include <linux/module.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/export.h>
> > >  #include <linux/atomic.h>
> > > @@ -168,6 +169,7 @@ void dma_fence_release(struct kref *kref)
> > >  {
> > >       struct dma_fence *fence =
> > >               container_of(kref, struct dma_fence, refcount);
> > > +     struct module *module = fence->owner;
> > >  
> > >       trace_dma_fence_destroy(fence);
> > >  
> > > @@ -178,6 +180,8 @@ void dma_fence_release(struct kref *kref)
> > >               fence->ops->release(fence);
> > >       else
> > >               dma_fence_free(fence);
> > > +
> > > +     module_put(module);
> > >  }
> > >  EXPORT_SYMBOL(dma_fence_release);
> > >  
> > > @@ -541,6 +545,7 @@ struct default_wait_cb {
> > >  
> > >  /**
> > >   * dma_fence_init - Initialize a custom fence.
> > > + * @module:  [in]    the module that calls this API
> > >   * @fence:   [in]    the fence to initialize
> > >   * @ops:     [in]    the dma_fence_ops for operations on this
> > > fence
> > >   * @lock:    [in]    the irqsafe spinlock to use for locking
> > > this fence
> > > @@ -556,8 +561,9 @@ struct default_wait_cb {
> > >   * to check which fence is later by simply using dma_fence_later.
> > >   */
> > >  void
> > > -dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops
> > > *ops,
> > > -            spinlock_t *lock, u64 context, unsigned seqno)
> > > +_dma_fence_init(struct module *module, struct dma_fence *fence,
> > > +             const struct dma_fence_ops *ops, spinlock_t *lock,
> > > +             u64 context, unsigned seqno)
> > >  {
> > >       BUG_ON(!lock);
> > >       BUG_ON(!ops || !ops->wait || !ops->enable_signaling ||
> > > @@ -571,7 +577,11 @@ struct default_wait_cb {
> > >       fence->seqno = seqno;
> > >       fence->flags = 0UL;
> > >       fence->error = 0;
> > > +     fence->owner = module;
> > > +
> > > +     if (!try_module_get(module))
> > > +             fence->owner = NULL;
> > >  
> > >       trace_dma_fence_init(fence);
> > >  }
> > > -EXPORT_SYMBOL(dma_fence_init);
> > > +EXPORT_SYMBOL(_dma_fence_init);
> > 
> > Do we still need to export the symbol, it won't be called from outside
> > anymore? Other than that looks good to me:
> 
> There's a big drawback in that a module reference is often insufficient,
> and that a reference on the driver (or whatever is required for the
> lifetime of the fence) will already hold the module reference.
> 
> Considering that we want a few 100k fences in flight per second, is
> there no other way to only export a fence with a module reference?

We'd need to make the timeline a full-blown object (Maarten owes me one
for that design screw-up), and then we could stuff all these things in
there.

And I think that's the right fix, since try_module_get for every
dma_fence_init just ain't cool really :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
