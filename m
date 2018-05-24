Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965386AbeEXHxf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 03:53:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:49156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935667AbeEXHxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 03:53:31 -0400
Date: Thu, 24 May 2018 09:53:27 +0200
From: Michal Hocko <mhocko@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Balbir Singh <bsingharora@gmail.com>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>, Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Huang Ying <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@kernel.org>, Jaewon Kim <jaewon31.kim@samsung.com>,
        Jan Kara <jack@suse.cz>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>, Mel Gorman <mgorman@suse.de>,
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
        Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1 00/10] mm: online/offline 4MB chunks controlled by
 device driver
Message-ID: <20180524075327.GU20441@dhcp22.suse.cz>
References: <20180523151151.6730-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523151151.6730-1-david@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've had some questions before and I am not sure they are fully covered.
At least not in the cover letter (I didn't get much further yet) which
should give us a highlevel overview of the feature.

On Wed 23-05-18 17:11:41, David Hildenbrand wrote:
> This is now the !RFC version. I did some additional tests and inspected
> all memory notifiers. At least page_ext and kasan need fixes.
> 
> ==========
> 
> I am right now working on a paravirtualized memory device ("virtio-mem").
> These devices control a memory region and the amount of memory available
> via it. Memory will not be indicated/added/onlined via ACPI and friends,
> the device driver is responsible for it.
> 
> When the device driver starts up, it will add and online the requested
> amount of memory from its assigned physical memory region. On request, it
> can add (online) either more memory or try to remove (offline) memory. As
> it will be a virtio module, we also want to be able to have it as a loadable
> kernel module.

How do you handle the offline case? Do you online all the memory to
zone_movable?

> Such a device can be thought of like a "resizable DIMM" or a "huge
> number of 4MB DIMMS" that can be automatically managed.

Why do we need such a small granularity? The whole memory hotplug is
centered around memory sections and those are 128MB in size. Smaller
sizes simply do not fit into that concept. How do you deal with that?

> As we want to be able to add/remove small chunks of memory to a VM without
> fragmenting guest memory ("it's not what the guest pays for" and "what if
> the hypervisor wants to use huge pages"), it looks like we can do that
> under Linux in a 4MB granularity by using online_pages()/offline_pages()

Please expand on this some more. Larger logical units usually lead to a
smaller fragmentation.

> We add a segment and online only 4MB blocks of it on demand. So the other
> memory might not be accessible.

But you still allocate vmemmap for the full memory section, right? That
would mean that you spend 2MB to online 4MB of memory. Sounds quite
wasteful to me.

> For kdump and onlining/offlining code, we
> have to mark pages as offline before a new segment is visible to the system
> (e.g. as these pages might not be backed by real memory in the hypervisor).

Please expand on the kdump part. That is really confusing because
hotplug should simply not depend on kdump at all. Moreover why don't you
simply mark those pages reserved and pull them out from the page
allocator?
-- 
Michal Hocko
SUSE Labs
