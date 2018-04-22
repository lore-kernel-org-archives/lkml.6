Return-Path: <david@redhat.com>
X-Google-Smtp-Source: AIpwx48ddLrNxPj24nQRmi3yRa9RnMOzK1lw5KQ0LTVdWaQSDZOxd2x5q0Yvkf1QN4zWRrm9nQvf
ARC-Seal: i=1; a=rsa-sha256; t=1524410037; cv=none;
        d=google.com; s=arc-20160816;
        b=BdMwYyupKtwloMalDTIH3ZXQk3c/SUpSyeZzh3G7aW68NWvC3AeprSX6oVLq7zERdg
         3YNztNcdCzbF3TXPpYZOB3kDDp88rL002+/tNvmCdQLdkt3Gnj4xZYCeaHF2UKHyLOLu
         Kh1PYZt1cjrzGdYoIzWu5unQHNOZYHw6yUfPzmtI/6WiPqhG1AVOy5Ih8PHKiAFKJAaN
         zVTD5H5VlmjT60i5304BpunnGj5r536udVSt4mOjoHr6KxHtBXaYFOOepXboYtpxEGUS
         G7d3n/crDebPVhq1UuuBUtowzS0YLzrtaj5abL8QY8qqgdcxw5Flk3z7AIpoKgiDWEeG
         5EQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=Uz0KUp/XzfWq1i7p+P4FslQt7GYXnyvDTnWC5g/nOHA=;
        b=Jq/o5NPdMZJ4+CIlyGy0Mbfe6r8qFogdr/RygQzJgRviD8SMqFAWLbUsLXLzXogiRO
         +Zus7WeAKQ8NFSlyo/kTk064E7nOKTSzhFxnEP101jiKsTlnRSKL/j4JbZbQnsDAPclI
         unGYrpOyX2NtRVGl3srsIUygw2VzKGFYpvaRDeZSjFY5I3WBNsvDqNI8IJDByLICtQe7
         Xy1CCKpzFgEv5Jzo/M+DkREMtwbQlCnM2xaB4pgwS1y/0o7sEwvfzlWSS+N7kYCNU1IO
         0V5CZL6XyQ/AzBPTl6Q7UfICbVQcZSmC3To/DYhg1l59/6n7VI6xAxqifa9gvT8kumtp
         FlYg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [PATCH RFC 2/8] mm: introduce PG_offline
To: Matthew Wilcox <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
 Huang Ying <ying.huang@intel.com>,
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
 <7db70df4-c714-574c-5b14-898c1cf49af6@redhat.com>
 <20180422140246.GA30714@bombadil.infradead.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <903ab7f7-88ce-9bc3-036b-261cce1bb26c@redhat.com>
Date: Sun, 22 Apr 2018 17:13:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180422140246.GA30714@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597637040722220932?=
X-GMAIL-MSGID: =?utf-8?q?1598459778716281210?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 22.04.2018 16:02, Matthew Wilcox wrote:
> On Sun, Apr 22, 2018 at 10:17:31AM +0200, David Hildenbrand wrote:
>> On 22.04.2018 05:01, Matthew Wilcox wrote:
>>> On Sat, Apr 21, 2018 at 06:52:18PM +0200, Vlastimil Babka wrote:
>>>> Sounds like your newly introduced "page types" could be useful here? I
>>>> don't suppose those offline pages would be using mapcount which is
>>>> aliased there?
>>>
>>> Oh, that's a good point!  Yes, this is a perfect use for page_type.
>>> We have something like twenty bits available there.
>>>
>>> Now you've got me thinking that we can move PG_hwpoison and PG_reserved
>>> to be page_type flags too.  That'll take us from 23 to 21 bits (on 32-bit,
>>> with PG_UNCACHED)
>>
>> Some things to clarify here. I modified the current RFC to also allow
>> PG_offline on allocated (ballooned) pages (e.g. virtio-balloon).
>>
>> kdump based dump tools can then easily identify which pages are not to
>> be dumped (either because the content is invalid or not accessible).
>>
>> I previously stated that ballooned pages would be marked as PG_reserved,
>> which is not true (at least not for virtio-balloon). However this allows
>> me to detect if all pages in a section are offline by looking at
>> (PG_reserved && PG_offline). So I can actually tell if a page is marked
>> as offline and allocated or really offline.
>>
>>
>> 1. The location (not the number!) of PG_hwpoison is basically ABI and
>> cannot be changed. Moving it around will most probably break dump tools.
>> (see kernel/crash_core.c)
> 
> It's not ABI.  It already changed after 4.9 when PG_waiters was introduced
> by commit 62906027091f.

It is, please have a look at the file I pointed you to.

We export the *value* of PG_hwpoison in the ELF file, therefore the
*value* can change, but the *location* (page_flags, mapcount, whatever)
must not change. Or am I missing something here? I don't think we can
move PG_hwpoison that easily.

Also, I can read "For pages that are never mapped to userspace,
page->mapcount may be used for storing extra information about page
type" - is that true for PG_hwpoison/PG_reserved? I am skeptical.

And we need something similar for PG_offline, because it will become
ABI. (I can see that PAGE_BUDDY_MAPCOUNT_VALUE is also exported in an
ELF file, so maybe a new page type might work for marking a page offline
- but I have to look at the details first tomorrow)

> 
>> 2. Exposing PG_offline via kdump will make it ABI as well. And we don't
>> want any complicated validity checks ("is the bit valid or not?"),
>> because that would imply having to make these bits ABI as well. So
>> having PG_offline just like PG_hwpoison part of page_flags is the right
>> thing to do. (see patch nr 4)
>>
>> 3. For determining if all pages of a section are offline (see patch nr
>> 5), I will have to be able to check 1. PG_offline and 2. PG_reserved on
>> any page. Will this be possible by moving e.g. PG_reserved to page
>> types? (especially if some field is suddenly aliased?)
> 
> It's possible to tell whether the field is in use as mapcount or
> page_types; mapcount should always be non-negative, and page_types
> reserves a few bits to detect under/overflow of mapcount.  The slab/slob
> users of the field will also be positive uses.
> 

Thanks for the info!

-- 

Thanks,

David / dhildenb
