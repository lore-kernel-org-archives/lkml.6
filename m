Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE42C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB5420838
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V2K4q+/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732560AbfBRNwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:52:00 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39188 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732538AbfBRNv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:51:58 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190218135157euoutp0190b21eb0c1515cb30b5da3a7e03d38dc~EeaQA4SCi2182321823euoutp01f
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 13:51:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190218135157euoutp0190b21eb0c1515cb30b5da3a7e03d38dc~EeaQA4SCi2182321823euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550497917;
        bh=er1pPMaGUu+8A5IAKmzhmjQZ7rLZcUzbNITov52MThs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=V2K4q+/gsdcTPmOWrB0rAKm0eWJvYF4+CJ2MA+R9OEiCuFWP6uiEAlNzVl1LuluHN
         pdOoPSb/3jlTN8fNj0DE1Pv/iGXzZqYUk2TzLzghzp5EgjlBicQ6SV9INbC3QPfoVm
         nz9xBeieNhXpJOB+GSsN1Sqd9kjpBmssX2OfhcPg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190218135156eucas1p14aeae02aab847b38206df634b0d586a4~EeaPsNtzX3104931049eucas1p1y;
        Mon, 18 Feb 2019 13:51:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5E.34.04441.C78BA6C5; Mon, 18
        Feb 2019 13:51:56 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190218135155eucas1p157d73c8e779f2b4687d00def5acafa03~EeaO5D2y_2884728847eucas1p1-;
        Mon, 18 Feb 2019 13:51:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190218135155eusmtrp1bc661fe781bbcfcaf037c3a3d114a8a4~EeaOq1B9G0543705437eusmtrp1Q;
        Mon, 18 Feb 2019 13:51:55 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-72-5c6ab87ccc96
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D0.25.04284.B78BA6C5; Mon, 18
        Feb 2019 13:51:55 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190218135155eusmtip17fe86d9f3ede33183c96c2bf2af101b5~EeaOUnQkd0431104311eusmtip1n;
        Mon, 18 Feb 2019 13:51:55 +0000 (GMT)
Subject: Re: [PATCH] dma-contiguous: do not allocate a single page from CMA
 area
To:     Nicolin Chen <nicoleotsuka@gmail.com>, robin.murphy@arm.com,
        hch@lst.de
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <5dc1865b-ab20-aa45-1d00-b8d95655226f@samsung.com>
Date:   Mon, 18 Feb 2019 14:51:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190215200635.20733-1-nicoleotsuka@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djPc7o1O7JiDP52SVqsXH2UyWLBfmuL
        y7vmsFm86r3BbnHwwxNWB1aPNfPWMHrsnHWX3WPyjeWMHrtvNrB5fN4kF8AaxWWTkpqTWZZa
        pG+XwJXxaO5qxoKNohULLnE0MP4V6GLk5JAQMJFoWXiLrYuRi0NIYAWjRN+BhcwQzhdGicXz
        jkA5nxklVp/cxQzTMnPiL3aIxHJGiVXf97JAOO8ZJd4dWs4OUiUsECSx90cjI4gtIuAtseDs
        Z1YQm1nASeJV51SwOJuAoUTX2y42EJtXwE7i/McLYHEWAVWJaVfXgtmiAjESU84dYYeoEZQ4
        OfMJC4jNKWAjMe39OhaImfIS29/OYYawxSVuPZnPBHKQhMAidok7//9Dne0i8WHnFjYIW1ji
        1fEt7BC2jMTpyT0sEA3NjBLtM2axQzg9jBJb5+yA6rCWOHz8ItALHEArNCXW79KHCDtKbGvd
        zAYSlhDgk7jxVhDiCD6JSdumM0OEeSU62oQgqtUkZh1fB7f24IVLzBMYlWYheW0WkndmIXln
        FsLeBYwsqxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQLTzel/xz/tYPx6KekQowAHoxIP
        74LlWTFCrIllxZW5hxglOJiVRHj71gOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ81YzPIgWEkhP
        LEnNTk0tSC2CyTJxcEo1MGqtbLtTHHJrYlXJsgvG2w7bL4z+3Ml1+c6O6/v717gXF9yb2ffO
        4K3MnImvxF/UxNZ1cohPfn9y/d94bWer80e0lt74P9n/o1rmoq03+jqWLfz/et7xW1323t/8
        a4NLzmRskrv/quvl+Qn/mB9JbeEs3zPJ8lLZ5nANrprsLYVayl6e4lxH5yxVYinOSDTUYi4q
        TgQAAcm5qzMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xu7rVO7JiDI6eULRYufook8WC/dYW
        l3fNYbN41XuD3eLghyesDqwea+atYfTYOesuu8fkG8sZPXbfbGDz+LxJLoA1Ss+mKL+0JFUh
        I7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j0dzVjAUbRSsWXOJo
        YPwr0MXIySEhYCIxc+IvdhBbSGApo8SendkQcRmJk9MaWCFsYYk/17rYuhi5gGreMkosvb6B
        BSQhLBAksfdHIyOILSLgLbHg7GewBmYBJ4lXnVMZIRr6GSW27l/FBJJgEzCU6HoLMomTg1fA
        TuL8xwtgzSwCqhLTrq4Fsjk4RAViJK6eY4QoEZQ4OfMJ2C5OARuJae/XsUDMV5f4M+8SM4Qt
        L7H97RwoW1zi1pP5TBMYhWYhaZ+FpGUWkpZZSFoWMLKsYhRJLS3OTc8tNtQrTswtLs1L10vO
        z93ECIytbcd+bt7BeGlj8CFGAQ5GJR7eBcuzYoRYE8uKK3MPMUpwMCuJ8PatBwrxpiRWVqUW
        5ccXleakFh9iNAX6bSKzlGhyPjDu80riDU0NzS0sDc2NzY3NLJTEec8bVEYJCaQnlqRmp6YW
        pBbB9DFxcEo1MJp03tmxbF7b65vnXWXKLi+dsYPjrDT7naxLR2QuxGwJPRl0QmPnP3Ohvf5p
        fSIXVs07ssNxn5vtvROayn5hp7h2PdBceO7JjchPN5/c8L2q2mw5s4dLW5Wnvjp4Y5+83+rK
        Mu07my2Vft6vUllW7THPddn8x7ItkzqWym0x7s41cfx5akndcwklluKMREMt5qLiRABxwgIQ
        wwIAAA==
