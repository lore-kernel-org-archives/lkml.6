Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbeBSJO2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 04:14:28 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:63363 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751866AbeBSJO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 04:14:26 -0500
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
 <2338eb8d-a26a-9722-d667-5a9785b32977@c-s.fr>
 <VI1PR0402MB3342D90D574C8829701882BE98C90@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <630c313c-5eca-224d-a5ac-fb3f2783573a@c-s.fr>
 <VI1PR0402MB334256E1706A4E1AED09F4A598C80@VI1PR0402MB3342.eurprd04.prod.outlook.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <d5809df9-fc17-03da-b7f4-038d973dbd1f@c-s.fr>
Date: Mon, 19 Feb 2018 10:14:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <VI1PR0402MB334256E1706A4E1AED09F4A598C80@VI1PR0402MB3342.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1258; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 19/02/2018 à 09:30, Horia Geantã a écrit :
> On 2/19/2018 9:58 AM, Christophe LEROY wrote:
>> Le 18/02/2018 à 18:14, Horia Geantã a écrit :
>>> There is no ahash_exit() callback mirroring ahash_init().
>>>
>>> The clean-up of request ctx should be done in the last states of the hash flows
>>> described here:
>>> https://www.kernel.org/doc/html/latest/crypto/devel-algos.html#cipher-definition-with-struct-shash-alg-and-ahash-alg
>>> for e.g. in the final() callback.
>>
>> Unfortunatly it seems that we can't rely on those finalising functions
>> being called all the time.
>> If you look into test_ahash_jiffies() for instance, in case of error the
>> call of crypto_hash_final() is skipped.
> 
> If test_ahash_jiffies() errors before calling crypto_ahash_final(req), this
> means a previous callback failed.
> Accordingly, DMA unmapping should be performed also on the corresponding errors
> paths in the driver.
> 

And what about ALGIF path from user space ?
What if the user never calls the last sendmsg() which will call 
hash_finup() ?

Christophe
