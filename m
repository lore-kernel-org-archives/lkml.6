Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D46C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B33920835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2stDMTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B33920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbeH3RaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728722AbeH3RaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:30:06 -0400
Received: from localhost (unknown [171.76.96.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 998112073D;
        Thu, 30 Aug 2018 13:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535635676;
        bh=dzYT/sytWBbQpJ3dxE+El5FNjnA62hMRvwr6T5myZWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J2stDMTFRGNIwVib3t1IW11Cb0GqgPlJnmTkn9c5i7KtUlR4yGXu/plNkZcKr7WXQ
         2ptW0HeaBUdJd1hiP9Y64Y95Qnhxs7sgUEmUxjxfFMwr4JTuikAzAOuNb8p/z+tsg2
         hNRE5yPoZaIm56XeHY9S82pG0r57+e7TpRa9p2CM=
Date:   Thu, 30 Aug 2018 18:57:45 +0530
From:   Vinod <vkoul@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: Re: [PATCH v4 2/7] dmaengine: xilinx_dma: in axidma slave_sg and
 dma_cylic mode align split descriptors
Message-ID: <20180830132745.GC2322@vkoul-mobl>
References: <20180802141012.19970-1-andrea.merello@gmail.com>
 <20180802141012.19970-2-andrea.merello@gmail.com>
 <20180827053002.GT2388@vkoul-mobl>
 <CAN8YU5MOdz_sW06B8yc_kewjsxP0DP5pgB2bSu=vkNG-ezvMpQ@mail.gmail.com>
 <CAN8YU5M0tJmsU4Xp+0xDwQYtqeB8tPP_4FyBC_ctUOSV=HZNmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN8YU5M0tJmsU4Xp+0xDwQYtqeB8tPP_4FyBC_ctUOSV=HZNmA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-08-18, 10:11, Andrea Merello wrote:
> On Wed, Aug 29, 2018 at 10:12 AM Andrea Merello
> <andrea.merello@gmail.com> wrote:
> >
> > On Mon, Aug 27, 2018 at 7:30 AM Vinod <vkoul@kernel.org> wrote:
> > >
> > > On 02-08-18, 16:10, Andrea Merello wrote:
> > >
> > > s/cylic/cyclic in patch title
> >
> > OK
> >
> > > > Whenever a single or cyclic transaction is prepared, the driver
> > > > could eventually split it over several SG descriptors in order
> > > > to deal with the HW maximum transfer length.
> > > >
> > > > This could end up in DMA operations starting from a misaligned
> > > > address. This seems fatal for the HW if DRE is not enabled.
> > >
> > > DRE?
> >
> > Stands for "Data Realignment Engine". I will add this string nearby
> > the acronym..
> >
> > > >
> > > > This patch eventually adjusts the transfer size in order to make sure
> > > > all operations start from an aligned address.
> > > >
> > > > Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > > > Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> > > > Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > > > ---
> > > > Changes in v2:
> > > >         - don't introduce copy_mask field, rather rely on already-esistent
> > > >           copy_align field. Suggested by Radhey Shyam Pandey
> > > >         - reword title
> > > > Changes in v3:
> > > >       - fix bug introduced in v2: wrong copy size when DRE is enabled
> > > >       - use implementation suggested by Radhey Shyam Pandey
> > > > Changes in v4:
> > > >       - rework on the top of 1/6
> > > > ---
> > > >  drivers/dma/xilinx/xilinx_dma.c | 22 ++++++++++++++++++----
> > > >  1 file changed, 18 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> > > > index a3aaa0e34cc7..aaa6de8a70e4 100644
> > > > --- a/drivers/dma/xilinx/xilinx_dma.c
> > > > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > > > @@ -954,15 +954,28 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
> > > >
> > > >  /**
> > > >   * xilinx_dma_calc_copysize - Calculate the amount of data to copy
> > > > + * @chan: Driver specific DMA channel
> > > >   * @size: Total data that needs to be copied
> > > >   * @done: Amount of data that has been already copied
> > > >   *
> > > >   * Return: Amount of data that has to be copied
> > > >   */
> > > > -static int xilinx_dma_calc_copysize(int size, int done)
> > > > +static int xilinx_dma_calc_copysize(struct xilinx_dma_chan *chan,
> > > > +                                 int size, int done)
> > >
> > > please align with opening brace
> >
> > OK
> 
> Sorry for getting back on this.
> I've checked it, but it seems already aligned with opening brace in
> the original e-mail text I've sent. (4 tabs + 4 spaces).

Okay, please see that code looks fine, I will check after I apply

-- 
~Vinod
