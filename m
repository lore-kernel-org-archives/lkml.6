Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754918AbeE2H12 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:27:28 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:60124 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754763AbeE2H10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:27:26 -0400
X-IronPort-AV: E=Sophos;i="5.49,455,1520924400";
   d="scan'208";a="11985664"
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
To: Peter Rosin <peda@axentia.se>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        <linux-kernel@vger.kernel.org>, Marek Vasut <marek.vasut@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-mtd@lists.infradead.org>,
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
 <959d826d-1a98-ca22-acee-a4548427fcd3@microchip.com>
 <a25ca617-d3da-d401-1ba9-8e5887f8a8e5@microchip.com>
 <024079cb-77ad-9c48-e370-e6e8f2de171b@axentia.se>
 <9c496531-f7b6-4b9d-dd51-0bfb68ead303@axentia.se>
 <c3cc1894-2d7d-93b6-a9de-ed9ca4564ae9@axentia.se>
 <19d68279-072e-7646-6fdd-8649578229ea@microchip.com>
 <9ae5fc1d-9f02-9742-f801-2252389294eb@axentia.se>
From: Eugen Hristev <eugen.hristev@microchip.com>
Message-ID: <2726a7b0-56b2-bb7f-ad4a-2a3139ebbb03@microchip.com>
Date: Tue, 29 May 2018 10:25:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <9ae5fc1d-9f02-9742-f801-2252389294eb@axentia.se>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.05.2018 10:10, Peter Rosin wrote:
> On 2018-05-29 08:30, Eugen Hristev wrote:
>>
>>
>> On 28.05.2018 13:10, Peter Rosin wrote:
>>> On 2018-05-28 00:11, Peter Rosin wrote:
>>>> On 2018-05-27 11:18, Peter Rosin wrote:
>>>>> On 2018-05-25 16:51, Tudor Ambarus wrote:
>>>>>> We think the best way is to keep LCD on DDR Ports 2 and 3 (8th and 9th
>>>>>> slaves), to have maximum bandwidth and to use DMA on DDR port 1 for NAND
>>>>>> (7th slave).
>>>>>
>>>>> Exactly how do I accomplish that?
>>>>>
>>>>> I can see how I can move the LCD between slave DDR port 2 and 3 by
>>>>> selecting LCDC DMA master 8 or 9 (but according to the above it should
>>>>> not matter). The big question is how I control what slave the NAND flash
>>>>> is going to use? I find nothing in the datasheet, and the code is also
>>>>> non-transparent enough for me to figure it out by myself without
>>>>> throwing out this question first...
>>
>>   >> [...]
>>
>>>> and the output is
>>>>
>>>> atmel-nand-controller 10000000.ebi:nand-controller: using dma0chan5 for DMA transfers
>>>>
>>>> So, DMA controller 0 is in use. I still don't know if IF0, IF1 or IF2 is used
>>>> or how to find out. I guess IF2 is not in use since that does not allow any
>>>> DDR2 port as slave...
>>
>> Hello Peter,
>>
>> Thank you for all the information, I will chip in to help a little bit.
>> The Master/channel is described in the device tree. The channel has a
>> controller, a mem/periph interface and a periph ID, plus a FIFO
>> configuration.
>>
>> The dma chan number reported in the dmesg is just software.
> 
> Got that, that was why I added the various additional traces in that
> horrid patch in the mail you are responding to :-)
> 
>>                                                              Here is an
>> example from DT:
>> dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(1)>,
>>          <&dma0 2 AT91_DMA_CFG_PER_ID(2)>;
>>
>> you can match this with the help from
>> Documentation/devicetree/bindings/dma/atmel-dma.txt:
>>
>> 1. A phandle pointing to the DMA controller.
>>
>> 2. The memory interface (16 most significant bits), the peripheral
>> interface
>> (16 less significant bits).
>>
>> 3. Parameters for the at91 DMA configuration register which are device
>>
>> dependent:
>>
>>     - bit 7-0: peripheral identifier for the hardware handshaking
>> interface. The
>>     identifier can be different for tx and rx.
>>
>>     - bit 11-8: FIFO configuration. 0 for half FIFO, 1 for ALAP, 2 for ASAP.
>>
>>
>> So , what was Tudor asking for, is your DT for the ebi node (if you are
>> using ebi), or, your NFC SRAM (Nand Flash Controller SRAM) DMA
>> devicetree chunk, so, we can figure out which type of DMA are you using.
>>
>> Normally, the ebi should be connected to both DMA0 and DMA1 on those
>> interfaces specified in DT. Which ones you want to use, depends on your
>> setup (and contention on the bus/accesses, like in your case, the HLCDC)
>>
>> Thats why we have multiple choices, to pick the right one for each case.
>> In our vanilla DT sama5d3.dtsi we do not have DMA described for ebi
>> interface.
> 
> Ahh, *that* NAND DMA configuration. Of course, how silly of me...
> 
> This is a setup based on the at91-linea.dtsi "CPU" board. That dtsi should
> have the relevant NAND/DMA info. Also, at91-nattis-2-natte-2.dts describes
> the older HW (with a 1024x768 panel) that is also affected, if you want a
> full device tree to look at.
> 
> Looks like I didn't make a selection, quoting from at91-linea.dtsi:

Ok, so try to force the nand to use DDR port 1 : use DMAC0 or DMAC1 on 
the interfaces corresponding just to DDR port 1, and see if helps (while 
leaving HLCDC on both masters - DDR port 2 and 3).

One more thing: what are the actual nand commands which you use when you 
get the glitches? read/write/erase ... ?
What happens if you try to minimize the nand access? you also said at 
some point that only *some* nand accesses cause glitches.

Another thing : even if the LCD displays a still image, the DMA still 
feeds data to the LCD right ?

> 
> &ebi {
> 	pinctrl-0 = <&pinctrl_ebi_nand_addr>;
> 	pinctrl-names = "default";
> 	status = "okay";
> };
> 
> &nand_controller {
> 	status = "okay";
> 
> 	nand: nand@3 {
> 		reg = <0x3 0x0 0x2>;
> 		atmel,rb = <0>;
> 		nand-bus-width = <8>;
> 		nand-ecc-mode = "hw";
> 		nand-ecc-strength = <4>;
> 		nand-ecc-step-size = <512>;
> 		nand-on-flash-bbt;
> 		label = "atmel_nand";
> 	};
> };
> 
> The reason is probably because the sama5d3xek device-trees didn't at the
> time of "fork". Does anybody have any suggestion for some extra properties
> to try in the above nodes?
> 
> Further, I forgot that I had actually upstreamed linea support for
> at91bootstrap, so relevant NAND timings etc can be found in lpddr1_init()
> in
> 
> 	at91bootstrap/contrib/board/axentia/sama5d3_linea/sama5d3_linea.c
> 
> Cheers,
> Peter
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
