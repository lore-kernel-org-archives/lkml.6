Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6D7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337B5223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337B5223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388353AbeKOW1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 17:27:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:52632 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729008AbeKOW1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 17:27:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3A3AB023;
        Thu, 15 Nov 2018 12:19:57 +0000 (UTC)
Date:   Thu, 15 Nov 2018 13:19:50 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Hansen <chansen3@cisco.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Miles Chen <miles.chen@mediatek.com>,
        David Rientjes <rientjes@google.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>
Subject: Re: [PATCH RFC 2/6] mm: convert PG_balloon to PG_offline
Message-ID: <20181115121950.GQ23831@dhcp22.suse.cz>
References: <20181114211704.6381-1-david@redhat.com>
 <20181114211704.6381-3-david@redhat.com>
 <20181114222321.GB1784@bombadil.infradead.org>
 <b4668081-5aa3-d7f5-6880-d01c75cfc6ae@redhat.com>
 <20181115020725.GC2353@rapoport-lnx>
 <5730ee16-9b18-ad3d-0fb3-e9edb55e2298@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5730ee16-9b18-ad3d-0fb3-e9edb55e2298@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Konstantin - the patch is http://lkml.kernel.org/r/20181114211704.6381-3-david@redhat.com]

On Thu 15-11-18 10:21:13, David Hildenbrand wrote:
> On 15.11.18 03:07, Mike Rapoport wrote:
> > On Wed, Nov 14, 2018 at 11:49:15PM +0100, David Hildenbrand wrote:
> >> On 14.11.18 23:23, Matthew Wilcox wrote:
> >>> On Wed, Nov 14, 2018 at 10:17:00PM +0100, David Hildenbrand wrote:
> >>>> Rename PG_balloon to PG_offline. This is an indicator that the page is
> >>>> logically offline, the content stale and that it should not be touched
> >>>> (e.g. a hypervisor would have to allocate backing storage in order for the
> >>>> guest to dump an unused page).  We can then e.g. exclude such pages from
> >>>> dumps.
> >>>>
> >>>> In following patches, we will make use of this bit also in other balloon
> >>>> drivers.  While at it, document PGTABLE.
> >>>
> >>> Thank you for documenting PGTABLE.  I didn't realise I also had this
> >>> document to update when I added PGTABLE.
> >>
> >> Thank you for looking into this :)
> >>
> >>>
> >>>> +++ b/Documentation/admin-guide/mm/pagemap.rst
> >>>> @@ -78,6 +78,8 @@ number of times a page is mapped.
> >>>>      23. BALLOON
> >>>>      24. ZERO_PAGE
> >>>>      25. IDLE
> >>>> +    26. PGTABLE
> >>>> +    27. OFFLINE
> >>>
> >>> So the offline *user* bit is new ... even though the *kernel* bit
> >>> just renames the balloon bit.  I'm not sure how I feel about this.
> >>> I'm going to think about it some more.  Could you share your decision
> >>> process with us?
> >>
> >> BALLOON was/is documented as
> >>
> >> "23 - BALLOON
> >>     balloon compaction page
> >> "
> >>
> >> and only includes all virtio-ballon pages after the non-lru migration
> >> feature has been implemented for ballooned pages. Since then, this flag
> >> does basically no longer stands for what it actually was supposed to do.
> > 
> > Perhaps I missing something, but how the user should interpret "23" when he
> > reads /proc/kpageflags?
> 
> Looking at the history in more detail:
> 
> commit 09316c09dde33aae14f34489d9e3d243ec0d5938
> Author: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
> Date:   Thu Oct 9 15:29:32 2014 -0700
> 
>     mm/balloon_compaction: add vmstat counters and kpageflags bit
> 
>     Always mark pages with PageBalloon even if balloon compaction is
> disabled
>     and expose this mark in /proc/kpageflags as KPF_BALLOON.
> 
> 
> So KPF_BALLOON was exposed when virtio-balloon pages were always marked
> with PG_balloon. So the documentation is actually wrong ("balloon page"
> vs. "balloon compaction page").
> 
> I have no idea who actually used that information. I suspect this was
> just some debugging aid.
> 
> > 
> >> To not break uapi I decided to not rename it but instead to add a new flag.
> > 
> > I've got a feeling that uapi was anyway changed for the BALLON flag
> > meaning.
> 
> Yes. If we *replace* KPF_BALLOON by KPF_OFFLINE
> 
> a) Some applications might no longer compile (I guess that's ok)
> b) Some old applications will treat KPF_OFFLINE like KPF_BALLOON (which
> should at least for virtio-balloon usage until now be fine - it is just
> more generic)

I do not think any compilation could break. If the semantic of the flag
is preserved then everything should work as expected.
-- 
Michal Hocko
SUSE Labs
