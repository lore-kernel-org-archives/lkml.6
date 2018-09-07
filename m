Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ED3C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E506120652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RVQ7eAYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E506120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeIGWbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:31:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34818 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeIGWbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=L/xMawFhxdJ7gWCvy7G4gRF+nNXSDDK2zVZojQoCY0A=; b=RVQ7eAYUaioc14er2mqN16Dzp
        L29YCP4GFGGAUhOF378snopXBshHFl5K50OKHPyAiz0FhQxgUwx+h2gf0QbqYAndaheTSqtEaQDro
        KT0Qd/EKzXond9vg+8/Tew1ia/BpSo+IGMf+jt6LqCA6C8d8rf31bjL5WwyDATc2S/ul0oKDkf5h5
        nstjeYySmc+T7LNpAvmZXoVrmDUv52yk1OMBhfcFxtzSzoQ6YhkZEEHCMQNZJ4I9EXQDADqvOCUGR
        N2ldMIOZ5oPjnG2rSH+hhCgCyHVma1rRdejBw1l1ObJP2Vq7f7SgfcvDfC4OF8rNoWh6lW95ClrcU
        fscT5MLBg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyKt5-0007hL-56; Fri, 07 Sep 2018 17:49:43 +0000
Date:   Fri, 7 Sep 2018 10:49:42 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org
Subject: Re: [PATCH 2/6] md: convert to kvmalloc
Message-ID: <20180907174942.GB3425@bombadil.infradead.org>
References: <20180907165635.8469-1-kent.overstreet@gmail.com>
 <20180907165635.8469-3-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907165635.8469-3-kent.overstreet@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:56:31PM -0400, Kent Overstreet wrote:
> @@ -165,7 +164,7 @@ ops_run_partial_parity(struct stripe_head *sh, struct raid5_percpu *percpu,
>  		       struct dma_async_tx_descriptor *tx)
>  {
>  	int disks = sh->disks;
> -	struct page **srcs = flex_array_get(percpu->scribble, 0);
> +	struct page **srcs = percpu->scribble;
>  	int count = 0, pd_idx = sh->pd_idx, i;
>  	struct async_submit_ctl submit;
>  
> @@ -196,8 +195,8 @@ ops_run_partial_parity(struct stripe_head *sh, struct raid5_percpu *percpu,
>  	}
>  
>  	init_async_submit(&submit, ASYNC_TX_FENCE|ASYNC_TX_XOR_ZERO_DST, tx,
> -			  NULL, sh, flex_array_get(percpu->scribble, 0)
> -			  + sizeof(struct page *) * (sh->disks + 2));
> +			  NULL, sh, percpu->scribble +
> +			  sizeof(struct page *) * (sh->disks + 2));

I think this would read better written as:

	init_async_submit(&submit, ASYNC_TX_FENCE|ASYNC_TX_XOR_ZERO_DST, tx,
			  NULL, sh, srcs + sh->disks + 2);

>  static addr_conv_t *to_addr_conv(struct stripe_head *sh,
>  				 struct raid5_percpu *percpu, int i)
>  {
> -	void *addr;
> -
> -	addr = flex_array_get(percpu->scribble, i);
> -	return addr + sizeof(struct page *) * (sh->disks + 2);
> +	return percpu->scribble + i * percpu->scribble_obj_size +
> +		sizeof(struct page *) * (sh->disks + 2);
>  }
>  
>  /* return a pointer to the address conversion region of the scribble buffer */
>  static struct page **to_addr_page(struct raid5_percpu *percpu, int i)
>  {
> -	void *addr;
> -
> -	addr = flex_array_get(percpu->scribble, i);
> -	return addr;
> +	return percpu->scribble + i * percpu->scribble_obj_size;
>  }

Perhaps this would be better as ...

 static struct page **to_addr_page(struct raid5_percpu *percpu, int i)
 {
-	void *addr;
-
-	addr = flex_array_get(percpu->scribble, i);
-	return addr;
+	return percpu->scribble + i * percpu->scribble_obj_size;
 }

 static addr_conv_t *to_addr_conv(struct stripe_head *sh,
 				 struct raid5_percpu *percpu, int i)
 {
-	void *addr;
-
-	addr = flex_array_get(percpu->scribble, i);
-	return addr + sizeof(struct page *) * (sh->disks + 2);
+	return to_addr_page(percpu, i) + sh->disks + 2;
 }


The rest looks good.
