Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17530C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB10220870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB10220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbeLMT6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:58:33 -0500
Received: from verein.lst.de ([213.95.11.211]:42933 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727684AbeLMT6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:58:33 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D452568DD6; Thu, 13 Dec 2018 20:58:31 +0100 (CET)
Date:   Thu, 13 Dec 2018 20:58:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        "alexander.h.duyck@linux.intel.com" 
        <alexander.h.duyck@linux.intel.com>,
        "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] dma-direct: Fix return value of dma_direct_supported
Message-ID: <20181213195831.GA15478@lst.de>
References: <20181003234746.3586.42014.stgit@localhost.localdomain> <5329f992-d3aa-c16c-1218-c26d758889b8@arm.com> <CAKgT0UfbAokpR=-xrfNjeYMroEDH4HtPgM6qK_nWmBqK3QOf6A@mail.gmail.com> <ebe0d4aa-5f37-cc40-4a80-cfe499d5b8e4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebe0d4aa-5f37-cc40-4a80-cfe499d5b8e4@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 07:45:57PM +0000, Lendacky, Thomas wrote:
> So I think this needs to be __phys_to_dma() here. I only recently got a
> system that had a device where the driver only supported 32-bit DMA and
> found that when SME is active this returns 0 and causes the driver to fail
> to initialize. This is because the SME encryption bit (bit 47) is part of
> the check when using phys_to_dma(). During actual DMA when SME is active,
> bounce buffers will be used for anything that can't meet the 48-bit
> requirement. But for this test, using __phys_to_dma() should give the
> desired results, right?
> 
> If you agree with this, I'll submit a patch to make the change. I missed
> this in 4.19, so I'll need to submit something to stable, too. The only
> issue there is the 4.20 fix won't apply cleanly to 4.19.

Yes, please send a patch.  Please make sure it includes a code comment
that explains why the __-prefixed version is used.
