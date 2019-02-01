Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55DCC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADE020844
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSTY4UQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbfBAS2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:28:52 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43629 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfBAS2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 13:28:51 -0500
Received: by mail-ot1-f65.google.com with SMTP id a11so6812190otr.10;
        Fri, 01 Feb 2019 10:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SC0lyMrasTuR9sEm02EoPwx+HkC+Cng7lP0Ta6oPNMg=;
        b=SSTY4UQxs7021+STvu0iFfLOSNEj/RdIAbdtN/Ozbmlu7+TVOQ2CtPdR82Vi/z1NpV
         QCrXsATH6egns4sXpo9psiWcsyr6VKbAL0d8PBGbPoLkiEYiVw2OdJQxau79xGj4Zj2L
         MVqiI8AoIr7Fl18OX5UWwYpT+Gd2kbLF77lytUExigZEy0zpm9CQr3yox6TC9jROLgTp
         TRYBoxEWYLKe2rKnW2KvzJAkIazbDUHySzovb4xxpZv2n/WH4EOmWuAD7nRbQfG4xtnV
         0byUtHyTvwLi6QNt2Lk2DFrYp6cgCtMIEJS9XiS1fGZ3Gzy9F3vgG9RpHcfDhARfgXD6
         Itgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SC0lyMrasTuR9sEm02EoPwx+HkC+Cng7lP0Ta6oPNMg=;
        b=QJND3poOageeBJAGhrqF8eyUC/lmhJNaTts/Pigceu5jSHTb/y8kjMqGmrVkLr08vE
         XmNS+wkpWauK9jrNLRDyvE4ADv8fKYLZ+mA5hP1trX22HMOpSzFNFqTaRTkG//jmxkNC
         QeC7IoTyUHhruqPotH12cQ0BaZ9Hk0ABLXFGJ8ZQI34WN/159Fl6j8vhcDUO7ag9wqlr
         KnEGRv6+BgUFrU5BD0M7oBPUqJk8LdFb+J79Wr59ZfIsMUMonbgGuDlVs+pudUlAzb52
         Dt2M9ZBmZZDcySskSirm+xw6EAERZ4TrR9GsIVsgfE3i96zqEY/5I06o1jSwfnVsV98T
         qfIA==
X-Gm-Message-State: AJcUukctfs3F7gx6JnCXCzPjKi5a9/4IFei5KjCnmP2rF9iZXa5G6rPW
        HESZQXLE/D7FiJ1MhH3rxEV7kmXm
X-Google-Smtp-Source: ALg8bN5932W/YGWCzdqtBPUXMdNjwx+AiLjQLHf+u+HHebo6drn0Nk11jwD8FwZ0mAKFaqNxHzv4Cw==
X-Received: by 2002:a9d:4c01:: with SMTP id l1mr29826716otf.242.1549045730113;
        Fri, 01 Feb 2019 10:28:50 -0800 (PST)
Received: from [192.168.0.2] ([98.156.228.54])
        by smtp.gmail.com with ESMTPSA id t197sm3918020oif.29.2019.02.01.10.28.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 10:28:49 -0800 (PST)
