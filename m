Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939702AbeE1QLW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:11:22 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:23103 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933391AbeE1QLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 12:11:16 -0400
X-IronPort-AV: E=Sophos;i="5.49,453,1520924400";
   d="scan'208";a="14412918"
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
To: Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC: Tudor Ambarus <tudor.ambarus@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
References: <20180329131054.22506-1-peda@axentia.se>
 <20180329153322.5e2fc1e7@bbrezillon>
 <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
 <20180329154416.5c1a0013@bbrezillon>
 <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
 <20180402142249.7e076a64@bbrezillon>
 <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
 <20180402212843.164d5d21@bbrezillon> <20180402222020.1d344c14@bbrezillon>
 <d7e6f78d-b57b-4d0f-c07c-ca6c1930cd51@axentia.se>
 <20180403091813.5fb5c18c@bbrezillon>
 <d0afd431-6e51-a9b7-c103-ecf1f6e07c2e@axentia.se>
 <959d826d-1a98-ca22-acee-a4548427fcd3@microchip.com>
 <a25ca617-d3da-d401-1ba9-8e5887f8a8e5@microchip.com>
 <024079cb-77ad-9c48-e370-e6e8f2de171b@axentia.se>
 <9c496531-f7b6-4b9d-dd51-0bfb68ead303@axentia.se>
 <c3cc1894-2d7d-93b6-a9de-ed9ca4564ae9@axentia.se>
 <20180528162718.6be7191f@bbrezillon>
 <db31aac0-6b59-8835-2181-635670e7f176@axentia.se>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <49ff8830-eb23-4ea8-0247-0f4fd783afb6@microchip.com>
Date: Mon, 28 May 2018 18:09:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <db31aac0-6b59-8835-2181-635670e7f176@axentia.se>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/2018 at 17:52, Peter Rosin wrote:
> On 2018-05-28 16:27, Boris Brezillon wrote:

[..]

>> Could it just be that you're reaching the DDR bus limit. As I said
>> previously, when you go through the CPU, and assuming you're consuming
>> the data directly, you have:
>>
>> 1/ NFC SRAM -> CPU
>> 2/ CPU -> L1 data cache --write-back--> DRAM
>> 3/ L1-cache -> CPU
>>
>> While, if you use DMA you get:
>>
>> 1/ NFC SRAM -> DRAM
>> 2/ SDRAM -> L1 data cache -> CPU
>>
>> So, if you're approaching the limit of (LP)DDR bandwidth, using the CPU
>> might make things a bit better. Still, if the limitation really comes
>> from the DDR bus, my opinion is that you should maybe use a smaller
>> resolution or use a more compact pixel format (RGB565?).
> 
> The issue is still there if I use a CLUT mode instead of rgb565, which is
> what I normally use (and what I would like to use, CLUT is just alien and
> a pain these days).
> 
> The panels we are using only supports one resolution (each), but the issue
> is there with both 1920x1080@16bpp and 1024x768@8bpp (~60Hz).
> 
>> Did you calculate how much of the bandwidth is taken by the HLCDC
>> block and compared it to the max (LP)DDR bandwidth?
> 
> I did, but don't remember the exact details. There is some room even for
> 1920x1080@16bpp, but not oceans of it. We were a bit uncertain if 16bpp
> would be possible, and in fact that was the reason I worked on CLUT
> support for atmel-hlcdc last year. But since the problem persists with
> much less memory pressure as well, I don't think that's it either.

Just jumping in the conversation with another perspective (maybe already 
tried actually).

Can you try to make all that you can to maximize the blanking period of 
your screen (some are more tolerant than others according to that). By 
doing so, you would allow the LCD FIFO to recover better after each 
line. You might loose some columns on the side of your display but it 
would give us a good idea of how far we are from getting rid of those 
annoying LCD reset glitches (that are due to underruns on LCD FIFO).

> Admittedly I have not tested these AHB matrix tricks with a smaller
> panel (it would take a bit of work to arrange for those tests), but the
> issue was there when I last tried (using defaults).

If what I said earlier has an impact, reducing the panel size will also 
make a difference. But the question is how small is "smaller" ;-)

Best regards,
-- 
Nicolas Ferre
