Return-Path: <david@redhat.com>
X-Google-Smtp-Source: AB8JxZp7eCKshG33FwHcLr6wmOnhrdhhDrcqq6E0nPl2Ng7DpgkhiOEnC23nP18kyKT0HZc5znYD
ARC-Seal: i=1; a=rsa-sha256; t=1524385058; cv=none;
        d=google.com; s=arc-20160816;
        b=xn2JLiXulxj1yfCYUpXqpSWlwnI9HwFp0i7dYg3WDofONMTSUdzQNQxl99O4+Hg6Op
         a4PSJl99z/Nn5WqafjiHqJFBLfX/dWMlGm1rOuDSNnCUxwVxbbnPFmcKvL8aCZ9QaP9w
         jiq56QfQzeALWVhb7f26FB8EAZyRW+t5r6k1aUXcOtfqu03qzspQdaSE9HMxBSJRls3L
         kb2Imkg5w/0ObPhXNP9kwE4pDIQecuIIaT/W8UyVW+BTZ6n5q0MtiKgmFoTJSOXmeNi3
         8gAjgMbPAovlX+4sEtmvIs+Zb3qqYs/3T6ynrGZPH4h+KEWr4qvIp5WJDqF8kG6JlQYy
         0SvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=kbZFoQ5fQKYv3XDPShCXfC8r3vEqUYx7Sm0NqPnqjgs=;
        b=j/A2+rP0LLc7LigzZgx53H+qNKRs2PrLWowlygNnZWYisUjtaFqTRmqBJVmvgZrgNy
         jIl8fnrTQvluuvJE+/5MB2tXePHBi/GbmbEFIFqdjnZBEddIsOLXIZfzLnxn+Gf2n2o/
         kIyLz9nDeuM2M2mH93enYHwAtb0mnShsiptcanx6ZO1WpSbQoHsH8T/GHQbIZx0QSLs7
         t3gXPfE6NbKchUVmLAOS1ioYA9avVboT9cmCl6hu+1PQjEUz3joY8YkCLl/QD+68ryuh
         wKNUbdyUY7QewQU26Hq0CdRGVBC/Hr59Y5bO8Mfc/RS9fC2Ij3JaQm237sywV+DhGrWD
         TFfg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [PATCH RFC 2/8] mm: introduce PG_offline
To: Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
 Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Michal Hocko <mhocko@suse.com>, Huang Ying <ying.huang@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Pavel Tatashin <pasha.tatashin@oracle.com>,
 Miles Chen <miles.chen@mediatek.com>,
 Mel Gorman <mgorman@techsingularity.net>, Rik van Riel <riel@redhat.com>,
 James Hogan <jhogan@kernel.org>,
 "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20180413131632.1413-1-david@redhat.com>
 <20180413131632.1413-3-david@redhat.com>
 <20180413171120.GA1245@bombadil.infradead.org>
 <89329958-2ff8-9447-408e-fd478b914ec4@suse.cz>
 <20180422030130.GG14610@bombadil.infradead.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <7db70df4-c714-574c-5b14-898c1cf49af6@redhat.com>
Date: Sun, 22 Apr 2018 10:17:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180422030130.GG14610@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597637040722220932?=
X-GMAIL-MSGID: =?utf-8?q?1598433586964389585?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 22.04.2018 05:01, Matthew Wilcox wrote:
> On Sat, Apr 21, 2018 at 06:52:18PM +0200, Vlastimil Babka wrote:
>> On 04/13/2018 07:11 PM, Matthew Wilcox wrote:
>>> On Fri, Apr 13, 2018 at 03:16:26PM +0200, David Hildenbrand wrote:
>>>> online_pages()/offline_pages() theoretically allows us to work on
>>>> sub-section sizes. This is especially relevant in the context of
>>>> virtualization. It e.g. allows us to add/remove memory to Linux in a VM in
>>>> 4MB chunks.
>>>>
>>>> While the whole section is marked as online/offline, we have to know
>>>> the state of each page. E.g. to not read memory that is not online
>>>> during kexec() or to properly mark a section as offline as soon as all
>>>> contained pages are offline.
>>>
>>> Can you not use PG_reserved for this purpose?
>>
>> Sounds like your newly introduced "page types" could be useful here? I
>> don't suppose those offline pages would be using mapcount which is
>> aliased there?
> 
> Oh, that's a good point!  Yes, this is a perfect use for page_type.
> We have something like twenty bits available there.
> 
> Now you've got me thinking that we can move PG_hwpoison and PG_reserved
> to be page_type flags too.  That'll take us from 23 to 21 bits (on 32-bit,
> with PG_UNCACHED)
> 

Some things to clarify here. I modified the current RFC to also allow
PG_offline on allocated (ballooned) pages (e.g. virtio-balloon).

kdump based dump tools can then easily identify which pages are not to
be dumped (either because the content is invalid or not accessible).

I previously stated that ballooned pages would be marked as PG_reserved,
which is not true (at least not for virtio-balloon). However this allows
me to detect if all pages in a section are offline by looking at
(PG_reserved && PG_offline). So I can actually tell if a page is marked
as offline and allocated or really offline.


1. The location (not the number!) of PG_hwpoison is basically ABI and
cannot be changed. Moving it around will most probably break dump tools.
(see kernel/crash_core.c)

2. Exposing PG_offline via kdump will make it ABI as well. And we don't
want any complicated validity checks ("is the bit valid or not?"),
because that would imply having to make these bits ABI as well. So
having PG_offline just like PG_hwpoison part of page_flags is the right
thing to do. (see patch nr 4)

3. For determining if all pages of a section are offline (see patch nr
5), I will have to be able to check 1. PG_offline and 2. PG_reserved on
any page. Will this be possible by moving e.g. PG_reserved to page
types? (especially if some field is suddenly aliased?)


I was wondering if we could reuse PG_hwpoison to mark "this page is not
to be read by dump tools" and store the real reason (page offline/page
has an hw error/page is part of a balloon ...) somewhere else (page
types?). But I am not sure if changing the semantic of PG_hwpoison
(visible to dump tools) is okay, and if we can then always "read out"
the type (especially: when is the page type field valid and can be used?)

Thanks!

-- 

Thanks,

David / dhildenb
