Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbeCMNK0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:10:26 -0400
Received: from verein.lst.de ([213.95.11.211]:57831 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932618AbeCMNKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:10:07 -0400
Date: Tue, 13 Mar 2018 14:10:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] dma-direct: handle the memory encryption bit in
        common code
Message-ID: <20180313131005.GA6260@lst.de>
References: <20180305174655.9878-1-hch@lst.de> <20180305174655.9878-12-hch@lst.de> <114e27be-5814-4258-4985-af08763c8a74@amd.com> <0c9d3e4a-8407-282a-73eb-21d28047e0e3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c9d3e4a-8407-282a-73eb-21d28047e0e3@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 02:48:51PM -0500, Tom Lendacky wrote:
> Ok, I found one issue that allows this to work when the IOMMU isn't
> enabled (see below).

Thanks, folded!

> But the bigger issue is when the IOMMU is enabled.  The IOMMU code uses
> a common mapping routine to create the I/O page tables.  This routine
> assumes that all memory being mapped is encrypted and therefore sets the
> encryption bit in the I/O page tables.  With this patch, the call to
> dma_alloc_direct() now returns un-encrypted memory which results in an
> encryption mis-match.  I think keeping dma_alloc_direct() as it was prior
> to this patch is the way to go.  It allows SME DMA allocations to remain
> encrypted and avoids added complexity in the amd_iommu.c file.  This
> would mean that SEV would still have special DMA operations (so that the
> alloc/free can change the memory to un-encrypted).
> 
> What do you think?

In terms of logic you are right.  I still don't like keeping a just
slightly tweaked version of dma_alloc_direct around just for this, it
will be perpetually out of sync in terms of features and bug fixes.

What do you think about this version that does the decision at runtime:

	http://git.infradead.org/users/hch/misc.git/commitdiff/b89f24dc856595dc7610d672bf077195ab0dabf4

The full tree is available here for testing:

	git://git.infradead.org/users/hch/misc.git dma-direct-x86
