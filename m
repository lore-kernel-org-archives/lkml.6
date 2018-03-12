Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752191AbeCLI0g (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:26:36 -0400
Received: from verein.lst.de ([213.95.11.211]:51590 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751263AbeCLI0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:26:34 -0400
Date: Mon, 12 Mar 2018 09:26:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, Muli Ben-Yehuda <mulix@mulix.org>,
        iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 04/13] x86: use generic swiotlb_ops
Message-ID: <20180312082633.GA5724@lst.de>
References: <20180305174655.9878-1-hch@lst.de> <20180305174655.9878-5-hch@lst.de> <825d4b49-8fa2-e670-75e3-77a88258af3a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <825d4b49-8fa2-e670-75e3-77a88258af3a@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 04:03:12PM +0000, Robin Murphy wrote:
>> Also fix the sta2x11 case.  For that SOC the dma map ops need an
>> additional physical to dma address translations.  For swiotlb buffers
>> that is done throught the phys_to_dma helper, but the sta2x11_dma_ops
>> also added an additional translation on the return value from
>> x86_swiotlb_alloc_coherent, which is only correct if that functions
>> returns a direct allocation and not a swiotlb buffer.  With the
>> generic swiotlb and dma-direct code phys_to_dma is not always used
>> and the separate sta2x11_dma_ops can be replaced with a simple
>> bit that marks if the additional physical to dma address translation
>> is needed.
>
> FWIW, last time I looked I got the impression that STA2x11 could just use 
> dma_pfn_offset - the comments and a2p/p2a logic in sta2x11-fixup.c 
> certainly imply that the underlying hardware situation is pretty much 
> exactly that for which dma_pfn_offset exists.

That probably is the case.  But without access to the hardware I don't
feel like doing this deeper surgery.  And even without that this case
provides a great simplification.
