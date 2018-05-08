Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754208AbeEHGP1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 02:15:27 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:33292 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbeEHGPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 02:15:25 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w486FLO0004136
X-Nifty-SrcIP: [209.85.213.44]
X-Google-Smtp-Source: AB8JxZpMM9vugf+1J/qmVXgj7d6pfOI2p+64X48rQj+1Yo8h2w9+8CHeMAyRpaubC9arrXNZV/F1nZl0GeGJIsnz5+o=
MIME-Version: 1.0
In-Reply-To: <20180507093933.393964b7@bbrezillon>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
 <1525350041-22995-2-git-send-email-absahu@codeaurora.org> <CAK7LNASWErFrvW+_6Lsw-aqO4T3=iyRZLXG21ML+ebOX=po2Zw@mail.gmail.com>
 <20180507093933.393964b7@bbrezillon>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 8 May 2018 15:14:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNATSv1_5hTrWgiATTNwri8YdqzoKe7P701MT69MVMRbUTg@mail.gmail.com>
Message-ID: <CAK7LNATSv1_5hTrWgiATTNwri8YdqzoKe7P701MT69MVMRbUTg@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] mtd: rawnand: helper function for setting up ECC parameters
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Abhishek Sahu <absahu@codeaurora.org>,
        Archit Taneja <architt@codeaurora.org>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Andy Gross <andy.gross@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-07 16:39 GMT+09:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> On Mon, 7 May 2018 12:40:39 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
>> 2018-05-03 21:20 GMT+09:00 Abhishek Sahu <absahu@codeaurora.org>:
>> > commit 2c8f8afa7f92 ("mtd: nand: add generic helpers to check,
>> > match, maximize ECC settings") provides generic helpers which
>> > drivers can use for setting up ECC parameters.
>> >
>> > Since same board can have different ECC strength nand chips so
>> > following is the logic for setting up ECC strength and ECC step
>> > size, which can be used by most of the drivers.
>> >
>> > 1. If both ECC step size and ECC strength are already set
>> >    (usually by DT) then just check whether this setting
>> >    is supported by NAND controller.
>> > 2. If NAND_ECC_MAXIMIZE is set, then select maximum ECC strength
>> >    supported by NAND controller.
>> > 3. Otherwise, try to match the ECC step size and ECC strength closest
>> >    to the chip's requirement. If available OOB size can't fit the chip
>> >    requirement then select maximum ECC strength which can be fit with
>> >    available OOB size with warning.
>> >
>> > This patch introduces nand_ecc_param_setup function which calls the
>> > required helper functions for the above logic. The drivers can use
>> > this single function instead of calling the 3 helper functions
>> > individually.
>> >
>> > CC: Masahiro Yamada <yamada.masahiro@socionext.com>
>> > Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
>> > ---
>> > * Changes from v1:
>> >
>> >   NEW PATCH
>> >
>> >  drivers/mtd/nand/raw/nand_base.c | 42 ++++++++++++++++++++++++++++++++++++++++
>> >  include/linux/mtd/rawnand.h      |  3 +++
>> >  2 files changed, 45 insertions(+)
>> >
>> > diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
>> > index 72f3a89..dd7a984 100644
>> > --- a/drivers/mtd/nand/raw/nand_base.c
>> > +++ b/drivers/mtd/nand/raw/nand_base.c
>> > @@ -6249,6 +6249,48 @@ int nand_maximize_ecc(struct nand_chip *chip,
>> >  }
>> >  EXPORT_SYMBOL_GPL(nand_maximize_ecc);
>> >
>> > +/**
>> > + * nand_ecc_param_setup - Set the ECC strength and ECC step size
>> > + * @chip: nand chip info structure
>> > + * @caps: ECC engine caps info structure
>> > + * @oobavail: OOB size that the ECC engine can use
>> > + *
>> > + * Choose the ECC strength according to following logic
>> > + *
>> > + * 1. If both ECC step size and ECC strength are already set (usually by DT)
>> > + *    then check if it is supported by this controller.
>> > + * 2. If NAND_ECC_MAXIMIZE is set, then select maximum ECC strength.
>> > + * 3. Otherwise, try to match the ECC step size and ECC strength closest
>> > + *    to the chip's requirement. If available OOB size can't fit the chip
>> > + *    requirement then fallback to the maximum ECC step size and ECC strength
>> > + *    and print the warning.
>> > + *
>> > + * On success, the chosen ECC settings are set.
>> > + */
>> > +int nand_ecc_param_setup(struct nand_chip *chip,
>> > +                        const struct nand_ecc_caps *caps, int oobavail)
>> > +{
>> > +       int ret;
>> > +
>> > +       if (chip->ecc.size && chip->ecc.strength)
>> > +               return nand_check_ecc_caps(chip, caps, oobavail);
>> > +
>> > +       if (chip->ecc.options & NAND_ECC_MAXIMIZE)
>> > +               return nand_maximize_ecc(chip, caps, oobavail);
>> > +
>> > +       if (!nand_match_ecc_req(chip, caps, oobavail))
>> > +               return 0;
>> > +
>> > +       ret = nand_maximize_ecc(chip, caps, oobavail);
>>
>>
>> Why two calls for nand_maximize_ecc()?
>
> As long as the code does the same thing, I don't care that much.
>
>>
>> My code is simpler,
>
> and I don't see how your code is simpler. Mainly a matter of taste
> AFAICS.
>
>> and does not display
>> false-positive warning.
>
> I agree on the false-positive warning though, this should be avoided.
>
>>
>>
>> > +       if (!ret)
>> > +               pr_warn("ECC (step, strength) = (%d, %d) not supported on this controller. Fallback to (%d, %d)\n",
>> > +                       chip->ecc_step_ds, chip->ecc_strength_ds,
>> > +                       chip->ecc.size, chip->ecc.strength);
>>
>>
>> This is annoying.
>>
>> {ecc_step_ds, ecc_strength_ds} are not provided by Non-ONFi devices.
>>
>> So,
>>   ECC (step, strength) = (0, 0) not supported on this controller.
>
> Well, if you have a chip that requires ECC but exposes 0bits/0bytes
> then this should be fixed. 0,0 should only be valid when the chip does
> not require ECC at all (so, only really old chips). For all other chips,
> including non-ONFI ones, we should have a valid value here.


Sorry, it was my misunderstanding.

My NAND chip is Toshiba.

If I remember correctly, Toshiba chips were not set
with ECC requirements in the past,
but as far as I tested the latest kernel now,
the ECC requirement was set by
drivers/mtd/nand/raw/nand_toshiba.c





>>
>> will be always displayed.
>>
>>
>> The strength will be checked by nand_ecc_strength_good() anyway.
>
> True. So, I agree that the pr_warn() is unneeded, but I still think we
> should fix all cases where ECC reqs are missing, so if you have such a
> setup, please add some code to nand_<vendor>.c to initialize
> ->ecc_xxx_ds properly.
>

If we decide to not display pr_warn(),
I think the code like denali_ecc_setup() should work, and simple.





-- 
Best Regards
Masahiro Yamada
