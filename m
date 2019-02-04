Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBD0C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8916D20811
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ve5vTZsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbfBDLsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:48:19 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49044 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbfBDLsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 06:48:19 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190204114817euoutp02677de29a11e5873bb38ca08c8d2fa89f~AJsST9ZCO2171221712euoutp02_
        for <linux-kernel@vger.kernel.org>; Mon,  4 Feb 2019 11:48:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190204114817euoutp02677de29a11e5873bb38ca08c8d2fa89f~AJsST9ZCO2171221712euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549280897;
        bh=RMdJimNfHjcVB+q5UQqAtDD/hUvuolJW5XbMU+7K4KI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ve5vTZsCMW6D6jUla6t3OaC8erxLonyXWHCV4taDJ/8bd4cwUt6hB32mRtBduzH84
         2xmZmiq4TNXF3BIm67imRw+Ux45Zjg0/JburJ9jjCjWszgsJjE02id+dXzbt3itCr/
         cc8kU4PPeGsn+EuPErG0B8CUmaPn0TCOHknkQkFY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190204114816eucas1p2183818377db6d5eb008925b031d99408~AJsRhmLdB1456514565eucas1p2L;
        Mon,  4 Feb 2019 11:48:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 83.A6.04806.086285C5; Mon,  4
        Feb 2019 11:48:16 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190204114815eucas1p1f3af51ae6e4429d6b33fb0c6c60a094f~AJsQsNV2S1035610356eucas1p1L;
        Mon,  4 Feb 2019 11:48:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190204114815eusmtrp1c80921965486f2dff4e8199e8dc5972c~AJsQdRoTj0295902959eusmtrp1S;
        Mon,  4 Feb 2019 11:48:15 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-91-5c582680c82a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9B.F0.04128.F76285C5; Mon,  4
        Feb 2019 11:48:15 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190204114814eusmtip248bd0e03e9ca95cd1c1e908c5c0323f6~AJsP7e9VP1981219812eusmtip2S;
        Mon,  4 Feb 2019 11:48:14 +0000 (GMT)
Subject: Re: [PATCH] ARM: dma-mapping: Clear DMA ops on teardown
To:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     hch@lst.de, treding@nvidia.com, rmk+kernel@armlinux.org.uk,
        bskeggs@redhat.com, tjakobi@math.uni-bielefeld.de,
        b.zolnierkie@samsung.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <a2013d45-69d4-5c24-f833-a27e5ac20cb8@samsung.com>
