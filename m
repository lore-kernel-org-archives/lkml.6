Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbeD0FgH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 01:36:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37762 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbeD0FgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 01:36:05 -0400
Date: Thu, 26 Apr 2018 22:35:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: linux-mm@kvack.org, mhocko@kernel.org, cl@linux.com,
        Jan Kara <jack@suse.cz>, matthew@wil.cx, x86@kernel.org,
        luto@amacapital.net, martin.petersen@oracle.com, jthumshirn@suse.de,
        broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM TOPIC NOTES] x86 ZONE_DMA love
Message-ID: <20180427053556.GB11339@infradead.org>
References: <20180426215406.GB27853@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426215406.GB27853@wotan.suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 09:54:06PM +0000, Luis R. Rodriguez wrote:
> In practice if you don't have a floppy device on x86, you don't need ZONE_DMA,

I call BS on that, and you actually explain later why it it BS due
to some drivers using it more explicitly.  But even more importantly
we have plenty driver using it through dma_alloc_* and a small DMA
mask, and they are in use - we actually had a 4.16 regression due to
them.

> SCSI is *severely* affected:

Not really.  We have unchecked_isa_dma to support about 4 drivers,
and less than a hand ful of drivers doing stupid things, which can
be fixed easily, and just need a volunteer.

> That's the end of the review of all current explicit callers on x86.
> 
> # dma_alloc_coherent_gfp_flags() and dma_generic_alloc_coherent()
> 
> dma_alloc_coherent_gfp_flags() and dma_generic_alloc_coherent() set
> GFP_DMA if if (dma_mask <= DMA_BIT_MASK(24))

All that code is long gone and replaced with dma-direct.  Which still
uses GFP_DMA based on the dma mask, though - see above.
