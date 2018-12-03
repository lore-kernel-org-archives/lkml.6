Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C30C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1429120851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuwZOKCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1429120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbeLCORd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:17:33 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51096 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeLCORd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:17:33 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so9428967iti.0;
        Mon, 03 Dec 2018 06:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0eBR1du0FBcsILSjbFbs8xtP4rEQA9FzykmaaYb/2U=;
        b=iuwZOKCxDidURg9i8Xh3mfslthW5qK+kACNKZpbWQGieJVeKcZDtQUC8MErw0sEZ2G
         U1mj0P2x1oe7boKPbj9w+Ng7seXCPlWSyu6UocPOJv7KvH8OHEgi8BjRkXwQcy2so5v2
         r9aqTklyawESqNBwTimIkJEyK6vOwJymC0D/i3G6HcrhM75/MHxU5VeYvJCoCuzvCVap
         8x/C93s47aSof/nenYPH36AIzjYlmXeguUPut9IMggvYnwebERO4VJUzIy9poX9Lersx
         3hnATPBN6PVrR26z08nlhN1cc/UMNwlNmzHdvT+adgihkNbSKyJBSDnatJsF9pMUG2m8
         K+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0eBR1du0FBcsILSjbFbs8xtP4rEQA9FzykmaaYb/2U=;
        b=U2ZdK3B+JMJ3N0tqOwR81DhIvj93oN1cz9XGtXx26+OzUV1RZZCu5mSadNLj30+vq4
         ECMmPwth6ryQnW37t/jtxewIcyMrUfhF4KVAIsaxjMoKvG5I4wfP3kzoQrv3jAkmMcLT
         o+5eq2tBKcfAUp+1JLCl64b/gdUQmSOTwitEusaxGGFAmTuZIotBtaWyDWMGO7lWmLI6
         b3LqouR43gbubjtE99TV4dBlQDztCwUyLNk1ylofJ+3oij4RMqknTEP7AfidG1KR62JP
         pANaF6bAbkDUH0J0j9Z4ZNsGhmbfCXo/CjUgUnEKODg6yNUM/EPCAcsptzWG6v75wtaQ
         kucg==
X-Gm-Message-State: AA+aEWZKM7IzjvUCRsx1qllt5yOR08Yx0IIiep+xcjnKmWW8J7CejJc8
        Do1F6KWINdREh8UUEo/t4+e3t8TVko0fNJ74BGM=
X-Google-Smtp-Source: AFSGD/WoFXb0IPsptvdswBGhFK6fRR63otF6Jf1LB1WVI806mBzJ4C8vnPwNebPMF2YO0aLyTBwNQ1JWOIWgBAe6GKI=
X-Received: by 2002:a24:d84:: with SMTP id 126-v6mr8294839itx.163.1543846580098;
 Mon, 03 Dec 2018 06:16:20 -0800 (PST)
