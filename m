Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D6CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2479420651
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfABWgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 17:36:11 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36024 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfABWgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 17:36:11 -0500
Received: by mail-qt1-f196.google.com with SMTP id t13so35137407qtn.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 14:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IMf53sM6tZivaYiNBLCexI9V1XVrngR9/S/wO/OL6mM=;
        b=jcuYlTzE0/lXkWTVOfRPlbPFPnJXTVRAE3YiV1Dxg24uvAZZUVBwXbwrImt/DRLeqA
         99XdZeuhfP/n6AvpCTkYzYENksiSCXj/qjzvYQekJOh0oOJWVkVAa48GqT9moid4QU4j
         /yPMZ2YbMmnDEpA8tLS2BZcwi2JJPGbtFZpiXMsx19XaWxqNX0D1xnguUnvW3Uw8/lz5
         eHX2oLaztAbLeed9KyLLgJyLXX0/zVxq8NZicv0o/HyPzUceW4dWYUZlDy2sclltQh1X
         SZIv7g9lTAmWqiZYLRALj8a4hgIc6/eaRBMMNXbhu1VebOvibKsZ3ALiw17pzH0pVQri
         BuDA==
X-Gm-Message-State: AJcUukfJDHJaTTnnu3cSnFIiN0HwYIpx70Z2Up7qNn5TncBflTqv0hEg
        ETHcOhuKjhdruXEInYrjGVGajA==
X-Google-Smtp-Source: ALg8bN5/w27Mqd3t2zVAC2t0CKPEWFLlEy+Ietn/Y754EQt4KTlvY10nHXjqk5T3q7Pnd3va0OCJ8Q==
X-Received: by 2002:ac8:19e2:: with SMTP id s31mr44916949qtk.215.1546468570303;
        Wed, 02 Jan 2019 14:36:10 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::814b? ([2601:602:9800:dae6::814b])
        by smtp.gmail.com with ESMTPSA id o42sm29606044qtc.90.2019.01.02.14.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 14:36:09 -0800 (PST)
Subject: Re: [PATCH] staging: android: ion: move map_kernel to
 ion_dma_buf_kmap
To:     Qing Xia <saberlily.xia@hisilicon.com>, sumit.semwal@linaro.org,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com
Cc:     linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devel@driverdev.osuosl.org,
        daniel.liuyi@hisilicon.com, yudongbin@hisilicon.com,
        kongfei@hisilicon.com
References: <1545639585-24785-1-git-send-email-saberlily.xia@hisilicon.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <1f507556-890e-e7f4-f80e-49cf7084d78a@redhat.com>
Date:   Wed, 2 Jan 2019 14:36:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1545639585-24785-1-git-send-email-saberlily.xia@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/24/18 12:19 AM, Qing Xia wrote:
> Now, as Google's user guide, if userspace need clean ION buffer's
> cache, they should call ioctl(fd, DMA_BUF_IOCTL_SYNC, sync). Then
> we found that ion_dma_buf_begin_cpu_access/ion_dma_buf_end_cpu_access
> will do ION buffer's map_kernel, it's not necessary. And if usersapce
> only need clean cache, they will call ion_dma_buf_end_cpu_access by
> dmabuf's ioctl, ION buffer's kmap_cnt will be wrong value -1, then
> driver could not get right kernel vaddr by dma_buf_kmap.
> 

The problem is this subtly violates how dma_buf is supposed
to work. All setup is supposed to happen in begin_cpu_access.
I agree calling map kernel each time isn't great but I think
this needs to be worked out with dma_buf.

Thanks,
Laura

> Signed-off-by: Qing Xia <saberlily.xia@hisilicon.com>
> ---
>   drivers/staging/android/ion/ion.c | 46 ++++++++++++++++++---------------------
>   1 file changed, 21 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index 9907332..f7e2812 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -303,45 +303,47 @@ static void ion_dma_buf_release(struct dma_buf *dmabuf)
>   static void *ion_dma_buf_kmap(struct dma_buf *dmabuf, unsigned long offset)
>   {
>   	struct ion_buffer *buffer = dmabuf->priv;
> +	void *vaddr;
>   
> -	return buffer->vaddr + offset * PAGE_SIZE;
> +	if (buffer->heap->ops->map_kernel) {
> +		mutex_lock(&buffer->lock);
> +		vaddr = ion_buffer_kmap_get(buffer);
> +		mutex_unlock(&buffer->lock);
> +		if (IS_ERR(vaddr))
> +			return vaddr;
> +
> +		return vaddr + offset * PAGE_SIZE;
> +	}
> +
> +	return NULL;
>   }
>   
>   static void ion_dma_buf_kunmap(struct dma_buf *dmabuf, unsigned long offset,
>   			       void *ptr)
>   {
> +	struct ion_buffer *buffer = dmabuf->priv;
> +
> +	if (buffer->heap->ops->map_kernel) {
> +		mutex_lock(&buffer->lock);
> +		ion_buffer_kmap_put(buffer);
> +		mutex_unlock(&buffer->lock);
> +	}
>   }
>   
>   static int ion_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
>   					enum dma_data_direction direction)
>   {
>   	struct ion_buffer *buffer = dmabuf->priv;
> -	void *vaddr;
>   	struct ion_dma_buf_attachment *a;
> -	int ret = 0;
> -
> -	/*
> -	 * TODO: Move this elsewhere because we don't always need a vaddr
> -	 */
> -	if (buffer->heap->ops->map_kernel) {
> -		mutex_lock(&buffer->lock);
> -		vaddr = ion_buffer_kmap_get(buffer);
> -		if (IS_ERR(vaddr)) {
> -			ret = PTR_ERR(vaddr);
> -			goto unlock;
> -		}
> -		mutex_unlock(&buffer->lock);
> -	}
>   
>   	mutex_lock(&buffer->lock);
>   	list_for_each_entry(a, &buffer->attachments, list) {
>   		dma_sync_sg_for_cpu(a->dev, a->table->sgl, a->table->nents,
>   				    direction);
>   	}
> -
> -unlock:
>   	mutex_unlock(&buffer->lock);
> -	return ret;
> +
> +	return 0;
>   }
>   
>   static int ion_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
> @@ -350,12 +352,6 @@ static int ion_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
>   	struct ion_buffer *buffer = dmabuf->priv;
>   	struct ion_dma_buf_attachment *a;
>   
> -	if (buffer->heap->ops->map_kernel) {
> -		mutex_lock(&buffer->lock);
> -		ion_buffer_kmap_put(buffer);
> -		mutex_unlock(&buffer->lock);
> -	}
> -
>   	mutex_lock(&buffer->lock);
>   	list_for_each_entry(a, &buffer->attachments, list) {
>   		dma_sync_sg_for_device(a->dev, a->table->sgl, a->table->nents,
> 

