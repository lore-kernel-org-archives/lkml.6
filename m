Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbeBQWsV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 17:48:21 -0500
Received: from smtp1.de.adit-jv.com ([62.225.105.245]:53953 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbeBQWsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 17:48:20 -0500
Date: Sat, 17 Feb 2018 23:48:06 +0100
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Sistare <steven.sistare@oracle.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Miles Chen <miles.chen@mediatek.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hartley <james.hartley@mips.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <rosca.eugeniu@gmail.com>
Subject: Re: [PATCH v3 1/1] mm: page_alloc: skip over regions of invalid pfns
 on UMA
Message-ID: <20180217224806.GA32581@vmlxhi-102.adit-jv.com>
References: <20180124143545.31963-1-erosca@de.adit-jv.com>
 <20180124143545.31963-2-erosca@de.adit-jv.com>
 <20180129184746.GK21609@dhcp22.suse.cz>
 <20180203122422.GA11832@vmlxhi-102.adit-jv.com>
 <20180212150314.GG3443@dhcp22.suse.cz>
 <20180212161640.GA30811@vmlxhi-102.adit-jv.com>
 <20180212184759.GI3443@dhcp22.suse.cz>
 <20180216164328.de7d37584409e827c396bf69@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180216164328.de7d37584409e827c396bf69@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On Fri, Feb 16, 2018 at 04:43:28PM -0800, Andrew Morton wrote:
> On Mon, 12 Feb 2018 19:47:59 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > > prerequisite for this is to reach some agreement on what people think is
> > > the best option, which I feel didn't occur yet.
> > 
> > I do not have a _strong_ preference here as well. So I will leave the
> > decision to you.
> > 
> > In any case feel free to add
> > Acked-by: Michal Hocko <mhocko@suse.com>
> 
> I find Michal's version to be a little tidier.
> 
> Eugeniu, please send Michal's patch at me with a fresh changelog, with
> your signed-off-by and your tested-by and your reported-by and we may
> as well add Michal's (thus-far-missing) signed-off-by ;)

I only needed to apply below touch to Michal's patch, which otherwise
works fine for me. I've sent it to you as v4. Thank you very much for
picking it.

Best regards,
Eugeniu.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cb3f844092ad..66891b3fb144 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5356,7 +5356,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
                         * end_pfn), such that we hit a valid pfn (or end_pfn)
                         * on our next iteration of the loop.
                         */
-                       if IS_ENABLED(HAVE_MEMBLOCK)
+                       if (IS_ENABLED(CONFIG_HAVE_MEMBLOCK))
                                pfn = memblock_next_valid_pfn(pfn, end_pfn) - 1;
                        continue;
                }
