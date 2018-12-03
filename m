Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01A2C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 00:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC5F2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 00:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="faXAjvLA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC5F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbeLCAKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 19:10:51 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38047 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbeLCAKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 19:10:50 -0500
Received: by mail-yb1-f195.google.com with SMTP id u103-v6so4596882ybi.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 16:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TRG9PABcW8mA5DBgv77eBT82q3qIyQcDamaw/SXw0hY=;
        b=faXAjvLAgkg4V7MqNaIC5IxEew6k/YIYlQ+IHIQcZ9YistQbr2o5Cv6zxoie9JXb+L
         J7eygIH96uOxqWJ1+X0NQdPg4HBuAJ0p9bFVc34aSBUSMBvrbxDD+bDHYUHYxBdR+5fI
         D9atOvhRPEsbEy1v1TdXNML0vhm49d1q1DnAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TRG9PABcW8mA5DBgv77eBT82q3qIyQcDamaw/SXw0hY=;
        b=XaOtUPAd4DsCflbTQq+YZZe8tiw5cP6+jIFhUJe6cjDDoD8MkViZf/CcKymx/rCyTR
         rmBWvtSxamBa86SYuvVbBXAy5aOAYvRZ2D2MhsFev1VIpQFp1yT5WyTu1ySycCFsnBDA
         sKMW+s2kmx09Y3ItaEMDPaCy5eOmRMGmsH0h7kmbbVT5EDyCjghe0sporwFiscHettN5
         FhCfvLAHfwcHtNNgrw54WIAjB+nx0DZtDmiRZT4PjPMBE96WNOQcGCnDWWtkm5p7naLc
         09I+Ua1/O0M2xn+RKJvmoTdmORbC2G7tlotI8w8v81y1iU+81GwRTBHJY61SNfAPa1ar
         u/wQ==
X-Gm-Message-State: AA+aEWb2q6Q7nO8VgKM8pV+Z09i66dzMvFSOVqCkzyRFT3nXnW5KwnEb
        Zjms3Yih5WoPMVzkWkAL2VNmnL980yk=
X-Google-Smtp-Source: AFSGD/XKWYO5vvGs7QAOfv87OUfb78El3vPqiWthc7UlgfdfrM68D4nR0OdNKpW9tgAexRFdFFhwkA==
X-Received: by 2002:a25:7e04:: with SMTP id z4-v6mr9846518ybc.118.1543795848025;
        Sun, 02 Dec 2018 16:10:48 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id c127sm3882011ywb.67.2018.12.02.16.10.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 16:10:46 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id a67-v6so4615469ybg.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 16:10:45 -0800 (PST)
X-Received: by 2002:a25:d68b:: with SMTP id n133mr686241ybg.204.1543795844971;
 Sun, 02 Dec 2018 16:10:44 -0800 (PST)
