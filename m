Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752556AbeDJHrM convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:47:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38145 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752196AbeDJHrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:47:10 -0400
Date: Tue, 10 Apr 2018 09:46:57 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Archit Taneja <architt@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Andy Gross <andy.gross@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/9] mtd: nand: qcom: use the ecc strength from device
 parameter
Message-ID: <20180410094657.63ac7ec9@xps13>
In-Reply-To: <23c8330d00d4d9b62c4c1ab597cbb22b@codeaurora.org>
References: <1522845745-6624-1-git-send-email-absahu@codeaurora.org>
        <1522845745-6624-2-git-send-email-absahu@codeaurora.org>
        <20180406143133.67f33d33@xps13>
        <23c8330d00d4d9b62c4c1ab597cbb22b@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On Tue, 10 Apr 2018 11:39:35 +0530, Abhishek Sahu
<absahu@codeaurora.org> wrote:

> On 2018-04-06 18:01, Miquel Raynal wrote:
> > Hi Abhishek,
> > 
> > On Wed,  4 Apr 2018 18:12:17 +0530, Abhishek Sahu
> > <absahu@codeaurora.org> wrote:
> >   
> >> Currently the driver uses the ECC strength specified in
> >> device tree. The ONFI or JEDEC device parameter page
> >> contains the ‘ECC correctability’ field which indicates the
> >> number of bits that the host should be able to correct per
> >> 512 bytes of data.  
> > 
> > This is misleading. This field is not about the controller but rather
> > the chip requirements in terms of minimal strength for nominal use.
> >   
> 
>   Thanks Miquel.
> 
>   Yes. Its NAND chip requirement. I have used the description for
>   NAND ONFI param page
> 
>   5.6.1.24. Byte 112: Number of bits ECC correctability
>   This field indicates the number of bits that the host should be
>   able to correct per 512 bytes of data.
> 
> >> The ecc correctability is assigned in
> >> chip parameter during device probe time. QPIC/EBI2 NAND
> >> supports 4/8-bit ecc correction. The Same kind of board
> >> can have different NAND parts so use the ecc strength
> >> from device parameter (if its non zero) instead of
> >> device tree.  
> > 
> > That is not what you do.
> > 
> > What you do is forcing the strength to be 8-bit per ECC chunk if the
> > NAND chip requires at least 8-bit/chunk strength.
> > 
> > The DT property is here to force a strength. Otherwise, Linux will
> > propose to the NAND controller to use the minimum strength required by
> > the chip (from either the ONFI/JEDEC parameter page or from a static
> > table).
> >   
> 
>   The main problem is that the same kind of boards can have different
>   NAND parts.
> 
>   Lets assume, we have following 2 cases.
> 
>   1. Non ONFI/JEDEC device for which chip->ecc_strength_ds
>      will be zero. In this case, the ecc->strength from DT
>      will be used

No, the strength from DT will always be used if the property is
present, no matter the type of chip.

>   2. ONFI/JEDEC device for which chip->ecc_strength_ds > 8.
>      Since QCOM nand controller can not support
>      ECC correction greater than 8 bits so we can use 8 bit ECC
>      itself instead of failing NAND boot completely.

I understand that. But this is still not what you do.

> 
> > IMHO, you have two solutions:
> > 1/ Remove these properties from the board DT (breaks DT backward
> > compatibility though);  
> 
>   - nand-ecc-strength: This is optional property in nand.txt and
>     Required property in qcom_nandc.txt.

Well, this property is not controller specific but chip specific. The
controller driver does not rely on it, so this property should not be
required.

> We can't remove since
>     if the device is Non ONFI/JEDEC, then ecc strength will come
>     from DT only.

We can remove it and let the core handle this (as this is generic to
all raw NANDs and not specific to this controller driver). Try it out!

However if the defaults value do not match your expectations, I think
you can add your non-ONFI/JEDEC chip in 'nand_ids.c', this should fill
your strength_ds field and let you avoid using these properties.

> 
> > 2/ Create another DT for the board.
> >   
> 
>   Its not about board but about part. We have IPQ8074 HK01 board
>   with 4 bit ECC chip/8 bit ECC chip/non ONFI/JEDEC chip.
> 
> > However, there is something to do in this driver: the strength chosen
> > should be limited to the controller capabilities (8-bit/512B if I
> > understand correctly). In this case you have two options: either you
> > limit the strength like the size [1] if (ecc->strength > 8);  
> 
>   Limiting the strength will make all the boards with ecc strength > 8
>   to fail completely
> 
> > just limit the maximum strength to 8 like this [2] and the core will
> > spawn a warning in the dmesg telling that the ECC strength used is
> > below the NAND chip requirements.  
> 
>   Yes its good idea. I can update the patch with dmesg warning.
> 
>   Thanks,
>   Abhishek
> 
> > 
> > Thanks,
> > Miquèl
> > 
> > [1]
> > https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/qcom_nandc.c#L2332
> > [2] http://code.bulix.org/nyf63w-315268
> > 
> >   
> >> 
> >> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> >> ---
> >>  drivers/mtd/nand/qcom_nandc.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >> 
> >> diff --git a/drivers/mtd/nand/qcom_nandc.c 
> >> b/drivers/mtd/nand/qcom_nandc.c
> >> index 563b759..8dd40de 100644
> >> --- a/drivers/mtd/nand/qcom_nandc.c
> >> +++ b/drivers/mtd/nand/qcom_nandc.c
> >> @@ -2334,6 +2334,14 @@ static int qcom_nand_host_setup(struct 
> >> qcom_nand_host *host)
> >>  		return -EINVAL;
> >>  	}
> >> 
> >> +	/*
> >> +	 * Read the required ecc strength from NAND device and overwrite
> >> +	 * the device tree ecc strength for devices which require
> >> +	 * ecc correctability bits >= 8
> >> +	 */
> >> +	if (chip->ecc_strength_ds >= 8)
> >> +		ecc->strength = 8;
> >> +
> >>  	wide_bus = chip->options & NAND_BUSWIDTH_16 ? true : false;
> >> 
> >>  	if (ecc->strength >= 8) {  
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/


Thanks,
Miquèl

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
