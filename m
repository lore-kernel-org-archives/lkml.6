Return-Path: <david@redhat.com>
X-Google-Smtp-Source: AB8JxZp9cvG+Bj341zkco3na6EyOIUYK6hnSEh7NrHwgedOkZk3/s9kPq1082nvO9EeHLbo/EPi+
ARC-Seal: i=1; a=rsa-sha256; t=1525101459; cv=none;
        d=google.com; s=arc-20160816;
        b=LbnvitFClHWF17gsZGjCwZXeMfR4F/EHDTKZZlLm/NJJila/ia5T7+WLI82dFMnGif
         Rw/nTEQo3e+82V7zvDUOyKv9kCduRAScncnRChwu6fqy0HTaO0GVRZd4LZnkgQkSmgjh
         +2H/18saBZ35uCDg6B0N6BWs7hY0gyIwhMcv/jr9wJ1JXicekpSTDINdxTgQTejE+Xao
         wUkb27Wl7kZLvmi0LVx0tVJ/Kj1h8psxxY+zDpazAkjRnWyH6VntHTa1U+Bfn7NjX1zR
         kKXCIJJwFjQMKtrZNHGgPC949XJFGq57CbbOn9qcoOL91OiWbjJBtgFgPcNsnt/3M2RB
         i1ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=tpm/qtpW6QPD1UcPIMRmgcaXm8Dbi5m3wTVGwb6HKS0=;
        b=aq53VkHTELkAzmm3jFC5HHHm75qmhRd9Y70nminD8jxuIxQTZxtliy64EmOcUrV/7A
         3KAaPRkxFOPzYt6dFdcqn2AgwFbgLYeYmSyx2EX97rbRhN9abuJpEGVVhNnlXLhBBKnN
         aBKZLu8ulBMuhXR5rW9LIde66lY2wXqtplUEFksKuw5VV6tthCvv53FSPYo4aoXm+00I
         Q9XQ8XhEDQtUWqfL1OFaWszuvrwdfk+dC/BlaU5zVUiRJxkwY26tVHGZYdQ0U0/EN86I
         daELFA4nbTVxxjT2HTg/yMopUkqNU429KIwGfbr9DDYGppxvhk6B4MKyIPsXhSlQUahx
         Q7fQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [PATCH RCFv2 1/7] mm: introduce and use PageOffline()
To: Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>, Dan Williams
 <dan.j.williams@intel.com>, Michal Hocko <mhocko@suse.com>,
 Jan Kara <jack@suse.cz>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Matthew Wilcox <mawilcox@microsoft.com>,
 Souptick Joarder <jrdr.linux@gmail.com>, Hugh Dickins <hughd@google.com>,
 Huang Ying <ying.huang@intel.com>, Miles Chen <miles.chen@mediatek.com>,
 Vlastimil Babka <vbabka@suse.cz>, Reza Arbab <arbab@linux.vnet.ibm.com>,
 Mel Gorman <mgorman@suse.de>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20180430094236.29056-1-david@redhat.com>
 <20180430094236.29056-2-david@redhat.com>
 <4d112f60-3c24-585e-152e-b42d68c899a2@oracle.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <28068791-bee4-095e-7338-cda4d229c3de@redhat.com>
Date: Mon, 30 Apr 2018 17:17:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <4d112f60-3c24-585e-152e-b42d68c899a2@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599163720299287217?=
X-GMAIL-MSGID: =?utf-8?q?1599184788072207436?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 30.04.2018 16:35, Pavel Tatashin wrote:
> Hi Dave,
> 
> A few comments below:
> 
>> +	for (i = 0; i < PAGES_PER_SECTION; i++) {
> 
> Performance wise, this is unfortunate that we have to add this loop for every hot-plug. But, I do like the finer hot-plug granularity that you achieve, and do not have a better suggestion how to avoid this loop. What I also like, is that you call init_single_page() only one time.

Thanks! Yes, unfortunately we cannot live with the single loop when
onlining pages for this feature.

> 
>> +		unsigned long pfn = phys_start_pfn + i;
>> +		struct page *page;
>> +		if (!pfn_valid(pfn))
>> +			continue;
>> +		page = pfn_to_page(pfn);
>> +
>> +		/* dummy zone, the actual one will be set when onlining pages */
>> +		init_single_page(page, pfn, ZONE_NORMAL, nid);
> 
> Is there a reason to use ZONE_NORMAL as a dummy zone? May be define some non-existent zone-id for that? I.e. __MAX_NR_ZONES? That might trigger some debugging checks of course..

Than it could happen that we consume more bits in pageflags than we
actually need. But it could be an opt-in debugging option later on, right?

> 
> In init_single_page() if WANT_PAGE_VIRTUAL is defined it is used to set virtual address.  Which is broken if we do not belong to ZONE_NORMAL.
> 

Grr, missed that. Thanks for your very good eyes!

> 1186	if (!is_highmem_idx(zone))
> 1187		set_page_address(page, __va(pfn << PAGE_SHIFT));
> 
> Otherwise, if you want to keep ZONE_NORMAL here, you could add a new function:
> 
> #ifdef WANT_PAGE_VIRTUAL
> static void set_page_virtual(struct page *page, and enum zone_type zone)
> {
> 	/* The shift won't overflow because ZONE_NORMAL is below 4G. */
> 	if (!is_highmem_idx(zone))
> 		set_page_address(page, __va(pfn << PAGE_SHIFT));
> }
> #else
> static inline void set_page_virtual(struct page *page, and enum zone_type zone)
> {}
> #endif
> 
> And call it from init_single_page(), and from __meminit memmap_init_zone() in "context == MEMMAP_HOTPLUG" if case.

Was thinking about moving it to set_page_zone() and conditionally
setting it to 0 or set_page_address(page, __va(pfn << PAGE_SHIFT)). What
do you prefer?

> 
>>
>> -static void __meminit __init_single_page(struct page *page, unsigned long pfn,
>> +extern void __meminit init_single_page(struct page *page, unsigned long pfn,
> 
> I've seen it in other places, but what is the point of having "extern" function in .c file?

I've seen it all over the place, that's why I am using it :) (as I
basically had the same question). Can somebody answer that?

> 
> 
>>  #ifdef CONFIG_MEMORY_HOTREMOVE
>> -/* Mark all memory sections within the pfn range as online */
>> +static bool all_pages_in_section_offline(unsigned long section_nr)
>> +{
>> +	unsigned long pfn = section_nr_to_pfn(section_nr);
>> +	struct page *page;
>> +	int i;
>> +
>> +	for (i = 0; i < PAGES_PER_SECTION; i++, pfn++) {
>> +		if (!pfn_valid(pfn))
>> +			continue;
>> +
>> +		page = pfn_to_page(pfn);
>> +		if (!PageOffline(page))
>> +			return false;
>> +	}
>> +	return true;
>> +}
> 
> Perhaps we could use some counter to keep track of number of subsections that are currently offlined? If section covers 128M of memory, and offline/online is 4M granularity, there are up-to 32 subsections in a section, and thus we need 5-bits to count them. I'm not sure if there is a space in mem_section for this counter. But, that would eliminate the loop above.

Yes, that would also be an optimization. At least I optimized it for now
so ordinary offline/online is not harmed. As we need PageOffline() also
for kdump (and maybe later also for safety checks when
onlining/offlining pages), we would right now store duplicate
information, so I would like to defer that.

Thanks a lot Pavel!

> 
> Thank you,
> Pavel
> 


-- 

Thanks,

David / dhildenb
