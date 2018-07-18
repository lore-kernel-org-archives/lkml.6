Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CD8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876E520850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJP0CSkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876E520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeGRGD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 02:03:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbeGRGD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 02:03:26 -0400
Received: from localhost (unknown [106.200.213.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE1FB20684;
        Wed, 18 Jul 2018 05:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531891641;
        bh=/ieGR3d+D0SiRFYhDVh4gOFVfjw5t1O+MSo6UJUyRvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MJP0CSkp86A84YUhy16p1GANZ81tgC/pIxNSS82dnTzfLZgr6XG+BDFySLaZHJPoZ
         a19u8HD+WXmiDgoG4UZlCsVONUbBkaKc2TYp7dMeCr3MzMhUshGVFNQpP4kTf2hw+N
         7v0jqFZPV5wbTfkvKJTwpuHxnu7vIW/iQSSJ6+K0=
Date:   Wed, 18 Jul 2018 10:57:13 +0530
From:   Vinod <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 05/14] dmaengine: dma-jz4780: Add support for the JZ4740
 SoC
Message-ID: <20180718052713.GH3219@vkoul-mobl>
References: <20180703123214.23090-1-paul@crapouillou.net>
 <20180703123214.23090-6-paul@crapouillou.net>
 <20180709171226.GK22377@vkoul-mobl>
 <20180716213339.GA19161@rob-hp-laptop>
 <20180717153407.GF3219@vkoul-mobl>
 <CAL_JsqJBw9vBURZQxa4RkDAfiinnNRK6CVTBmpnC3TaSukZLRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJBw9vBURZQxa4RkDAfiinnNRK6CVTBmpnC3TaSukZLRA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-07-18, 11:40, Rob Herring wrote:
> On Tue, Jul 17, 2018 at 9:34 AM Vinod <vkoul@kernel.org> wrote:
> >
> > On 16-07-18, 15:33, Rob Herring wrote:
> > > On Mon, Jul 09, 2018 at 10:42:26PM +0530, Vinod wrote:
> > > > On 03-07-18, 14:32, Paul Cercueil wrote:
> > > >
> > > > >  enum jz_version {
> > > > > + ID_JZ4740,
> > > > >   ID_JZ4770,
> > > > >   ID_JZ4780,
> > > > >  };
> > > > > @@ -247,6 +248,7 @@ static void jz4780_dma_desc_free(struct virt_dma_desc *vdesc)
> > > > >  }
> > > > >
> > > > >  static const unsigned int jz4780_dma_ord_max[] = {
> > > > > + [ID_JZ4740] = 5,
> > > > >   [ID_JZ4770] = 6,
> > > > >   [ID_JZ4780] = 7,
> > > > >  };
> > > > > @@ -801,11 +803,13 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
> > > > >  }
> > > > >
> > > > >  static const unsigned int jz4780_dma_nb_channels[] = {
> > > > > + [ID_JZ4740] = 6,
> > > > >   [ID_JZ4770] = 6,
> > > > >   [ID_JZ4780] = 32,
> > > > >  };
> > > >
> > > > I feel these should be done away with if we describe hardware in DT
> > >
> > > The compatible property can imply things like this.
> >
> > So what is the general recommendation, let DT describe hardware
> > including version delta or use compatible to code that in driver?
> 
> Compatible is the version. Looking at the above, the version or ID
> isn't even stable.
> 
> > Is it documented anywhere?
> 
> Not really. It's a judgment call generally. Maybe # of DMA channels
> should be a property because that is something most controllers have.
> But you really have to define the property up front, not when the 2nd
> version of h/w shows up with different properties.
> 
> To start defining guidelines, a couple of things come to mind:
> 
> - Define properties for parameters that vary from board to board (for one SoC).
> - You can't add new required properties to existing bindings, so the
> not present default must work for all existing compatibles (or you
> need per compatible driver data).
> - Bugs/quirks/errata should be handled by compatible, not adding a
> property. Because bugs should be fixable without a dtb update and only
> a kernel update.

Sounds good to me, thanks for the guide.

-- 
~Vinod
