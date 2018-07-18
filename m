Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A02EECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEF32075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DEF32075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbeGRN5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:57:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:34712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730329AbeGRN5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:57:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9B940AE61;
        Wed, 18 Jul 2018 13:19:10 +0000 (UTC)
Date:   Wed, 18 Jul 2018 15:19:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>, Jan Kara <jack@suse.cz>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Mel Gorman <mgorman@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miles Chen <miles.chen@mediatek.com>,
        Oscar Salvador <osalvador@techadventures.net>,
        Paul Mackerras <paulus@samba.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Reza Arbab <arbab@linux.vnet.ibm.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1 00/10] mm: online/offline 4MB chunks controlled by
 device driver
Message-ID: <20180718131905.GB7193@dhcp22.suse.cz>
References: <20180523151151.6730-1-david@redhat.com>
 <20180524075327.GU20441@dhcp22.suse.cz>
 <14d79dad-ad47-f090-2ec0-c5daf87ac529@redhat.com>
 <20180524093121.GZ20441@dhcp22.suse.cz>
 <c0b8bbd5-6c01-f550-ae13-ef80b2255ea6@redhat.com>
 <20180524120341.GF20441@dhcp22.suse.cz>
 <1a03ac4e-9185-ce8e-a672-c747c3e40ff2@redhat.com>
 <20180524142241.GJ20441@dhcp22.suse.cz>
 <819e45c5-6ae3-1dff-3f1d-c0411b6e2e1d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <819e45c5-6ae3-1dff-3f1d-c0411b6e2e1d@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[got back to this really late. Sorry about that]

On Thu 24-05-18 23:07:23, David Hildenbrand wrote:
> On 24.05.2018 16:22, Michal Hocko wrote:
> > I will go over the rest of the email later I just wanted to make this
> > point clear because I suspect we are talking past each other.
> 
> It sounds like we are now talking about how to solve the problem. I like
> that :)
> 
> > 
> > On Thu 24-05-18 16:04:38, David Hildenbrand wrote:
> > [...]
> >> The point I was making is: I cannot allocate 8MB/128MB using the buddy
> >> allocator. All I want to do is manage the memory a virtio-mem device
> >> provides as flexible as possible.
> > 
> > I didn't mean to use the page allocator to isolate pages from it. We do
> > have other means. Have a look at the page isolation framework and have a
> > look how the current memory hotplug (ab)uses it. In short you mark the
> > desired physical memory range as isolated (nobody can allocate from it)
> > and then simply remove it from the page allocator. And you are done with
> > it. Your particular range is gone, nobody will ever use it. If you mark
> > those struct pages reserved then pfn walkers should already ignore them.
> > If you keep those pages with ref count 0 then even hotplug should work
> > seemlessly (I would have to double check).
> > 
> > So all I am arguing is that whatever your driver wants to do can be
> > handled without touching the hotplug code much. You would still need
> > to add new ranges in the mem section units and manage on top of that.
> > You need to do that anyway to keep track of what parts are in use or
> > offlined anyway right? Now the mem sections. You have to do that anyway
> > for memmaps. Our sparse memory model simply works in those units. Even
> > if you make a part of that range unavailable then the section will still
> > be there.
> > 
> > Do I make at least some sense or I am completely missing your point?
> > 
> 
> I think we're heading somewhere. I understand that you want to separate
> this "semi" offline part from the general offlining code. If so, we
> should definitely enforce segment alignment for online_pages/offline_pages.
> 
> Importantly, what I need is:
> 
> 1. Indicate and prepare memory sections to be used for adding memory
>    chunks (right now add_memory())

Yes, this is section based. So you will always get memmap (struct page)
for the whole section.

> 2. Make memory chunks of a section available to the system (right now
>    online_pages())

Yes, this doesn't have to be section based. All you need is to mark
remaining pages as offline. They are reserved at this moment so nobody
should touch tehem.

> 3. Remove memory chunks of a section from the system (right now
>    offline_pages())

Yes. All we need is to note that those reserved pages are actually good
to offline. I have mentioned that reserved pages are yours at this stage
so you can note the special state without an additional page flag.

The generic hotplug code just have to learn about this new state.
has_unmovable_pages sounds like a proper place to do that. You simply
clear the offline state and the PageReserved and you are done with the
page.

> 4. Remove memory sections from the system (right now remove_memory())

no change needed

> 5. Hinder dumping tools from reading memory chunks that are logically
>    offline (right now PageOffline())

I still fail to see why do we even care about some dumping tools. Pages
are reserved so they simply shouldn't touch that memory at all.

-- 
Michal Hocko
SUSE Labs