Subject: Re: [PATCH] dell_rbu: stop abusing the DMA API
To:     Christoph Hellwig <hch@lst.de>, dvhart@infradead.org
Cc:     andy@infradead.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190129073409.7247-1-hch@lst.de>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <4fce2a6c-2e57-bc29-0dca-8ed3bef95333@gmail.com>
Date:   Fri, 1 Feb 2019 12:28:46 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20190129073409.7247-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 190131-0, 01/31/2019), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/29/2019 1:34 AM, Christoph Hellwig wrote:
> For some odd reason dell_rbu actually seems to want the physical and
> not a bus address for the allocated buffer.  Lets assume that actually
> is correct given that it is BIOS-related and that is a good source
> of insanity.  In that case we should not use dma_alloc_coherent with
> a NULL device to allocate memory, but use GFP_DMA32 to stay under
> the 32-bit BIOS limit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/platform/x86/dell_rbu.c | 52 ++++++++++-----------------------
>  1 file changed, 15 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell_rbu.c b/drivers/platform/x86/dell_rbu.c
> index ccefa84f7305..fba7d96c1714 100644
> --- a/drivers/platform/x86/dell_rbu.c
> +++ b/drivers/platform/x86/dell_rbu.c
> @@ -59,7 +59,6 @@ static struct _rbu_data {
>  	unsigned long image_update_buffer_size;
>  	unsigned long bios_image_size;
>  	int image_update_ordernum;
> -	int dma_alloc;
>  	spinlock_t lock;
>  	unsigned long packet_read_count;
>  	unsigned long num_packets;
> @@ -89,7 +88,6 @@ static struct packet_data packet_data_head;
>  
>  static struct platform_device *rbu_device;
>  static int context;
> -static dma_addr_t dell_rbu_dmaaddr;
>  
>  static void init_packet_head(void)
>  {
> @@ -380,12 +378,8 @@ static void img_update_free(void)
>  	 */
>  	memset(rbu_data.image_update_buffer, 0,
>  		rbu_data.image_update_buffer_size);
> -	if (rbu_data.dma_alloc == 1)
> -		dma_free_coherent(NULL, rbu_data.bios_image_size,
> -			rbu_data.image_update_buffer, dell_rbu_dmaaddr);
> -	else
> -		free_pages((unsigned long) rbu_data.image_update_buffer,
> -			rbu_data.image_update_ordernum);
> +	free_pages((unsigned long) rbu_data.image_update_buffer,
> +		rbu_data.image_update_ordernum);
>  
>  	/*
>  	 * Re-initialize the rbu_data variables after a free
> @@ -394,7 +388,6 @@ static void img_update_free(void)
>  	rbu_data.image_update_buffer = NULL;
>  	rbu_data.image_update_buffer_size = 0;
>  	rbu_data.bios_image_size = 0;
> -	rbu_data.dma_alloc = 0;
>  }
>  
>  /*
> @@ -410,10 +403,8 @@ static void img_update_free(void)
>  static int img_update_realloc(unsigned long size)
>  {
>  	unsigned char *image_update_buffer = NULL;
> -	unsigned long rc;
>  	unsigned long img_buf_phys_addr;
>  	int ordernum;
> -	int dma_alloc = 0;
>  
>  	/*
>  	 * check if the buffer of sufficient size has been
> @@ -444,36 +435,23 @@ static int img_update_realloc(unsigned long size)
>  
>  	ordernum = get_order(size);
>  	image_update_buffer =
> -		(unsigned char *) __get_free_pages(GFP_KERNEL, ordernum);
> -
> -	img_buf_phys_addr =
> -		(unsigned long) virt_to_phys(image_update_buffer);
> -
> -	if (img_buf_phys_addr > BIOS_SCAN_LIMIT) {
> -		free_pages((unsigned long) image_update_buffer, ordernum);
> -		ordernum = -1;
> -		image_update_buffer = dma_alloc_coherent(NULL, size,
> -			&dell_rbu_dmaaddr, GFP_KERNEL);
> -		dma_alloc = 1;
> -	}
> -
> -	spin_lock(&rbu_data.lock);
> -
> -	if (image_update_buffer != NULL) {
> -		rbu_data.image_update_buffer = image_update_buffer;
> -		rbu_data.image_update_buffer_size = size;
> -		rbu_data.bios_image_size =
> -			rbu_data.image_update_buffer_size;
> -		rbu_data.image_update_ordernum = ordernum;
> -		rbu_data.dma_alloc = dma_alloc;
> -		rc = 0;
> -	} else {
> +		(unsigned char *)__get_free_pages(GFP_DMA32, ordernum);
> +	if (!image_update_buffer) {
>  		pr_debug("Not enough memory for image update:"
>  			"size = %ld\n", size);
> -		rc = -ENOMEM;
> +		return -ENOMEM;
>  	}
>  
> -	return rc;
> +	img_buf_phys_addr = (unsigned long)virt_to_phys(image_update_buffer);
> +	if (WARN_ON_ONCE(img_buf_phys_addr > BIOS_SCAN_LIMIT))
> +		return -EINVAL; /* can't happen per defintion */
> +
> +	spin_lock(&rbu_data.lock);
> +	rbu_data.image_update_buffer = image_update_buffer;
> +	rbu_data.image_update_buffer_size = size;
> +	rbu_data.bios_image_size = rbu_data.image_update_buffer_size;
> +	rbu_data.image_update_ordernum = ordernum;
> +	return 0;
>  }
>  
>  static ssize_t read_packet_data(char *buffer, loff_t pos, size_t count)
> 

Acked-by: Stuart Hayes <stuart.w.hayes@gmail.com>
