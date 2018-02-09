Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752963AbeBIVXX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 16:23:23 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:59519 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752754AbeBIVXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 16:23:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0SxxUwdS_1518211395;
Subject: Re: [PATCH v2] mm: thp: fix potential clearing to referenced flag in
 page_idle_clear_pte_refs_one()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kirill.shutemov@linux.intel.com, gavin.dg@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1518203521-81173-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180209124300.fc3468a72e0d223c0e4d4195@linux-foundation.org>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <5a0ccaab-c9d6-85c6-0b2e-a69b2ad27586@linux.alibaba.com>
Date: Fri, 9 Feb 2018 13:23:14 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180209124300.fc3468a72e0d223c0e4d4195@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/18 12:43 PM, Andrew Morton wrote:
> On Sat, 10 Feb 2018 03:12:01 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>> For PTE-mapped THP, the compound THP has not been split to normal 4K
>> pages yet, the whole THP is considered referenced if any one of sub
>> page is referenced.
>>
>> When walking PTE-mapped THP by pvmw, all relevant PTEs will be checked
>> to retrieve referenced bit. But, the current code just returns the
>> result of the last PTE. If the last PTE has not referenced, the
>> referenced flag will be cleared.
>>
>> Just did logical OR for referenced to get the correct result.
>>
>> Reported-by: Gang Deng <gavin.dg@linux.alibaba.com>
>> Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>> v2: adopted the suggestion from Kirill. Not use "||=" style to keep checkpatch
>> quiet, otherwise it reports ERROR: spaces required around that '||'
>>
>>   mm/page_idle.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/page_idle.c b/mm/page_idle.c
>> index 0a49374..a4baec9 100644
>> --- a/mm/page_idle.c
>> +++ b/mm/page_idle.c
>> @@ -65,11 +65,15 @@ static bool page_idle_clear_pte_refs_one(struct page *page,
>>   	while (page_vma_mapped_walk(&pvmw)) {
>>   		addr = pvmw.address;
>>   		if (pvmw.pte) {
>> -			referenced = ptep_clear_young_notify(vma, addr,
>> -					pvmw.pte);
>> +			/*
>> +			 * For PTE-mapped THP, one sub page is referenced,
>> +			 * the whole THP is referenced.
>> +			 */
>> +			referenced = referenced || ptep_clear_young_notify(vma,
>> +					addr, pvmw.pte);
> That doesn't work.  If `referenced' is already true,
> ptep_clear_young_notify() will not be called.
>
> 	if (ptep_clear_young_notify(...))
> 		referenced = true;
>
> would suit.

Thanks for pointing out this. Sorry for the careless programming.

>
>
> It makes me wonder what difference this bug makes and why that
> difference was not noted in your testing.  Any theories about that?
> How can we design a test which *will* make this error apparent?

Actually, there is NOT an apparent test for this issue yet. It was found 
by visual inspection when we were backporting the PVMW patches. And, it 
is not that easy to construct a test for idle page tracking to capture 
this trivial miscounting (might be just one page difference). The 
counting is global not per process and it is always increased unless 
resetting the reference bit.

Any good idea?

Thanks,
Yang
