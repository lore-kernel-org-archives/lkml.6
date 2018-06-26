Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F60C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B085E26696
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YcSG/F2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B085E26696
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932883AbeFZISO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:18:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33325 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932129AbeFZIRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:17:45 -0400
Received: by mail-ed1-f67.google.com with SMTP id l23-v6so441134edq.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 01:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=T+A1GAReIRq0Bj18T8Vv20VScdHxyNIV0LgoXcLGzg4=;
        b=YcSG/F2DbctMJAGYl3yENSgLg9Ci7vXDB8Ux5MlKKmwHaQ5Oeq9a2JyqSOLFMxy+/j
         wY41FoLjqulTfFzA80G4GuM2pmFES16fc+s0ov69xjqdu+a5YGLtMlvP5td5qWTgiR79
         z0D3WjgOZklleZ4px1Z41MY1tVIb/CCsoiSFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=T+A1GAReIRq0Bj18T8Vv20VScdHxyNIV0LgoXcLGzg4=;
        b=un9rETQX7IO3dTi0AVQMuA6zmCSuSfnaF3NfJExe5K24evKl7WXBlhcHSRBdp2Y4tM
         Cn67pxXHOEoIT8Od//A5a15xWGshgJRV5NONdwpuRRCNjKg2YLT/M5g88zyotaekgAlE
         AykP3jEBoFbjWCPYmuHJGxgAi8/X74Sw9p5bRCi1AQkR2xhhvT0hV7Sruc1/xNvYl/A/
         9a+cEVhBU4PDlxvqTb9XoshoTP1LAX4W8G3lfso66S9W9Je9nlI7oiYsoRNWK2xuNzM6
         wrwucJW1GPIIcCselUxHs8LnyE7eGTiWwUKVaQ1E1YfAbM2E4NOxNo8J9krY+f6vjQBi
         E/Qg==
X-Gm-Message-State: APt69E2AINXoKV+YP8QTNh5YGdtKN9aJkBwXPdv/GSozp1g7xxU6JbAe
        fRqOTr+zIvrj2tnIaSKAgZYUkA==
X-Google-Smtp-Source: AAOMgpdtZ1oNKwW3n3ThKmysKdlQBxuQ0a1p1kmTVJ0RYi0mq7ED/VdF0NOXCGnJ4kOoH3EK2d9JCg==
X-Received: by 2002:a50:aa8c:: with SMTP id q12-v6mr933175edc.64.1530001064185;
        Tue, 26 Jun 2018 01:17:44 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-109.fiber7.init7.net. [212.51.149.109])
        by smtp.gmail.com with ESMTPSA id o25-v6sm490921edr.75.2018.06.26.01.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 01:17:43 -0700 (PDT)
Date:   Tue, 26 Jun 2018 10:17:40 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Akhil P Oommen <akhilpo@codeaurora.org>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Gustavo Padovan <gustavo@padovan.org>, sumit.semwal@linaro.org,
        jcrouse@codeaurora.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        smasetty@codeaurora.org
Subject: Re: [PATCH v2] dma-buf/fence: Take refcount on the module that owns
 the fence
Message-ID: <20180626081740.GT2958@phenom.ffwll.local>
Mail-Followup-To: Akhil P Oommen <akhilpo@codeaurora.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Gustavo Padovan <gustavo@padovan.org>, sumit.semwal@linaro.org,
        jcrouse@codeaurora.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        smasetty@codeaurora.org
References: <1529660407-6266-1-git-send-email-akhilpo@codeaurora.org>
 <1529661856.7034.404.camel@padovan.org>
 <152966212844.11773.6596589902326100250@mail.alporthouse.com>
 <20180625075040.GK2958@phenom.ffwll.local>
 <82f8e976-2a5a-56df-28bb-c75314824bf6@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82f8e976-2a5a-56df-28bb-c75314824bf6@codeaurora.org>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 09:21:15PM +0530, Akhil P Oommen wrote:
