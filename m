Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D7FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33472146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZK4BHGAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33472146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbeISFJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 01:09:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46268 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeISFJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 01:09:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id u24-v6so1732409pfn.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 16:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KIsFAbs/sm2ZutcLohC8ZOYBYWbliwjU2C5LK84ZQ5U=;
        b=ZK4BHGAfH25XYMMZmq2KmCA50Kpjg++y49FMQXjTZ940mH4FV5QncWtC22d03aKALQ
         vWC7lTq1jKbHhjGxFHlNbPnPGaUxcCfm6WFuhiZQdrymWYrQEHMU7ziVWEs0PzK7QBhL
         Lzu/gFy7KD/wxnq6ULxaYism4/OFVAMVmf9Q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KIsFAbs/sm2ZutcLohC8ZOYBYWbliwjU2C5LK84ZQ5U=;
        b=Ydt8P/t0aSr7olRzTpk7syPbtIym5WcKSTmwjQmT5q2vw1R66jTID+AAOEtLp1Km0F
         CT4qFpocnT2KZJYXxDQvNSQk6I0EA9NrzPvbC2vZGaV8Vsa7238Lv/No9CAHczsz5EHm
         8tnoTFKXHxQx6AALFerBm6JPNczZkMgb1Gbui2uYpChkVhHLJRkcpLpSyWPkjcAZxT7p
         D3PnQy0SqETvsrz7V2NqS28QO5bOmQ3gVYpTzFPnyvZRavnaRw564f88M5KR/nMXFycn
         HexEPR+0mvKIVs1rBIwTCjXZVEAxUqXLtHqc3jqd1ZqMkQlEZWGNGn6XO3uRNJZnp+u2
         beeQ==
X-Gm-Message-State: APzg51CmoBrA05MYCJQPFTRYp+XtuoPS52xrBeJrRJQLyWyiVB7tI/CX
        PcgOBpPtZ+s8vUNsyWan8rEp
X-Google-Smtp-Source: ANB0VdbEfksfs7SdXObC6jq34YQGK4oic+Sjm4M27Do4MBz/V2Hwp0MDogs0QTiuhwTnYqdxfgbnAQ==
X-Received: by 2002:a63:5204:: with SMTP id g4-v6mr29527417pgb.274.1537313656443;
        Tue, 18 Sep 2018 16:34:16 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id d81-v6sm30791122pfj.122.2018.09.18.16.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 16:34:15 -0700 (PDT)
Date:   Tue, 18 Sep 2018 16:34:14 -0700
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Vinod <vkoul@kernel.org>
Cc:     dan.j.williams@intel.com, afaerber@suse.de, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
        liuwei@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br
Subject: Re: [PATCH 2/3] dmaengine: Add Slave and Cyclic mode support for
 Actions Semi Owl S900 SoC
Message-ID: <20180918233414.GA19844@Mani-XPS-13-9360>
References: <20180901164215.3683-1-manivannan.sadhasivam@linaro.org>
 <20180901164215.3683-3-manivannan.sadhasivam@linaro.org>
 <20180918163512.GE2613@vkoul-mobl>
 <20180918225236.GA17306@Mani-XPS-13-9360>
 <20180918233200.GK2613@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918233200.GK2613@vkoul-mobl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 04:32:00PM -0700, Vinod wrote:
> Hi Mani,
> 
> On 18-09-18, 15:52, Manivannan Sadhasivam wrote:
> > On Tue, Sep 18, 2018 at 09:35:12AM -0700, Vinod wrote:
> > > On 01-09-18, 22:12, Manivannan Sadhasivam wrote:
> > > 
> > > > @@ -364,6 +372,26 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
> > > >  			OWL_DMA_MODE_DT_DCU | OWL_DMA_MODE_SAM_INC |
> > > >  			OWL_DMA_MODE_DAM_INC;
> > > >  
> > > > +		break;
> > > > +	case DMA_MEM_TO_DEV:
> > > > +		mode |= OWL_DMA_MODE_TS(vchan->drq)
> > > > +			| OWL_DMA_MODE_ST_DCU | OWL_DMA_MODE_DT_DEV
> > > > +			| OWL_DMA_MODE_SAM_INC | OWL_DMA_MODE_DAM_CONST;
> > > > +
> > > > +		/* Handle bus width for UART */
> > > > +		if (sconfig->dst_addr_width == DMA_SLAVE_BUSWIDTH_1_BYTE)
> > > > +			mode |= OWL_DMA_MODE_NDDBW_8BIT;
> > > 
> > > this is fine per se, but not correct way to handle in dmaengine driver.
> > > You should be agnostic to user of dmaengine, so handle all the buswidths
> > > the IP block supports and update the values accordingly. That way new
> > > uses can be added w/o requiring change in dmaengine driver
> > 
> > Currently, all members of Owl family supports only 32bit and 8bit
> > bus widths. 32bit is common for all peripherals and 8bit applies to only
> > UART since the internal buffer is 8bit wide. So, this makes sense to me!
> 
> Above you are onky handing DMA_SLAVE_BUSWIDTH_1_BYTE and not 32bit which
> this IP supports.. You should handle all widths supported vt hardware..
>

Hi Vinod,

Default width is 32bit and we will only override it for UART... Should I
add a comment stating this?

Thanks,
Mani

> -- 
> ~Vinod
