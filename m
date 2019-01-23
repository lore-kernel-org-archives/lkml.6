Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82975C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6DF20861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548245816;
	bh=sYpBi9Rv15CsOdOlrt6+JUPIBr033oHvZ52AthQyOao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BbemEwZXDah1ZgaI+NBuOXZMEMfYk02//FnDZUfzxvHs2tXU45CZxFayUTAmGEv5Q
	 nSIR8a2NkgloY3fnuhrwsweLzo3MNO8NSr1wHzrWhBjHg+KGMYHxlgnEbPL4CWe51o
	 oGZfLNgP+npxvHc/driolZqR6O6ebM8992Ld9YVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfAWMQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:16:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfAWMQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:16:54 -0500
Received: from localhost (unknown [106.200.229.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 836EF20861;
        Wed, 23 Jan 2019 12:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548245813;
        bh=sYpBi9Rv15CsOdOlrt6+JUPIBr033oHvZ52AthQyOao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Poht8yJz86OvJzoNsvR1ib6WGFUEeuthADX0MQ4Xyk7h041YQBhQzAIAN6Prl9Bf
         JmFWoquZ8+W2dgtI94BaDisrZVeMuOHevBBO6jE5pM8BctJWaE8sjmF/QpEcyzRDv0
         qArttKYzKIJXJdZusuTBNt5SpTjPkYPNDat3a4RQ=
Date:   Wed, 23 Jan 2019 17:45:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: dmaengine: usage of dmaengine_get() and dma_find_channel()
Message-ID: <20190123121521.GM4635@vkoul-mobl>
References: <23108003.0nNWatJzJB@pcbe13614>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23108003.0nNWatJzJB@pcbe13614>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-01-19, 17:41, Federico Vaga wrote:
> Hello,
> 
> I am a bit puzzle about the proper usage these two functions:
> 
> void dmaengine_get(void)
> struct dma_chan *dma_find_channel(enum dma_transaction_type tx_type)
> 
> Looking into the kernel sources dma_find_channel is not used, despite the fact 
> that it looks as one of the suggested mechanism to access a DMA engine. So, I 
> cannot find a valid example of its usage.
> 
> The same for dmaengine_get(). On the other hand, at least this function is 
> used in: drivers/video/fbdev/mx3fb.c. But I believe that its usage is wrong 
> because it uses: dmaengine_get() + dma_request_channel(), instead of 
> dmaengine_get() + dma_find_channel().
> 
> Reading the code my understanding is that dmaengine_get() + dma_find_channel() 
> should be used for "public" (not private) DMA engine channels.
> 
> It's here where things are getting obscure to me. My understanding is that DMA 
> channels which are not private can be used by several drivers at the same 
> time. In principle they submit all their transfers and the DMA engine will 
> process them and then the DMA engine will notify the drivers about their 
> completion.

The concept of public channel is a channel capable of doing any dma
transfer for example a system dmaengine capable of flipping bits from
system memory to memory/devices.

For peripherals, we cannot do a generic transfer and the transfer is
specific given a set of parameters for it to work, thus the channel is
private... These channels can be used by many users as long as that is
supported by engine. In an idle world, the dmaengine should have N
channels and provide M software channels and lets users use them and
schedule these for best throughput, we are not there yet :(

> My understanding is also that the dmaengine subsystem assumes that "public" 
> channels of the same type are interchangeable.
> 
> In my use case I wrote a DMA engine which is specific for a subset of driver, 
> and it cannot be used by others (so is sharable among a group of drivers). All 
> these drivers, potentially, they can submit their transfers to the DMA engine 
> in parallel; but I cannot do it because I'm forced to use 
> dma_request_channel() in order to be able to filter the DMA channels, and this 
> will make automatically the channel PRIVATE which prevents other drivers to 
> use the same channel.

Please use virtual channels for that, clients can use virtual channels
and they can be submitted to a hardware channel.

> With the current API I do not see alternative for me. I have to use 
> dma_request_channel() in order to filter DMA channels. But I am wondering if 
> it make sense for you, and if it does, is there a solution today? Or, is it 
> possibile to design one?
> 
> Thanks (I do not know if this message is clear enough)
> 

-- 
~Vinod
