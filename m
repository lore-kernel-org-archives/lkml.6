Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965780AbeBMUpw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 15:45:52 -0500
Received: from mga11.intel.com ([192.55.52.93]:42960 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965719AbeBMUpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 15:45:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="203851891"
Subject: Re: [PATCH] lib/scatterlist: Make sg_page_count() accessible to other
 modules
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: chris@chris-wilson.co.uk,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1518285964-31657-1-git-send-email-alexey.skidanov@intel.com>
 <CAHp75VdzafHdDzpgnc74XZQOfUdgxuH6QwrtXw_YMvWEX0icUQ@mail.gmail.com>
From: Alexey Skidanov <alexey.skidanov@intel.com>
Message-ID: <dc425e86-2fc5-97dc-985b-a00d93b32c63@intel.com>
Date: Tue, 13 Feb 2018 22:46:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdzafHdDzpgnc74XZQOfUdgxuH6QwrtXw_YMvWEX0icUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/13/2018 10:14 PM, Andy Shevchenko wrote:
> On Sat, Feb 10, 2018 at 8:06 PM, Alexey Skidanov
> <alexey.skidanov@intel.com> wrote:
>> Currently, sg_page_count() may be used only inside the scatterlist.c file.
>>
>> However, the same calculation is done outside of scatterlist.c file
>> causing to code duplication.
>>
>> To fix this, we move the sg_page_count() to the scatterlist.h file, making it
>> accessible to other modules.
> 
> Can you provide an example of potential (or existing?) use case?
> 
This one, for example - drivers/staging/android/ion/ion_heap.c:
for_each_sg(table->sgl, sg, table->nents, i) {
	int npages_this_entry = PAGE_ALIGN(sg->length) / PAGE_SIZE;
	struct page *page = sg_page(sg);
	BUG_ON(i >= npages);
	for (j = 0; j < npages_this_entry; j++)
		*(tmp++) = page++;
}

One more is in the patch I have submitted for review.
>>
>> Signed-off-by: Alexey Skidanov <alexey.skidanov@intel.com>
>> ---
>>  include/linux/scatterlist.h | 5 +++++
>>  lib/scatterlist.c           | 5 -----
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
>> index b7c8325..fe28148 100644
>> --- a/include/linux/scatterlist.h
>> +++ b/include/linux/scatterlist.h
>> @@ -248,6 +248,11 @@ static inline void *sg_virt(struct scatterlist *sg)
>>         return page_address(sg_page(sg)) + sg->offset;
>>  }
>>
>> +static inline int sg_page_count(struct scatterlist *sg)
>> +{
>> +       return PAGE_ALIGN(sg->offset + sg->length) >> PAGE_SHIFT;
>> +}
>> +
>>  int sg_nents(struct scatterlist *sg);
>>  int sg_nents_for_len(struct scatterlist *sg, u64 len);
>>  struct scatterlist *sg_next(struct scatterlist *);
>> diff --git a/lib/scatterlist.c b/lib/scatterlist.c
>> index 7c1c55f..4a59131 100644
>> --- a/lib/scatterlist.c
>> +++ b/lib/scatterlist.c
>> @@ -486,11 +486,6 @@ void __sg_page_iter_start(struct sg_page_iter *piter,
>>  }
>>  EXPORT_SYMBOL(__sg_page_iter_start);
>>
>> -static int sg_page_count(struct scatterlist *sg)
>> -{
>> -       return PAGE_ALIGN(sg->offset + sg->length) >> PAGE_SHIFT;
>> -}
>> -
>>  bool __sg_page_iter_next(struct sg_page_iter *piter)
>>  {
>>         if (!piter->__nents || !piter->sg)
>> --
>> 2.7.4
>>
> 
> 
> 
