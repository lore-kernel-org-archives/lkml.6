Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D5BC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47C92086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpUFxOU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47C92086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeIKMei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:34:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbeIKMeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:34:37 -0400
Received: from localhost (unknown [171.76.126.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25A7420865;
        Tue, 11 Sep 2018 07:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536651397;
        bh=++P0gGCRlK+L/iV6KM40zTkJGbfilgruck7EGj4bpA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hpUFxOU16vOYO5Dnggm7BZJnUjNlEqd7WBooy2mOB9CPaiOP1RSd3dlp4ywi+Fwe0
         65uxo4dwjKCDsJuyYdUt0a5+glla1yLuSY4EeKxjZmKS73YhJgolyN/FfX73YsT4ki
         AL2u7RTqiFFPjNnGYJUE8B9WhTJllK/FfseMkDNk=
Date:   Tue, 11 Sep 2018 13:06:27 +0530
From:   Vinod <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de, radheys@xilinx.com
Subject: Re: [PATCH v2 2/2] dmaengine: doc: Add sections for per descriptor
 metadata support
Message-ID: <20180911073627.GL2634@vkoul-mobl>
References: <20180830121910.16005-1-peter.ujfalusi@ti.com>
 <20180830121910.16005-3-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830121910.16005-3-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-08-18, 15:19, Peter Ujfalusi wrote:
> Update the provider and client documentation with details about the
> metadata support.

It would make sense to make this patch 1 :)

> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  Documentation/driver-api/dmaengine/client.rst | 70 +++++++++++++++++++
>  .../driver-api/dmaengine/provider.rst         | 46 ++++++++++++
>  2 files changed, 116 insertions(+)
> 
> diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
> index fbbb2831f29f..584a39347cfe 100644
> --- a/Documentation/driver-api/dmaengine/client.rst
> +++ b/Documentation/driver-api/dmaengine/client.rst
> @@ -151,6 +151,76 @@ The details of these operations are:
>       Note that callbacks will always be invoked from the DMA
>       engines tasklet, never from interrupt context.
>  
> +  Optional: per descriptor metadata
> +  ---------------------------------
> +  DMAengine provides two ways for metadata support.
> +
> +  DESC_METADATA_CLIENT
> +
> +    The metadata buffer is allocated/provided by the client driver and it is
> +    attached to the descriptor.
> +
> +  .. code-block:: c
> +
> +     int dmaengine_desc_attach_metadata(struct dma_async_tx_descriptor *desc,
> +				   void *data, size_t len);
> +
> +  DESC_METADATA_ENGINE
> +
> +    The metadata buffer is allocated/managed by the DMA driver. The client
> +    driver can ask for the pointer, maximum size and the currently used size of
> +    the metadata and can directly update or read it.
> +
> +  .. code-block:: c
> +
> +     void *dmaengine_desc_get_metadata_ptr(struct dma_async_tx_descriptor *desc,
> +		size_t *payload_len, size_t *max_len);
> +
> +     int dmaengine_desc_set_metadata_len(struct dma_async_tx_descriptor *desc,
> +		size_t payload_len);
> +
> +  Client drivers can query if a given mode is supported with:
> +
> +  .. code-block:: c
> +
> +     bool dmaengine_is_metadata_mode_supported(struct dma_chan *chan,
> +		enum dma_desc_metadata_mode mode);
> +
> +  Depending on the used mode client drivers must follow different flow.
> +
> +  DESC_METADATA_CLIENT
> +
> +    - DMA_MEM_TO_DEV / DEV_MEM_TO_MEM:
> +      1. prepare the descriptor (dmaengine_prep_*)
> +         construct the metadata in the client's buffer
> +      2. use dmaengine_desc_attach_metadata() to attach the buffer to the
> +         descriptor
> +      3. submit the transfer
> +    - DMA_DEV_TO_MEM:
> +      1. prepare the descriptor (dmaengine_prep_*)
> +      2. use dmaengine_desc_attach_metadata() to attach the buffer to the
> +         descriptor
> +      3. submit the transfer
> +      4. when the transfer is completed, the metadata should be available in the
> +         attached buffer
> +
> +  DESC_METADATA_ENGINE
> +
> +    - DMA_MEM_TO_DEV / DEV_MEM_TO_MEM:
> +      1. prepare the descriptor (dmaengine_prep_*)
> +      2. use dmaengine_desc_get_metadata_ptr() to get the pointer to the
> +         engine's metadata area
> +      3. update the metadata at the pointer
> +      4. use dmaengine_desc_set_metadata_len()  to tell the DMA engine the
> +         amount of data the client has placed into the metadata buffer
> +      5. submit the transfer
> +    - DMA_DEV_TO_MEM:
> +      1. prepare the descriptor (dmaengine_prep_*)
> +      2. submit the transfer
> +      3. on transfer completion, use dmaengine_desc_get_metadata_ptr() to get the
> +         pointer to the engine's metadata are
> +      4. Read out the metadate from the pointer

Lets put a note here that only one method should be used

> +
>  4. Submit the transaction
>  
>     Once the descriptor has been prepared and the callback information
> diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
> index dfc4486b5743..502c59f75302 100644
> --- a/Documentation/driver-api/dmaengine/provider.rst
> +++ b/Documentation/driver-api/dmaengine/provider.rst
> @@ -247,6 +247,52 @@ after each transfer. In case of a ring buffer, they may loop
>  (DMA_CYCLIC). Addresses pointing to a device's register (e.g. a FIFO)
>  are typically fixed.
>  
> +Per descriptor metadata support
> +-------------------------------
> +Some data movement architecure (DMA controller and peripherals) uses metadata

typo architecure

> +associated with a transaction. The DMA controller role is to transfer the
> +payload and the metadata alongside.
> +The metadata itself is not used by the DMA engine itself, but it contains
> +parameters, keys, vectors, etc for peripheral or from the peripheral.
> +
> +The DMAengine framework provides a generic ways to facilitate the metadata for
> +descriptors. Depending on the architecture the DMA driver can implment either

implment
-- 
~Vinod