X-CMS-MailID: 20190218135155eucas1p157d73c8e779f2b4687d00def5acafa03
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190215200726epcas2p1f3da0044c08c5dae90eec3d73656c135
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190215200726epcas2p1f3da0044c08c5dae90eec3d73656c135
References: <CGME20190215200726epcas2p1f3da0044c08c5dae90eec3d73656c135@epcas2p1.samsung.com>
        <20190215200635.20733-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

On 2019-02-15 21:06, Nicolin Chen wrote:
> The addresses within a single page are always contiguous, so it's
> not so necessary to always allocate one single page from CMA area.
> Since the CMA area has a limited predefined size of space, it may
> run out of space in heavy use cases, where there might be quite a
> lot CMA pages being allocated for single pages.
>
> However, there is also a concern that a device might care where a
> page comes from -- it might expect the page from CMA area and act
> differently if the page doesn't.
>
> This patch tries to skip of one-page size allocations and returns
> NULL so as to let callers allocate normal pages unless the device
> has its own CMA area. This would save resources from the CMA area
> for more CMA allocations. And it'd also reduce CMA fragmentations
> resulted from trivial allocations.
>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>  kernel/dma/contiguous.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index b2a87905846d..09074bd04793 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -186,16 +186,32 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
>   *
>   * This function allocates memory buffer for specified device. It uses
>   * device specific contiguous memory area if available or the default
> - * global one. Requires architecture specific dev_get_cma_area() helper
> - * function.
> + * global one.
> + *
> + * However, it skips one-page size of allocations from the global area.
> + * As the addresses within one page are always contiguous, so there is
> + * no need to waste CMA pages for that kind; it also helps reduce the
> + * fragmentations in the CMA area. So a caller should be the rebounder
> + * in such case to allocate a normal page upon NULL return value.
> + *
> + * Requires architecture specific dev_get_cma_area() helper function.
>   */
>  struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
>  				       unsigned int align, bool no_warn)
>  {
> +	struct cma *cma;
> +
>  	if (align > CONFIG_CMA_ALIGNMENT)
>  		align = CONFIG_CMA_ALIGNMENT;
>  
> -	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
> +	if (dev && dev->cma_area)
> +		cma = dev->cma_area;
> +	else if (count > 1)
> +		cma = dma_contiguous_default_area;
> +	else
> +		return NULL;
> +
> +	return cma_alloc(cma, count, align, no_warn);
>  }
>  
>  /**

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

