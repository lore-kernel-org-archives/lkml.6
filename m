Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D463ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84112133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OtravUJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84112133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeISE10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 00:27:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40820 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeISE10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 00:27:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17-v6so1672751plp.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 15:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dt+vUw7mDbyXvOd04XIAU28UAni/lvUREwcBFMD/UvY=;
        b=OtravUJz01swJ9fA1GhZxKs+GZXNJBWt5JCbzuQ1wNdZtY+m/IidXEjSkBt8T9HM/2
         myblvM9bmjYvyGivzagPqr9SLApIg4kDfnF/AvEwD+e5ZOBT/h7Q6X4+xqND9xYptyrv
         E2go1QiLpoMq+hhCQu2d4lquSoFqAnxEwfo8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dt+vUw7mDbyXvOd04XIAU28UAni/lvUREwcBFMD/UvY=;
        b=n5UpbrZb8bMClO6LvgwGWlmvzC9twzyTzVgc6nSSPLbe0wyVjdcmA3PAdq1Hbr53wr
         14/uMRWKOa0Bm9HTQE5qSCTaEhUqQMdwJy7GbgeDvmT4RnH7nGp8AevuiDkUFZfVglgK
         +RTY8tCkCo8TAt2IekTovrj+iuMPnWXETZzTy0wrFGVZNXR2DFhxW5KCJBDggOZxt2WR
         Q6jpyJAGFtcaZn3NOpW0GWwx0Gi+vz4nca7WJA7Jl+CAJbGqpZUJBuedCoxZRv4L4Cn0
         lReZIA+q+50CvLuIqq3HqzVkMctchJO5qbqLmwrLfscSVetsel4+/3brd+y/K2945tXL
         I2Yw==
X-Gm-Message-State: APzg51CG+j5Gm3XnegptoHKvgrevnms/pAb65Clh5T/tzXk65SsTT2ra
        UaCYwNJYzfCoAEWwfxqaldh1
X-Google-Smtp-Source: ANB0VdZT59C0lv6ornfzQR6I6tKp5EgQ1loo7Z9jcW4h5w/4YR6aHKsO2QjiXjR15VOmF+SSd+DPSQ==
X-Received: by 2002:a17:902:8b86:: with SMTP id ay6-v6mr31817357plb.25.1537311158300;
        Tue, 18 Sep 2018 15:52:38 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id 186-v6sm34159751pgg.56.2018.09.18.15.52.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 15:52:37 -0700 (PDT)
Date:   Tue, 18 Sep 2018 15:52:36 -0700
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
Message-ID: <20180918225236.GA17306@Mani-XPS-13-9360>
References: <20180901164215.3683-1-manivannan.sadhasivam@linaro.org>
 <20180901164215.3683-3-manivannan.sadhasivam@linaro.org>
 <20180918163512.GE2613@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918163512.GE2613@vkoul-mobl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 09:35:12AM -0700, Vinod wrote:
> On 01-09-18, 22:12, Manivannan Sadhasivam wrote:
> 
> > @@ -364,6 +372,26 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
> >  			OWL_DMA_MODE_DT_DCU | OWL_DMA_MODE_SAM_INC |
> >  			OWL_DMA_MODE_DAM_INC;
> >  
> > +		break;
> > +	case DMA_MEM_TO_DEV:
> > +		mode |= OWL_DMA_MODE_TS(vchan->drq)
> > +			| OWL_DMA_MODE_ST_DCU | OWL_DMA_MODE_DT_DEV
> > +			| OWL_DMA_MODE_SAM_INC | OWL_DMA_MODE_DAM_CONST;
> > +
> > +		/* Handle bus width for UART */
> > +		if (sconfig->dst_addr_width == DMA_SLAVE_BUSWIDTH_1_BYTE)
> > +			mode |= OWL_DMA_MODE_NDDBW_8BIT;
> 
> this is fine per se, but not correct way to handle in dmaengine driver.
> You should be agnostic to user of dmaengine, so handle all the buswidths
> the IP block supports and update the values accordingly. That way new
> uses can be added w/o requiring change in dmaengine driver
>

Hi Vinod,

Currently, all members of Owl family supports only 32bit and 8bit
bus widths. 32bit is common for all peripherals and 8bit applies to only
UART since the internal buffer is 8bit wide. So, this makes sense to me!

Thanks,
Mani

> -- 
> ~Vinod
