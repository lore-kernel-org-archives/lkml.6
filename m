Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753301AbeFAQyD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:54:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:44096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753206AbeFAQx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:53:57 -0400
Date: Fri, 1 Jun 2018 09:53:47 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org,
        tgraf@suug.ch, manfred@colorfullife.com, mhocko@kernel.org,
        guillaume.knispel@supersonicimagine.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/5] lib/rhashtable: convert param sanitations to WARN_ON
Message-ID: <20180601165347.kvruerdm3gu57ifv@linux-r8p5>
References: <20180601160125.30031-1-dave@stgolabs.net>
 <20180601160125.30031-2-dave@stgolabs.net>
 <20180601160944.ji2gsp3pyunlj476@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180601160944.ji2gsp3pyunlj476@gondor.apana.org.au>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Jun 2018, Herbert Xu wrote:

>On Fri, Jun 01, 2018 at 09:01:21AM -0700, Davidlohr Bueso wrote:
>> For the purpose of making rhashtable_init() unable to fail,
>> we can replace the returning -EINVAL with WARN_ONs whenever
>> the caller passes bogus parameters during initialization.
>>
>> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
>> ---
>>  lib/rhashtable.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
>> index 9427b5766134..05a4b1b8b8ce 100644
>> --- a/lib/rhashtable.c
>> +++ b/lib/rhashtable.c
>> @@ -1024,12 +1024,11 @@ int rhashtable_init(struct rhashtable *ht,
>>
>>  	size = HASH_DEFAULT_SIZE;
>>
>> -	if ((!params->key_len && !params->obj_hashfn) ||
>> -	    (params->obj_hashfn && !params->obj_cmpfn))
>> -		return -EINVAL;
>> +	WARN_ON((!params->key_len && !params->obj_hashfn) ||
>> +		(params->obj_hashfn && !params->obj_cmpfn));
>>
>> -	if (params->nulls_base && params->nulls_base < (1U << RHT_BASE_SHIFT))
>> -		return -EINVAL;
>> +	WARN_ON(params->nulls_base &&
>> +		params->nulls_base < (1U << RHT_BASE_SHIFT));
>
>I still don't like this.
>
>Yes for your use-case you will never crash and a WARN_ON is fine.
>However, rhashtable is used in all sorts of contexts and returning
>an error makes sense for quite a number of them.

Curious, are these users setting up the param structure dynamically
or something that they can pass along bogus values?

If that's the case then yes, I definitely agree.
