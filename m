Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB369C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4478208DC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttezdYdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4478208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeH0IqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 04:46:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbeH0IqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 04:46:05 -0400
Received: from localhost (unknown [106.200.197.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 437DF208B7;
        Mon, 27 Aug 2018 05:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535346066;
        bh=xK5XFMr82FYnO08yGjHe9cFwP6Iw5A3I9pjsOGaLr94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ttezdYdX4fHqKg936I69rIsLebbhOZDOOzMfobNziKJgGq3T1/7t8mcAp023vZ3yg
         xEjAMOX+rApHJciEddqsGEpYqo95j2O6ukrA2pOx2IloTX0r43WZwTHrUFvCgY/Vg0
         QAvmycFIkCMvgRCyx/OkUzxfcSM4vJv9qf+kjovc=
Date:   Mon, 27 Aug 2018 10:30:57 +0530
From:   Vinod <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Daniel Silsby <dansilsby@gmail.com>
Subject: Re: [PATCH v4 11/18] dmaengine: dma-jz4780: Add missing residue DTC
 mask
Message-ID: <20180827050057.GR2388@vkoul-mobl>
References: <20180807114218.20091-1-paul@crapouillou.net>
 <20180807114218.20091-12-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807114218.20091-12-paul@crapouillou.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-08-18, 13:42, Paul Cercueil wrote:
> From: Daniel Silsby <dansilsby@gmail.com>
> 
> The 'dtc' word in jz DMA descriptors contains two fields: The
> lowest 24 bits are the transfer count, and upper 8 bits are the DOA
> offset to next descriptor. The upper 8 bits are now correctly masked
> off when computing residue in jz4780_dma_desc_residue(). Note that
> reads of the DTCn hardware reg are automatically masked this way.
> 
> Signed-off-by: Daniel Silsby <dansilsby@gmail.com>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> ---
>  drivers/dma/dma-jz4780.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
>  v2: No change
> 
>  v3: No change
> 
>  v4: Add my Signed-off-by
> 
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index 3a4d0a4b550d..a4292ac4c686 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -616,7 +616,8 @@ static size_t jz4780_dma_desc_residue(struct jz4780_dma_chan *jzchan,
>  	residue = 0;
>  
>  	for (i = next_sg; i < desc->count; i++)
> -		residue += desc->desc[i].dtc << jzchan->transfer_shift;
> +		residue += (desc->desc[i].dtc & 0xffffff) <<

GENMASK(23, 0) please.

-- 
~Vinod
