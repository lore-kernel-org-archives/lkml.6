Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7853CC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467DD21477
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467DD21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbeJMBZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:25:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42706 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJMBZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:25:23 -0400
Received: by mail-qt1-f196.google.com with SMTP id j46-v6so14723379qtc.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 10:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4qmu83MR5VX3tzffJ5LBoeWXTlCd2NWBGIEiIg8b/GA=;
        b=XGnpnr7z8gRwRnoRxU9hvR8A46bZ0jnXDl1olOL7d1nY80kHt0PxG8p6lgY34AUTNn
         27H5SHpTNW3xcO4ydnq/jlaNm0lcLdyzEkiuCE9PPHls0SVbiFOBri/RhJe5VktoogDj
         qmzjTVoYjPmYKnfwM0qnn4qn3/HOKajicZQWlP6uEBW3qrBFzqwVEvMg4sfWFB1cYOBd
         xxANhiGmVJa+fSpb6YSeaLVFwIYFcg2tkjkpx0Ef255oGTj5QGf6x9bpsPDPk6NzMDPR
         JKMw5I3TJ16ChlFPnX4Bpu9QISw6wN4b32n/I4sSthKSZ/Nub4iYPoxcO9L8udeqgAAO
         pC6Q==
X-Gm-Message-State: ABuFfohsm7eAOllPGN3ie5GILKP9BPWbw8IfbfMh5EzZUon2YXC41cNA
        ouVQE1vFojgCQbcsXcUZqP25bQ==
X-Google-Smtp-Source: ACcGV61kmC6jFk/pr1ZtyiRfYGPpEMOzlIVOTnLHfocjlpgp9jMYVzIL98dzsUefR9sIhyo14PPsEQ==
X-Received: by 2002:ac8:468e:: with SMTP id g14-v6mr6482319qto.137.1539366704667;
        Fri, 12 Oct 2018 10:51:44 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc:4eb2:6dae:ab32:e5b0? ([2601:602:9802:a8dc:4eb2:6dae:ab32:e5b0])
        by smtp.gmail.com with ESMTPSA id 144-v6sm1027795qkk.63.2018.10.12.10.51.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 10:51:43 -0700 (PDT)
Subject: Re: [PATCH] staging: ion: Rework ion_map_dma_buf() to minimize
 re-mapping
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Beata Michalska <Beata.Michalska@arm.com>,
        Matt Szczesiak <matt.szczesiak@arm.com>,
        Anders Pedersen <Anders.Pedersen@arm.com>,
        John Reitan <John.Reitan@arm.com>,
        Liam Mark <lmark@codeaurora.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        dri-devel@lists.freedesktop.org
