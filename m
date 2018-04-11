Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753690AbeDKPf2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 11:35:28 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:3716 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752335AbeDKPf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 11:35:27 -0400
X-IronPort-AV: E=Sophos;i="5.48,436,1517900400";
   d="scan'208";a="13069502"
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
To: Peter Rosin <peda@axentia.se>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC: Boris Brezillon <boris.brezillon@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Josh Wu <rainyfeeling@outlook.com>, <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>, <linux-mtd@lists.infradead.org>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
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
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <959d826d-1a98-ca22-acee-a4548427fcd3@microchip.com>
Date: Wed, 11 Apr 2018 17:34:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <d0afd431-6e51-a9b7-c103-ecf1f6e07c2e@axentia.se>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2018 at 16:44, Peter Rosin wrote:
> Hi Nicolas,
> 
> Boris asked for your input on this (the datasheet difference appears to
> have no bearing on the issue) elsewhere in the tree of messages. It's
> now been a week or so and I'm starting to wonder if you missed this
> altogether or if you are simply out of office or something?

Hi Peter,

I didn't dig into this issue with matrix datasheet reset values and your 
findings below. I'll try to move forward with your detailed explanation 
and with my contacts within the "product" team internally.

However, I have the feeling that this sounds a little bit familiar to me 
and that the pins drive strength for the NAND Flash *and* LCD must be 
positioned to "Medium drive" at least for these interfaces (register 
PIO_CFGR).

We use this particular setting for our own vendor branch and found that 
the LCD and NAND Flash was far more sable on *some HW boards*. Here is 
an example for NAND but you can find the same for LCD:
https://github.com/linux4sam/linux-at91/commit/99d9e4c8848a2f16cc5b34bb27e588ca7504b695
Obviously the "drive strength" property added by Ludovic has been 
proposed but is not accepted yet in Mainline and this is why you don't 
see it positioned here.

If it feels like an issue with "crosstalk" it might be the reason why. 
For overruns or underruns, it's true that I would say that it's not 
related and that dealing with the matrix is the way to go.

You can simply test this using devmem2 and see if it's better.

Hope that it helps.
Best regards,
   Nicolas

