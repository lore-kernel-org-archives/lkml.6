Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBCDC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E2C2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFO55fqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E2C2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbeJPWf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:35:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbeJPWf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:35:28 -0400
Received: from localhost (unknown [106.201.39.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 001C420881;
        Tue, 16 Oct 2018 14:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539701080;
        bh=Sjz7AQg4FaRW/zW/lu2tkgAJUc8msJopx4zqoSr5M3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uFO55fqwC0/IZrY09rEohld2CuNVu5IErt62Mv94PJYs++MN/GFo1bppa6kPcrgob
         ERGAuBC43HGix0378yWqubZAp2O1PCQ+ZpdzbESgLOGvlThC7oTSToXCfzEYclCcOw
         wQ870Cy10cARg7j9DGHrwBk4w1jlyaYM+4KpcwTw=
Date:   Tue, 16 Oct 2018 20:14:32 +0530
From:   Vinod <vkoul@kernel.org>
To:     Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] dmaengine: stm32-dma: Add DMA/MDMA chaining
 support
Message-ID: <20181016144432.GR2400@vkoul-mobl>
References: <1538139715-24406-1-git-send-email-pierre-yves.mordret@st.com>
 <1538139715-24406-5-git-send-email-pierre-yves.mordret@st.com>
 <20181007160030.GB2372@vkoul-mobl>
 <e9cedfdd-ad90-9123-03bb-34a2e84059c5@st.com>
 <20181010040343.GO2372@vkoul-mobl>
 <d64da587-a680-20c4-7139-f59fd1f299bc@st.com>
 <20181015171403.GM2400@vkoul-mobl>
 <9a375fd3-964f-3d57-9d18-b010e20a4d42@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a375fd3-964f-3d57-9d18-b010e20a4d42@st.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-10-18, 11:19, Pierre Yves MORDRET wrote:
> 
> 
> On 10/15/18 7:14 PM, Vinod wrote:
> > On 10-10-18, 09:02, Pierre Yves MORDRET wrote:
> >>
> >>
> >> On 10/10/2018 06:03 AM, Vinod wrote:
> >>> On 09-10-18, 10:40, Pierre Yves MORDRET wrote:
> >>>>
> >>>>
> >>>> On 10/07/2018 06:00 PM, Vinod wrote:
> >>>>> On 28-09-18, 15:01, Pierre-Yves MORDRET wrote:
> >>>>>> This patch adds support of DMA/MDMA chaining support.
> >>>>>> It introduces an intermediate transfer between peripherals and STM32 DMA.
> >>>>>> This intermediate transfer is triggered by SW for single M2D transfer and
> >>>>>> by STM32 DMA IP for all other modes (sg, cyclic) and direction (D2M).
> >>>>>>
> >>>>>> A generic SRAM allocator is used for this intermediate buffer
> >>>>>> Each DMA channel will be able to define its SRAM needs to achieve chaining
> >>>>>> feature : (2 ^ order) * PAGE_SIZE.
> >>>>>> For cyclic, SRAM buffer is derived from period length (rounded on
> >>>>>> PAGE_SIZE).
> >>>>>
> >>>>> So IIUC, you chain two dma txns together and transfer data via an SRAM?
> >>>>
> >>>> Correct. one DMA is DMAv2 (stm32-dma) and the other is MDMA(stm32-mdma).
> >>>> Intermediate transfer is between device and memory.
> >>>> This intermediate transfer is using SDRAM.
> >>>
> >>> Ah so you use dma calls to setup mdma xtfers? I dont think that is a
> >>> good idea. How do you know you should use mdma for subsequent transfer?
> >>>
> >>
> >> When user bindings told to setup chaining intermediate MDMA transfers are always
> >> triggers.
> >> For instance if a user requests a Dev2Mem transfer with chaining. From client
> >> pov this is still a prep_slave_sg. Internally DMAv2 is setup in cyclic mode (in
> >> double buffer mode indeed => 2 buffer of PAGE_SIZE/2) and destination is SDRAM.
> >> DMAv2 will flip/flop on those 2 buffers.
> >> At the same time DMAv2 driver prepares a MDMA SG that will fetch data from those
> >> 2 buffers in SDRAM and fills final destination memory.
> > 
> > I am not able to follow is why does it need to be internal, why should
> > the client not set the two transfers and trigger them?
> > 
> 
> Client may use or not chaining: defined within DT. API and dynamic are same at

That should be upto client... As a dmaengine driver you should enable
data transfer from src to dstn.

> driver client level. Moreover driver exposes only DMAv2 and not both DMAv2 and
> MDMA. This is totally hidden for client. If client sets both this would imply

Why should a controller be hidden from user, I dont see why that would
be a good thing

> changing all drivers that may want use chaining. Even more to deal with DMAv2
> and MDMA at its level.
> Since DMAv2 deals with MDMA, all drivers are same as before. no changes required.

It is not about changes, it is about the SW model you want to have.

The intermediate SRAM transfers should not be made within DMAengine
driver, client can chose to have two transfers and couple or not, it is
upto them to choose. Sorry I do not like this abstraction and would like
to see a cleaner approach

-- 
~Vinod
