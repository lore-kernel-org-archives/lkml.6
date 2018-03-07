Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934113AbeCGRHC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:07:02 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33694 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933533AbeCGRG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:06:57 -0500
X-Google-Smtp-Source: AG47ELurpJcjUibIwdHfd7AfTiHLcIQBqpP2DmV67RMLaTe66ygqdPtCHTfxCw8sZwyRV3w84L7z9A==
Subject: Re: [PATCH 3/6] lib/scatterlist: Do not leak pages when high-order
 allocation fails
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "tvrtko.ursulin@intel.com" <tvrtko.ursulin@intel.com>,
        "hare@suse.com" <hare@suse.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>
References: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
 <20180307124712.14963-4-tvrtko.ursulin@linux.intel.com>
 <1520439389.2890.16.camel@wdc.com>
From: Tvrtko Ursulin <tursulin@ursulin.net>
Message-ID: <16b39b14-a59f-d184-b4f5-4c184f227ed5@ursulin.net>
Date: Wed, 7 Mar 2018 17:06:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520439389.2890.16.camel@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/03/18 16:16, Bart Van Assche wrote:
> On Wed, 2018-03-07 at 12:47 +0000, Tvrtko Ursulin wrote:
>> diff --git a/lib/scatterlist.c b/lib/scatterlist.c
>> index 9884be50a2c0..e13a759c5c49 100644
>> --- a/lib/scatterlist.c
>> +++ b/lib/scatterlist.c
>> @@ -493,7 +493,7 @@ struct scatterlist *sgl_alloc_order(unsigned long length, unsigned int order,
>>   {
>>   	unsigned int chunk_len = PAGE_SIZE << order;
>>   	struct scatterlist *sgl, *sg;
>> -	unsigned int nent;
>> +	unsigned int nent, i;
>>   
>>   	nent = round_up(length, chunk_len) >> (PAGE_SHIFT + order);
>>   
>> @@ -517,11 +517,12 @@ struct scatterlist *sgl_alloc_order(unsigned long length, unsigned int order,
>>   
>>   	sg_init_table(sgl, nent);
>>   	sg = sgl;
>> +	i = 0;
>>   	while (length) {
>>   		struct page *page = alloc_pages(gfp, order);
>>   
>>   		if (!page) {
>> -			sgl_free(sgl);
>> +			sgl_free_n_order(sgl, i, order);
>>   			return NULL;
>>   		}
>>   
>> @@ -529,6 +530,7 @@ struct scatterlist *sgl_alloc_order(unsigned long length, unsigned int order,
>>   		sg_set_page(sg, page, chunk_len, 0);
>>   		length -= chunk_len;
>>   		sg = sg_next(sg);
>> +		i++;
>>   	}
> 
> Since the entire sg-list is zero-initialized before this loop starts, since
> the sg-list is not chained onto another sg-list before this function returns
> and since sgl_free_n_order() checks whether or not each page pointer is NULL
> before freeing it I think we don't need the new loop variable 'i' and that
> we can call sgl_free_order() instead of sgl_free_n_order().

Yes true, I've only realized that in a later patch. Can rebase to move 
that change earlier in.

Regards,

Tvrtko
