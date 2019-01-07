Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D38C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A722147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfAGRGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:06:18 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:37200 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfAGRGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:06:18 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43YMH559FMz9vGlM;
        Mon,  7 Jan 2019 18:06:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id dl4EcOjDCiYh; Mon,  7 Jan 2019 18:06:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43YMH54fNvz9vGlL;
        Mon,  7 Jan 2019 18:06:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 985168B838;
        Mon,  7 Jan 2019 18:06:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id GcQYpRrA_W5j; Mon,  7 Jan 2019 18:06:16 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 53AAA8B833;
        Mon,  7 Jan 2019 18:06:16 +0100 (CET)
Subject: Re: [PATCH v3] crypto: talitos - fix ablkcipher for CONFIG_VMAP_STACK
To:     Horia Geanta <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <ae7b64e9415874060977e32ed48b62f1f6148084.1545346337.git.christophe.leroy@c-s.fr>
 <VI1PR0402MB3485FC2A3758BCEAC05BF3A2988E0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <VI1PR0402MB34853754B8F90F5904710526988E0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d609078d-b432-0fba-8a48-4224e62b46a9@c-s.fr>
Date:   Mon, 7 Jan 2019 18:06:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <VI1PR0402MB34853754B8F90F5904710526988E0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 04/01/2019 à 16:24, Horia Geanta a écrit :
> On 1/4/2019 5:17 PM, Horia Geanta wrote:
>> On 12/21/2018 10:07 AM, Christophe Leroy wrote:
>> [snip]
>>> IV cannot be on stack when CONFIG_VMAP_STACK is selected because the stack
>>> cannot be DMA mapped anymore.
>>> This looks better, thanks.
>>
>>> This patch copies the IV into the extended descriptor when iv is not
>>> a valid linear address.
>>>
>> Though I am not sure the checks in place are enough.
>>
>>> Fixes: 4de9d0b547b9 ("crypto: talitos - Add ablkcipher algorithms")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>>   v3: Using struct edesc buffer.
>>>
>>>   v2: Using per-request context.
>> [snip]
>>> +	if (ivsize && !virt_addr_valid(iv))
>>> +		alloc_len += ivsize;
>> [snip]
>>>   
>>> +	if (ivsize && !virt_addr_valid(iv))
>> A more precise condition would be (!is_vmalloc_addr || is_vmalloc_addr(iv))
>>
> Sorry for the typo, I meant:
> (!virt_addr_valid(iv) || is_vmalloc_addr(iv))

As far as I know, virt_addr_valid() means the address is in the linear 
memory space. So it cannot be a vmalloc_addr if it is a linear space 
addr, can it ?

At least, it is that way on powerpc which is the arch embedding the 
talitos crypto engine. virt_addr_valid() means we are under max_pfn, 
while VMALLOC_START is above max_pfn.

Christophe

> 
>> It matches the checks in debug_dma_map_single() helper, though I am not sure
>> they are enough to rule out all exceptions of DMA API.
