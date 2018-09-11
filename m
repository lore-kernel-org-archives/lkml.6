Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C84FC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5AD2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xXljdJYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5AD2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbeIKMbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:31:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbeIKMbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:31:16 -0400
Received: from localhost (unknown [171.76.126.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 595F920865;
        Tue, 11 Sep 2018 07:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536651197;
        bh=K1wSlWlDzYIAo+WlWPvgl8ucz73NNrMO40tBF6H8bLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xXljdJYgDFYDza8FrbMPcvh2r+HJXHU3ptZKpJrl5lScl7u1MlGMnHciwE5v4wNHf
         babitXhY4Vvz/5p0bPRxND5yRoNkhpwKg/UbA5FBbmFPwj+cYUgmTllHISY6ClvwuO
         6Il7v6SARN0hhhP4dvmPRefsfaNwi3FCTp6r6e54=
Date:   Tue, 11 Sep 2018 13:03:07 +0530
From:   Vinod <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de, radheys@xilinx.com
Subject: Re: [PATCH v2 1/2] dmaengine: Add metadata_ops for
 dma_async_tx_descriptor
Message-ID: <20180911073307.GK2634@vkoul-mobl>
References: <20180830121910.16005-1-peter.ujfalusi@ti.com>
 <20180830121910.16005-2-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830121910.16005-2-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-08-18, 15:19, Peter Ujfalusi wrote:
> The metadata is best described as side band data or parameters traveling
> alongside the data DMAd by the DMA engine. It is data
> which is understood by the peripheral and the peripheral driver only, the
> DMA engine see it only as data block and it is not interpreting it in any
> way.
> 
> The metadata can be different per descriptor as it is a parameter for the
> data being transferred.
> 
> If the DMA supports per descriptor metadata it can implement the attach,
> get_ptr/set_len callbacks.
> 
> Client drivers must only use either attach or get_ptr/set_len to avoid
> misconfiguration.
> 
> Client driver can check if a given metadata mode is supported by the
> channel during probe time with
> dmaengine_is_metadata_mode_supported(chan, DESC_METADATA_CLIENT);
> dmaengine_is_metadata_mode_supported(chan, DESC_METADATA_ENGINE);
> 
> and based on this information can use either mode.
> 
> Wrappers are also added for the metadata_ops.
> 
> To be used in DESC_METADATA_CLIENT mode:
> dmaengine_desc_attach_metadata()
> 
> To be used in DESC_METADATA_ENGINE mode:
> dmaengine_desc_get_metadata_ptr()
> dmaengine_desc_set_metadata_len()
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/dmaengine.c   |  73 ++++++++++++++++++++++++++
>  include/linux/dmaengine.h | 108 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 181 insertions(+)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index f1a441ab395d..53bd1eae23f2 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -1306,6 +1306,79 @@ void dma_async_tx_descriptor_init(struct dma_async_tx_descriptor *tx,
>  }
>  EXPORT_SYMBOL(dma_async_tx_descriptor_init);
>  
> +static inline int desc_check_and_set_metadata_mode(
> +	struct dma_async_tx_descriptor *desc, enum dma_desc_metadata_mode mode)
> +{
> +	/* Make sure that the metadata mode is not mixed */
> +	if (!desc->desc_metadata_mode) {
> +		if (dmaengine_is_metadata_mode_supported(desc->chan, mode))
> +			desc->desc_metadata_mode = mode;
> +		else
> +			return -ENOTSUPP;
> +	} else if (desc->desc_metadata_mode != mode) {
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +int dmaengine_desc_attach_metadata(struct dma_async_tx_descriptor *desc,
> +				   void *data, size_t len)
> +{
> +	int ret;
> +
> +	if (!desc)
> +		return -EINVAL;
> +
> +	ret = desc_check_and_set_metadata_mode(desc, DESC_METADATA_CLIENT);
> +	if (ret)
> +		return ret;
> +
> +	if (!desc->metadata_ops || !desc->metadata_ops->attach)
> +		return -ENOTSUPP;
> +
> +	return desc->metadata_ops->attach(desc, data, len);
> +}
> +EXPORT_SYMBOL(dmaengine_desc_attach_metadata);

EXPORT_SYMBOL_GPL ?
-- 
~Vinod
