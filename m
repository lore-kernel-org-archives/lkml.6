Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449FDC1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E6B20896
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbfARUsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 15:48:07 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33815 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729437AbfARUsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 15:48:06 -0500
Received: by mail-qk1-f194.google.com with SMTP id q8so8867260qke.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 12:48:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JB9u0uJwLlp13f1Tu5byW66K3dszZKTeroCvxmljJv4=;
        b=B8NBL+zKWmVqf+vZeZOsaahsa9XFUn3SEbEi2n7rqZ6RwDbyL7Klj5P1gwx+hoiANF
         h3ahJk3vTX0+poTHKdSCkhYXHj3oCP4dRgxOFVQObsQHf1idV5rP0PfhNJBca/HnKWE7
         f06W1U0oeO5SJrpB29Ty+U4G/V1eIBZwPXzwtdWLl6or1XnxRihjxJDQA1AACYoazrJO
         i1k2RY7Lt50eONad2Q1OdbDjbylwV9ZNGeq7Ku9feNB9Lsji9obZVwvMu6FUbmuHLPOh
         pnA2bihZCttTrmsAqH4xLyHYzQktyt/TPtunRDqu0F4gjstShl+2DJdx2ot+MDeEX99f
         jRXQ==
X-Gm-Message-State: AJcUukcGl+3knHQze5oGu7YCSZATKCNZqA/NJV4RCIB6oWT4dn2ysbIw
        BTetozHgmNTHJresjkpwL738qA==
X-Google-Smtp-Source: ALg8bN66utnXRyu0OYmHtDBBTzDxPvasLqGIYCkKugS5FxFhSYOj5xpQgCh82vD5PLP3miPQPWDFHw==
X-Received: by 2002:a37:8f02:: with SMTP id r2mr16698392qkd.246.1547844486072;
        Fri, 18 Jan 2019 12:48:06 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::fb21? ([2601:602:9800:dae6::fb21])
        by smtp.gmail.com with ESMTPSA id m193sm43248352qke.61.2019.01.18.12.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 12:48:05 -0800 (PST)
Subject: Re: [PATCH 3/4] dma-buf: add support for mapping with dma mapping
 attributes
To:     Liam Mark <lmark@codeaurora.org>, sumit.semwal@linaro.org
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        afd@ti.com, john.stultz@linaro.org
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
 <1547836667-13695-4-git-send-email-lmark@codeaurora.org>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <9f654f36-08de-f5e8-c9b3-ff9b2954f0a6@redhat.com>
Date:   Fri, 18 Jan 2019 12:48:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547836667-13695-4-git-send-email-lmark@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 10:37 AM, Liam Mark wrote:
> Add support for configuring dma mapping attributes when mapping
> and unmapping memory through dma_buf_map_attachment and
> dma_buf_unmap_attachment.
> 
> Signed-off-by: Liam Mark <lmark@codeaurora.org>
> ---
>   include/linux/dma-buf.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index 58725f890b5b..59bf33e09e2d 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -308,6 +308,8 @@ struct dma_buf {
>    * @dev: device attached to the buffer.
>    * @node: list of dma_buf_attachment.
>    * @priv: exporter specific attachment data.
> + * @dma_map_attrs: DMA mapping attributes to be used in
> + *		   dma_buf_map_attachment() and dma_buf_unmap_attachment().
>    *
>    * This structure holds the attachment information between the dma_buf buffer
>    * and its user device(s). The list contains one attachment struct per device
> @@ -323,6 +325,7 @@ struct dma_buf_attachment {
>   	struct device *dev;
>   	struct list_head node;
>   	void *priv;
> +	unsigned long dma_map_attrs;
>   };
>   
>   /**
> 

Did you miss part of this patch? This only adds it to the structure but doesn't
add it to any API. The same commment applies to the follow up patch,
I don't quite see how it's being used.

Thanks,
Laura
