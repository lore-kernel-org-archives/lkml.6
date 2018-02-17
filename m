Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751141AbeBQQcs (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 11:32:48 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:15089 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751033AbeBQQcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 11:32:46 -0500
Subject: Re: [PATCH 16/18] crypto: talitos - do hw_context DMA mapping outside
 the requests
To: =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <cover.1507284818.git.christophe.leroy@c-s.fr>
 <e47bf94ae44f23230b1647e31c9623f1075d3b79.1507284818.git.christophe.leroy@c-s.fr>
 <VI1PR0402MB3342A0A8530F74D408CA2F0298FC0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <2338eb8d-a26a-9722-d667-5a9785b32977@c-s.fr>
Date: Sat, 17 Feb 2018 17:32:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <VI1PR0402MB3342A0A8530F74D408CA2F0298FC0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 07/02/2018 à 15:39, Horia Geantă a écrit :
> On 10/6/2017 4:06 PM, Christophe Leroy wrote:
>> At every request, we map and unmap the same hash hw_context.
>>
>> This patch moves the dma mapping/unmapping in functions ahash_init()
>> and ahash_import().
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   drivers/crypto/talitos.c | 80 ++++++++++++++++++++++++++++++++++--------------
>>   1 file changed, 57 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
>> index ebfd6d982ed6..d495649d5267 100644
>> --- a/drivers/crypto/talitos.c
>> +++ b/drivers/crypto/talitos.c
>> @@ -819,6 +819,7 @@ struct talitos_ctx {
>>   	unsigned int keylen;
>>   	unsigned int enckeylen;
>>   	unsigned int authkeylen;
>> +	dma_addr_t dma_hw_context;
> This doesn't look correct.
> 
> talitos_ctx structure is the tfm context.
> dma_hw_context is the IOVA of hw_context, located in talitos_ahash_req_ctx
> structure (request context).

Yes but I have now found how I can know that the request context is 
being released in order to unmap() dma at that time.
It is tricky to use the tmf context I agree, but at least I know when 
tmf context get destroyed, ie in talitos_cra_exit_ahash()
The request context is created by ahash_request_alloc() and released by
ahash_request_free(). I have not found the way to call dma_unmap() 
before ahash_request_free() gets called.

> 
> If there are multiple requests in flight for the same tfm, dma_hw_context will
> be overwritten.

Before overwritting dma_hw_context, it is always released, see 
talitos_cra_exit_ahash(), ahash_init(), ahash_import()

> 
> dma_hw_context needs to be moved in request context (talitos_ahash_req_ctx struct).

Any suggestion then on how to handle the issue explained above ?

Thanks
Christophe

> 
> Thanks,
> Horia
> 
