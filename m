Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E05BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0781920652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAqq+8s5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfAQPZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:25:29 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35899 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfAQPZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:25:28 -0500
Received: by mail-qt1-f195.google.com with SMTP id t13so11708535qtn.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 07:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sWXxCBB8Nivy/3zb+B95MOFQdh3vwvPbSP/ZdbU73Ic=;
        b=DAqq+8s5NXvG2YDmdsMcVKPtr/jUt1Lnf7yQ8fwAoZ9DgwA/THTrN5tTB+lTPtbJ6Y
         15B2fkKcKRqiMCePGlqIJJOsetxvlWLac0RwWG2sB/W3rQ9ZhdzrvggnhaXwYfJOe/NW
         p5aiCUZmg60RQGNrV4c1ltuGnVPwY7OrBHMzZpXQrhCR/cozUaHZ+L20acuBx044cSl/
         cNwnKGkuhZ3AIxtDQQLX391CNmty5EeUq4l6aCDEnTo4+x9w5Vu7mIfKb+JBLSEdI3+x
         ZEFDOQvGldBV+7qIAzRTdfTV/+veSy7JDvx5Gnb18wWqMhfRfDJBjQtuovn7xICCtVe4
         2j5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sWXxCBB8Nivy/3zb+B95MOFQdh3vwvPbSP/ZdbU73Ic=;
        b=PfEikxC9AJRd3XPGhFvIY8MuVdAe0Mdx6SRIMuD7Pjok2dDiXdoXwE1KldteAJRvB8
         ihIu7Jrmvuow4ix/cpBd7nZ/JduZwP4bdvBKwg6AbH3ASgIJ0ytgs4sVc70KGI7gfGfm
         fX/sJW7ud9x/iFunuBSiEg+XpfwRL3ff07W2hM+CCCwoG+yn07CUS7CGI5G1jDq8jqH3
         oS2SibVSRQAc6O3K5eyYGf939jCkrw30QldqMjdCMnBKKF3/JeffFVI1t9IpgcGT4ptk
         tZIZy9EncIw6KraHNhotBCYiP3IjlDCZOxURlonWm4bc96zphmCIDPWiYwSULA0NdESh
         OE2Q==
X-Gm-Message-State: AJcUukffm3oSImkBJ2LSDV6kgwRAB2Nu83UOZV2xjErjOCLo+9870mMU
        zzpDrZiMl8S0c7zZafvAmZmr5xQ3
X-Google-Smtp-Source: ALg8bN6npU102hKZVmFdO5DYfR7byUitHaskIFxi+2QoHBBqZls+DSq00qhwLLjH0XFdydpmlhZmKA==
X-Received: by 2002:a0c:aca7:: with SMTP id m36mr11445658qvc.237.1547738726934;
        Thu, 17 Jan 2019 07:25:26 -0800 (PST)
Received: from localhost.localdomain (198-0-156-163-static.hfc.comcastbusiness.net. [198.0.156.163])
        by smtp.gmail.com with ESMTPSA id d21sm16474qtr.34.2019.01.17.07.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 07:25:26 -0800 (PST)
Date:   Thu, 17 Jan 2019 10:25:23 -0500
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, joe.jin@oracle.com
Subject: Re: [PATCH v2 2/2] swiotlb: checking whether swiotlb buffer is full
 with io_tlb_used
Message-ID: <20190117152520.GA24900@localhost.localdomain>
References: <1544402278-8175-1-git-send-email-dongli.zhang@oracle.com>
 <1544402278-8175-2-git-send-email-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544402278-8175-2-git-send-email-dongli.zhang@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 08:37:58AM +0800, Dongli Zhang wrote:
> This patch uses io_tlb_used to help check whether swiotlb buffer is full.
> io_tlb_used is no longer used for only debugfs. It is also used to help
> optimize swiotlb_tbl_map_single().

Please split this up.

That is have the 'if (unlikely(nslots > io_tlb_nslabs - io_tlb_used))'
as a seperate patch.

And the #ifdef folding in the previous patch.

Also rebase on top of latest Linus please.

> 
> Suggested-by: Joe Jin <joe.jin@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  kernel/dma/swiotlb.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 3979c2c..9300341 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -76,12 +76,10 @@ static phys_addr_t io_tlb_start, io_tlb_end;
>   */
>  static unsigned long io_tlb_nslabs;
>  
> -#ifdef CONFIG_DEBUG_FS
>  /*
>   * The number of used IO TLB block
>   */
>  static unsigned long io_tlb_used;
> -#endif
>  
>  /*
>   * This is a free list describing the number of free entries available from
> @@ -489,6 +487,10 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  	 * request and allocate a buffer from that IO TLB pool.
>  	 */
>  	spin_lock_irqsave(&io_tlb_lock, flags);
> +
> +	if (unlikely(nslots > io_tlb_nslabs - io_tlb_used))
> +		goto not_found;
> +
>  	index = ALIGN(io_tlb_index, stride);
>  	if (index >= io_tlb_nslabs)
>  		index = 0;
> @@ -538,9 +540,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
>  	return SWIOTLB_MAP_ERROR;
>  found:
> -#ifdef CONFIG_DEBUG_FS
>  	io_tlb_used += nslots;
> -#endif
>  	spin_unlock_irqrestore(&io_tlb_lock, flags);
>  
>  	/*
> @@ -602,9 +602,7 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
>  		for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE -1) && io_tlb_list[i]; i--)
>  			io_tlb_list[i] = ++count;
>  
> -#ifdef CONFIG_DEBUG_FS
>  		io_tlb_used -= nslots;
> -#endif
>  	}
>  	spin_unlock_irqrestore(&io_tlb_lock, flags);
>  }
> -- 
> 2.7.4
> 
