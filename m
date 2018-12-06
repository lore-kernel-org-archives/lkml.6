Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB59C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60D920850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="InbbPfhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60D920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbeLFOMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:12:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42480 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbeLFOMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:12:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gTDmroXrokXlKA6CmS+cPlnphZoEkVvys0mQa0xzHXI=; b=InbbPfhwSReJPvgAwpYR5MR1S
        wQw6fLDCd37UIrYY6wW7U1QqevsuSpu7uckHfHkXTkBANZajgBfhhzGK/o+d5xNlgxcv5Hi4N7tqF
        rgxyJEZuo+ftWpqvRH+sfe1n7WZrfXGN8vn1ffbDYV4NOJTa5DF5sHxkATYDG5mv5Cs01DRpmpof9
        CSQ32JM1gMk8BJgletPATM4m36dxoNvdASPTr/tMwRU3fdIgBKc/sT9uJkwiv6vwtfLZJL7Hc4euU
        FTZRAKkd2o1sHV24kF6WKWC3v6rN9CBfVXlaKX8Ta/JWeF88824fwqcqyMi8AgZT3gKlBMKEgJ2Wt
        CJeO/Mbqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUuNL-0001FS-HK; Thu, 06 Dec 2018 14:11:35 +0000
Date:   Thu, 6 Dec 2018 06:11:35 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/34] powerpc/dart: remove dead cleanup code in
 iommu_init_early_dart
Message-ID: <20181206141135.GA4770@infradead.org>
References: <20181114082314.8965-1-hch@lst.de>
 <20181114082314.8965-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114082314.8965-15-hch@lst.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

On Wed, Nov 14, 2018 at 09:22:54AM +0100, Christoph Hellwig wrote:
> If dart_init failed we didn't have a chance to setup dma or controller
> ops yet, so there is no point in resetting them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/sysdev/dart_iommu.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
> index a5b40d1460f1..283ce04c5844 100644
> --- a/arch/powerpc/sysdev/dart_iommu.c
> +++ b/arch/powerpc/sysdev/dart_iommu.c
> @@ -428,7 +428,7 @@ void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
>  
>  	/* Initialize the DART HW */
>  	if (dart_init(dn) != 0)
> -		goto bail;
> +		return;
>  
>  	/* Setup bypass if supported */
>  	if (dart_is_u4)
> @@ -439,15 +439,6 @@ void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
>  
>  	/* Setup pci_dma ops */
>  	set_pci_dma_ops(&dma_iommu_ops);
> -	return;
> -
> - bail:
> -	/* If init failed, use direct iommu and null setup functions */
> -	controller_ops->dma_dev_setup = NULL;
> -	controller_ops->dma_bus_setup = NULL;
> -
> -	/* Setup pci_dma ops */
> -	set_pci_dma_ops(&dma_nommu_ops);
>  }
>  
>  #ifdef CONFIG_PM
> -- 
> 2.19.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
