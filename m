Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280DBC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D85420852
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ0REPas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D85420852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732906AbeGKMVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:21:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbeGKMVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:21:07 -0400
Received: from localhost (unknown [106.200.243.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DFB72084A;
        Wed, 11 Jul 2018 12:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531311424;
        bh=7MPLgS8jcq32VU6ZOl+aL6zKzSYkVQuVD8gwoppUNW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kQ0REPasqeQ6hjZSrqYY4mTMwfHtAXyuhNc3dtssPMClTTRZnlrxD0VEIdWJurI/a
         4qZI8tD1eQRNsOSnUgnNbpMz5e2Gh4cf34v7V5ZW+azYG7PpW4NtNRrUcBWlWsQVee
         dWOz/5r49HY+PVbQDOGAQ6p205q8CI0TuXYMUDKw=
Date:   Wed, 11 Jul 2018 17:46:55 +0530
From:   Vinod <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 02/14] dmaengine: dma-jz4780: Separate chan/ctrl registers
Message-ID: <20180711121655.GS3219@vkoul-mobl>
References: <20180703123214.23090-1-paul@crapouillou.net>
 <20180703123214.23090-3-paul@crapouillou.net>
 <20180709170359.GI22377@vkoul-mobl>
 <1531237019.17118.1@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531237019.17118.1@crapouillou.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-07-18, 17:36, Paul Cercueil wrote:

> > >  @@ -3,7 +3,8 @@
> > >   Required properties:
> > > 
> > >   - compatible: Should be "ingenic,jz4780-dma"
> > >  -- reg: Should contain the DMA controller registers location and
> > > length.
> > >  +- reg: Should contain the DMA channel registers location and
> > > length, followed
> > >  +  by the DMA controller registers location and length.
> > >   - interrupts: Should contain the interrupt specifier of the DMA
> > > controller.
> > >   - interrupt-parent: Should be the phandle of the interrupt
> > > controller that
> > >   - clocks: Should contain a clock specifier for the JZ4780 PDMA
> > > clock.
> > >  @@ -22,7 +23,8 @@ Example:
> > > 
> > >   dma: dma@13420000 {
> > >   	compatible = "ingenic,jz4780-dma";
> > >  -	reg = <0x13420000 0x10000>;
> > >  +	reg = <0x13420000 0x400
> > >  +	       0x13421000 0x40>;
> > 
> > Second should be optional or we break platform which may not have
> > updated DT..
> 
> See comment below.
> 
> > >  -	jzdma->base = devm_ioremap_resource(dev, res);
> > >  -	if (IS_ERR(jzdma->base))
> > >  -		return PTR_ERR(jzdma->base);
> > >  +	jzdma->chn_base = devm_ioremap_resource(dev, res);
> > >  +	if (IS_ERR(jzdma->chn_base))
> > >  +		return PTR_ERR(jzdma->chn_base);
> > >  +
> > >  +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > >  +	if (!res) {
> > >  +		dev_err(dev, "failed to get I/O memory\n");
> > >  +		return -EINVAL;
> > >  +	}
> > 
> > okay and this breaks if you happen to get probed on older DT. I think DT
> > is treated as ABI so you need to continue support older method while
> > finding if DT has split resources
> 
> See my response to PrasannaKumar. All the Ingenic-based boards do compile
> the devicetree within the kernel, so I think it's still fine to add breaking
> changes. I'll wait on @Rob to give his point of view on this, though.
> 
> (It's not something hard to change, but I'd like to know what's the policy
> in that case. I have other DT-breaking patches to submit)

The policy is that DT is an ABI and should not break :)

Who maintains Ingenic arch. MAINTAINERS doesn't tell me.

-- 
~Vinod
