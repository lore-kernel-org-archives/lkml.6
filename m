Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3805C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA732082F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gRkJj9Bn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA732082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeK1SkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:40:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43696 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbeK1SkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 13:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ErAFqOvgcD85IUXCMoZh61H8AXDyZEZHHutRK7/9vn4=; b=gRkJj9BnQlXoVv7Ew0C1fAYJ1
        11NO5eEToraV2ok46bMdatF6gTXbZneXKnmAsZ7aAk/IZPuzg3WKKMY0qr6A8vdjtxSxaAO/6irxK
        aFP7Q26uAn0gqHKiFV9x8NslWlOcYuvz4XxT5QYSCNPfmZ6TBklHzQOm397N4P+0/kf7K4nnsf0Vw
        mVmRPKH8gctm145RBQgBvMK/pFJxRIStJI1kQNSFPwrKMRmfkS0yaf6lF50XxO196qM4ArUqUxX3K
        MmAMaxdSNj/ys+7jMgvYwYn7Zeop9oFhopDSaiZv8v2Jka8cDBpeVIFQXvy1/3AHs1TA/4btpu9sn
        Rut1+f4SA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRuRg-0003Sl-T6; Wed, 28 Nov 2018 07:39:40 +0000
Date:   Tue, 27 Nov 2018 23:39:40 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     airlied@linux.ie, robdclark@gmail.com, tfiga@chromium.org,
        linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH v2 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
Message-ID: <20181128073940.GA13072@infradead.org>
References: <20181126213710.3084-1-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126213710.3084-1-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +		/*
> +		 * dma_sync_sg_*() flush the physical pages, so point
> +		 * sg->dma_address to the physical ones for the right behavior.
> +		 */
> +		for_each_sg(msm_obj->sgt->sgl, s, msm_obj->sgt->nents, i)
> +			sg_dma_address(s) = sg_phys(s);
> +

I'm sorry, but this is completely bogus and not acceptable.

The only place that is allowed to initialize sg_dma_address is
dma_map_sg.  If the default dma ops don't work for your setup we have
major a problem and need to fix the dma api / iommu integration instead
of hacking around it.
