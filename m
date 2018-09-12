Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11ED8C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 04:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE1320880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 04:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Enra9o8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE1320880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbeILJiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 05:38:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725738AbeILJiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 05:38:19 -0400
Received: from localhost (unknown [171.76.126.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66B08206B6;
        Wed, 12 Sep 2018 04:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536726940;
        bh=qlSRNh7I87/Zh5D+AEgF5XtMMtu1XdLNhNmUK7gOOK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Enra9o8u3YIS9CdDHTxMsdC8OdpD0pGmT7G1rebnLBkR1wnZgFYu8h41l3ul+0epF
         9zloKau4KM8uxs2NkT0hPmOEfQPQ46nuGzA3TBDuQDvmUL/GD3YaFoR9n089mtw5NB
         P5oWLOuNM6UiI3lip1/VjuN2RYveDIA7TDJu2QqM=
Date:   Wed, 12 Sep 2018 10:05:30 +0530
From:   Vinod <vkoul@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] dmaengine: uniphier-mdmac: add UniPhier MIO DMAC
 driver
Message-ID: <20180912043530.GE2766@vkoul-mobl>
References: <1535074873-15617-1-git-send-email-yamada.masahiro@socionext.com>
 <1535074873-15617-3-git-send-email-yamada.masahiro@socionext.com>
 <20180911070003.GI2634@vkoul-mobl>
 <CAK7LNASMhKfQT-Hqv48=HqOPRx3OVMtdNBEe=c7dE-B_5_Nuyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASMhKfQT-Hqv48=HqOPRx3OVMtdNBEe=c7dE-B_5_Nuyw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-09-18, 12:01, Masahiro Yamada wrote:
> Hi Vinod,
> 
> 
> 2018-09-11 16:00 GMT+09:00 Vinod <vkoul@kernel.org>:
> > On 24-08-18, 10:41, Masahiro Yamada wrote:
> >
> >> +/* mc->vc.lock must be held by caller */
> >> +static u32 __uniphier_mdmac_get_residue(struct uniphier_mdmac_desc *md)
> >> +{
> >> +     u32 residue = 0;
> >> +     int i;
> >> +
> >> +     for (i = md->sg_cur; i < md->sg_len; i++)
> >> +             residue += sg_dma_len(&md->sgl[i]);
> >
> > so if the descriptor is submitted to hardware, we return the descriptor
> > length, which is not correct.
> >
> > Two cases are required to be handled:
> > 1. Descriptor is in queue (IMO above logic is fine for that, but it can
> > be calculated at descriptor submit and looked up here)
> 
> Where do you want it to be calculated?

where is it calculated now?

> This hardware provides only simple registers (address and size)
> for one-shot transfer instead of descriptors.
> 
> So, I used sgl as-is because I did not see a good reason
> to transform sgl to another data structure.


> > this seems missing stuff. Where do you do register calculation for the
> > descriptor and where is slave_config here, how do you know where to
> > send/receive data form/to (peripheral)
> 
> 
> This dmac is really simple, and un-flexible.
> 
> The peripheral address to send/receive data from/to is hard-weird.
> cfg->{src_addr,dst_addr} is not configurable.
> 
> Look at __uniphier_mdmac_handle().
> 'dest_addr' and 'src_addr' must be set to 0 for the peripheral.

Fair enough, what about other values like addr_width and maxburst?
-- 
~Vinod
