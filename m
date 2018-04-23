Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754669AbeDWKYn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:24:43 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:39393 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754591AbeDWKYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:24:39 -0400
X-Google-Smtp-Source: AIpwx4/inmLJ/QTy5E7BF4q5DUOyLIuV2ClSbrUdWikrC6KfTjm84VxjkcV8FkSArH13BUC82Evh2pfqa4rc+rHsKkg=
MIME-Version: 1.0
In-Reply-To: <20180423113619.6f557d8e@jawa>
References: <20180422213126.32756-1-lukma@denx.de> <CAPDyKFqaV0ehiHCNdt0i4sWE9cskBa9AQHdRZmzCphPzCdm9ow@mail.gmail.com>
 <20180423113619.6f557d8e@jawa>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Apr 2018 12:24:38 +0200
Message-ID: <CAPDyKFrhzVcST2SYjJaLb1vLTG3Rv+X7tmh7E-78A8xTYQyXOg@mail.gmail.com>
Subject: Re: [PATCH] mmc: disable card sleep via device-tree
To: Lukasz Majewski <lukma@denx.de>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Chanho Min <chanho.min@lge.com>, devicetree@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Stanislav Meduna <stanislav.meduna@nxtcontrol.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 April 2018 at 11:36, Lukasz Majewski <lukma@denx.de> wrote:
> Hi Ulf,
>
>> On 22 April 2018 at 23:31, Lukasz Majewski <lukma@denx.de> wrote:
>> > From: Stanislav Meduna <stanislav.meduna@nxtcontrol.com>
>> >
>> > On a TQMa53 module the mmc_sleep leaves the eMMC card in a state
>> > that the imx53 rom boot code is unable to probe, resulting in
>> > reboot hanging. Add a device tree property to disable sleeping
>> > on suspend.
>> >
>> > For TQMa53 modules the exact commit to cause hang after reboot
>> > (v3.10 -> v3.11):
>> > commit 486fdbbc1483 ("mmc: core: Add shutdown callback for (e)MMC
>> > bus_ops")
>> >
>> > [The exact discussion can be found here:
>> > https://patchwork.kernel.org/patch/8881401/
>> > "i.MX53 restart via watchdog does not work"
>> >
>> > Signed-off-by: Stanislav Meduna <stanislav.meduna@nxtcontrol.com>
>> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
>> > ---
>> >  Documentation/devicetree/bindings/mmc/mmc-card.txt | 4 ++++
>> >  drivers/mmc/core/mmc.c                             | 7 +++++--
>> >  include/linux/mmc/card.h                           | 2 +-
>> >  3 files changed, 10 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.txt
>> > b/Documentation/devicetree/bindings/mmc/mmc-card.txt index
>> > 8d2d71758907..c3ee151edd7c 100644 ---
>> > a/Documentation/devicetree/bindings/mmc/mmc-card.txt +++
>> > b/Documentation/devicetree/bindings/mmc/mmc-card.txt @@ -12,6 +12,9
>> > @@ Required properties: Optional properties:
>> >  -broken-hpi : Use this to indicate that the mmc-card has a broken
>> > hpi implementation, and that hpi should not be used
>> > +-no-sleep-on-suspend : Do not put the card to sleep when
>> > suspending.
>> > +              There are boards with bootloaders that are unable
>> > +              to probe such card when rebooting.
>> >
>> >  Example:
>> >
>> > @@ -26,5 +29,6 @@ Example:
>> >                 reg = <0>;
>> >                 compatible = "mmc-card";
>> >                 broken-hpi;
>> > +               no-sleep-on-suspend;
>> >         };
>> >  };
>> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> > index 208a762b87ef..a3b74b5c8893 100644
>> > --- a/drivers/mmc/core/mmc.c
>> > +++ b/drivers/mmc/core/mmc.c
>> > @@ -381,8 +381,11 @@ static int mmc_decode_ext_csd(struct mmc_card
>> > *card, u8 *ext_csd) }
>> >
>> >         np = mmc_of_find_child_device(card->host, 0);
>> > -       if (np && of_device_is_compatible(np, "mmc-card"))
>> > +       if (np && of_device_is_compatible(np, "mmc-card")) {
>> >                 broken_hpi = of_property_read_bool(np,
>> > "broken-hpi");
>> > +               card->no_sleep_on_suspend =
>> > +                       of_property_read_bool(np,
>> > "no-sleep-on-suspend");
>> > +       }
>> >         of_node_put(np);
>> >
>> >         /*
>> > @@ -1990,7 +1993,7 @@ static int _mmc_suspend(struct mmc_host
>> > *host, bool is_suspend) if (mmc_can_poweroff_notify(host->card) &&
>> >                 ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE)
>> > || !is_suspend)) err = mmc_poweroff_notify(host->card, notify_type);
>> > -       else if (mmc_can_sleep(host->card))
>> > +       else if (mmc_can_sleep(host->card)
>> > && !host->card->no_sleep_on_suspend)
>>
>> No, this is wrong.
>>
>> This means that the mmc_power_off() a few lines below would start to
>> violate the eMMC spec.
>> That via powering off the card, without first
>> sending the sleep or power-off-notify command.
>> You are probably just lucky, as your particular eMMC card still copes
>> with this in-correct sequence (I know there are these kind of cards).
>>
>> Well, what is also interesting in this regards, is what is happening
>> during mmc_power_off().
>
> The mmc_power_off() -> mmc_pwrseq_power_off() -> here the *pwrseq is
> null, so we do nothing with the power.
>
> In mmc_power_off() function we call mmc_set_initial_state(host);
>
>> Does your host driver cut power to VMMC and/or
>> VQMMC?
>
> The esdhci3 controller uses 'vmm-supply' which is a 'regulator-fixed'
> with 'regulator-always-on' attribute.

Assume you mean vmmc-supply.

Anyway, it seems a bit weird to have this regulator as fixed and
always on. Of course it's possible, but it's more common to have vqmmc
fixed and always on. Maybe double check the schematics.

>
> It seems like the eMMC is always powered with 3.3V.

What about vqmmc then?

>
> Considering the above it seems like the card is still powered - the HW
> design also supports some backup powering (so the voltage from the
> board is not took immediately).

I think you need to verify that the CMD5 (sleep) is actually sent and
successfully completed.

In regards to that, do your host support MMC_CAP_WAIT_WHILE_BUSY? If
not, there is a delay (specific to the card) after the CMD5.

So the support in your host driver for MMC_CAP_WAIT_WHILE_BUSY could
be broken, or the delay may be too short. Perhaps forcing to use the
delay and use a delay that for sure should work is worth to test.

>
>
> To be even more strange the suspend to mem works without any issues
> (without this patch).
> With "reboot -f" it seems like we hang in imx53 BootROM (as I can read
> it from my JTAG debugger).

So clearly there is a difference during reboot.

A wild guess... Probably vmmc supply is turned on/off in this path,
while perhaps the CMD5 support has failed when the kernel issued it...

>
> As written in the commit message - problems started after sending
> suspend sequence of eMMC commands to the eMMC device.
>
>
> [The eMMC memory itself is Micron 4GiB - 4.4.1]

[...]

Kind regards
Uffe