Date:   Mon, 4 Feb 2019 12:48:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <2f5833b7639543d614095cd3f5ab0dc0274e26d6.1548081277.git.robin.murphy@arm.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyyUcRzH+97z4x43d/s6ync02mlUCynTEzLF6um/5h8WVhdPKI7u/Ah/
        dGXJLkIKXbdcpfysW1wYTaM4psmP/IxlYRJiSQ2l3D1T/nu/P5/X5/P5vrcvhYnfETZUlCye
        lcuk0RJSgNe0Lnc6Kx2DQvbNjNvSzwt1BD1dkgHosooWHq195UVXjfcTdG+9hqR7snN5dNPC
        BEGnVywQ9IdVka+AqbxfCZje/m6MqS6+zOQNlgCmYUhJMmutfCYr7SvJzDf2kcxNfTlgFqvs
        TgpOCbzD2eioRFbu6nNGEFkx7BfXJbq0ohoBSpBhrgJmFILuaGFuilQBASWGpQANPZnmceY7
        QI1DmYAziwCN5M/iGyNV2o98rlGyTv0sIowNMZwHqGTgmFFbQl90Qz9JGCErmA1Qe02taQKD
        WQBp9fk8I0VCN6SaU5FGLYQ+6P1vpekEDnei1WujwKi3whB0u/MNn2MsUPvdCRNjBoPRn5cr
        plkM2qPaOQ3GaWs0PFFkCoHgNB+V9lSuD1Drxh89HOZxESzRF4Oez+ntqCMvE+f4NICuF6r5
        nMkE6IWmjuQoL/Ta0E0YF2FwN9LVu3LlI6ihqQ1w+0VocM6Ce4MI3aopwLiyEGWkiznaEakN
        z/6dberqwXKARL0pmXpTGvWmNOr/d7UALwfWbIIiJoJVHJCxSS4KaYwiQRbhEhYbUwXWv1nH
        mmGpDjT+OtsMIAUk5sIxn8AQMSFNVCTHNANEYRIrYeeOoBCxMFyanMLKY0/LE6JZRTOwpXCJ
        tTB1y1iwGEZI49kLLBvHyje6PMrMRgk8LerPLxf0uh8+XnB08p5fuchHJ3vLPkoqbM+9Wp1e
        7Ep8C3QwCD7PxMseO207F+B9EGYVhA1aLTn3OWUWTrQ1jthpDznt1/i36JRdLp6pyim9x5Xh
        lBN3FnN+LPuVhTrgoU6psxdtAzwG7Jvyi/oedLm15qn2jux6Wl88qsM/BUhwRaTUbQ8mV0j/
        AsQncrRiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsVy+t/xe7r1ahExBku3y1hsnLGe1eLl8g5G
        i5WrjzJZLNhvbbHp8TVWi8u75rBZXOqfyGRx8MMTVou21R9YLW7/5nPg8lgzbw2jx+VrF5k9
        Ni+p95h8Yzmjx+6bDWwe/46xe/Q2v2PzeL/vKptH35ZVjB6fN8kFcEXp2RTll5akKmTkF5fY
        KkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZay+5Vxwga/iV9cdxgbGDp4u
        Rk4OCQETiU0L7rN3MXJxCAksZZR4f/QgG0RCRuLktAZWCFtY4s+1LjaIoreMEvM2/WIGSQgL
        OEh0b3kKViQi0M8ocX6TKkgRs0Avo8Sjub9ZIDrWMUrsfPONEaSKTcBQouttF9gKXgE7iSt/
        G1hAbBYBFYnfrXeBajg4RAViJK6eY4QoEZQ4OfMJWAmnQLTE/z2/wFqZBdQl/sy7xAxhy0ts
        fzsHyhaXuPVkPtMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3
        MQKjd9uxn1t2MHa9Cz7EKMDBqMTD+8AuPEaINbGsuDL3EKMEB7OSCO85hYgYId6UxMqq1KL8
        +KLSnNTiQ4ymQL9NZJYSTc4HJpa8knhDU0NzC0tDc2NzYzMLJXHe8waVUUIC6YklqdmpqQWp
        RTB9TBycUg2M2t+evd/zd8fiOatu+j2/71d7l7cs2OJvp1AdxyH7S/+9b2YzJ21L/OR1mV9z
        un0ir2b0n8h0nuz8f1k8mk9XnPjk/f3Gtdk37bN2RwjYH854rvz57NvmbWwLNhheiJZetNZq
        xvNVzH84ulXXH+GS83WYYPqTLeXK9Y3vXx/2e7duf8q8yOgPPkosxRmJhlrMRcWJAGqNqtP0
        AgAA
X-CMS-MailID: 20190204114815eucas1p1f3af51ae6e4429d6b33fb0c6c60a094f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190121145305epcas4p1df032b4c2c44d5f291eb2bedde9de40d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190121145305epcas4p1df032b4c2c44d5f291eb2bedde9de40d
References: <CGME20190121145305epcas4p1df032b4c2c44d5f291eb2bedde9de40d@epcas4p1.samsung.com>
        <2f5833b7639543d614095cd3f5ab0dc0274e26d6.1548081277.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 2019-01-21 15:52, Robin Murphy wrote:
> Installing the appropriate non-IOMMU DMA ops in arm_iommu_detch_device()
> serves the case where IOMMU-aware drivers choose to control their own
> mapping but still make DMA API calls, however it also affects the case
> when the arch code itself tears down the mapping upon driver unbinding,
> where the ops now get left in place and can inhibit arch_setup_dma_ops()
> on subsequent re-probe attempts.
>
> Fix the latter case by making sure that arch_teardown_dma_ops() cleans
> up whenever the ops were automatically installed by its counterpart.
>
> Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: 1874619a7df4 "ARM: dma-mapping: Set proper DMA ops in arm_iommu_detach_device()"
> Tested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>
> Sorry for the delay - there was a giant email infrastructure cock-up just
> at the point I wanted to go back through my archive and double-check the
> discussion around the original commit...

No problem, could you also upload it to rmk's patch tracking system?
IMHO rmk's tree will be the best place to handle this fix.

> Robin.
>
>  arch/arm/mm/dma-mapping.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index f1e2922e447c..1e3e08a1c456 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2390,4 +2390,6 @@ void arch_teardown_dma_ops(struct device *dev)
>  		return;
>  
>  	arm_teardown_iommu_dma_ops(dev);
> +	/* Let arch_setup_dma_ops() start again from scratch upon re-probe */
> +	set_dma_ops(dev, NULL);
>  }

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

