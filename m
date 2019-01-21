Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6E2C31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F201E2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U44LmsnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfAUH0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:26:16 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:53330 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfAUH0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:26:15 -0500
Received: by mail-it1-f193.google.com with SMTP id g85so15172369ita.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 23:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ajYMFC2reghOmzcthv0vHrytNzOAbc6ti5YAojE+CZM=;
        b=U44LmsnC/9sS1fBgJPAdNPCuCUDcsd3tgK4roX5+ENPyA8ZkQf02E40wJJWNxe4xoM
         NkDPOIPlBKjLgWJc41d/3Grx7wkY+qpMgQEC5cjXn0EA3bYE06pGlYLLRHwkWlK8E1P2
         iPnD+AU0lgplUJtxXnQKuD4tWXPPAcLuXVqeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ajYMFC2reghOmzcthv0vHrytNzOAbc6ti5YAojE+CZM=;
        b=Pq3zu4jOQKPQKqx1ZGsNZOwmTpIhjOY62XUx0Xcgch0b8cgxpDWVOY+/37y1HdYBO1
         aN4Q8fxdR+NI86TvzR3EEfgPVUU07ib6k+cIHGxpUiV6hk1+1BEGr21lHtCOpTVWoDHh
         sB7irltr82UICcijfvRkioFyIxxT87kH2pkAs6GfhKOYYtHEYANrGFP+oF56Z9hno8Rl
         J88Xc9sxtCmoNQCuvhGawje4aAL47S/zYPE2rTDAChmXBj7fzua5R6Gur2Z9xcL0DI04
         XBgH+5NdZvPY0qJDNKE+eHbt/XC2z5PV0vpp4TDM1/Ho9aYk4/ry6JUTUhIVOfrp8FMX
         yL7w==
X-Gm-Message-State: AJcUukeg5oKu4pkA2ePIfD99ZeYKq/cQEQ9QgdTBTOwGWip40c9gkwwa
        Adh2ULE1sUdlYInXVoBQUytEAwu82nf3wrYDmLoNZA==
X-Google-Smtp-Source: ALg8bN5fYHgYbrTBUaHBE6nY3/l1o8uC2r8ga7peqyyblIzHnRu5CCCUAfGtJ6cwlzbXeF3smuZ7abuw90az88epf3U=
X-Received: by 2002:a02:4c9:: with SMTP id 192mr16576843jab.2.1548055574176;
 Sun, 20 Jan 2019 23:26:14 -0800 (PST)
MIME-Version: 1.0
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
In-Reply-To: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 21 Jan 2019 08:26:02 +0100
Message-ID: <CAKv+Gu8P-5hxZ8+OV_xSZteTvCLw-Sc-=KJM1i=3aWajcS9bUw@mail.gmail.com>
Subject: Re: [PATCH 0/3] iommu/arm-smmu: Add support to use Last level cache
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, pdaly@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tfiga@chromium.org, jcrouse@codeaurora.org, pratikp@codeaurora.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019 at 06:54, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>
> Qualcomm SoCs have an additional level of cache called as
> System cache, aka. Last level cache (LLC). This cache sits right
> before the DDR, and is tightly coupled with the memory controller.
> The clients using this cache request their slices from this
> system cache, make it active, and can then start using it.
> For these clients with smmu, to start using the system cache for
> buffers and, related page tables [1], memory attributes need to be
> set accordingly. This series add the required support.
>

Does this actually improve performance on reads from a device? The
non-cache coherent DMA routines perform an unconditional D-cache
invalidate by VA to the PoC before reading from the buffers filled by
the device, and I would expect the PoC to be defined as lying beyond
the LLC to still guarantee the architected behavior.



> This change is a realisation of following changes from downstream msm-4.9:
> iommu: io-pgtable-arm: Support DOMAIN_ATTRIBUTE_USE_UPSTREAM_HINT[2]
> iommu: io-pgtable-arm: Implement IOMMU_USE_UPSTREAM_HINT[3]
>
> Changes since v2:
>  - Split the patches into io-pgtable-arm driver and arm-smmu driver.
>  - Converted smmu domain attributes to a bitmap, so multiple attributes
>    can be managed easily.
>  - With addition of non-coherent page table mapping support [4], this
>    patch series now aligns with the understanding of upgrading the
>    non-coherent devices to use some level of outer cache.
>  - Updated the macros and comments to reflect the use of QCOM_SYS_CACHE.
>  - QCOM_SYS_CACHE can still be used at stage 2, so that doens't depend on
>    stage-1 mapping.
>  - Added change to disable the attribute from arm_smmu_domain_set_attr()
>    when needed.
>  - Removed the page protection controls for QCOM_SYS_CACHE at the DMA API
>    level.
>
> Goes on top of the non-coherent page tables support patch series [4]
>
> [1] https://patchwork.kernel.org/patch/10302791/
> [2] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=bf762276796e79ca90014992f4d9da5593fa7d51
> [3] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=d4c72c413ea27c43f60825193d4de9cb8ffd9602
> [4] https://lore.kernel.org/patchwork/cover/1032938/
>
> Vivek Gautam (3):
>   iommu/arm-smmu: Move to bitmap for arm_smmu_domain atrributes
>   iommu/io-pgtable-arm: Add support to use system cache
>   iommu/arm-smmu: Add support to use system cache
>
>  drivers/iommu/arm-smmu.c       | 28 ++++++++++++++++++++++++----
>  drivers/iommu/io-pgtable-arm.c | 15 +++++++++++++--
>  drivers/iommu/io-pgtable.h     |  4 ++++
>  include/linux/iommu.h          |  2 ++
>  4 files changed, 43 insertions(+), 6 deletions(-)
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
