Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4C7C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F0F214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vhgkucat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F0F214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbeISFG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 01:06:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbeISFG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 01:06:57 -0400
Received: from localhost (unknown [209.121.128.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C528A2146D;
        Tue, 18 Sep 2018 23:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537313520;
        bh=AWFW9ZFyFL4dSt7DvO2Z0+EIZSwA0HJssT0uc6T++eo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vhgkucat5OCzUlhRlzCpQK8BhVqJvfUZm6G6s1wMqm+Ogy3UKcND1FMCpSvyIKXES
         yWgF4HoAQaTJDjIyNrJrVNZhuTDLz4yxbmObLDN7dxDV7jrSx9/Q/IGzOujcK7g47l
         Px3Q/dTIU4Gp9cwB2p1+tLvU2Ar0WNdfnNy+w14E=
Date:   Tue, 18 Sep 2018 16:32:00 -0700
From:   Vinod <vkoul@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Message-ID: <20180918233200.GK2613@vkoul-mobl>
References: <20180901164215.3683-1-manivannan.sadhasivam@linaro.org>
 <20180901164215.3683-3-manivannan.sadhasivam@linaro.org>
 <20180918163512.GE2613@vkoul-mobl>
 <20180918225236.GA17306@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918225236.GA17306@Mani-XPS-13-9360>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On 18-09-18, 15:52, Manivannan Sadhasivam wrote:
> On Tue, Sep 18, 2018 at 09:35:12AM -0700, Vinod wrote:
> > On 01-09-18, 22:12, Manivannan Sadhasivam wrote:
> > 
> > > @@ -364,6 +372,26 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
> > >  			OWL_DMA_MODE_DT_DCU | OWL_DMA_MODE_SAM_INC |
> > >  			OWL_DMA_MODE_DAM_INC;
> > >  
> > > +		break;
> > > +	case DMA_MEM_TO_DEV:
> > > +		mode |= OWL_DMA_MODE_TS(vchan->drq)
> > > +			| OWL_DMA_MODE_ST_DCU | OWL_DMA_MODE_DT_DEV
> > > +			| OWL_DMA_MODE_SAM_INC | OWL_DMA_MODE_DAM_CONST;
> > > +
> > > +		/* Handle bus width for UART */
> > > +		if (sconfig->dst_addr_width == DMA_SLAVE_BUSWIDTH_1_BYTE)
> > > +			mode |= OWL_DMA_MODE_NDDBW_8BIT;
> > 
> > this is fine per se, but not correct way to handle in dmaengine driver.
> > You should be agnostic to user of dmaengine, so handle all the buswidths
> > the IP block supports and update the values accordingly. That way new
> > uses can be added w/o requiring change in dmaengine driver
> 
> Currently, all members of Owl family supports only 32bit and 8bit
> bus widths. 32bit is common for all peripherals and 8bit applies to only
> UART since the internal buffer is 8bit wide. So, this makes sense to me!

Above you are onky handing DMA_SLAVE_BUSWIDTH_1_BYTE and not 32bit which
this IP supports.. You should handle all widths supported vt hardware..

-- 
~Vinod
