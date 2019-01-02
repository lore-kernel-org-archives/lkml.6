Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC37BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE2E218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRoXfFMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbfABKbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:31:48 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33287 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbfABKbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 05:31:48 -0500
Received: by mail-ed1-f65.google.com with SMTP id p6so25816094eds.0;
        Wed, 02 Jan 2019 02:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jAbhEv01L2qwCkYKLDLhjrRuLFnohUgvi9oiWW1LUPY=;
        b=ZRoXfFMdR7GBFtALYs+KVuwiphGlSGGEtYvoIFZkxvKlZ+UpaYMnxx1lXm+DyEPyQm
         AQtWu6zgPp5IjsO3vP+KmTN7m0KCMWCunpqJ4TUdrj8cZ/34v+uKVuGB9smfHe3wGRFE
         ShjOvkOYjwJCebCqzeA9xAyq9ETbQE/8w2nX1DhF/1adObA4dxS8vGPQeBLq7SEJyd33
         PweWN4fRSivr/FQpmre0zxcEFVEK96bcVMOYmLY9KhZJFmp/ORfAk82xjSRoRhEcNAXr
         Q2c27slir1rwTmXLkcJZ/QzwPCtQWeMe9ULKe8ZLvLQfCVCpY0vRnsiwXhc//FztwPju
         lppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jAbhEv01L2qwCkYKLDLhjrRuLFnohUgvi9oiWW1LUPY=;
        b=thU8UahIfTts0grvBLCjctS4nuHLAGFKY+YN8nI0fQSlftNVU5K+dL5B9/VulAaKq9
         I7YUDJvfWUYqThgzITjo5Jd+JJVGgxueOk/9YRUNC2UAsSLKVXF0wnZHrK1BcwYh9LRn
         xQ9L8HmIvtleGuZkDWa0GaiE2ZD3kuaLxPLDPHrhxakWOSoqk3jsukDdrbLaE4ZeHlKa
         z+cW1qXer7/f3nWamZt/bwmQlQTW9ukgDgPG5070KZ/AKuXuL2gIX0zVrYprF69nLjx0
         U2VpVKlAtd7K3QFnCXS1D0gry7Nwdh8EqeOdNAJkGrY7GS4WChVBsKe4RvVubl87zLNi
         vwNw==
X-Gm-Message-State: AA+aEWZqVINX/XFIaBbAdzdUq1ksIoEhE3UpFwtzONEpnQr3AQgcwL4r
        CC8ls74R/zPIHvCdSLxa+QI=
X-Google-Smtp-Source: AFSGD/XBV+kzGvUawWIDP7QH2FtM+nEofBe8EtOKcAxe8Dqu1AicQYunscCUxByg7BGX4j8DP/Ivpg==
X-Received: by 2002:a50:b667:: with SMTP id c36mr40121223ede.190.1546425105031;
        Wed, 02 Jan 2019 02:31:45 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id j23sm19506204edr.89.2019.01.02.02.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 02:31:44 -0800 (PST)
Date:   Wed, 2 Jan 2019 11:31:41 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] net: sungem: device driver frees DMA memory with wrong
 function
Message-ID: <20190102103141.GA15872@Red>
References: <20181223193821.GA24922@Red>
 <20181228083621.GA25585@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228083621.GA25585@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 12:36:21AM -0800, Christoph Hellwig wrote:
> Please try this patch:
> 

The error type change to "DMA-API: gem 0000:00:0f.0: device driver failed to check map error" (I will send patch for fixing this).
Note that I used the patch from your just sent DMA series (since the patch below is included in).

So you can add my
Tested-by: LABBE Corentin <clabbe.montjoie@gmail.com>

Thanks

> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index a52c6409bdc2..f454e0ed1398 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -284,32 +284,25 @@ static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
>  }
>  #endif
>  
> -static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
> -					      size_t size,
> -					      enum dma_data_direction dir,
> -					      unsigned long attrs)
> +static inline dma_addr_t dma_map_page_attrs(struct device *dev,
> +		struct page *page, size_t offset, size_t size,
> +		enum dma_data_direction dir, unsigned long attrs)
>  {
>  	const struct dma_map_ops *ops = get_dma_ops(dev);
>  	dma_addr_t addr;
>  
>  	BUG_ON(!valid_dma_direction(dir));
> -	debug_dma_map_single(dev, ptr, size);
>  	if (dma_is_direct(ops))
> -		addr = dma_direct_map_page(dev, virt_to_page(ptr),
> -				offset_in_page(ptr), size, dir, attrs);
> +		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
>  	else
> -		addr = ops->map_page(dev, virt_to_page(ptr),
> -				offset_in_page(ptr), size, dir, attrs);
> -	debug_dma_map_page(dev, virt_to_page(ptr),
> -			   offset_in_page(ptr), size,
> -			   dir, addr, true);
> +		addr = ops->map_page(dev, page, offset, size, dir, attrs);
> +	debug_dma_map_page(dev, page, offset, size, dir, addr, false);
> +
>  	return addr;
>  }
>  
> -static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
> -					  size_t size,
> -					  enum dma_data_direction dir,
> -					  unsigned long attrs)
> +static inline void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
>  {
>  	const struct dma_map_ops *ops = get_dma_ops(dev);
>  
> @@ -321,12 +314,6 @@ static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
>  	debug_dma_unmap_page(dev, addr, size, dir, true);
>  }
>  
> -static inline void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr,
> -		size_t size, enum dma_data_direction dir, unsigned long attrs)
> -{
> -	return dma_unmap_single_attrs(dev, addr, size, dir, attrs);
> -}
> -
>  /*
>   * dma_maps_sg_attrs returns 0 on error and > 0 on success.
>   * It should never return a value < 0.
> @@ -363,25 +350,6 @@ static inline void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg
>  		ops->unmap_sg(dev, sg, nents, dir, attrs);
>  }
>  
> -static inline dma_addr_t dma_map_page_attrs(struct device *dev,
> -					    struct page *page,
> -					    size_t offset, size_t size,
> -					    enum dma_data_direction dir,
> -					    unsigned long attrs)
> -{
> -	const struct dma_map_ops *ops = get_dma_ops(dev);
> -	dma_addr_t addr;
> -
> -	BUG_ON(!valid_dma_direction(dir));
> -	if (dma_is_direct(ops))
> -		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
> -	else
> -		addr = ops->map_page(dev, page, offset, size, dir, attrs);
> -	debug_dma_map_page(dev, page, offset, size, dir, addr, false);
> -
> -	return addr;
> -}
> -
>  static inline dma_addr_t dma_map_resource(struct device *dev,
>  					  phys_addr_t phys_addr,
>  					  size_t size,
> @@ -488,6 +456,19 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
>  
>  }
>  
> +static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
> +			size, dir, attrs);
> +}
> +
> +static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	return dma_unmap_page_attrs(dev, addr, size, dir, attrs);
> +}
> +
>  #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
>  #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
>  #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
