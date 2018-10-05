Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEA8C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9D520652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9D520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbeJEP0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:26:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:45132 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728433AbeJEP0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:26:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 01:29:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,343,1534834800"; 
   d="scan'208";a="89401936"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga003.jf.intel.com with SMTP; 05 Oct 2018 01:28:45 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 05 Oct 2018 11:28:44 +0300
Date:   Fri, 5 Oct 2018 11:28:44 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        H Hartley Sweeten <hartleys@visionengravers.com>,
        Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH] spi: spi-ep93xx: Change dir type in
 ep93xx_spi_dma_{finish,prepare}
Message-ID: <20181005082844.GT2302@lahna.fi.intel.com>
References: <20181004023926.15847-1-natechancellor@gmail.com>
 <20181004103247.GC6412@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004103247.GC6412@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 04, 2018 at 11:32:47AM +0100, Mark Brown wrote:
> On Wed, Oct 03, 2018 at 07:39:26PM -0700, Nathan Chancellor wrote:
> > Clang warns when one enumerated type is implicitly converted to another.
> > 
> > drivers/spi/spi-ep93xx.c:342:62: warning: implicit conversion from
> > enumeration type 'enum dma_transfer_direction' to different enumeration
> 
> Please remember to CC driver maintainers and authors on patch
> submissions so they can review things, copying in Hartley and Mika.

Thanks for copying me.

> > type 'enum dma_data_direction' [-Wenum-conversion]
> >         nents = dma_map_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> >                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > ./include/linux/dma-mapping.h:428:58: note: expanded from macro
> > 'dma_map_sg'
> > \#define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
> >                                ~~~~~~~~~~~~~~~~          ^
> > drivers/spi/spi-ep93xx.c:348:57: warning: implicit conversion from
> > enumeration type 'enum dma_transfer_direction' to different enumeration
> > type 'enum dma_data_direction' [-Wenum-conversion]
> >                 dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> >                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> > 'dma_unmap_sg'
> > \#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
> >                                  ~~~~~~~~~~~~~~~~~~          ^
> > drivers/spi/spi-ep93xx.c:377:56: warning: implicit conversion from
> > enumeration type 'enum dma_transfer_direction' to different enumeration
> > type 'enum dma_data_direction' [-Wenum-conversion]
> >         dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> >         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> > 'dma_unmap_sg'
> > \#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
> >                                  ~~~~~~~~~~~~~~~~~~          ^
> > 3 warnings generated.
> > 
> > dma_{,un}map_sg expects an enum of type dma_data_direction but this
> > driver uses dma_transfer_direction for everything. Converting to
> > dma_data_direction would be desirable but there are a few shared
> > structures that expect dma_transfer_direction so it is just simpler to
> > change the parameter here. dma_transfer_direction and dma_data_direction
> > are different sizes but this driver only uses the 1 and 2 values which
> > mean the same thing so this change is safe.

I would rather do the conversion than passing "int" to the function even
if both enums happen to have same value now. I would be surprised if
there is no helper function already for the conversion :)
