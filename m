Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758481AbeD0QSS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:18:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33108 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757513AbeD0QSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:18:17 -0400
Date: Fri, 27 Apr 2018 09:18:13 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Christopher Lameter <cl@linux.com>
Cc: Michal Hocko <mhocko@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-mm@kvack.org,
        Jan Kara <jack@suse.cz>, matthew@wil.cx, x86@kernel.org,
        luto@amacapital.net, martin.petersen@oracle.com, jthumshirn@suse.de,
        broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM TOPIC NOTES] x86 ZONE_DMA love
Message-ID: <20180427161813.GD8161@bombadil.infradead.org>
References: <20180426215406.GB27853@wotan.suse.de>
 <20180427053556.GB11339@infradead.org>
 <20180427071843.GB17484@dhcp22.suse.cz>
 <alpine.DEB.2.20.1804271103160.11686@nuc-kabylake>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1804271103160.11686@nuc-kabylake>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 11:07:07AM -0500, Christopher Lameter wrote:
> Well it looks like what we are using it for is to force allocation from
> low physical memory if we fail to obtain proper memory through a normal
> channel.  The use of ZONE_DMA is only there for emergency purposes.
> I think we could subsitute ZONE_DMA32 on x87 without a problem.
> 
> Which means that ZONE_DMA has no purpose anymore.
> 
> Can we make ZONE_DMA on x86 refer to the low 32 bit physical addresses
> instead and remove ZONE_DMA32?
> 
> That would actually improve the fallback because you have more memory for
> the old devices.

Some devices have incredibly bogus hardware like 28 bit addressing
or 39 bit addressing.  We don't have a good way to allocate memory by
physical address other than than saying "GFP_DMA for anything less than
32, GFP_DMA32 (or GFP_KERNEL on 32-bit) for anything less than 64 bit".

Even CMA doesn't have a "cma_alloc_phys()".  Maybe that's the right place
to put such an allocation API.
