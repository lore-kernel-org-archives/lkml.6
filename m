Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3DAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7AF20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d02xQFqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfANLLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:11:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59658 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfANLLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B6QdV8niI0v+E++qV45QJgcGN38ZZIMvkJ8kgwLS+R0=; b=d02xQFquGqc7txklQToX8PqM3
        sJppm1/MQNih6J3LJ8ivL5BvdGUWRL0/GimlT/dFOmynjNprSCBSHbiuz2i9AcTFtMHQdFMMjKh2d
        HF0WzGARstNR6onB09lfJQTwO9nROYAB8h6Q9+8ON8B9FUBNiLi3Q/51fT1T8Dph1m9JivO9YkgAs
        2kOnrpn8MTcMGp3GSbOeEGLXiG3h6sGel1BCRfIa8+czwgXLKnTWOscOr0+EPvNNs7zeX3BfcHaDa
        XETdtGNKu5ZZX7pd4quFTe01BKi1FCjtNFmeLH4lwG0Z5KhA3jgsV7xi0okCoLU6XqYkiMpNEr11y
        Agq5lqJhQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gj097-0006EK-Aa; Mon, 14 Jan 2019 11:11:09 +0000
Date:   Mon, 14 Jan 2019 03:11:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] scsi: ufs: Consider device limitations for dma_mask
Message-ID: <20190114111109.GA18673@infradead.org>
References: <20190111225402.6133-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111225402.6133-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 02:54:02PM -0800, Bjorn Andersson wrote:
>   */
>  static int ufshcd_set_dma_mask(struct ufs_hba *hba)
>  {
> -	if (hba->capabilities & MASK_64_ADDRESSING_SUPPORT) {
> -		if (!dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(64)))
> -			return 0;
> -	}
> -	return dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(32));
> +	u64 dma_mask = dma_get_mask(hba->dev);
> +
> +	if (hba->capabilities & MASK_64_ADDRESSING_SUPPORT)
> +		dma_mask &= DMA_BIT_MASK(64);
> +	else
> +		dma_mask &= DMA_BIT_MASK(32);
> +
> +	return dma_set_mask_and_coherent(hba->dev, dma_mask);

NAK.  ufshcd clearly is in charge of setting the dma mask, so reading
it back from someone else who might have set it is completely bogus.

You either need to introduce a quirk or a way to communicate the
different limit so that it can be set by the core.
