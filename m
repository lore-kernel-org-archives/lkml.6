Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F48C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0BF2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548182932;
	bh=1Q7e3mCTan2fPghdfqb2j+OPoeXtVWaBvg/Y5rIvhxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BSMvzQtnGRVqwWSz/xJZXPlDjwqmIB6TzROAU1Fj94mGdyfPez3KqtS5QtoVhzjaG
	 40vTtQo6HPbtiwAnwJ4kKehuYzoxSHjmqEGAWwdBJZBszWwkuq75vQL/S2EkPLjN6v
	 M7oxVyBOjhyH1leIsF3AE7MbG3+xJySKLc13WlcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfAVSsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:48:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfAVSsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:48:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61BFE21019;
        Tue, 22 Jan 2019 18:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548182929;
        bh=1Q7e3mCTan2fPghdfqb2j+OPoeXtVWaBvg/Y5rIvhxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DXUoR9uk3DIMfghWBsZu4UJyf9/PZf/3+dntrk2OZDa76caDQOZL2fZwlEWYaor7/
         qoUFqB2SBv/Hq96vqV3bNepBhLcZfFObkIsHYk4HMptvTEyGjrp06qXSasuV2+Y5wi
         a05uLCCrC2z89lYgXkJy2SePZQmIvcgRMN8YSibY=
Date:   Tue, 22 Jan 2019 19:48:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH] dma: debug: no need to check return value of
 debugfs_create functions
Message-ID: <20190122184847.GA32627@kroah.com>
References: <20190122152151.16139-39-gregkh@linuxfoundation.org>
 <2b974ef1-4336-8187-cbc5-ba2a14691837@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b974ef1-4336-8187-cbc5-ba2a14691837@arm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 06:44:38PM +0000, Robin Murphy wrote:
> Hi Greg,
> 
> On 22/01/2019 15:21, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> > 
> > Also delete the variables for the file dentries for the debugfs entries
> > as they are never used at all once they are created.
> 
> Modulo one nit below, I certainly approve of the cleanup :)
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: iommu@lists.linux-foundation.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   kernel/dma/debug.c | 81 ++++++----------------------------------------
> >   1 file changed, 10 insertions(+), 71 deletions(-)
> > 
> > diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> > index 23cf5361bcf1..2f5fc8b9d39f 100644
> > --- a/kernel/dma/debug.c
> > +++ b/kernel/dma/debug.c
> > @@ -136,14 +136,6 @@ static u32 nr_prealloc_entries = PREALLOC_DMA_DEBUG_ENTRIES;
> >   /* debugfs dentry's for the stuff above */
> >   static struct dentry *dma_debug_dent        __read_mostly;
> 
> Does this actually need to be at file scope, or could it be punted to a
> local in dma_debug_fs_init() while we're here?

It can be moved to the function scope if you want me to, I was trying to
do the least needed here :)

thanks,

greg k-h
