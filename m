Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AB8JxZpB9Rxfj+t1da56wuvpiUfbnowzccaB+oLi7ZRcoOxwjnk5uMJk+9K2WnVHmoV9nTUTUt1s
ARC-Seal: i=1; a=rsa-sha256; t=1525099046; cv=none;
        d=google.com; s=arc-20160816;
        b=PyDyeeD8yKR4dOm4Vsr71BfoBk2WlfAjBAW36StPADRWabplsA3xO9Rqe/u9HdjRCL
         BN80mAhcGrghkGEXhy7UUAJhFbW8zegEC81SxUBmd3qDgC5S5N42bL/zpeX0yraU3L7o
         DId3l3nTYSgh7j8NIfUb+LRMVQ/XbASsuLAeaIOwticGoFsr2xH3wGt2EmjMbG+q5ecu
         aV3GqlnaRMn2Xn5BtCyqx1/PS3/uxDp1gLhStm8beIufxIOy68xLCvrz00XMf5AO40oH
         79chkBKkln0Q61wsolwb+u+avWvXbBNtxlkilTzbyGwC9umXcQPE1oNSpK1eYsZ3r0C9
         75kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=b3EBX1CPEeCZbSQpsWvELqhKa6Fpuu7uwVAo+DtsMcU=;
        b=xqf5tB9SvqzaTgGEBLs3E+xkxNXoD2KajVGmtpKgva5ImPDqDldGcI2km2t+If8ZEA
         tDdQUdOuCeW8ytz0HtbWvBiA8i8USUN4OFPAmfOv+W1klsYkA02ucfwlFUjitFrCHqwm
         FNDnpPxT0aLFOI1UVtQ8eOYUh57HCba6Yr68kfrbiiglNP86gB8qcp/EqfG+vzdgzgPg
         7hYPqRqPmELO96kTgMZepm9ASKZf2+aEBxJ7X/OrwK/Ov50YcHCD4306E13ltLyT/4zC
         FVZ6XapBRWwsPdUKNkvnTYJmaOfOcvL5zyaGg3EdZElHj9SiaUmZZL4+/UrRRRi6Qk3O
         mpmw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=QIaPHX/i;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=QIaPHX/i;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH RCFv2 1/7] mm: introduce and use PageOffline()
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams
 <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Hugh Dickins <hughd@google.com>, Huang Ying <ying.huang@intel.com>,
        Miles Chen <miles.chen@mediatek.com>, Vlastimil Babka <vbabka@suse.cz>,
        Reza Arbab <arbab@linux.vnet.ibm.com>, Mel Gorman <mgorman@suse.de>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20180430094236.29056-1-david@redhat.com>
 <20180430094236.29056-2-david@redhat.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <4d112f60-3c24-585e-152e-b42d68c899a2@oracle.com>
Date: Mon, 30 Apr 2018 10:35:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430094236.29056-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8878 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804300141
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599163720299287217?=
X-GMAIL-MSGID: =?utf-8?q?1599182258034895640?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Dave,

A few comments below:

> +	for (i = 0; i < PAGES_PER_SECTION; i++) {

Performance wise, this is unfortunate that we have to add this loop for every hot-plug. But, I do like the finer hot-plug granularity that you achieve, and do not have a better suggestion how to avoid this loop. What I also like, is that you call init_single_page() only one time.

> +		unsigned long pfn = phys_start_pfn + i;
> +		struct page *page;
> +		if (!pfn_valid(pfn))
> +			continue;
> +		page = pfn_to_page(pfn);
> +
> +		/* dummy zone, the actual one will be set when onlining pages */
> +		init_single_page(page, pfn, ZONE_NORMAL, nid);

Is there a reason to use ZONE_NORMAL as a dummy zone? May be define some non-existent zone-id for that? I.e. __MAX_NR_ZONES? That might trigger some debugging checks of course..

In init_single_page() if WANT_PAGE_VIRTUAL is defined it is used to set virtual address.  Which is broken if we do not belong to ZONE_NORMAL.

1186	if (!is_highmem_idx(zone))
1187		set_page_address(page, __va(pfn << PAGE_SHIFT));

Otherwise, if you want to keep ZONE_NORMAL here, you could add a new function:

#ifdef WANT_PAGE_VIRTUAL
static void set_page_virtual(struct page *page, and enum zone_type zone)
{
	/* The shift won't overflow because ZONE_NORMAL is below 4G. */
	if (!is_highmem_idx(zone))
		set_page_address(page, __va(pfn << PAGE_SHIFT));
}
#else
static inline void set_page_virtual(struct page *page, and enum zone_type zone)
{}
#endif

And call it from init_single_page(), and from __meminit memmap_init_zone() in "context == MEMMAP_HOTPLUG" if case.

>
> -static void __meminit __init_single_page(struct page *page, unsigned long pfn,
> +extern void __meminit init_single_page(struct page *page, unsigned long pfn,

I've seen it in other places, but what is the point of having "extern" function in .c file?


>  #ifdef CONFIG_MEMORY_HOTREMOVE
> -/* Mark all memory sections within the pfn range as online */
> +static bool all_pages_in_section_offline(unsigned long section_nr)
> +{
> +	unsigned long pfn = section_nr_to_pfn(section_nr);
> +	struct page *page;
> +	int i;
> +
> +	for (i = 0; i < PAGES_PER_SECTION; i++, pfn++) {
> +		if (!pfn_valid(pfn))
> +			continue;
> +
> +		page = pfn_to_page(pfn);
> +		if (!PageOffline(page))
> +			return false;
> +	}
> +	return true;
> +}

Perhaps we could use some counter to keep track of number of subsections that are currently offlined? If section covers 128M of memory, and offline/online is 4M granularity, there are up-to 32 subsections in a section, and thus we need 5-bits to count them. I'm not sure if there is a space in mem_section for this counter. But, that would eliminate the loop above.

Thank you,
Pavel
