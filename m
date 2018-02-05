Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753135AbeBEOEJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 09:04:09 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:39375 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbeBEOEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 09:04:01 -0500
X-Google-Smtp-Source: AH8x2274Trj1K5S5YB4Tw9wikcKblSIjLlaGrO5gFDTS7Tzl3ZeGD/YE86RtH2rV0S4MaA1NY/80RTXada+ydgY6t/o=
MIME-Version: 1.0
In-Reply-To: <335d92c8-1af2-da64-e366-95d7513ad69d@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-41-git-send-email-david@lechnology.com> <335d92c8-1af2-da64-e366-95d7513ad69d@lechnology.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 5 Feb 2018 15:04:00 +0100
Message-ID: <CAMRc=McJsneYdh8zDmYcUsFLiAyOmSeyOKhKfim4or7LwyEH1w@mail.gmail.com>
Subject: Re: [PATCH v6 40/41] ARM: da8xx-dt: switch to device tree clocks
To: David Lechner <david@lechnology.com>
Cc: linux-clk@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-01-24 4:26 GMT+01:00 David Lechner <david@lechnology.com>:
> On 01/20/2018 11:14 AM, David Lechner wrote:
>>
>> This removes all of the clock init code from da8xx-dt.c. This includes
>> all of the OF_DEV_AUXDATA that was just used for looking up clocks.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>
>> v6 changes:
>> - removed misleading statement from commit message
>>
>>   arch/arm/mach-davinci/da8xx-dt.c | 61
>> +---------------------------------------
>>   1 file changed, 1 insertion(+), 60 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/da8xx-dt.c
>> b/arch/arm/mach-davinci/da8xx-dt.c
>
>
>>   static void __init da850_init_machine(void)
>>   {
>> -       /* All existing boards use 100MHz SATA refclkpn */
>> -       static const unsigned long sata_refclkpn = 100 * 1000 * 1000;
>> -
>> -       int ret;
>> -
>> -       ret = da8xx_register_usb20_phy_clk(false);
>> -       if (ret)
>> -               pr_warn("%s: registering USB 2.0 PHY clock failed: %d",
>> -                       __func__, ret);
>> -       ret = da8xx_register_usb11_phy_clk(false);
>> -       if (ret)
>> -               pr_warn("%s: registering USB 1.1 PHY clock failed: %d",
>> -                       __func__, ret);
>> -
>> -       ret = da850_register_sata_refclk(sata_refclkpn);
>> -       if (ret)
>> -               pr_warn("%s: registering SATA REFCLK failed: %d",
>> -                       __func__, ret);
>> -
>> -       of_platform_default_populate(NULL, da850_auxdata_lookup, NULL);
>> +       of_platform_default_populate(NULL, NULL, NULL);
>
>
> of_platform_default_populate() can actually be removed completely.
> of_platform_default_populate_init() is called implicitly during
> arch_initcall_sync
>
>>         davinci_pm_init();
>>         pdata_quirks_init();
>>   }

Hi David,

this patch breaks nand on da850-lcdk (and probably on da850-evm) since
the nand driver can no longer clk_get() the nand clock. We would need
to keep the dev_auxdata at least for aemif.

Thanks,
Bartosz