MIME-Version: 1.0
References: <20181201165348.24140-1-robdclark@gmail.com> <a29008a3-8eff-260d-5c93-9757a729f9e0@arm.com>
In-Reply-To: <a29008a3-8eff-260d-5c93-9757a729f9e0@arm.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 3 Dec 2018 09:16:08 -0500
Message-ID: <CAF6AEGvkgbhQ=b+4gG_q1Dk=yc+NoKestb1aeQoVDroXFK6-Qg@mail.gmail.com>
Subject: Re: [PATCH] of/device: add blacklist for iommu dma_ops
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>, hch@lst.de,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        freedreno <freedreno@lists.freedesktop.org>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 7:45 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi Rob,
>
> On 01/12/2018 16:53, Rob Clark wrote:
> > This solves a problem we see with drm/msm, caused by getting
> > iommu_dma_ops while we attach our own domain and manage it directly at
> > the iommu API level:
> >
> >    [0000000000000038] user address but active_mm is swapper
> >    Internal error: Oops: 96000005 [#1] PREEMPT SMP
> >    Modules linked in:
> >    CPU: 7 PID: 70 Comm: kworker/7:1 Tainted: G        W         4.19.3 #90
> >    Hardware name: xxx (DT)
> >    Workqueue: events deferred_probe_work_func
> >    pstate: 80c00009 (Nzcv daif +PAN +UAO)
> >    pc : iommu_dma_map_sg+0x7c/0x2c8
> >    lr : iommu_dma_map_sg+0x40/0x2c8
> >    sp : ffffff80095eb4f0
> >    x29: ffffff80095eb4f0 x28: 0000000000000000
> >    x27: ffffffc0f9431578 x26: 0000000000000000
> >    x25: 00000000ffffffff x24: 0000000000000003
> >    x23: 0000000000000001 x22: ffffffc0fa9ac010
> >    x21: 0000000000000000 x20: ffffffc0fab40980
> >    x19: ffffffc0fab40980 x18: 0000000000000003
> >    x17: 00000000000001c4 x16: 0000000000000007
> >    x15: 000000000000000e x14: ffffffffffffffff
> >    x13: ffff000000000000 x12: 0000000000000028
> >    x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
> >    x9 : 0000000000000000 x8 : ffffffc0fab409a0
> >    x7 : 0000000000000000 x6 : 0000000000000002
> >    x5 : 0000000100000000 x4 : 0000000000000000
> >    x3 : 0000000000000001 x2 : 0000000000000002
> >    x1 : ffffffc0f9431578 x0 : 0000000000000000
> >    Process kworker/7:1 (pid: 70, stack limit = 0x0000000017d08ffb)
> >    Call trace:
> >     iommu_dma_map_sg+0x7c/0x2c8
> >     __iommu_map_sg_attrs+0x70/0x84
> >     get_pages+0x170/0x1e8
> >     msm_gem_get_iova+0x8c/0x128
> >     _msm_gem_kernel_new+0x6c/0xc8
> >     msm_gem_kernel_new+0x4c/0x58
> >     dsi_tx_buf_alloc_6g+0x4c/0x8c
> >     msm_dsi_host_modeset_init+0xc8/0x108
> >     msm_dsi_modeset_init+0x54/0x18c
> >     _dpu_kms_drm_obj_init+0x430/0x474
> >     dpu_kms_hw_init+0x5f8/0x6b4
> >     msm_drm_bind+0x360/0x6c8
> >     try_to_bring_up_master.part.7+0x28/0x70
> >     component_master_add_with_match+0xe8/0x124
> >     msm_pdev_probe+0x294/0x2b4
> >     platform_drv_probe+0x58/0xa4
> >     really_probe+0x150/0x294
> >     driver_probe_device+0xac/0xe8
> >     __device_attach_driver+0xa4/0xb4
> >     bus_for_each_drv+0x98/0xc8
> >     __device_attach+0xac/0x12c
> >     device_initial_probe+0x24/0x30
> >     bus_probe_device+0x38/0x98
> >     deferred_probe_work_func+0x78/0xa4
> >     process_one_work+0x24c/0x3dc
> >     worker_thread+0x280/0x360
> >     kthread+0x134/0x13c
> >     ret_from_fork+0x10/0x18
> >    Code: d2800004 91000725 6b17039f 5400048a (f9401f40)
> >    ---[ end trace f22dda57f3648e2c ]---
> >    Kernel panic - not syncing: Fatal exception
> >    SMP: stopping secondary CPUs
> >    Kernel Offset: disabled
> >    CPU features: 0x0,22802a18
> >    Memory Limit: none
> >
> > The problem is that when drm/msm does it's own iommu_attach_device(),
> > now the domain returned by iommu_get_domain_for_dev() is drm/msm's
> > domain, and it doesn't have domain->iova_cookie.
>
> Does this crash still happen with 4.20-rc? Because as of 6af588fed391 it
> really shouldn't.

for this hw, I'm still on 4.19, although that does look like it would
avoid the issue.

> > We kind of avoided this problem prior to sdm845/dpu because the iommu
> > was attached to the mdp node in dt, which is a child of the toplevel
> > mdss node (which corresponds to the dev passed in dma_map_sg()).  But
> > with sdm845, now the iommu is attached at the mdss level so we hit the
> > iommu_dma_ops in dma_map_sg().
> >
> > But auto allocating/attaching a domain before the driver is probed was
> > already a blocking problem for enabling per-context pagetables for the
> > GPU.  This problem is also now solved with this patch.
>
> s/solved/worked around/
>
> If you want a guarantee of actually getting a specific hardware context
> allocated for a given domain, there needs to be code in the IOMMU driver
> to understand and honour that. Implicitly depending on whatever happens
> to fall out of current driver behaviour on current systems is not a real
> solution.

ok, fair.. but I'll settle for "works" in the absence of better options..

At some level, it would be nice to be able to optionally specify a
context-bank in the iommu bindings.  But not sure how to make that fit
w/ cb allocated per domain.  And I assume I'm the only one who has
this problem?

> > Fixes: 97890ba9289c dma-mapping: detect and configure IOMMU in of_dma_configure
>
> That's rather misleading, since the crash described above depends on at
> least two other major changes which came long after that commit.

Fair, when I realized it was the difference in where the iommu
attaches between dpu1 (sdm845) and everything coming before, I should
have removed the tag.

BR,
-R

> It's not that I don't understand exactly what you want here - just that
> this commit message isn't a coherent justification for that ;)
>
> > Tested-by: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > ---
> > This is an alternative/replacement for [1].  What it lacks in elegance
> > it makes up for in practicality ;-)
> >
> > [1] https://patchwork.freedesktop.org/patch/264930/
> >
> >   drivers/of/device.c | 22 ++++++++++++++++++++++
> >   1 file changed, 22 insertions(+)
> >
> > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > index 5957cd4fa262..15ffee00fb22 100644
> > --- a/drivers/of/device.c
> > +++ b/drivers/of/device.c
> > @@ -72,6 +72,14 @@ int of_device_add(struct platform_device *ofdev)
> >       return device_add(&ofdev->dev);
> >   }
> >
> > +static const struct of_device_id iommu_blacklist[] = {
> > +     { .compatible = "qcom,mdp4" },
> > +     { .compatible = "qcom,mdss" },
> > +     { .compatible = "qcom,sdm845-mdss" },
> > +     { .compatible = "qcom,adreno" },
> > +     {}
> > +};
> > +
> >   /**
> >    * of_dma_configure - Setup DMA configuration
> >    * @dev:    Device to apply DMA configuration
> > @@ -164,6 +172,20 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
> >       dev_dbg(dev, "device is%sbehind an iommu\n",
> >               iommu ? " " : " not ");
> >
> > +     /*
> > +      * There is at least one case where the driver wants to directly
> > +      * manage the IOMMU, but if we end up with iommu dma_ops, that
> > +      * interferes with the drivers ability to use dma_map_sg() for
> > +      * cache operations.  Since we don't currently have a better
> > +      * solution, and this code runs before the driver is probed and
> > +      * has a chance to intervene, use a simple blacklist to avoid
> > +      * ending up with iommu dma_ops:
> > +      */
> > +     if (of_match_device(iommu_blacklist, dev)) {
> > +             dev_dbg(dev, "skipping iommu hookup\n");
> > +             iommu = NULL;
> > +     }
>
> Given that a default domain will already have been allocated by the time
> we get here, regardless of whether we pretend of_iommu_configure() did
> nothing, I'm puzzled as to how this change is 'solving' that aspect as
> claimed :/
>
> Is CONFIG_IOMMU_DEFAULT_PASSTHROUGH a sufficient workaround for msm at
> the moment, or do you have other devices which do actually want
> iommu_dma_ops?
>
> Robin.
>
> > +
> >       arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
> >
> >       return 0;
> >