> On 2018-04-03 09:18, Boris Brezillon wrote:
>> On Tue, 3 Apr 2018 08:11:30 +0200
>> Peter Rosin <peda@axentia.se> wrote:
>>
>>> On 2018-04-02 22:20, Boris Brezillon wrote:
>>>> On Mon, 2 Apr 2018 21:28:43 +0200
>>>> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>>>>    
>>>>> On Mon, 2 Apr 2018 19:59:39 +0200
>>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>>   
>>>>>> On 2018-04-02 14:22, Boris Brezillon wrote:
>>>>>>> On Thu, 29 Mar 2018 16:27:12 +0200
>>>>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>>>>        
>>>>>>>> On 2018-03-29 15:44, Boris Brezillon wrote:
>>>>>>>>> On Thu, 29 Mar 2018 15:37:43 +0200
>>>>>>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>>>>>>          
>>>>>>>>>> On 2018-03-29 15:33, Boris Brezillon wrote:
>>>>>>>>>>> On Thu, 29 Mar 2018 15:10:54 +0200
>>>>>>>>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>>>>>>>>            
>>>>>>>>>>>> On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
>>>>>>>>>>>> flash accesses have a tendency to cause display disturbances. Add a
>>>>>>>>>>>> module param to disable DMA from the NAND controller, since that fixes
>>>>>>>>>>>> the display problem for me.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>>>>>>>>>> ---
>>>>>>>>>>>>   drivers/mtd/nand/raw/atmel/nand-controller.c | 7 ++++++-
>>>>>>>>>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>>>>>>>>> index b2f00b398490..2ff7a77c7b8e 100644
>>>>>>>>>>>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>>>>>>>>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>>>>>>>>> @@ -129,6 +129,11 @@
>>>>>>>>>>>>   #define DEFAULT_TIMEOUT_MS			1000
>>>>>>>>>>>>   #define MIN_DMA_LEN				128
>>>>>>>>>>>>   
>>>>>>>>>>>> +static bool atmel_nand_avoid_dma __read_mostly;
>>>>>>>>>>>> +
>>>>>>>>>>>> +MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
>>>>>>>>>>>> +module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);
>>>>>>>>>>>
>>>>>>>>>>> I'm not a big fan of those driver specific cmdline parameters. Can't we
>>>>>>>>>>> instead give an higher priority to HLCDC master using the bus matrix?
>>>>>>>>>>
>>>>>>>>>> I don't know if it will be enough, but we sure can try. However, I have
>>>>>>>>>> no idea how to do that. I will happily test stuff though...
>>>>>>>>>
>>>>>>>>> There's no interface to configure that from Linux, but you can try to
>>>>>>>>> tweak it with devmem and if that does the trick, maybe we can expose a
>>>>>>>>> way to configure that from Linux. For more details, see the "Bus Matrix
>>>>>>>>> (MATRIX)" section in Atmel datasheets.
>>>>>>>>
>>>>>>>> I don't seem to succeed in changing the registers I think I need to change.
>>>>>>>> I can poke the "Write Protection Mode Register" by writing MAT0 and MAT1 to
>>>>>>>> it.
>>>>>>>
>>>>>>> You mean 0x4D415400, right? ("MAT0" != 0x4D415400).
>>>>>>
>>>>>> Bits 1 through 7 do not matter, so even though not equal they are (or
>>>>>> should be) equivalent. But I did use 0x4d415400. I simply used the
>>>>>> shorter syntax since that was easier to type and conveyed the relevant
>>>>>> info.
>>>>>
>>>>> Ok.
>>>>>   
>>>>>>      
>>>>>>>> But when I try to write to "Priority Registers B For Slaves" it doesn't
>>>>>>>> take, regardless of write protect mode.
>>>>>>>
>>>>>>> Did you check MATRIX_WPSR after writing to MATRIX_PRXSY?
>>>>>>
>>>>>> No, but did it again and checked, see transcript below.
>>>>>
>>>>> I don't use devmem2. Is 'readback' information accurate or is it
>>>>> always what's been written? Because when you write 0x33 to 0xFFFFECBC,
>>>>> 0x33 is read back, but just after that, when you read it again it's 0.
>>>>>   
>>>>>> BTW, how do I
>>>>>> know which master is in use for the LCD controller? 8 or 9? Both?
>>>>>
>>>>> It's configurable on a per-layer basis through the SIF bit in
>>>>> LCDC_<layer>CFG0. The driver tries to dispatch the load on those 2 AHB
>>>>> masters [1].
>>>>>   
>>>>>> And
>>>>>> which DDR slave is the target? 7, 8, 9 or 10? More than one?
>>>>>
>>>>> This, I don't know. I guess all of them can be used.
>>>>
>>>> Looks like I was wrong. According to "Table 15-3. SAMA5D3 Master to
>>>> Slave Access", LCDC port 0 can only access DDR port 2 and LCDC port 1
>>>> can only access DDR port 3.
>>>
>>> About that table, someone with HW-knowledge should have a real close
>>> look at it! Why?
>>>
>>> I peeked at all the PRxSy registers and there are a lot of '3' entries
>>> for all the MxPR fields. In fact, the '3' entries align very neatly
>>> with the checks in this "Master to Slave Access" table. Except they
>>> don't, after a while.
>>>
>>> Here's how the table looks in my datasheet:
>>>
>>>   0 vv--v--v--vvvv-
>>>   1 vv--v--v--vvvv-
>>>   2 vv-------------
>>>   3 vv--------vvv--
>>>   4 vv-------------
>>>   5 v--------------
>>>   6 vv--vv-vvvvvvvv
>>>     v--------------
>>>   7 v--------------
>>>   8 --v-v--v-------
>>>   9 -v---v--v--v---
>>> 10 ---------vv-vvv
>>> 11 v--v-----------
>>> 12 v-----v--------
>>>
>>> And here's the '3' entries when digging in the registers (the extra
>>> dash at the end is for the 16th non-existent slave):
>>>
>>>   0 33--3--3--3333--
>>>   1 33--3--3--3333--
>>>   2 33--------------
>>>   3 -3--------333---
>>>   4 33--------------
>>>   5 3---------------
>>>   6 33--33-33333333-
>>>   7 --3-3--3--------
>>>   8 -3---3--3--3----
>>>   9 --3-3--3-33-333-
>>> 10 3--3------------
>>> 11 3-----3---------
>>> 12 ----------------
>>> 13 ----------------
>>> 14 ----------------
>>> 15 ----------------
>>>
>>> There's a big mismatch for the four DDR2 lines in the table; they
>>> seem to map to only three registers. Other than that, the only tweak
>>> or anomaly is that first entry (Cortex A5) for master 3 (Int ROM).
>>>
>>> *time passes*
>>>
>>> Arrrgh!! You say "Table 15-3". This is Table 14-3 for me! I believe
>>> I'm using the latest datasheet (02-Feb-16). What are you reading???!?
>>
>> Oops, I was reading an old datasheet (from 2014).
> 


-- 
Nicolas Ferre
