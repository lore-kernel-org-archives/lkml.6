Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752361AbeEQRVd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 13:21:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:58130 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752320AbeEQRVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 13:21:32 -0400
Date: Thu, 17 May 2018 19:21:28 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Tony Lindgren <tony@atomide.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Laura Abbott <lauraa@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Nazarewicz <mina86@mina86.com>,
        Minchan Kim <minchan@kernel.org>, Rik van Riel <riel@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "mm/cma: manage the memory of the CMA area by
 using the ZONE_MOVABLE"
Message-ID: <20180517172128.GX12670@dhcp22.suse.cz>
References: <20180517125959.8095-1-ville.syrjala@linux.intel.com>
 <20180517132109.GU12670@dhcp22.suse.cz>
 <20180517133629.GH23723@intel.com>
 <20180517135832.GI23723@intel.com>
 <20180517164947.GV12670@dhcp22.suse.cz>
 <20180517171335.GN23723@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180517171335.GN23723@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-05-18 20:13:35, Ville Syrjälä wrote:
> On Thu, May 17, 2018 at 06:49:47PM +0200, Michal Hocko wrote:
> > On Thu 17-05-18 16:58:32, Ville Syrjälä wrote:
> > > On Thu, May 17, 2018 at 04:36:29PM +0300, Ville Syrjälä wrote:
> > > > On Thu, May 17, 2018 at 03:21:09PM +0200, Michal Hocko wrote:
> > > > > On Thu 17-05-18 15:59:59, Ville Syrjala wrote:
> > > > > > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > > > > 
> > > > > > This reverts commit bad8c6c0b1144694ecb0bc5629ede9b8b578b86e.
> > > > > > 
> > > > > > Make x86 with HIGHMEM=y and CMA=y boot again.
> > > > > 
> > > > > Is there any bug report with some more details? It is much more
> > > > > preferable to fix the issue rather than to revert the whole thing
> > > > > right away.
> > > > 
> > > > The machine I have in front of me right now didn't give me anything.
> > > > Black screen, and netconsole was silent. No serial port on this
> > > > machine unfortunately.
> > > 
> > > Booted on another machine with serial:
> > 
> > Could you provide your .config please?
> 
> Attached. Not sure there's anything particularly useful in it though
> since I've now seen this on all the highmem systems I've booted.

It has CONFIG_HAVE_MEMBLOCK_NODE_MAP so the movable_zone initialization
depends on quite some crazy movable init code paths. So maybe that is
the place to look at.
 
 
> BTW I just noticed that the reported memory sizes look pretty crazy:
> 
> Memory: 3926480K/3987424K available (5254K kernel code, 561K rwdata,
> 2156K rodata, 572K init, 9308K bss, 56848K reserved,
> 4096K cma-reserved, 3078532K highmem)
> 
> vs.
> 
> Memory: 7001976K/3987424K available (5254K kernel code, 561K rwdata,
> 2156K rodata, 572K init, 9308K bss, 4291097664K reserved,
> 4096K cma-reserved, 7005012K highmem)

This smells like a fallout. Reserved pages clearly underflowed which
suggested we are initializating more than we should.
-- 
Michal Hocko
SUSE Labs
