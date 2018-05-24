Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032713AbeEXUgl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:36:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967272AbeEXUgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:36:40 -0400
Subject: Re: [PATCH v1 09/10] mm/memory_hotplug: teach offline_pages() to not
 try forever
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Reza Arbab <arbab@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180523151151.6730-1-david@redhat.com>
 <20180523151151.6730-10-david@redhat.com>
 <20180524143953.GK20441@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <18a119a8-1b2c-a2cc-7ba1-d0a3c244d381@redhat.com>
Date: Thu, 24 May 2018 22:36:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180524143953.GK20441@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.05.2018 16:39, Michal Hocko wrote:
> [I didn't really go through other patch but this one caught my eyes just
>  because of the similar request proposed yesterday]
> 
> On Wed 23-05-18 17:11:50, David Hildenbrand wrote:
> [...]
>> @@ -1686,6 +1686,10 @@ static int __ref __offline_pages(unsigned long start_pfn,
>>  	pfn = scan_movable_pages(start_pfn, end_pfn);
>>  	if (pfn) { /* We have movable pages */
>>  		ret = do_migrate_range(pfn, end_pfn);
>> +		if (ret && !retry_forever) {
>> +			ret = -EBUSY;
>> +			goto failed_removal;
>> +		}
>>  		goto repeat;
>>  	}
>>  
> 
> Btw. this will not work in practice. Even a single temporary pin on a page
> will fail way too easily. If you really need to control this then make
> it a retry counter with default -1UL.

Interestingly, this will work for the one specific use case that I am
using this interface for right now.

The reason is that I don't want to offline a specific chunk, I want to
find some chunks to offline (in contrast to e.g. DIMMs where you rely
try to offline a very specific one).

If I get a failure on that chunk (e.g. temporary pin) I will retry the
next chunk. At one point, I will eventually retry this chunk and then it
succeeds.

> 
> We really do need a better error reporting from do_migrate_range and
> distinguish transient from permanent failures. In general we shouldn't
> even get here for pages which are not migrateable...

I totally agree, I also want to know if an error is permanent or
transient - and I want the posibility to "fail fast" (e.g. -EAGAIN)
instead of looping forever.


-- 

Thanks,

David / dhildenb
