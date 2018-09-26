Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFA3C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF27214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF27214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeIZWRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:17:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37948 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeIZWRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:17:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id r77-v6so9030569pgr.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 09:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5NyqmxwwOb+SXllFh3wehTityOAl0eRpHk5BPsT9J5M=;
        b=QVXaobn5Llo4L8pgQbfLXBWL028TBHMKbG5vPqE2cUCzyeD5oQ9fQZ2HzbFq5mEYnk
         doheZpes0QGgALX9Jpc6FkBTT+RtNLQgVFLrETrNcGUTxpQosZzTn6EaLLHi9Sl+01g4
         uMh+uhaB8hEGWX/n5ZV7ZgfuSBzoXNdGih0gCW6bOp8xbWBmnQPQ1MpPkHRsTGeJnRX8
         0NDnX2hcuWz7LRBonrMoXPDiRCsF+fQSvRfrv/gMYQaJDFv94zxmpeqcfVAj41vYMsku
         Bbtlu2tV7DJkurx5OBiSeRuJ/i4yHZm979e2PU40xJr9W0ViDxYWcZiHI4fUjNz33ibg
         3gEQ==
X-Gm-Message-State: ABuFfohnwp+JnkAmH26Sqe6XJCH1oIo+KTiHIIY6pjnuvyFtgZ2Y/Cwy
        qvVGIR1m+7L+AT8Wc0G5pyfuRg==
X-Google-Smtp-Source: ACcGV62BSYPcKCFPwOCa6pgzSQGSR0TVvcUY6CQ3CDHEwDmazNwwL0pFPL3SvY5J17bblXwlZQSk3g==
X-Received: by 2002:a63:bd01:: with SMTP id a1-v6mr6368672pgf.12.1537977810687;
        Wed, 26 Sep 2018 09:03:30 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id u17-v6sm12480361pfa.176.2018.09.26.09.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 09:03:29 -0700 (PDT)
Date:   Wed, 26 Sep 2018 09:03:29 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Moritz Fischer <mdf@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: nixge: fix warnings on 32-bit platforms
Message-ID: <20180926160328.GA1927@archbook>
References: <20180926124808.1867468-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926124808.1867468-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, Sep 26, 2018 at 02:47:24PM +0200, Arnd Bergmann wrote:
> Making it work on 64-bit caused 32-bit builds to regress:
> 
> drivers/net/ethernet/ni/nixge.c: In function 'nixge_hw_dma_bd_release':
> drivers/net/ethernet/ni/nixge.c:254:9: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>    skb = (struct sk_buff *)
>          ^
> In file included from include/linux/skbuff.h:17,
>                  from include/linux/if_ether.h:23,
>                  from include/linux/etherdevice.h:25,
>                  from drivers/net/ethernet/ni/nixge.c:7:
> drivers/net/ethernet/ni/nixge.c: In function 'nixge_hw_dma_bd_init':
> drivers/net/ethernet/ni/nixge.c:130:37: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>    (bd)->field##_lo = lower_32_bits(((u64)addr)); \
>                                      ^
> include/linux/kernel.h:234:33: note: in definition of macro 'lower_32_bits'
>  #define lower_32_bits(n) ((u32)(n))
>                                  ^
> 
> Casting to a uintptr_t avoids all these warnings.
> 
> Fixes: 7e8d5755be0e ("net: nixge: Add support for 64-bit platforms")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/ni/nixge.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
> index 74cf52e3fb09..2e132f6a7c36 100644
> --- a/drivers/net/ethernet/ni/nixge.c
> +++ b/drivers/net/ethernet/ni/nixge.c
> @@ -127,8 +127,8 @@ struct nixge_hw_dma_bd {
>  #ifdef CONFIG_PHYS_ADDR_T_64BIT
>  #define nixge_hw_dma_bd_set_addr(bd, field, addr) \
>  	do { \
> -		(bd)->field##_lo = lower_32_bits(((u64)addr)); \
> -		(bd)->field##_hi = upper_32_bits(((u64)addr)); \
> +		(bd)->field##_lo = lower_32_bits(((uintptr_t)addr)); \
> +		(bd)->field##_hi = upper_32_bits(((uintptr_t)addr)); \
>  	} while (0)
>  #else
>  #define nixge_hw_dma_bd_set_addr(bd, field, addr) \
> @@ -251,7 +251,7 @@ static void nixge_hw_dma_bd_release(struct net_device *ndev)
>  				 NIXGE_MAX_JUMBO_FRAME_SIZE,
>  				 DMA_FROM_DEVICE);
>  
> -		skb = (struct sk_buff *)
> +		skb = (struct sk_buff *)(uintptr_t)
>  			nixge_hw_dma_bd_get_addr(&priv->rx_bd_v[i],
>  						 sw_id_offset);
>  		dev_kfree_skb(skb);
> @@ -601,8 +601,8 @@ static int nixge_recv(struct net_device *ndev, int budget)
>  		tail_p = priv->rx_bd_p + sizeof(*priv->rx_bd_v) *
>  			 priv->rx_bd_ci;
>  
> -		skb = (struct sk_buff *)nixge_hw_dma_bd_get_addr(cur_p,
> -								 sw_id_offset);
> +		skb = (struct sk_buff *)(uintptr_t)
> +			nixge_hw_dma_bd_get_addr(cur_p, sw_id_offset);
>  
>  		length = cur_p->status & XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
>  		if (length > NIXGE_MAX_JUMBO_FRAME_SIZE)
> -- 
> 2.18.0
> 

I had submitted a similar patch https://lkml.org/lkml/2018/9/24/1719
here. I should probably add the Fixes tag yours has but other than that
they look largely equivalent. Comments?

Thanks,

Moritz
