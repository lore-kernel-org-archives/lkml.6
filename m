Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EFDECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C191D20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5OPi79S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C191D20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeGTKQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:16:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbeGTKQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:16:47 -0400
Received: from localhost (unknown [106.51.19.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6DD520673;
        Fri, 20 Jul 2018 09:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532078965;
        bh=+HiBGrY/KbFhZ/rXN2AvxSqzmFmZhW2uVQz0iFcnnHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B5OPi79SphMv8v290ROZ57BauvrcBrpBQ+gS3TQ+4y56QS/YtopSPfM/2RalRDrMI
         UN3K5LFr4BZwjlzyHDPrdHfoCKNaKIh8rVL3nUKpAqOY/PEuQLpU8hflzHsTrPKvLy
         MnlVdK3icvsO7E3m4YvMHhT7qlrfVrDp4z3qyGnE=
Date:   Fri, 20 Jul 2018 14:59:21 +0530
From:   Vinod <vkoul@kernel.org>
To:     hannah@marvell.com
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        thomas.petazzoni@bootlin.com, linux-kernel@vger.kernel.org,
        nadavh@marvell.com, omrii@marvell.com, oferh@marvell.com,
        gregory.clement@bootlin.com
Subject: Re: [PATCH 3/5] dmaengine: mv_xor_v2: convert callback to helper
 function
Message-ID: <20180720092921.GR3219@vkoul-mobl>
References: <1531823403-3683-1-git-send-email-hannah@marvell.com>
 <1531823403-3683-4-git-send-email-hannah@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531823403-3683-4-git-send-email-hannah@marvell.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-07-18, 13:30, hannah@marvell.com wrote:
> From: Hanna Hawa <hannah@marvell.com>
> 
> This is in preperation of moving to a callback that provides results to the

typo preperation

> callback for the transaction. The conversion will maintain current behavior
> and the driver must convert to new callback mechanism at a later time in
> order to receive results.
> 
> Signed-off-by: Hanna Hawa <hannah@marvell.com>
> ---
>  drivers/dma/mv_xor_v2.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
> index e718498..14e2a7a 100644
> --- a/drivers/dma/mv_xor_v2.c
> +++ b/drivers/dma/mv_xor_v2.c
> @@ -589,9 +589,8 @@ static void mv_xor_v2_tasklet(unsigned long data)
>  			 */
>  			dma_cookie_complete(&next_pending_sw_desc->async_tx);
>  
> -			if (next_pending_sw_desc->async_tx.callback)
> -				next_pending_sw_desc->async_tx.callback(
> -				next_pending_sw_desc->async_tx.callback_param);
> +			dmaengine_desc_get_callback_invoke(
> +					&next_pending_sw_desc->async_tx, NULL);
>  
>  			dma_descriptor_unmap(&next_pending_sw_desc->async_tx);
>  		}

-- 
~Vinod
