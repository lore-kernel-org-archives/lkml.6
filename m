Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeFDPrC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:47:02 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:31984 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeFDPrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:47:00 -0400
X-IronPort-AV: E=Sophos;i="5.49,476,1520924400";
   d="scan'208";a="14833495"
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
To: Peter Rosin <peda@axentia.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        <linux-mtd@lists.infradead.org>, Richard Weinberger <richard@nod.at>,
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
From: Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <28c58ca3-d8ca-7195-3aa2-10d7c703dd65@microchip.com>
Date: Mon, 4 Jun 2018 18:46:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <c3cc1894-2d7d-93b6-a9de-ed9ca4564ae9@axentia.se>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter,

On 05/28/2018 01:10 PM, Peter Rosin wrote:

[cut]

> So, I think I want either
> 
> A) the NAND controller to use master 1 DMAC0/IF0 (i.e. slave 8 DDR2 port 2) and
>     the LCDC to use master 9 (i.e. slave 9 DDR2 Port 3)
> 
> or
> 
> B) the NAND controller to use master 2 DMAC0/IF1 (i.e. slave 7 DDR2 port 1, and
>     possibly slave 9 DDR2 port 3 (if my previous findings are relevant) and the
>     LCDC to use master 8 (i.e. slave 8 DDR2 Port 2)

My understanding is that "Table 14-3. Master to Slave Access" describes
what connections are allowed between the masters and slaves, while the
PRxSy registers just set the priorities. What happens when you assign
the highest priority to a master to slave connection that is not
allowed? Probably it is ignored, but I'll check with the hardware team.
So I expect that the NAND controller can not use DDR2 port 3 regardless
of the priority set.

[cut]

> So, output is as expected and I believe that the patch makes the NAND DMA
> accesses use master 2 DMAC0/IF1 and are thus forced to use slave 7 DDR2 Port 1
> (and possibly 9). The LCDC is using slave 8 DDR2 Port 2. So there should be no
> slave conflict?
> 
> But the on-screen crap remains during NAND accesses.

No conflict, but you missed to dispatch the load on the LCDC DMA
masters, if I understood correctly.

So, I think we want to test the following:
- NAND controller to use DMAC0/IF1 (slave 7 DDR2 port 1)
- LCDC to use master 8 (slave 8 DDR2 Port 2) and master 9 (slave 9 DDR2
Port 3).

Best,
ta