References: <1539214413-26173-1-git-send-email-john.stultz@linaro.org>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <7534ca1d-f874-7809-6125-d9fc72f70e39@redhat.com>
Date:   Fri, 12 Oct 2018 10:51:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539214413-26173-1-git-send-email-john.stultz@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2018 04:33 PM, John Stultz wrote:
> Since 4.12, much later narrowed down to commit 2a55e7b5e544
> ("staging: android: ion: Call dma_map_sg for syncing and mapping"),
> we have seen graphics performance issues on the HiKey960.
> 
> This was initially confounded by the fact that the out-of-tree
> DRM driver was using HiSi custom ION heap which broke with the
> 4.12 ION abi changes, so there was lots of suspicion that the
> performance problems were due to switching to a somewhat simple
> cma based DRM driver for HiKey960. Additionally, as no
> performance regression was seen w/ the original HiKey board
> (which is SMP, not big.LITTLE as w/ HiKey960), there was some
> thought that the out-of-tree EAS code wasn't quite optimized.
> 
> But after chasing a number of other leads, I found that
> reverting the ION code to 4.11-era got the majority of the
> graphics performance back (there may yet be further EAS tweaks
> needed), which lead me to the dma_map_sg change.
> 
> In talking w/ Laura and Liam, it was suspected that the extra
> cache operations were causing the trouble. Additionally, I found
> that part of the reason we didn't see this w/ the original
> HiKey board is that its (proprietary blob) GL code uses ion_mmap
> and ion_map_dma_buf is called very rarely, where as with
> HiKey960, the (also proprietary blob) GL code calls
> ion_map_dma_buf much more frequently via the kernel driver.
> 
> Anyway, with the cause of the performance regression isolated,
> I've tried to find a way to improve the performance of the
> current code.
> 
> This approach, which I've mostly copied from the drm_prime
> implementation is to try to track the direction we're mapping
> the buffers so we can avoid calling dma_map/unmap_sg on every
> ion_map_dma_buf/ion_unmap_dma_buf call, and instead try to do
> the work in attach/detach paths.
> 
> I'm not 100% sure of the correctness here, so close review would
> be good, but it gets the performance back to being similar to
> reverting the ION code to the 4.11-era.
> 
> Feedback would be greatly appreciated!
> 
> Cc: Beata Michalska <Beata.Michalska@arm.com>
> Cc: Matt Szczesiak <matt.szczesiak@arm.com>
> Cc: Anders Pedersen <Anders.Pedersen@arm.com>
> Cc: John Reitan <John.Reitan@arm.com>
> Cc: Liam Mark <lmark@codeaurora.org>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Martijn Coenen <maco@android.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>   drivers/staging/android/ion/ion.c | 36 +++++++++++++++++++++++++++++++-----
>   1 file changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index 9907332..a4d7fca 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -199,6 +199,7 @@ struct ion_dma_buf_attachment {
>   	struct device *dev;
>   	struct sg_table *table;
>   	struct list_head list;
> +	enum dma_data_direction dir;
>   };
>   
>   static int ion_dma_buf_attach(struct dma_buf *dmabuf,
> @@ -220,6 +221,7 @@ static int ion_dma_buf_attach(struct dma_buf *dmabuf,
>   
>   	a->table = table;
>   	a->dev = attachment->dev;
> +	a->dir = DMA_NONE;
>   	INIT_LIST_HEAD(&a->list);
>   
>   	attachment->priv = a;
> @@ -236,6 +238,18 @@ static void ion_dma_buf_detatch(struct dma_buf *dmabuf,
>   {
>   	struct ion_dma_buf_attachment *a = attachment->priv;
>   	struct ion_buffer *buffer = dmabuf->priv;
> +	struct sg_table *table;
> +
> +	if (!a)
> +		return;
> +
> +	table = a->table;
> +	if (table) {
> +		if (a->dir != DMA_NONE)
> +			dma_unmap_sg(attachment->dev, table->sgl, table->nents,
> +				     a->dir);
> +		sg_free_table(table);
> +	}
>   
>   	free_duped_table(a->table);
>   	mutex_lock(&buffer->lock);
> @@ -243,6 +257,7 @@ static void ion_dma_buf_detatch(struct dma_buf *dmabuf,
>   	mutex_unlock(&buffer->lock);
>   
>   	kfree(a);
> +	attachment->priv = NULL;
>   }
>   
>   static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
> @@ -251,12 +266,24 @@ static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
>   	struct ion_dma_buf_attachment *a = attachment->priv;
>   	struct sg_table *table;
>   
> -	table = a->table;
> +	if (WARN_ON(direction == DMA_NONE || !a))
> +		return ERR_PTR(-EINVAL);
>   
> -	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
> -			direction))
> -		return ERR_PTR(-ENOMEM);
> +	if (a->dir == direction)
> +		return a->table;
>   
> +	if (WARN_ON(a->dir != DMA_NONE))
> +		return ERR_PTR(-EBUSY);
> +
> +	table = a->table;
> +	if (!IS_ERR(table)) {
> +		if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
> +				direction)) {
> +			table = ERR_PTR(-ENOMEM);
> +		} else {
> +			a->dir = direction;
> +		}
> +	}
>   	return table;
>   }
>   
> @@ -264,7 +291,6 @@ static void ion_unmap_dma_buf(struct dma_buf_attachment *attachment,
>   			      struct sg_table *table,
>   			      enum dma_data_direction direction)
>   {
> -	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);

This changes the semantics so that the only time a buffer
gets unmapped is on detach. I don't think we want to restrict
Ion to that behavior but I also don't know if anyone else
is relying on that. I thought there might have been some Qualcomm
stuff that did that (Liam? Todd?)

I suspect most of the cost of the dma_map/dma_unmap is from the
cache flushing and not the actual mapping operations. If this
is the case, another option might be to figure out how to
incorporate dma_attrs so drivers can use DMA_ATTR_SKIP_CPU_SYNC
to decide when they actually want to sync.

Thanks,
Laura

>   }
>   
>   static int ion_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
> 