MIME-Version: 1.0
References: <20181201165348.24140-1-robdclark@gmail.com>
In-Reply-To: <20181201165348.24140-1-robdclark@gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Sun, 2 Dec 2018 16:10:33 -0800
X-Gmail-Original-Message-ID: <CAAFQd5CWRKGA2=TEpYvnLuBzu6=2h1i_YtmN_FusyFuLy5BpdQ@mail.gmail.com>
Message-ID: <CAAFQd5CWRKGA2=TEpYvnLuBzu6=2h1i_YtmN_FusyFuLy5BpdQ@mail.gmail.com>
Subject: Re: [PATCH] of/device: add blacklist for iommu dma_ops
To:     Rob Clark <robdclark@gmail.com>
Cc:     "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        freedreno <freedreno@lists.freedesktop.org>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>, frowand.list@gmail.com,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 1, 2018 at 8:54 AM Rob Clark <robdclark@gmail.com> wrote:
>
> This solves a problem we see with drm/msm, caused by getting
> iommu_dma_ops while we attach our own domain and manage it directly at
> the iommu API level:
>
>   [0000000000000038] user address but active_mm is swapper
>   Internal error: Oops: 96000005 [#1] PREEMPT SMP
>   Modules linked in:
>   CPU: 7 PID: 70 Comm: kworker/7:1 Tainted: G        W         4.19.3 #90
>   Hardware name: xxx (DT)
>   Workqueue: events deferred_probe_work_func
>   pstate: 80c00009 (Nzcv daif +PAN +UAO)
>   pc : iommu_dma_map_sg+0x7c/0x2c8
>   lr : iommu_dma_map_sg+0x40/0x2c8
>   sp : ffffff80095eb4f0
>   x29: ffffff80095eb4f0 x28: 0000000000000000
>   x27: ffffffc0f9431578 x26: 0000000000000000
>   x25: 00000000ffffffff x24: 0000000000000003
>   x23: 0000000000000001 x22: ffffffc0fa9ac010
>   x21: 0000000000000000 x20: ffffffc0fab40980
>   x19: ffffffc0fab40980 x18: 0000000000000003
>   x17: 00000000000001c4 x16: 0000000000000007
>   x15: 000000000000000e x14: ffffffffffffffff
>   x13: ffff000000000000 x12: 0000000000000028
>   x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
>   x9 : 0000000000000000 x8 : ffffffc0fab409a0
>   x7 : 0000000000000000 x6 : 0000000000000002
>   x5 : 0000000100000000 x4 : 0000000000000000
>   x3 : 0000000000000001 x2 : 0000000000000002
>   x1 : ffffffc0f9431578 x0 : 0000000000000000
>   Process kworker/7:1 (pid: 70, stack limit = 0x0000000017d08ffb)
>   Call trace:
>    iommu_dma_map_sg+0x7c/0x2c8
>    __iommu_map_sg_attrs+0x70/0x84
>    get_pages+0x170/0x1e8
>    msm_gem_get_iova+0x8c/0x128
>    _msm_gem_kernel_new+0x6c/0xc8
>    msm_gem_kernel_new+0x4c/0x58
>    dsi_tx_buf_alloc_6g+0x4c/0x8c
>    msm_dsi_host_modeset_init+0xc8/0x108
>    msm_dsi_modeset_init+0x54/0x18c
>    _dpu_kms_drm_obj_init+0x430/0x474
>    dpu_kms_hw_init+0x5f8/0x6b4
>    msm_drm_bind+0x360/0x6c8
>    try_to_bring_up_master.part.7+0x28/0x70
>    component_master_add_with_match+0xe8/0x124
>    msm_pdev_probe+0x294/0x2b4
>    platform_drv_probe+0x58/0xa4
>    really_probe+0x150/0x294
>    driver_probe_device+0xac/0xe8
>    __device_attach_driver+0xa4/0xb4
>    bus_for_each_drv+0x98/0xc8
>    __device_attach+0xac/0x12c
>    device_initial_probe+0x24/0x30
>    bus_probe_device+0x38/0x98
>    deferred_probe_work_func+0x78/0xa4
>    process_one_work+0x24c/0x3dc
>    worker_thread+0x280/0x360
>    kthread+0x134/0x13c
>    ret_from_fork+0x10/0x18
>   Code: d2800004 91000725 6b17039f 5400048a (f9401f40)
>   ---[ end trace f22dda57f3648e2c ]---
>   Kernel panic - not syncing: Fatal exception
>   SMP: stopping secondary CPUs
>   Kernel Offset: disabled
>   CPU features: 0x0,22802a18
>   Memory Limit: none
>
> The problem is that when drm/msm does it's own iommu_attach_device(),
> now the domain returned by iommu_get_domain_for_dev() is drm/msm's
> domain, and it doesn't have domain->iova_cookie.
>
> We kind of avoided this problem prior to sdm845/dpu because the iommu
> was attached to the mdp node in dt, which is a child of the toplevel
> mdss node (which corresponds to the dev passed in dma_map_sg()).  But
> with sdm845, now the iommu is attached at the mdss level so we hit the
> iommu_dma_ops in dma_map_sg().
>
> But auto allocating/attaching a domain before the driver is probed was
> already a blocking problem for enabling per-context pagetables for the
> GPU.  This problem is also now solved with this patch.
>
> Fixes: 97890ba9289c dma-mapping: detect and configure IOMMU in of_dma_configure
> Tested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Rob Clark <robdclark@gmail.com>
> ---
> This is an alternative/replacement for [1].  What it lacks in elegance
> it makes up for in practicality ;-)
>
> [1] https://patchwork.freedesktop.org/patch/264930/
>
>  drivers/of/device.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 5957cd4fa262..15ffee00fb22 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -72,6 +72,14 @@ int of_device_add(struct platform_device *ofdev)
>         return device_add(&ofdev->dev);
>  }
>
> +static const struct of_device_id iommu_blacklist[] = {
> +       { .compatible = "qcom,mdp4" },
> +       { .compatible = "qcom,mdss" },
> +       { .compatible = "qcom,sdm845-mdss" },
> +       { .compatible = "qcom,adreno" },
> +       {}
> +};
> +
>  /**
>   * of_dma_configure - Setup DMA configuration
>   * @dev:       Device to apply DMA configuration
> @@ -164,6 +172,20 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
>         dev_dbg(dev, "device is%sbehind an iommu\n",
>                 iommu ? " " : " not ");
>
> +       /*
> +        * There is at least one case where the driver wants to directly
> +        * manage the IOMMU, but if we end up with iommu dma_ops, that
> +        * interferes with the drivers ability to use dma_map_sg() for
> +        * cache operations.  Since we don't currently have a better
> +        * solution, and this code runs before the driver is probed and
> +        * has a chance to intervene, use a simple blacklist to avoid
> +        * ending up with iommu dma_ops:
> +        */
> +       if (of_match_device(iommu_blacklist, dev)) {
> +               dev_dbg(dev, "skipping iommu hookup\n");
> +               iommu = NULL;
> +       }
> +
>         arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
>
>         return 0;
> --
> 2.19.2
>

+Marek Szyprowski who I believe had a similar problem with Exynos DRM before.

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
