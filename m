Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3034DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33D721019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbfAVNZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:25:53 -0500
Received: from 8bytes.org ([81.169.241.247]:58826 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727936AbfAVNZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:25:53 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1C2AE53D; Tue, 22 Jan 2019 14:25:52 +0100 (CET)
Date:   Tue, 22 Jan 2019 14:25:51 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-debug: add dumping facility via debugfs
Message-ID: <20190122132551.GC32526@8bytes.org>
References: <1547646265-9414-1-git-send-email-clabbe@baylibre.com>
 <2f43688f-9c08-a9c4-6175-caa3d2e40261@arm.com>
 <20190118113543.GA9481@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118113543.GA9481@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 12:35:43PM +0100, Christoph Hellwig wrote:
> On Wed, Jan 16, 2019 at 06:10:13PM +0000, Robin Murphy wrote:
> > It's a shame that this is pretty much a duplication of 
> > debug_dma_dump_mappings(), but there seems no straightforward way to define 
> > one in terms of the other :/
> 
> We could always play some macro magic, but I think that is worse than
> duplicating a little bit of functionality.

I havn't checked in detail, can seq_buf be used somehow to write a
function that fits both cases?

> Btw, the dev argument to debug_dma_dump_mappings is always NULL and
> could be removed..

This function was also written as a debug-helper for driver developers.
As such it might not make it into the final driver, but the developer
might want to use it to dump the mappings for her device only. So I'd
like to keep the parameter, even when it is always NULL for in-kernel
uses.

> > (although given that we'd rather not have that weird external interface 
> > anyway, maybe "now you can use debugfs instead" might be justification 
> > enough for cleaning it up...)
> 
> One argument against that is the system might be in a shape where you
> can't easily read a file when it is in that shape.  The argument for
> that is that in many systems the full list of mappings might overwhelm
> the kernel log.

For driver developers a file is easier to use, but in case of an
unusable system one can at least easily read out parts of the
dma-mappings from a crash-dump if it is in the kernel-log. So I think
it makes sense to have both.

Regards,

	Joerg
