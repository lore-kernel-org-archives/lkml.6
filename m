Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E74C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3168208E1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vgmyzni2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3168208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbeGJFwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 01:52:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751058AbeGJFwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 01:52:39 -0400
Received: from localhost (unknown [106.200.232.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AC5020881;
        Tue, 10 Jul 2018 05:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531201959;
        bh=YIBjc5TiKWUYyZUl1Agnnf4BWMjT8pvgVMlK0xLkOzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vgmyzni2nRWBWmzXJ1dbA/BccCooAszyo5ZWMa+s5tbk2gUlRZLdvkOPjSeYyOTPe
         xmMM0tRMVoqmTvi1ZHoat7TZLdzd4adxA1JZBd4c5Oejb+ZZp3Ee8fVILbgo3f+K1G
         RrIqRjEKbrwCvroT8JioxTX8573bSbw6kUmEwk/8=
Date:   Tue, 10 Jul 2018 11:22:30 +0530
From:   Vinod <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     radheys@xilinx.com, vinod.koul@intel.com, lars@metafoo.de,
        michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        appanad@xilinx.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC] dmaengine: Add metadat_ops for dma_async_tx_descriptor
Message-ID: <20180710055230.GB3219@vkoul-mobl>
References: <32208a9c-2b15-d345-1432-f1e387531f9b@ti.com>
 <20180601102429.16429-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601102429.16429-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hey Peter,

Sorry for late response on this..

On 01-06-18, 13:24, Peter Ujfalusi wrote:
> If the DMA supports per descriptor metadata it can implement the attach,
> get_ptr/set_len callbacks.
> 
> Client drivers must only use either attach or get_ptr/set_len to avoid
> miss configuration.
> 
> Wrappers are also added for the metadata_ops:
> dmaengine_desc_attach_metadata()
> dmaengine_desc_get_metadata_ptr()
> dmaengine_desc_set_metadata_len()
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
> 
> since attachments are bouncing back, I send the patch separately
> 
> Regards,
> Peter
> 
>  include/linux/dmaengine.h | 50 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 51fbb861e84b..ac42ace36aa3 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -491,6 +491,18 @@ struct dmaengine_unmap_data {
>  	dma_addr_t addr[0];
>  };
>  
> +struct dma_async_tx_descriptor;
> +
> +struct dma_descriptor_metadata_ops {
> +	int (*attach)(struct dma_async_tx_descriptor *desc, void *data,
> +		      size_t len);

How does one detach? When should the client free up the memory, IOW when
does dma driver drop ref to data.

> +
> +	void *(*get_ptr)(struct dma_async_tx_descriptor *desc,
> +			 size_t *payload_len, size_t *max_len);

so what is this supposed to do..?

> +	int (*set_len)(struct dma_async_tx_descriptor *desc,
> +		       size_t payload_len);

attach already has length, so how does this help?

> +};
> +
>  /**
>   * struct dma_async_tx_descriptor - async transaction descriptor
>   * ---dma generic offload fields---
> @@ -520,6 +532,7 @@ struct dma_async_tx_descriptor {
>  	dma_async_tx_callback_result callback_result;
>  	void *callback_param;
>  	struct dmaengine_unmap_data *unmap;
> +	struct dma_descriptor_metadata_ops *metadata_ops;
>  #ifdef CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH
>  	struct dma_async_tx_descriptor *next;
>  	struct dma_async_tx_descriptor *parent;
> @@ -932,6 +945,43 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy(
>  						    len, flags);
>  }
>  
> +static inline int dmaengine_desc_attach_metadata(
> +		struct dma_async_tx_descriptor *desc, void *data, size_t len)
> +{
> +	if (!desc)
> +		return 0;
> +
> +	if (!desc->metadata_ops || !desc->metadata_ops->attach)
> +		return -ENOTSUPP;
> +
> +	return desc->metadata_ops->attach(desc, data, len);
> +}
> +
> +static inline void *dmaengine_desc_get_metadata_ptr(
> +		struct dma_async_tx_descriptor *desc, size_t *payload_len,
> +		size_t *max_len)
> +{
> +	if (!desc)
> +		return NULL;
> +
> +	if (!desc->metadata_ops || !desc->metadata_ops->get_ptr)
> +		return ERR_PTR(-ENOTSUPP);
> +
> +	return desc->metadata_ops->get_ptr(desc, payload_len, max_len);
> +}
> +
> +static inline int dmaengine_desc_set_metadata_len(
> +		struct dma_async_tx_descriptor *desc, size_t payload_len)
> +{
> +	if (!desc)
> +		return 0;
> +
> +	if (!desc->metadata_ops || !desc->metadata_ops->set_len)
> +		return -ENOTSUPP;
> +
> +	return desc->metadata_ops->set_len(desc, payload_len);
> +}
> +
>  /**
>   * dmaengine_terminate_all() - Terminate all active DMA transfers
>   * @chan: The channel for which to terminate the transfers
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
~Vinod