> 
> 
> On 6/25/2018 1:20 PM, Daniel Vetter wrote:
> > On Fri, Jun 22, 2018 at 11:08:48AM +0100, Chris Wilson wrote:
> > > Quoting Gustavo Padovan (2018-06-22 11:04:16)
> > > > Hi Akhil,
> > > > 
> > > > On Fri, 2018-06-22 at 15:10 +0530, Akhil P Oommen wrote:
> > > > > Each fence object holds function pointers of the module that
> > > > > initialized
> > > > > it. Allowing the module to unload before this fence's release is
> > > > > catastrophic. So, keep a refcount on the module until the fence is
> > > > > released.
> > > > > 
> > > > > Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
> > > > > ---
> > > > > Changes in v2:
> > > > > - added description for the new function parameter.
> > > > > 
> > > > >   drivers/dma-buf/dma-fence.c | 16 +++++++++++++---
> > > > >   include/linux/dma-fence.h   | 10 ++++++++--
> > > > >   2 files changed, 21 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-
> > > > > fence.c
> > > > > index 4edb9fd..2aaa44e 100644
> > > > > --- a/drivers/dma-buf/dma-fence.c
> > > > > +++ b/drivers/dma-buf/dma-fence.c
> > > > > @@ -18,6 +18,7 @@
> > > > >    * more details.
> > > > >    */
> > > > > +#include <linux/module.h>
> > > > >   #include <linux/slab.h>
> > > > >   #include <linux/export.h>
> > > > >   #include <linux/atomic.h>
> > > > > @@ -168,6 +169,7 @@ void dma_fence_release(struct kref *kref)
> > > > >   {
> > > > >        struct dma_fence *fence =
> > > > >                container_of(kref, struct dma_fence, refcount);
> > > > > +     struct module *module = fence->owner;
> > > > >        trace_dma_fence_destroy(fence);
> > > > > @@ -178,6 +180,8 @@ void dma_fence_release(struct kref *kref)
> > > > >                fence->ops->release(fence);
> > > > >        else
> > > > >                dma_fence_free(fence);
> > > > > +
> > > > > +     module_put(module);
> > > > >   }
> > > > >   EXPORT_SYMBOL(dma_fence_release);
> > > > > @@ -541,6 +545,7 @@ struct default_wait_cb {
> > > > >   /**
> > > > >    * dma_fence_init - Initialize a custom fence.
> > > > > + * @module:  [in]    the module that calls this API
> > > > >    * @fence:   [in]    the fence to initialize
> > > > >    * @ops:     [in]    the dma_fence_ops for operations on this
> > > > > fence
> > > > >    * @lock:    [in]    the irqsafe spinlock to use for locking
> > > > > this fence
> > > > > @@ -556,8 +561,9 @@ struct default_wait_cb {
> > > > >    * to check which fence is later by simply using dma_fence_later.
> > > > >    */
> > > > >   void
> > > > > -dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops
> > > > > *ops,
> > > > > -            spinlock_t *lock, u64 context, unsigned seqno)
> > > > > +_dma_fence_init(struct module *module, struct dma_fence *fence,
> > > > > +             const struct dma_fence_ops *ops, spinlock_t *lock,
> > > > > +             u64 context, unsigned seqno)
> > > > >   {
> > > > >        BUG_ON(!lock);
> > > > >        BUG_ON(!ops || !ops->wait || !ops->enable_signaling ||
> > > > > @@ -571,7 +577,11 @@ struct default_wait_cb {
> > > > >        fence->seqno = seqno;
> > > > >        fence->flags = 0UL;
> > > > >        fence->error = 0;
> > > > > +     fence->owner = module;
> > > > > +
> > > > > +     if (!try_module_get(module))
> > > > > +             fence->owner = NULL;
> > > > >        trace_dma_fence_init(fence);
> > > > >   }
> > > > > -EXPORT_SYMBOL(dma_fence_init);
> > > > > +EXPORT_SYMBOL(_dma_fence_init);
> > > > Do we still need to export the symbol, it won't be called from outside
> > > > anymore? Other than that looks good to me:
> > > There's a big drawback in that a module reference is often insufficient,
> > > and that a reference on the driver (or whatever is required for the
> > > lifetime of the fence) will already hold the module reference.
> > > 
> > > Considering that we want a few 100k fences in flight per second, is
> > > there no other way to only export a fence with a module reference?
> > We'd need to make the timeline a full-blown object (Maarten owes me one
> > for that design screw-up), and then we could stuff all these things in
> > there.
> > 
> > And I think that's the right fix, since try_module_get for every
> > dma_fence_init just ain't cool really :-)
> > -Daniel
> Thanks for the feedback, Daniel.
> I see your point, but I am not sure how much impact an extra refcounting
> would create considering the whole effort of setting up a new fence. Also,
> this refcounting is not required for built-in modules.
> 
> As of now, unloading a kernel module that uses fence_init() is an easy way
> to bring down the system. This patch simply fixes that. What you have
> suggested sounds like a non-trivial effort which someone who is more
> familiar with this code base can do a better job than me. Perhaps we can
> take this patch now to fix the issue at hand and later somebody else can
> share a more optimal solution. :)

Module unload is a developer-only feature for a reason. Given that I don't
think fixing this with a hack is the right approach. And dma_fence_init()
is supposed to be really fast.

Also note that you can fix this already for your own driver by simply
waiting for all pending dma_fences to get released, so I don't think it's
super-important to land this asap.

Yes the real fix is a bit more involved, but shouldn't be too hard to pull
off really.
-Daniel

> 
> @Gustavo & @Sumit, I would like the maintainers to take a decision here.
> 
> -Akhil.

> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
