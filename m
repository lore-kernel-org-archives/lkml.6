Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933969AbeCGRGL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:06:11 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43780 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933468AbeCGRGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:06:09 -0500
X-Google-Smtp-Source: AG47ELupdxROY2Aonyo5reXEQO0Zi5lBOYQNSzLABP+4xfaDA4fmHlIpT4uSB6iGU0MtkgLR4IuwzQ==
Subject: Re: [PATCH 1/6] lib/scatterlist: Tidy types and fix overflow checking
 in sgl_alloc_order
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "tvrtko.ursulin@intel.com" <tvrtko.ursulin@intel.com>,
        "hare@suse.com" <hare@suse.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>
References: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
 <20180307124712.14963-2-tvrtko.ursulin@linux.intel.com>
 <1520439036.2890.13.camel@wdc.com>
From: Tvrtko Ursulin <tursulin@ursulin.net>
Message-ID: <e85a8ad8-b9ba-33e2-49a8-80453a8b9281@ursulin.net>
Date: Wed, 7 Mar 2018 17:06:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520439036.2890.13.camel@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/03/18 16:10, Bart Van Assche wrote:
> On Wed, 2018-03-07 at 12:47 +0000, Tvrtko Ursulin wrote:
>> sgl_alloc_order explicitly takes a 64-bit length (unsigned long long) but
>> then rejects it in overflow checking if greater than 4GiB allocation was
>> requested. This is a consequence of using unsigned int for the right hand
>> side condition which then natuarally overflows when shifted left, earlier
>> than nent otherwise would.
>>
>> Fix is to promote the right hand side of the conditional to unsigned long.
> 
> Agreed.
> 
>> It is also not useful to allow for 64-bit lenght on 32-bit platforms so
>> I have changed this type to a natural unsigned long. Like this it changes
>> size naturally depending on the architecture.
> 
> I do not agree. Although uncommon, it is possible that e.g. a SCSI initiator
> sends a transfer of more than 4 GB to a target system and that that transfer
> must not be split. Since this code is used by the SCSI target, I think that's
> an example of an application where it is useful to allow allocations of more
> than 4 GB at once on a 32-bit system.

If it can work on 32-bit (it can DMA from highmem or what?) and 
allocation can realistically succeed then  I'm happy to defer to storage 
experts on this one.

> 
>> 2.
>>
>> elem_len should not be explicitly sized u32 but unsigned int, to match
>> the underlying struct scatterlist nents type. Same for the nent_p output
>> parameter type.
> 
> Are you sure it is useful to support allocations with an order that exceeds
> (31 - PAGE_SHIFT)? Since memory gets fragmented easily in the Linux kernel I
> think that it's unlikely that such allocations will succeed.

Not sure what you are getting at here.

There are not explicit width types anywhere in the SGL API apart this 
u32 elem_lem.

So I changed it to unsigned int not to confuse. It gets passed in to 
sg_set_page which takes unsigned int. So no reason for it to be u32.

> 
>> I renamed this to chunk_len and consolidated its use throughout the
>> function.
> 
> Please undo this change such that the diff remains as short as possible.

Name change only? Yeah can do that. Even though chunk as a term is 
somewhat established elsewhere in lib/scatterlist.c.

>> -void sgl_free_n_order(struct scatterlist *sgl, int nents, int order)
>> +void sgl_free_n_order(struct scatterlist *sgl, unsigned int nents,
>> +		      unsigned int order)
>>   {
>>   	struct scatterlist *sg;
>>   	struct page *page;
>> -	int i;
>> +	unsigned int i;
>>   
>>   	for_each_sg(sgl, sg, nents, i) {
>>   		if (!sg)
>> @@ -583,9 +587,9 @@ EXPORT_SYMBOL(sgl_free_n_order);
>>    * @sgl: Scatterlist with one or more elements
>>    * @order: Second argument for __free_pages()
>>    */
>> -void sgl_free_order(struct scatterlist *sgl, int order)
>> +void sgl_free_order(struct scatterlist *sgl, unsigned int order)
>>   {
>> -	sgl_free_n_order(sgl, INT_MAX, order);
>> +	sgl_free_n_order(sgl, UINT_MAX, order);
>>   }
>>   EXPORT_SYMBOL(sgl_free_order);
> 
> Do you have an application that calls these functions to allocate more than
> INT_MAX * PAGE_SIZE bytes at once? If not, please leave these changes out.

There is no reason to used signed int here and it is even inconsistent 
with itself because sgl_alloc_order returns you nents in an unsigned 
int. And sg_init_table takes unsigned int for nents. So really I see no 
reason to have signed types for nents on sgl_free side of the API.

Regards,

Tvrtko
