Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750983AbeEaVop (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 17:44:45 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:37134 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeEaVok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 17:44:40 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Thu, 31 May 2018 23:44:37 +0200
From: Stefan Agner <stefan@agner.ch>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, robh+dt@kernel.org,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, mark.rutland@arm.com, thierry.reding@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, dev@lynxeye.de,
        richard@nod.at, marcel@ziswiler.com, krzk@kernel.org, digetx@gmail.com,
        benjamin.lindqvist@endian.se, jonathanh@nvidia.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, mirza.krak@gmail.com,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [RESEND PATCH 2/5] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
In-Reply-To: <20180531223027.57e36d0b@bbrezillon>
References: <cover.1526990589.git.stefan@agner.ch>
 <86fdf19ec92b732709732fb60199f16488b4b727.1526990589.git.stefan@agner.ch>
 <20180528000422.7f18dc5f@xps13> <047a9a5e72c8db52858a505865d4f720@agner.ch>
 <20180531223027.57e36d0b@bbrezillon>
Message-ID: <12cb03d078c3571171362710f9019d41@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-0.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[25];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.05.2018 22:30, Boris Brezillon wrote:
> On Thu, 31 May 2018 19:54:08 +0200
> Stefan Agner <stefan@agner.ch> wrote:
> 
>> >> +
>> >> +	mtd->dev.parent = &pdev->dev;
>> >> +	mtd->name = "tegra_nand";
>> >
>> > I just figured it was undocumented (yet) but you could have a label
>> > string property in your nand DT node that tells you the name of the
>> > MTD device instead of something too generic like tegra_nand.
>> >
>>
>> Using label in the NAND chip subnode actually causes current U-Boot to
>> delete (!!) the chip node and create partitions on the controller node.
>>
>> See:
>> https://elixir.bootlin.com/u-boot/latest/source/common/fdt_support.c#L757
>>
>> The code essentially uses the property label to detect whether its a
>> NAND chip or a partition...
> 
> Why not fixing that in uboot? The representation where the NAND device
> and NAND controller are mixed in a single node called nand@xxx is just
> wrong from a HW PoV, and it seems uboot is using this representation,
> which is probably why you have a problem when trying to find the
> partition directly under the NAND controller node.
> 
>>
>> At least this is the case when using fdt_fixup_mtdparts and passing the
>> controller compatible ("nvidia,tegra20-nand") in node_info,
> 
> Just a digression, but I recommend using
> "nvidia,tegra20-nand-controller" for the compatible, because the node
> is describing the NAND controller not the NAND chip. 
> 

Ok.

>> what our
>> downstream U-Boot is currently doing. Maybe we should pass the
>> compatible property of the NAND chip?
> 
> Or maybe you should search for partitions in children of the controller
> node instead of searching directly under the controller node itself.
> 

Yes, that is what it is doing... But only if that child has not a label.

fdt_fixup_mtdparts is common code. Change the behaviour now probably
breaks boards... 

Anyway, this discussion needs to be shifted to the U-Boot mailing list.

>> But afaik, chips do not have a
>> compatible necessarily.
> 
> Nope, and it should stay like that.
> 
>>
>> So using label in the chip node is currently a no-go for me.
> 
> I hope I'm wrong but I fear this is not the only problem you'll face
> when switching to a controller+chip representation. This is just the
> tip of the iceberg.
> 

Works not too bad otherwise, so far :-)

>>
>> Will send out v3 soon.
> 
> Sure, let's see how v3 looks.

--
Stefan
