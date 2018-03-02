Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946816AbeCBRmE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 12:42:04 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:17177 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966197AbeCBRmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 12:42:02 -0500
Subject: Re: [PATCH 17/18] crypto: talitos - chain in buffered data for ahash
 on SEC1
To: =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <cover.1507284818.git.christophe.leroy@c-s.fr>
 <28d351a973d31d140239c7e7e64999d95a011e8c.1507284818.git.christophe.leroy@c-s.fr>
 <VI1PR0402MB3342BDF9D4E389B4E296A53298C50@VI1PR0402MB3342.eurprd04.prod.outlook.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <355bc65b-fbc4-deee-058a-999e5b740819@c-s.fr>
Date: Fri, 2 Mar 2018 18:42:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <VI1PR0402MB3342BDF9D4E389B4E296A53298C50@VI1PR0402MB3342.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 02/03/2018 à 18:27, Horia Geantă a écrit :
> On 10/6/2017 4:05 PM, Christophe Leroy wrote:
> [...]
>> @@ -1778,6 +1814,36 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
>>   	if (is_sec1 && from_talitos_ptr_len(&desc->ptr[3], true) == 0)
>>   		talitos_handle_buggy_hash(ctx, edesc, &desc->ptr[3]);
>>   
>> +	if (is_sec1 && req_ctx->nbuf && length) {
>> +		struct talitos_desc *desc2 = desc + 1;
>> +		dma_addr_t next_desc;
> [...]
>> +		next_desc = dma_map_single(dev, &desc2->hdr1, TALITOS_DESC_SIZE,
>> +					   DMA_BIDIRECTIONAL);
>> +		desc->next_desc = cpu_to_be32(next_desc);
> Where is desc->next_desc initialized for the !is_sec1 case?
> Memory allocation is done using kmalloc(), and since desc->next_desc is checked
> in some cases also for SEC 2.x+, it should be initialized to 0.

See 
https://elixir.bootlin.com/linux/v4.16-rc3/source/drivers/crypto/talitos.c#L1411

	edesc = kmalloc(alloc_len, GFP_DMA | flags);
	if (!edesc) {
		dev_err(dev, "could not allocate edescriptor\n");
		err = ERR_PTR(-ENOMEM);
		goto error_sg;
	}
	memset(&edesc->desc, 0, sizeof(edesc->desc));


Christophe
