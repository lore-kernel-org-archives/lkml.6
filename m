Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933859AbeEWRRm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 13:17:42 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44900 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933767AbeEWRRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 13:17:40 -0400
X-Google-Smtp-Source: AB8JxZpAsLi2PZqJYqPY0rW1pt3G1l9f9qEImiw2Ttje7Dnno5AuutnEiipL8GUGZili7/4CntLqEQ==
Subject: Re: [RFC PATCH] mtd: spi-nor: add support to non-uniform SPI NOR
 flash memories
To: Tudor Ambarus <tudor.ambarus@microchip.com>,
        cyrille.pitchen@microchip.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        richard@nod.at
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        nicolas.ferre@microchip.com, Cristian.Birsan@microchip.com
References: <20180518093233.24241-1-tudor.ambarus@microchip.com>
 <89d45190-95b0-b780-b219-e6c6adcb6147@gmail.com>
 <4cd7d47a-fd56-6b54-3b38-262adf46a97f@microchip.com>
 <bbb9387b-4404-e6a0-b8b5-f48bcebdd474@gmail.com>
 <123e50da-e49e-f876-bdb4-2719f7f7640a@microchip.com>
 <a32aa2ee-7d9e-37b6-811f-799570ce1cea@gmail.com>
 <66b2b859-72db-33cc-75ae-2493a4aad235@microchip.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <aa083709-c3e2-f075-1a99-c31399a1cb77@gmail.com>
Date: Wed, 23 May 2018 14:54:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <66b2b859-72db-33cc-75ae-2493a4aad235@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/23/2018 02:52 PM, Tudor Ambarus wrote:
> Hi, Marek,

Hi,

> On 05/23/2018 12:56 PM, Marek Vasut wrote:
> [...]
>>>> [...]
>>>>
>>>>>>> +    while (len) {
>>>>>>> +        cmd = spi_nor_find_best_erase_cmd(map, region, addr, len);
>>>>>>> +        if (!cmd)
>>>>>>> +            return -EINVAL;
>>>>>> What would happen if you realize mid-way that you cannot erase some
>>>>>> sector , do you end up with partial erase ?
>>>>> Is this possible? In non-overlaid regions, the address is aligned with
>>>>> at least one of the erase commands, else -EINVAL. For overlaid regions
>>>>> alignment doesn't matter. But yes, if this is possible, in this case,
>>>>> this proposal will do a partial erase.
>>>> Shouldn't we fail up front instead ?
>>> It will be great if we can do this without having performance penalties.
>>> Can we loose the conditions for the last erase command? If one wants to
>>> erase 80k chunk starting from offset 0 and only 32k and 64k erase type
>>> are supported, can we erase 96k?
>> No. But can you maybe build a list of erase commands to be executed once
>> you validate that the erase can be performed for example ?
> 
> My second choice was an array witch saves u8 opcode and u32 erasesize.
> There are flashes of 256MB, in the worst case scenario with 4k erase
> type, we will end up with 64K entries.

Some RLE encoding might help here ?

> How about enforcing the length to be multiple of mtd->erasesize, like we
> do in uniform_erase? With this, the problem disappears.

What is the erase size for the 4k-sector 256MiB flash ?

-- 
Best regards,
Marek Vasut
