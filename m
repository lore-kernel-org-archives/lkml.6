Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89048C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E22121479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxwFS24A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E22121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeJIQN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:13:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbeJIQN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:13:59 -0400
Received: from localhost (unknown [171.76.86.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1CE32089D;
        Tue,  9 Oct 2018 08:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539075486;
        bh=rVMi8ADf4R56AynRsbSbjCoK88ANtC5QUfae/Tlnx6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GxwFS24AD9xtJHz9c/fzT9+YQ0UDMVqD2XRiGgwpywXG5u7amEOfETQEgUoZ2gKgr
         PsuaE8WDAXVGh+/+2ZUxvgeZqK6UiPYvAURBZAt7qAA+s1rD2SMEwPYrpkYeYcLZZy
         bczZk2nm4Z0dZlrrVERP8OXXbK4SNdFL8PXpoIdQ=
Date:   Tue, 9 Oct 2018 14:27:57 +0530
From:   Vinod <vkoul@kernel.org>
To:     Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: stm32-dma: Add DMA/MDMA chaining
 support bindings
Message-ID: <20181009085757.GI2372@vkoul-mobl>
References: <1538139715-24406-1-git-send-email-pierre-yves.mordret@st.com>
 <1538139715-24406-2-git-send-email-pierre-yves.mordret@st.com>
 <20181007145722.GY2372@vkoul-mobl>
 <5d7a218c-9e96-3931-88ab-0b4dcb3ec4e5@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d7a218c-9e96-3931-88ab-0b4dcb3ec4e5@st.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 09-10-18, 09:18, Pierre Yves MORDRET wrote:

> >>  * DMA client
> >> @@ -68,7 +84,16 @@ channel: a phandle to the DMA controller plus the following four integer cells:
> >>  	0x1: 1/2 full FIFO
> >>  	0x2: 3/4 full FIFO
> >>  	0x3: full FIFO
> >> -
> >> + -bit 2: Intermediate M2M transfer from/to DDR to/from SRAM throughout MDMA
> >> +	0: MDMA not used to generate an intermediate M2M transfer
> >> +	1: MDMA used to generate an intermediate M2M transfer.
> >> + -bit 3-4: indicated SRAM Buffer size in (2^order)*PAGE_SIZE.
> >> +	PAGE_SIZE is given by Linux at 4KiB: include/asm-generic/page.h.
> >> +	Order is given by those 2 bits starting at 0.
> >> +	Valid only whether Intermediate M2M transfer is set.
> > 
> > why do we need this as a property?
> 
> In some UC, we need more than 4KiB in case of chaining for better performances.
> Chaining has to be enabled by client if performance is at sacks.

Okay if that is the case why is the user not taking care of this?
Creating DMA txn and chaining them up and starting the chain? Why would
dmaengine driver need to do that?

-- 
~Vinod
