Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C47C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4732086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbfARUkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 15:40:12 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35275 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbfARUkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 15:40:12 -0500
Received: by mail-qk1-f195.google.com with SMTP id w204so8835788qka.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 12:40:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lwTaUTNBuHjjcupV4kAZVcE0HDJXSAgm6awdGXChx4U=;
        b=j55TDCgc9gYdTtJ9FyENhEDGird4XTy1tMYVoeZPJB8akgMLESTHQ9KtUi9cVeE9Ij
         vYO/5BAnhcETub67RnOlHoi1qoVpzLopTuQ6dmjJrhGlPaltudvZYwMWo047AmT/DlLc
         o+tiog+Yvv8GOejMPU95V2YSkNDHH/lxxeVPU6aNw5T/DlgWxsA9hL0z8GwM9r+jv1ug
         BFkEsxgEHrb1HA0oFhtDFYJtLTHi9P9gEfxZJahDMpbvt2MkvP8lLgBXbIvWEpePjI9E
         +4qs3icBtWwSjZF3DtXZbWlBfp/h1alLDF5ilZDmgr1ZRYUveksTdx7hJGWEWByfZt8+
         47fw==
X-Gm-Message-State: AJcUukeBlEVMjkzLmV7rkDVl56akcsyKUHa3rnh3c8v8iFW2dQAAyaOL
        DsIXJBiDZRfH0gJpSmLAGlp7QA==
X-Google-Smtp-Source: ALg8bN63KRU9cJipCM+QRgnN9p5pqOqpvExZr/KG+axO7ipCNolLBlM+34lCZqOi5Yuu6oU3olQpVA==
X-Received: by 2002:a37:7707:: with SMTP id s7mr16519077qkc.252.1547844011489;
        Fri, 18 Jan 2019 12:40:11 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::fb21? ([2601:602:9800:dae6::fb21])
        by smtp.gmail.com with ESMTPSA id m193sm43241153qke.61.2019.01.18.12.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 12:40:10 -0800 (PST)
Subject: Re: [PATCH 1/4] staging: android: ion: Support cpu access during
 dma_buf_detach
To:     Liam Mark <lmark@codeaurora.org>, sumit.semwal@linaro.org
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        afd@ti.com, john.stultz@linaro.org
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
 <1547836667-13695-2-git-send-email-lmark@codeaurora.org>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <84304c70-fd12-75a8-f073-acb3c76d79b7@redhat.com>
Date:   Fri, 18 Jan 2019 12:40:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547836667-13695-2-git-send-email-lmark@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 10:37 AM, Liam Mark wrote:
> Often userspace doesn't know when the kernel will be calling dma_buf_detach
> on the buffer.
> If userpace starts its CPU access at the same time as the sg list is being
> freed it could end up accessing the sg list after it has been freed.
> 
> Thread A				Thread B
> - DMA_BUF_IOCTL_SYNC IOCT
>   - ion_dma_buf_begin_cpu_access
>    - list_for_each_entry
> 					- ion_dma_buf_detatch
> 					 - free_duped_table
>     - dma_sync_sg_for_cpu
> 
> Fix this by getting the ion_buffer lock before freeing the sg table memory.
> 
> Fixes: 2a55e7b5e544 ("staging: android: ion: Call dma_map_sg for syncing and mapping")
> Signed-off-by: Liam Mark <lmark@codeaurora.org>
> ---
>   drivers/staging/android/ion/ion.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index a0802de8c3a1..6f5afab7c1a1 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -248,10 +248,10 @@ static void ion_dma_buf_detatch(struct dma_buf *dmabuf,
>   	struct ion_dma_buf_attachment *a = attachment->priv;
>   	struct ion_buffer *buffer = dmabuf->priv;
>   
> -	free_duped_table(a->table);
>   	mutex_lock(&buffer->lock);
>   	list_del(&a->list);
>   	mutex_unlock(&buffer->lock);
> +	free_duped_table(a->table);
>   
>   	kfree(a);
>   }
> 

Acked-by: Laura Abbott <labbott@redhat.com>
