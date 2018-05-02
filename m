Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751045AbeEBKpk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 06:45:40 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33485 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbeEBKpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 06:45:39 -0400
X-Google-Smtp-Source: AB8JxZpd4A1L3ryTVPAfnWFTPyUxm1Gx5tiqylSLM3KtNYnD5ENO7Ez2g99fAIh1laqRm9fA5jpFwy+w62X8ryTnMN8=
MIME-Version: 1.0
In-Reply-To: <447b4f2f-27c8-f552-d058-3b2eba71a765@ti.com>
References: <20180430082453.8091-1-brgl@bgdev.pl> <20180430082453.8091-2-brgl@bgdev.pl>
 <3dccc5af-2df1-8374-e4e8-0a8b9ea1ae99@ti.com> <8b7e4588-5a35-6c18-fe60-148d6ccf778c@ti.com>
 <447b4f2f-27c8-f552-d058-3b2eba71a765@ti.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 2 May 2018 12:45:38 +0200
Message-ID: <CAMRc=Md4_QvyMP_vwwD8qpONr3SmWoxn+BJDd1OBHdR6rCLoWg@mail.gmail.com>
Subject: Re: [PATCH 01/12] mtd: nand: davinci: store the core chipselect
 number in platform data
To: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>, Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-01 12:29 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
> On Tuesday 01 May 2018 03:23 PM, Sekhar Nori wrote:
>> On Tuesday 01 May 2018 02:55 PM, Sekhar Nori wrote:
>>> On Monday 30 April 2018 01:54 PM, Bartosz Golaszewski wrote:
>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>
>>>> We have the 'ti,davinci-chipselect' property in the device tree, but
>>>> when using platform data the driver silently uses the id field of
>>>> struct platform_device as the chipselect. This is confusing and we
>>>> almost broke the nand support again recently after converting the
>>>> platform to common clock framework (which changed the device id in the
>>>> clock lookup - the problem is gone now that we no longer acquire the
>>>> clock in the nand driver.
>>>>
>>>> This patch adds a new filed - core_chipsel - to the platform_data.
>>>
>>> s/filed/field
>>>
>>>> Subsequent patches will convert the platforms to using this new field.
>>>
>>> Can you add a comment for this new field too, like how we have for most
>>> other fields?
>>>
>>> Curious on what 'core' in core_chipsel means. Something to do with
>>> chip-select offset we have on DA850?
>>
>> Looks like you may have just picked the terminology from DaVinci NAND
>> driver (introduced back in 2009). But in this context, it means the
>> 0-indexed chip-select number that of the asynchronous memory interface
>> to which the NAND device is connected.
>>
>> So, may be a comment here will suffice.
>
> This is what I committed:
>

I don't see it in your tree yet.

> --8<--
> commit 533d93703fa717fdf74c4fb711c868c4fdc8b475 (HEAD -> refs/heads/v4.18/nand-cs-simplification)
> Author:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
> AuthorDate: Mon Apr 30 10:24:42 2018 +0200
> Commit:     Sekhar Nori <nsekhar@ti.com>
> CommitDate: Tue May 1 15:57:47 2018 +0530
>
>     mtd: nand: davinci: store the core chipselect number in platform data
>
>     We have the 'ti,davinci-chipselect' property in the device tree, but
>     when using platform data the driver silently uses the id field of
>     struct platform_device as the chipselect. This is confusing and we
>     almost broke the nand support again recently after converting the
>     platform to common clock framework (which changed the device id in the
>     clock lookup - the problem is gone now that we no longer acquire the
>     clock in the nand driver.
>
>     This patch adds a new field - core_chipsel - to the platform_data.
>     Subsequent patches will convert the platforms to using this new field.
>
>     Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>     Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>
> diff --git a/include/linux/platform_data/mtd-davinci.h b/include/linux/platform_data/mtd-davinci.h
> index f1a2cf655bdb..1bbfa27cccb4 100644
> --- a/include/linux/platform_data/mtd-davinci.h
> +++ b/include/linux/platform_data/mtd-davinci.h
> @@ -56,6 +56,16 @@ struct davinci_nand_pdata {          /* platform_data */
>         uint32_t                mask_ale;
>         uint32_t                mask_cle;
>
> +       /*
> +        * 0-indexed chip-select number of the asynchronous
> +        * interface to which the NAND device has been connected.
> +        *
> +        * So, if you have NAND connected to CS3 of DA850, you
> +        * will pass '1' here. Since the asynchronous interface
> +        * on DA850 starts from CS2.
> +        */

Maybe we should add that on all other DaVinci SoCs the async interface
starts from CS0?

> +       uint32_t                core_chipsel;
> +
>         /* for packages using two chipselects */
>         uint32_t                mask_chipsel;
>
>

Thanks,
Bart
