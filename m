Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753157AbeBFSmR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:42:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:48643 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752852AbeBFSmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:42:10 -0500
Date: Tue, 6 Feb 2018 10:32:54 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Davidlohr Bueso <dbueso@suse.de>, akpm@linux-foundation.org,
        mingo@kernel.org, peterz@infradead.org, jack@suse.cz,
        mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        mawilcox@microsoft.com, mgorman@techsingularity.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/64] mm: teach pagefault paths about range locking
Message-ID: <20180206183254.zsm276etjarud3lj@linux-n805>
Mail-Followup-To: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>, akpm@linux-foundation.org,
        mingo@kernel.org, peterz@infradead.org, jack@suse.cz,
        mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        mawilcox@microsoft.com, mgorman@techsingularity.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20180205012754.23615-1-dbueso@wotan.suse.de>
 <20180205012754.23615-7-dbueso@wotan.suse.de>
 <7217f6dc-bce0-e73f-7d63-a328180d6ca7@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7217f6dc-bce0-e73f-7d63-a328180d6ca7@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Feb 2018, Laurent Dufour wrote:

>> --- a/drivers/misc/sgi-gru/grufault.c
>> +++ b/drivers/misc/sgi-gru/grufault.c
>> @@ -189,7 +189,8 @@ static void get_clear_fault_map(struct gru_state *gru,
>>   */
>>  static int non_atomic_pte_lookup(struct vm_area_struct *vma,
>>  				 unsigned long vaddr, int write,
>> -				 unsigned long *paddr, int *pageshift)
>> +				 unsigned long *paddr, int *pageshift,
>> +				 struct range_lock *mmrange)
>>  {
>>  	struct page *page;
>>
>> @@ -198,7 +199,8 @@ static int non_atomic_pte_lookup(struct vm_area_struct *vma,
>>  #else
>>  	*pageshift = PAGE_SHIFT;
>>  #endif
>> -	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <= 0)
>> +	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0,
>> +			   &page, NULL, mmrange) <= 0)
>
>There is no need to pass down the range here since underlying called
>__get_user_pages_locked() is told to not unlock the mmap_sem.
>In general get_user_pages() doesn't need a range parameter.

Yeah, you're right. At least it was a productive exercise for auditing.

Thanks,
Davidlohr
