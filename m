Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDEBC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA43520656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfAOMux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:50:53 -0500
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:37306 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728181AbfAOMuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:50:52 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 15889B870F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 12:50:50 +0000 (GMT)
Received: (qmail 3612 invoked from network); 15 Jan 2019 12:50:50 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 Jan 2019 12:50:49 -0000
Date:   Tue, 15 Jan 2019 12:50:45 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/25] mm, compaction: Skip pageblocks with reserved pages
Message-ID: <20190115125045.GA27437@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-7-mgorman@techsingularity.net>
 <657ee6fc-48df-59ab-70b7-6066513e3b22@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <657ee6fc-48df-59ab-70b7-6066513e3b22@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 01:10:57PM +0100, Vlastimil Babka wrote:
> On 1/4/19 1:49 PM, Mel Gorman wrote:
> > Reserved pages are set at boot time, tend to be clustered and almost never
> > become unreserved. When isolating pages for either migration sources or
> > target, skip the entire pageblock is one PageReserved page is encountered
> > on the grounds that it is highly probable the entire pageblock is reserved.
> > 
> > The performance impact is relative to the number of reserved pages in
> > the system and their location so it'll be variable but intuitively it
> > should make sense. If the memblock allocator was ever changed to spread
> > reserved pages throughout the address space then this patch would be
> > impaired but it would also be considered a bug given that such a change
> > would ruin fragmentation.
> > 
> > On both 1-socket and 2-socket machines, scan rates are reduced slightly
> > on workloads that intensively allocate THP while the system is fragmented.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > ---
> >  mm/compaction.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index 3afa4e9188b6..94d1e5b062ea 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -484,6 +484,15 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
> >  			goto isolate_fail;
> >  		}
> >  
> > +		/*
> > +		 * A reserved page is never freed and tend to be clustered in
> > +		 * the same pageblock. Skip the block.
> > +		 */
> > +		if (PageReserved(page)) {
> > +			blockpfn = end_pfn;
> > +			break;
> > +		}
> > +
> >  		if (!PageBuddy(page))
> >  			goto isolate_fail;
> >  
> > @@ -827,6 +836,13 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
> >  					goto isolate_success;
> >  			}
> >  
> > +			/*
> > +			 * A reserved page is never freed and tend to be
> > +			 * clustered in the same pageblocks. Skip the block.
> 
> AFAICS memory allocator is not the only user of PageReserved. There
> seems to be some drivers as well, notably the DRM subsystem via
> drm_pci_alloc(). There's an effort to clean those up [1] but until then,
> there might be some false positives here.
> 
> [1] https://marc.info/?l=linux-mm&m=154747078617898&w=2
> 

Hmm, I'm tempted to leave this anyway. The reservations for PCI space are
likely to be persistent and I also do not expect them to grow much. While
I consider it to be partially abuse to use PageReserved like this, it
should get cleaned up slowly over time. If this turns out to be wrong,
I'll attempt to fix the responsible driver that is scattering
PageReserved around the place and at worst, revert this if it turns out
to be a major problem in practice. Any objections?

-- 
Mel Gorman
SUSE Labs
