Return-Path: <david@redhat.com>
X-Google-Smtp-Source: AIpwx4/Zip5NcVzReEYpR+cq1mHY+JVQvY+hpJiBUC4d3GzoPOSZUwrDG4glR1sfZq+FCSLbMYy/
ARC-Seal: i=1; a=rsa-sha256; t=1523867517; cv=none;
        d=google.com; s=arc-20160816;
        b=cyX77cqElxAWjY7v+Tih5+qQNOOi1TtVRPqaGfI1+zBb4b/8lflGumhwQefi6NRMTc
         Ng60Br8neDWELilP+eDUgnLSc0eM97E2eYOVuFMdsGVTMHFoaWUppaJvhrO+9n3/UAtL
         B8Lfh2HQ+A5LjHQ3yZ3237f4HPj0ugY0KQWCojHO2wUbdxyNajodO3gD7MmBT9sQU5zF
         gTiKOG0AMEhY8tVGO3w0wIUKbNWh8llW9OTarfJUjqPty1vbfsHut+9tgkrd6Sp/6ySv
         jCjd+fzDDHOYHnBcmGlJm6qGQJ5XPe3aIWuCZbdTnTG9lRf8txMhOktFbsGZb9petPfj
         Caog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=kk1VMKyWqMsaDjCgs+FUXXvBM2Avk99rP0f1uLxi7bY=;
        b=lOfHHpqOvUlKrfFMobOxvlpOZQNzmW26lpwLlOA0Zts7rBCQHG8t4s4JXXWncTl3Od
         ugh0u4636J9bGDdVm3FryjbanLdiCr1EMij2VVHeQJFe8K3Z+4Z2bDzra0MscAAwboju
         uob6u8fxYvMEyGredrPwVdvjfUgM5K06WGURX4Iuf5tVRQGq7eZrruVIfRhaixx1AyKf
         IDy3S39ibkWYwSYvwV/hI94adrw/1NPrtTObNNVl+GWBdnmTQGhKEhJkJ3M0n15RzpG6
         9tXQ3mgYM4zFOW9BoPLH8QvbY8zrI4S1lhkpCBm8lMCqHm3p7xVCgSmyxWEyPBSM6TzX
         HNXw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [PATCH RFC 2/8] mm: introduce PG_offline
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
 Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Michal Hocko <mhocko@suse.com>, Huang Ying <ying.huang@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Pavel Tatashin <pasha.tatashin@oracle.com>,
 Miles Chen <miles.chen@mediatek.com>, Vlastimil Babka <vbabka@suse.cz>,
 Mel Gorman <mgorman@techsingularity.net>, Rik van Riel <riel@redhat.com>,
 James Hogan <jhogan@kernel.org>,
 "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20180413131632.1413-1-david@redhat.com>
 <20180413131632.1413-3-david@redhat.com>
 <20180413171120.GA1245@bombadil.infradead.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <1ecb2fe4-a22e-813f-a157-1fdaf3cbc8d1@redhat.com>
Date: Mon, 16 Apr 2018 10:31:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413171120.GA1245@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597637040722220932?=
X-GMAIL-MSGID: =?utf-8?q?1597890905729199881?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 13.04.2018 19:11, Matthew Wilcox wrote:
> On Fri, Apr 13, 2018 at 03:16:26PM +0200, David Hildenbrand wrote:
>> online_pages()/offline_pages() theoretically allows us to work on
>> sub-section sizes. This is especially relevant in the context of
>> virtualization. It e.g. allows us to add/remove memory to Linux in a VM in
>> 4MB chunks.
>>
>> While the whole section is marked as online/offline, we have to know
>> the state of each page. E.g. to not read memory that is not online
>> during kexec() or to properly mark a section as offline as soon as all
>> contained pages are offline.
> 
> Can you not use PG_reserved for this purpose?
> 
>> + * PG_offline indicates that a page is offline and the backing storage
>> + * might already have been removed (virtualization). Don't touch!
> 
>  * PG_reserved is set for special pages, which can never be swapped out. Some
>  * of them might not even exist...
> 
> They seem pretty congruent to me.
> 

Can we really go ahead and make dump tools exclude any PG_reserved page
from a memory dump? While it might be true for ballooned pages, I doubt
that this assumption holds in general. ("cannot be swapped out" doesn't
imply "content should never be read/dumped")


I need PG_offline right now for two reasons:

1. Make kdump skip these pages (like PG_hwpoison), because they might
not even be readable anymore as the hypervisor might have restricted
memory access completely.

2. Detect when all pages of a memory section are offline, so we can mark
the section as offline and eventually remove it.


A clear point speaking against using PG_reserved for 2. is the following
simple example.

Let's assume we use virtio-balloon and inflated some chunk of memory in
a section (let's say 4MB). Now we offline (using the new driver) all
other chunks in a section, except the memory allocated by
virtio-balloon. We would suddenly mark the section as offline and
eventually remove it. This is of course very bad.


I think using PG_reserved for 1. is wrong. PG_reserved is usually used
for pages _after_ coming from an allocator. Using PG_reserved for 2.
will not work.


An ugly way for 2. would be, remembering for each section which pages
are actually online, but I would like to avoid that, especially as it
only solves part of a problem.

-- 

Thanks,

David / dhildenb
