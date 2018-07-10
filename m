Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9DDC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FDB208FA
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUxTymkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FDB208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934267AbeGJPbO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754260AbeGJPbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:31:13 -0400
Received: from localhost (unknown [106.200.232.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3913D208EB;
        Tue, 10 Jul 2018 15:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531236672;
        bh=CYXOkUQhg75e+7V96Q+PaR/QMYhiPM2TsCrtY0NzzPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uUxTymkHAPyrcF1KsTDYWNzSB6RanQOPfw+cDMFGv0JnPBxjE9EUFy0+M52Ai8YXp
         Nl0LUNC1Ixm0MoUwM7mMm2e9mTAiMIeADtxLFnASH8f2T4zcGpoBK+C0wLbpOnrm2S
         3KUDshlggRlGxYGrIQVP/nQK9dOxyw+c7Vpb/z8g=
Date:   Tue, 10 Jul 2018 21:01:04 +0530
From:   Vinod <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     dan.j.williams@intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v1 2/4] dmaengine: imx-sdma: add check_bd_buswidth() to
 kill the dulicated code
Message-ID: <20180710153104.GF3219@vkoul-mobl>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-3-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531239793-11781-3-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-07-18, 00:23, Robin Gong wrote:
> Add check_bd_buswidth() to minimize the code size.

this looks mostly fine and I think this should be first patch..

> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/dma/imx-sdma.c | 64 +++++++++++++++++++++++---------------------------
>  1 file changed, 29 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 27ccabf..ed2267d 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1326,6 +1326,33 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
>  	return NULL;
>  }
>  
> +static int check_bd_buswidth(struct sdma_buffer_descriptor *bd,
> +			     struct sdma_channel *sdmac, int count,
> +			     dma_addr_t dma_dst, dma_addr_t dma_src)
> +{
> +	int ret = 0;
> +
> +	switch (sdmac->word_size) {
> +	case DMA_SLAVE_BUSWIDTH_4_BYTES:
> +		bd->mode.command = 0;
> +		if ((count | dma_dst | dma_src) & 3)
> +			ret = -EINVAL;
> +		break;

empty line after each break please

> +	case DMA_SLAVE_BUSWIDTH_2_BYTES:
> +		bd->mode.command = 2;
> +		if ((count | dma_dst | dma_src) & 1)
> +			ret = -EINVAL;
> +		break;
> +	case DMA_SLAVE_BUSWIDTH_1_BYTE:
> +		 bd->mode.command = 1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
-- 
~Vinod
