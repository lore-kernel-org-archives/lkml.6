Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032800AbeEXLAw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 07:00:52 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:35948 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030243AbeEXLAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 07:00:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Thu, 24 May 2018 13:00:41 +0200
From: Stefan Agner <stefan@agner.ch>
To: Benjamin Lindqvist <benjamin.lindqvist@endian.se>
Cc: boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        Lucas Stach <dev@lynxeye.de>, miquel.raynal@bootlin.com,
        richard@nod.at, marcel@ziswiler.com, krzk@kernel.org, digetx@gmail.com,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        Mirza Krak <mirza.krak@gmail.com>, linux-mtd@lists.infradead.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [RESEND PATCH 2/5] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
In-Reply-To: <CAGefG55kvShaLhNYsFznbOq0_6RNbb+eJ47DLnnU9qRRpwu-iA@mail.gmail.com>
References: <cover.1526990589.git.stefan@agner.ch>
 <86fdf19ec92b732709732fb60199f16488b4b727.1526990589.git.stefan@agner.ch>
 <CAGefG55kvShaLhNYsFznbOq0_6RNbb+eJ47DLnnU9qRRpwu-iA@mail.gmail.com>
Message-ID: <d8d6cb9fcd8ce7ea5c13b227012de6d2@agner.ch>
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
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[32.05%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.05.2018 09:45, Benjamin Lindqvist wrote:
> Hi Stefan (and all),
> 
> First off, I apoloigize in advance if I'm deviating from common
> kernel mailing list courtesy -- this is my first time responding.
> I just have a comment on the NAND driver that I'd like to bring
> to the public.
> 

Welcome!

>> +       switch (mtd->oobsize) {
>> ...
>> +       case 224:
>> +               mtd_set_ooblayout(mtd, &tegra_nand_oob_224_ops);
>> +               chip->ecc.strength = 8;
>> +               chip->ecc.bytes = 18;
>> +               value |= CFG_ECC_SEL | CFG_TVAL_8;
>> +               break; +       case 224:
> 
> I am not sure how you arrived at this oobsize-based inference. I
> have not seen any explicit relation between oob size and ECC
> algorithm used in the reference manual. Indeed, the U-Boot I was
> working on (a fork of the Toradex 2015.04 U-Boot) always has
> oobsize == 224 but used either BCH[t=16] or RS[t=4]. In fact, we
> tried choosing RS[t=8] in U-Boot but we failed to make the
> BootROM decode this at all. So we had to use RS[t=4]. But
> changing the algorithm did not automatically change the oobsize,
> at least it didn't for us. So maybe you should consider if this
> is really the way to go about deciding which algorithm is used.

The oobsize based inference to set the HW ECC mode comes from the
patchset I picked up. Typically, the size of the OOB area is such that
it allows "good enough" error correction required for that chip. So
using it as indicator for the ECC algorithm is not entirely off...

But yeah I agree we have better means, and I already started working on
a better mechanism. Also, I worked on BCH support, and it looks pretty
good already.

If we want to auto select mode we can use the ECC requirements from
ONFI/JEDEC/parameter page. Or we could use device tree only. 

Thanks for bringing up the Boot ROM issue. In fact I investigated the
supported modes the recent days too. First off, as you mentioned, the
boot ROM seems to probe different modes until it succeeds. By trying
through all RS and BCH modes, it seems that it only probes some modes:
- RS t=4
- BCH t=8
- BCH t=16

I guess those are preferred modes in practise. Not sure if we should
make sure the auto selection such that it only chooses from this list...

> 
> Note that we're in fact using this patch set in Linux today, but
> we had to remove the oobsize inference part. Currently we're
> simply hard coding it to CFG_TVAL_4, but maybe it would be
> cleaner to add ECC algo as a board config instead, e.g. in the
> .dts file or whatever. This seems to be done by other vendors
> already, see for example excerpt of
> Documentation/devicetree/bindings/mtd/gpmc-nand.txt below:
> 
>  - ti,nand-ecc-opt: A string setting the ECC layout to use. One of:
> "sw" 1-bit Hamming ecc code via software
> "hw" <deprecated> use "ham1" instead
> "hw-romcode" <deprecated> use "ham1" instead
> "ham1" 1-bit Hamming ecc code
> "bch4" 4-bit BCH ecc code
> "bch8" 8-bit BCH ecc code
> "bch16" 16-bit BCH ECC code
> Refer below "How to select correct ECC scheme for your device ?"
> 
> It seems as if this method would be equally applicable to Tegra NAND.

Yeah, ideally we can reuse "nand-ecc-algo". Although, Reed-Solomon is
not yet in the list.  So using this property would require to extend
this standard property.

--
Stefan
