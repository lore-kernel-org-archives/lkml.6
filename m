Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033256AbeEXOWu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:22:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:38815 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030742AbeEXOWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:22:48 -0400
Date: Thu, 24 May 2018 16:22:42 +0200
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
Message-ID: <20180524142241.GJ20441@dhcp22.suse.cz>
References: <20180523151151.6730-1-david@redhat.com>
 <20180524075327.GU20441@dhcp22.suse.cz>
 <14d79dad-ad47-f090-2ec0-c5daf87ac529@redhat.com>
 <20180524093121.GZ20441@dhcp22.suse.cz>
 <c0b8bbd5-6c01-f550-ae13-ef80b2255ea6@redhat.com>
 <20180524120341.GF20441@dhcp22.suse.cz>
 <1a03ac4e-9185-ce8e-a672-c747c3e40ff2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a03ac4e-9185-ce8e-a672-c747c3e40ff2@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will go over the rest of the email later I just wanted to make this
point clear because I suspect we are talking past each other.

On Thu 24-05-18 16:04:38, David Hildenbrand wrote:
[...]
> The point I was making is: I cannot allocate 8MB/128MB using the buddy
> allocator. All I want to do is manage the memory a virtio-mem device
> provides as flexible as possible.

I didn't mean to use the page allocator to isolate pages from it. We do
have other means. Have a look at the page isolation framework and have a
look how the current memory hotplug (ab)uses it. In short you mark the
desired physical memory range as isolated (nobody can allocate from it)
and then simply remove it from the page allocator. And you are done with
it. Your particular range is gone, nobody will ever use it. If you mark
those struct pages reserved then pfn walkers should already ignore them.
If you keep those pages with ref count 0 then even hotplug should work
seemlessly (I would have to double check).

So all I am arguing is that whatever your driver wants to do can be
handled without touching the hotplug code much. You would still need
to add new ranges in the mem section units and manage on top of that.
You need to do that anyway to keep track of what parts are in use or
offlined anyway right? Now the mem sections. You have to do that anyway
for memmaps. Our sparse memory model simply works in those units. Even
if you make a part of that range unavailable then the section will still
be there.

Do I make at least some sense or I am completely missing your point?
-- 
Michal Hocko
SUSE Labs
