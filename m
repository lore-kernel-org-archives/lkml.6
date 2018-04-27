Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758718AbeD0QHM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:07:12 -0400
Received: from resqmta-ch2-06v.sys.comcast.net ([69.252.207.38]:43332 "EHLO
        resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758682AbeD0QHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:07:09 -0400
Date: Fri, 27 Apr 2018 11:07:07 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Michal Hocko <mhocko@kernel.org>
cc: Christoph Hellwig <hch@infradead.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-mm@kvack.org,
        Jan Kara <jack@suse.cz>, matthew@wil.cx, x86@kernel.org,
        luto@amacapital.net, martin.petersen@oracle.com, jthumshirn@suse.de,
        broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM TOPIC NOTES] x86 ZONE_DMA love
In-Reply-To: <20180427071843.GB17484@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.20.1804271103160.11686@nuc-kabylake>
References: <20180426215406.GB27853@wotan.suse.de> <20180427053556.GB11339@infradead.org> <20180427071843.GB17484@dhcp22.suse.cz>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfMAO9VLGcmmzJ8pEpuUJK/dweQkO0A/z1EuYoUV+qY/yyFe1u/g90kFtsl61saQUBa6xwBB0hvL0W1OslmhNffa6dxAa06wSkbqqCDjf4EwWOwEkO10F
 KR/CHr2Nc14Aa4W9uikRhTiIc0F46dHGhHDYfCO/DDQYxxW3jan1oeMr622M1pY4NJxZ2uBdLQGftPcq/NVDPOHEbKrURsaGI/p35+niaC7sI1FE1yzl/fe9
 9pUVFhFubzTol4AZpnJacY0iXvGQCEH9u2v+aTY7YM9fJKKopK6s0aPSFuQYQCr7lYBT86fXO36JRM0clAaIIjj4iwe6QEbpVh9mI56ilnuc3katwfGGkwFJ
 U5XXEVDJxAb+8AibQrIKxHi3pNdhzLabGTfoii9MjOZBTY7nKrZgWsveO5QqakotIMG8LNZ9s0TiIMsYwvu5yQA/izSm9CPDdFwvI5iUyVnvdznh9NRRFpUB
 RYnS3kGAQfFe2xWDkyWPWL5fdXnOOBGBa9xgzfZ9rSnv0xqoOEsJlf1GaflBHPUmkjFTlQMw8FOVhCbrxs51YJlgDSLpYWzTz5peDI8BawctWWR8hbMuYcN0
 YR5MZbSb20x1TtV+6QYgPCHq
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2018, Michal Hocko wrote:

> On Thu 26-04-18 22:35:56, Christoph Hellwig wrote:
> > On Thu, Apr 26, 2018 at 09:54:06PM +0000, Luis R. Rodriguez wrote:
> > > In practice if you don't have a floppy device on x86, you don't need ZONE_DMA,
> >
> > I call BS on that, and you actually explain later why it it BS due
> > to some drivers using it more explicitly.  But even more importantly
> > we have plenty driver using it through dma_alloc_* and a small DMA
> > mask, and they are in use - we actually had a 4.16 regression due to
> > them.
>
> Well, but do we need a zone for that purpose? The idea was to actually
> replace the zone by a CMA pool (at least on x86). With the current
> implementation of the CMA we would move the range [0-16M] pfn range into
> zone_movable so it can be used and we would get rid of all of the
> overhead each zone brings (a bit in page flags, kmalloc caches and who
> knows what else)

Well it looks like what we are using it for is to force allocation from
low physical memory if we fail to obtain proper memory through a normal
channel.  The use of ZONE_DMA is only there for emergency purposes.
I think we could subsitute ZONE_DMA32 on x87 without a problem.

Which means that ZONE_DMA has no purpose anymore.

Can we make ZONE_DMA on x86 refer to the low 32 bit physical addresses
instead and remove ZONE_DMA32?

That would actually improve the fallback because you have more memory for
the old devices.
