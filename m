Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48472C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 04:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5A920897
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 04:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwI1Ggmw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5A920897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeH2H4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 03:56:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbeH2H4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 03:56:10 -0400
Received: from localhost (unknown [171.76.77.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4FE220850;
        Wed, 29 Aug 2018 04:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535515281;
        bh=mzGPb9ii1y+rcmHuqMM7Mi4BNtiBHe2MgIrJn3+j94k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VwI1GgmwOdPNQ1p6EdkXgZwGwrVpdby47JOy82CblWGw9ttVvKpdl5j1DwlIt3KJ1
         DeUGUPeHVfCMnVMGgAwtPYPgAWUdwxJ4eVIH+pgNeUJP17ekchCFeDhoq9nOaZtiYS
         YHTotAYYPiWLeDWZeUcaHndTfUcACccaou6Wfg3o=
Date:   Wed, 29 Aug 2018 09:31:11 +0530
From:   Vinod <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radheys@xilinx.com>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Michal Simek <michals@xilinx.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] dmaengine: xilinx_dma: Fix 64-bit simple CDMA
 transfer
Message-ID: <20180829040111.GD2388@vkoul-mobl>
References: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1532688639-32230-4-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20180821155553.GI2388@vkoul-mobl>
 <MWHPR0201MB362803E975383398B361330FC70A0@MWHPR0201MB3628.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR0201MB362803E975383398B361330FC70A0@MWHPR0201MB3628.namprd02.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-08-18, 14:03, Radhey Shyam Pandey wrote:
> > On 27-07-18, 16:20, Radhey Shyam Pandey wrote:
> > > In AXI CDMA simple mode also pass MSB bits of source and destination
> > > address to xilinx_write function. This fixes simple CDMA operation
> > > mode using 64-bit addressing.
> > >
> > > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > > ---
> > >  drivers/dma/xilinx/xilinx_dma.c |    6 ++++--
> > >  1 files changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> > > index a37871e..2e15d86 100644
> > > --- a/drivers/dma/xilinx/xilinx_dma.c
> > > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > > @@ -1245,8 +1245,10 @@ static void xilinx_cdma_start_transfer(struct
> > xilinx_dma_chan *chan)
> > >
> > >  		hw = &segment->hw;
> > >
> > > -		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR, hw-
> > >src_addr);
> > > -		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR, hw-
> > >dest_addr);
> > > +		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR,
> > (dma_addr_t)
> > > +			     ((u64)hw->src_addr_msb << 32 | hw->src_addr));
> > 
> > so this is:
> >         (dma_addr_t)((u64)hw->src_addr_msb << 32 | hw->src_addr)
> > 
> > what is src_addr data type? I think its u32. It would be better to
> > update xilinx_write() to take u64 and not dma_addr_t.
> 
> Yes, src_addr_msb and src_addr BD fields are u32. To explain: There is no
> prob in xilinx_write it takes dma_addr_t as an arg which is 32/64 bit 
> depending on _DMA_ADDR_T_64BIT. In 64bit CDMA transfer, there was a bug
> i.e in the call to xilinx_write src_addr_msb 32 bits were not passed. To fix
> that combine MSB and LSB 32 bits before passing it to xilinx_write.

Yeah that part was clear but the implementation can be better..

-- 
~Vinod
