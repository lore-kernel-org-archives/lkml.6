Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979EFC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4215C20895
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZ8nn61j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4215C20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbeGYNuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728863AbeGYNuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:50:06 -0400
Received: from localhost (unknown [122.178.229.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C16B620894;
        Wed, 25 Jul 2018 12:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532522314;
        bh=fBXOginqq4qlGAfn+SPO2ngJXbLyvIH4JFJF+Fq3t0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pZ8nn61j3gnO6fhT3fduefxZEkgRRx8YGXQPp/QX99OtZiMUrozS8J8uCKipwkhFK
         Nucf/NBJGO4HPu1S0YBfe2dmJk+14xi1IegNFiUIjjaGTs4VlLdv8HDSS2lgJCdg2q
         w73Var4rEhHL+HTF2mK/9crrkuseOiYvTKC1trQY=
Date:   Wed, 25 Jul 2018 18:08:26 +0530
From:   Vinod <vkoul@kernel.org>
To:     Huang Shijie <sjhuang@iluvatar.ai>
Cc:     corbet@lwn.net, dan.j.williams@intel.com, robh@kernel.org,
        linux-doc@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: add a new helper dmam_async_device_register
Message-ID: <20180725123826.GT3661@vkoul-mobl>
References: <20180725054645.9723-1-sjhuang@iluvatar.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725054645.9723-1-sjhuang@iluvatar.ai>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-18, 13:46, Huang Shijie wrote:
> This patch adds the dmam_async_device_register for DMA code.
> Use the Devres to call the release for the DMA engine driver.

no users?

> 
> Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
> ---
>  Documentation/driver-model/devres.txt |  1 +
>  drivers/dma/dmaengine.c               | 35 +++++++++++++++++++++++++++
>  include/linux/dmaengine.h             |  1 +
>  3 files changed, 37 insertions(+)
> 
> diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
> index a3e8bceb5f19..26c6de621446 100644
> --- a/Documentation/driver-model/devres.txt
> +++ b/Documentation/driver-model/devres.txt
> @@ -240,6 +240,7 @@ CLOCK
>    devm_of_clk_add_hw_provider()
>  
>  DMA
> +  dmam_async_device_register()

can we name it dmaengine_async_device_register, not to confuse with dma APIs

>    dmam_alloc_coherent()
>    dmam_alloc_attrs()
>    dmam_declare_coherent_memory()
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 84ac38dbdb65..2477af0bdfc7 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -1135,6 +1135,41 @@ void dma_async_device_unregister(struct dma_device *device)
>  }
>  EXPORT_SYMBOL(dma_async_device_unregister);
>  
> +static void dmam_device_release(struct device *dev, void *res)
> +{
> +	struct dma_device *device;
> +
> +	device = *(struct dma_device **)res;
> +	dma_async_device_unregister(device);
> +}
> +
> +/**
> + * dmam_async_device_register - registers DMA devices found
> + * @device: &dma_device
> + *
> + * The operation is managed and will be undone on driver detach.
> + */
> +int dmam_async_device_register(struct dma_device *device)
> +{
> +	void *p;
> +	int ret;
> +
> +	p = devres_alloc(dmam_device_release, sizeof(void *), GFP_KERNEL);
> +	if (!p)
> +		return -ENOMEM;
> +
> +	ret = dma_async_device_register(device);
> +	if (!ret) {
> +		*(struct dma_device **)p = device;
> +		devres_add(device->dev, p);
> +	} else {
> +		devres_free(p);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(dmam_async_device_register);
> +
>  struct dmaengine_unmap_pool {
>  	struct kmem_cache *cache;
>  	const char *name;
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index c8c3a7a93802..b98bced0b98e 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -1406,6 +1406,7 @@ static inline int dmaengine_desc_free(struct dma_async_tx_descriptor *desc)
>  /* --- DMA device --- */
>  
>  int dma_async_device_register(struct dma_device *device);
> +int dmam_async_device_register(struct dma_device *device);
>  void dma_async_device_unregister(struct dma_device *device);
>  void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
>  struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
> -- 
> 2.17.1

-- 
~Vinod
