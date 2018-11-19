Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8FFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3612920671
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3612920671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbeKTASn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:18:43 -0500
Received: from verein.lst.de ([213.95.11.211]:38203 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbeKTASn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:18:43 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1EE8C68AFE; Mon, 19 Nov 2018 14:55:00 +0100 (CET)
Date:   Mon, 19 Nov 2018 14:55:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Miller <davem@davemloft.net>
Cc:     hch@lst.de, iommu@lists.linux-foundation.org,
        torvalds@linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [RFC] remove the ->mapping_error method from dma_map_ops
Message-ID: <20181119135459.GB16334@lst.de>
References: <20181109084632.22848-1-hch@lst.de> <20181109.151234.2231390463846593374.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109.151234.2231390463846593374.davem@davemloft.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 03:12:34PM -0800, David Miller wrote:
> But patch #2 on the other hand, not so much.
> 
> I hate seeing values returned by reference, it adds cost especially
> on cpus where all argments and return values fit in registers (we end
> up forcing a stack slot and memory references).
> 
> And we don't need it here.
> 
> DMA addresses are like pointers, and therefore we can return errors and
> valid success values in the same dma_addr_t just fine.  PTR_ERR() --> DMA_ERR(),
> IS_PTR_ERR() --> IS_DMA_ERR, etc.

In the end this is an inline function, so with a decently smart
compiler the generated code shouldn't change too much.  The big problem
that prompted me to come up with this patch is that not handling failure
from dma_map* in a swiotlb setup can lead to grave data corruption, and
we have no easy way to force error checking on these return values.

I've added a few of the static typechecking suspect if they have a
better idea on how to make the return value of dma_map_single/pages
in a way that we get warnings if dma_mapping_error isn't called on them.
But I can't really think of a good way.
