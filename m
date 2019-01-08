Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED192C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB95B206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfAHNM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:12:29 -0500
Received: from verein.lst.de ([213.95.11.211]:34195 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfAHNM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:12:29 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E610768C8E; Tue,  8 Jan 2019 14:12:27 +0100 (CET)
Date:   Tue, 8 Jan 2019 14:12:27 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: fix DMA ops layering violations in vmwgfx
Message-ID: <20190108131227.GB6003@lst.de>
References: <20190105080108.14837-1-hch@lst.de> <99091bb861e21d5bb4182f08dedbc494c637cc0f.camel@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99091bb861e21d5bb4182f08dedbc494c637cc0f.camel@vmware.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 09:51:45AM +0000, Thomas Hellstrom wrote:
> Hi, Christoph,
> 
> On Sat, 2019-01-05 at 09:01 +0100, Christoph Hellwig wrote:
> > Hi Thomas,
> > 
> > vmwgfx has been doing some odd checks based on DMA ops which rely
> > on deep DMA mapping layer internals, and I think the changes in
> > Linux 4.21 finally broke most of these implicit assumptions.
> 
> Thanks. 
> What we're really trying to do here is to try to detect the situation
> where DMA remapping using hardware IOMMUs is going on but memory is
> still coherent, since the driver can currently only work with coherent
> memory[1]. Currently we use intel_iommu_enabled to detect this
> situation, but it would be really helpful if there were a generic bool
> that advertizes this situation since we need to deal with other IOMMUs
> as well going forward. Any suggestion?

I'm missing the link of the [1] reference above.  But if you need
coherent memory you should simply always use dma_alloc_coherent, that
is the only gurantee you get.  If you use any other dma mapping methods
you will otherwise need to explicitly transfer ownership by mapping/
unmapping or using dma_sync* before and after every device access.

And the whole DMA API bypass using the phys mode is something that
I'd really prefer not to see in any driver as it tends to cause
major problems sooner or later.
