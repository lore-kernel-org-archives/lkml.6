Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755188AbeE0FWy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 01:22:54 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43868 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755119AbeE0FWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 01:22:51 -0400
X-Google-Smtp-Source: AB8JxZp3xKUpLuy51Yo9KBNPMtALalFiHlPyh/QjgtJ5kiapWi7Chu51bqwlwXyWgU8xx/9cReflEA==
Subject: Re: [RFC PATCH] m68k: set dma and coherent masks for Macintosh SONIC
 based ethernet
To: Finn Thain <fthain@telegraphics.com.au>,
        Guenter Roeck <linux@roeck-us.net>
References: <1527378785-13326-1-git-send-email-linux@roeck-us.net>
 <alpine.LNX.2.21.1805271212480.9@nippy.intranet>
Cc: Joshua Thompson <funaho@jurai.org>, Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Michael Schmitz <schmitzmic@gmail.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <55c1c33b-4a34-bd72-57de-577ce8d95e0b@gmail.com>
Date: Sun, 27 May 2018 17:22:42 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1805271212480.9@nippy.intranet>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

was your patch to implement this in arch_setup_pdev_archdata() rejected?
That should have fixed the warning already ...

Am 27.05.2018 um 15:01 schrieb Finn Thain:
> On Sat, 26 May 2018, Guenter Roeck wrote:
> 
>> As of commit 205e1b7f51e4 ("dma-mapping: warn when there is no
>> coherent_dma_mask") the NatSemi SONIC Ethernet driver is issuing the
>> following warning on driver initialization on Macintosh q800 systems.
>>
>> SONIC ethernet @50f0a000, MAC 08:00:07:12:34:56, IRQ 3
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 macsonic_init+0x6a/0x15a
>> Modules linked in:
>> CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0-rc6-mac-00286-g527f47c #1
>> Stack from 0781fdd8:
>>         0781fdd8 003615b3 000181ba 000005c4 07a24cbc 00000000 00000000 000020e8
>> 	07a24800 002c196c 0001824e 00334c06 00000204 001f782a 00000009 00000000
>> 	00000000 003358d9 001f782a 00334c06 00000204 00000003 00000000 07a24800
>> 	002b5cb6 000372ec 001f8b1a 07a24800 00359203 50f0a000 07a14a48 00000003
>> 	00000000 07845c0a 0039dcca 003c835c 003c835c 0035b924 001c19de 07845c00
>> 	07845c0a 0039dcca 001c06dc 07845c0a 0781fed8 00000007 0054d040 07845c0a
>> Call Trace: [<000181ba>] __warn+0xc0/0xc2
>>  [<000020e8>] do_one_initcall+0x0/0x140
>>  [<0001824e>] warn_slowpath_null+0x26/0x2c
>>  [<001f782a>] macsonic_init+0x6a/0x15a
>>  [<001f782a>] macsonic_init+0x6a/0x15a
>>  [<002b5cb6>] memcmp+0x0/0x2a
>>  [<000372ec>] printk+0x0/0x18
>>  [<001f8b1a>] mac_sonic_platform_probe+0x380/0x404
>>
>> As per the warning the coherent_dma_mask is not set on this device.
>> There is nothing special about the DMA memory coherency on this hardware
>> so we can just set the mask to 32bits in the platform data for the FEC
>> ethernet devices.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Acked-by: Finn Thain <fthain@telegraphics.com.au>
> 
> Geert, assuming that Guenter's patch is acceptable, would you also accept 
> a similar patch for the "macmace" platform device?
> 
>> ---
>> Modeled after f61e64310b75 ("m68k: set dma and coherent masks for platform
>> FEC ethernets"). 
>>
>> RFC: Is "nothing special about the DMA memory coherency" correect ?
>>
> 
> As I understand it, "cache-coherence" is meaningless unless you have 
> multiple CPU cores and caches. If there's only one CPU core, its cache 
> can't be said to be "coherent" or "non-coherent". Moreover, DMA (direct 
> memory access) concerns an IO device and a memory, not a cache, so the 
> term "coherent dma" is bogus IMHO.

DMA does concern the CPU cache insofar as (without explicit cache
maintenance) the CPU cache may hold stale data after a DMA write, or
data to be used in a DMA read may not have been written back from cache
to memory. As far as I understand it, the generic DMA API does handle
these cache maintenance aspects without a need for action at the driver
level. But you're correct that the question of coherent memory does not
arise on uniprocessor systems, so the whole warning could have been
avoided.

Unless 'coherent memory' in this context means no explicit cache
maintenance is required (CPU does bus snooping - which of our platforms
fully support that)?

Cheers,

	Michael
