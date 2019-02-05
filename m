Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759EFC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D63C2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfBEIBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:01:09 -0500
Received: from verein.lst.de ([213.95.11.211]:52883 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbfBEIBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:01:08 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id AE24F68DD3; Tue,  5 Feb 2019 09:01:06 +0100 (CET)
Date:   Tue, 5 Feb 2019 09:01:06 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] drm/vmwgfx: remove CONFIG_INTEL_IOMMU ifdefs v2
Message-ID: <20190205080106.GA4863@lst.de>
References: <20190125081215.4622-1-thellstrom@vmware.com> <20190125081215.4622-3-thellstrom@vmware.com> <20190204081932.GB5730@lst.de> <1f22fa519670f7caa3c2f4f48d7cb6daf79d6eb0.camel@vmware.com> <d67d5aef5059c26a281c7ab00131d6ca202ab5ee.camel@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d67d5aef5059c26a281c7ab00131d6ca202ab5ee.camel@vmware.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 07:59:22AM +0000, Thomas Hellstrom wrote:
> On Mon, 2019-02-04 at 13:11 +0100, Thomas Hellström wrote:
> > On Mon, 2019-02-04 at 09:19 +0100, Christoph Hellwig wrote:
> > > On Fri, Jan 25, 2019 at 09:12:13AM +0100, Thomas Hellstrom wrote:
> > > > -#if !defined(CONFIG_SWIOTLB) && !defined(CONFIG_INTEL_IOMMU)
> > > > -	/*
> > > > -	 * No coherent page pool
> > > > -	 */
> > > > -	if (dev_priv->map_mode == vmw_dma_alloc_coherent)
> > > > +	/* No TTM coherent page pool? FIXME: Ask TTM instead! */
> > > > +	if (!(IS_ENABLED(CONFIG_SWIOTLB) ||
> > > > IS_ENABLED(CONFIG_INTEL_IOMMU)) &&
> > > > +	    (dev_priv->map_mode == vmw_dma_alloc_coherent))
> > > >  		return -EINVAL;
> > > > -#endif
> > > > +
> > > 
> > > I don't think this edited in change makes any sense.  The swiotlb
> > > vs
> > > dma-direct versions of dma_alloc_coherent are the same, so this
> > > check
> > > seems very obsfucating.
> > 
> > So this part of code is identical in functionality to the previous
> > version. It checks whether the TTM module has the coherent page pool
> > enabled. (an identical test is present in TTM). What we *really* need
> > to do here instead is to ask TTM whether it has enabled its coherent
> > page pool instead of trying to mimic TTM's test, and I have a
> > changeset
> > under review for that. But as mentioned previously, I don't want to
> > change the TTM interface outside of a merge window, so we either have
> > to live with the above for 5.0 or keep the old defines. I'd prefer
> > the
> > former so I don't have to respin the patch series once more.
> > 
> > Thanks,
> > Thoams
> > 
> 
> Hi, Christoph,
> 
> I need to get this merged this week. Could you please ack or ack
> removing this hunk + updating the following patches for merge errors?
> 
> If no response, I'll add a Cc: tag on the patch and a #v1 to your s-o-
> b.

Please go ahead.  I'll look into the fallout later.
