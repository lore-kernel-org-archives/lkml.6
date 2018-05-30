Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968191AbeE3A3z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 20:29:55 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:21893 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965083AbeE3A3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 20:29:54 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w4U0TcCE022593
X-Nifty-SrcIP: [209.85.217.170]
X-Google-Smtp-Source: ADUXVKINh/uGCm4LS4YcDdi2mrfPwJG9JORVIlS2N1WS3D41t5eeWpaAvLSu5AyPX59FfOvYmYUMHz+DjQ8tjIv8FDY=
MIME-Version: 1.0
In-Reply-To: <20180529213036.150ed16a@bbrezillon>
References: <1527250904-21988-1-git-send-email-absahu@codeaurora.org>
 <1527250904-21988-2-git-send-email-absahu@codeaurora.org> <20180526095807.5caf5800@xps13>
 <20180529213036.150ed16a@bbrezillon>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 30 May 2018 09:28:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNASW4oCekGGkMfmO3tMUviVaium0EOYan6aLFANhL0FAXw@mail.gmail.com>
Message-ID: <CAK7LNASW4oCekGGkMfmO3tMUviVaium0EOYan6aLFANhL0FAXw@mail.gmail.com>
Subject: Re: [PATCH v3 01/16] mtd: rawnand: helper function for setting up ECC configuration
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
        Archit Taneja <architt@codeaurora.org>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Abhishek Sahu <absahu@codeaurora.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

2018-05-30 4:30 GMT+09:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> On Sat, 26 May 2018 10:42:47 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
>> Hi Abhishek,
>>
>> On Fri, 25 May 2018 17:51:29 +0530, Abhishek Sahu
>> <absahu@codeaurora.org> wrote:
>>
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
>> >    available OOB size.
>> >
>> > This patch introduces nand_ecc_choose_conf function which calls the
>> > required helper functions for the above logic. The drivers can use
>> > this single function instead of calling the 3 helper functions
>> > individually.
>> >
>> > CC: Masahiro Yamada <yamada.masahiro@socionext.com>
>> > Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
>> > ---
>> > * Changes from v2:
>> >
>> >   1. Renamed function to nand_ecc_choose_conf.
>> >   2. Minor code reorganization to remove warning and 2 function calls
>> >      for nand_maximize_ecc.
>> >
>> > * Changes from v1:
>> >   NEW PATCH
>> >
>> >  drivers/mtd/nand/raw/nand_base.c | 42 ++++++++++++++++++++++++++++++++++++++++
>> >  drivers/mtd/nand/raw/nand_base.c | 31 +++++++++++++++++++++++++++++++
>> >  include/linux/mtd/rawnand.h      |  3 +++
>> >  2 files changed, 34 insertions(+)
>> >
>> > diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
>> > index 72f3a89..e52019d 100644
>> > --- a/drivers/mtd/nand/raw/nand_base.c
>> > +++ b/drivers/mtd/nand/raw/nand_base.c
>> > @@ -6249,6 +6249,37 @@ int nand_maximize_ecc(struct nand_chip *chip,
>> >  }
>> >  EXPORT_SYMBOL_GPL(nand_maximize_ecc);
>> >
>> > +/**
>> > + * nand_ecc_choose_conf - Set the ECC strength and ECC step size
>> > + * @chip: nand chip info structure
>> > + * @caps: ECC engine caps info structure
>> > + * @oobavail: OOB size that the ECC engine can use
>> > + *
>> > + * Choose the ECC configuration according to following logic
>> > + *
>> > + * 1. If both ECC step size and ECC strength are already set (usually by DT)
>> > + *    then check if it is supported by this controller.
>> > + * 2. If NAND_ECC_MAXIMIZE is set, then select maximum ECC strength.
>> > + * 3. Otherwise, try to match the ECC step size and ECC strength closest
>> > + *    to the chip's requirement. If available OOB size can't fit the chip
>> > + *    requirement then fallback to the maximum ECC step size and ECC strength.
>> > + *
>> > + * On success, the chosen ECC settings are set.
>> > + */
>> > +int nand_ecc_choose_conf(struct nand_chip *chip,
>> > +                    const struct nand_ecc_caps *caps, int oobavail)
>> > +{
>> > +   if (chip->ecc.size && chip->ecc.strength)
>> > +           return nand_check_ecc_caps(chip, caps, oobavail);
>> > +
>> > +   if (!(chip->ecc.options & NAND_ECC_MAXIMIZE) &&
>> > +       !nand_match_ecc_req(chip, caps, oobavail))
>> > +           return 0;
>> > +
>> > +   return nand_maximize_ecc(chip, caps, oobavail);
>>
>> I personally don't mind if nand_maximize_ecc() is called twice in
>> the function if it clarifies the logic. Maybe the following will be
>> more clear for the user?
>>
>>       if (chip->ecc.size && chip->ecc.strength)
>>               return nand_check_ecc_caps(chip, caps, oobavail);
>>
>>       if (chip->ecc.options & NAND_ECC_MAXIMIZE)
>>               return nand_maximize_ecc(chip, caps, oobavail);
>>
>>       if (!nand_match_ecc_req(chip, caps, oobavail))
>>               return 0;
>>
>>       return nand_maximize_ecc(chip, caps, oobavail);
>
> I personally don't mind, and it seems Masahiro wanted to keep the logic
> he had used in the denali driver.
>
>>
>> Also, I'm not sure we should just error out when nand_check_ecc_caps()
>> fails. What about something more robust, like:
>>
>>       int ret;
>>
>>       if (chip->ecc.size && chip->ecc.strength) {
>>               ret = nand_check_ecc_caps(chip, caps, oobavail);
>>               if (ret)
>>                       goto maximize_ecc;
>
> Nope. When someone asked for a specific ECC config by passing the
> nand-ecc-xxx props we should apply it or return an erro if it's not
> supported. People passing those props should now what the ECC engine
> supports and pick one valid values.
>
>>
>>               return 0;
>>       }
>>
>>       if (chip->ecc.options & NAND_ECC_MAXIMIZE)
>>               goto maximize_ecc;
>>
>>       ret = nand_match_ecc_req(chip, caps, oobavail);
>>       if (ret)
>>               goto maximize_ecc;
>>
>>       return 0;
>>
>> maximize_ecc:
>>       return nand_maximize_ecc(chip, caps, oobavail);
>>
>
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/






This version looks good to me.

If you want to check the error code more precisely,
how about something like follows?



int nand_ecc_choose_conf(struct nand_chip *chip,
                        const struct nand_ecc_caps *caps, int oobavail)
{
       int ret;

       if (chip->ecc.size && chip->ecc.strength)
               return nand_check_ecc_caps(chip, caps, oobavail);

       if (!(chip->ecc.options & NAND_ECC_MAXIMIZE)) {
               ret = nand_match_ecc_req(chip, caps, oobavail);
               if (ret != -ENOTSUPP)
                       return ret;
       }

       return nand_maximize_ecc(chip, caps, oobavail);
}


Only the difference is the case
where nand_match_ecc_req() returns a different error code
than ENOTSUPP.
(Currently, this happens only when insane 'oobavail' is passed.)


ENOTSUPP means 'required ECC setting is not supported'.
Other error code is more significant, so it is not a good reason
to fall back to miximization, IMHO.



-- 
Best Regards
Masahiro Yamada
