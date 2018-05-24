Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968699AbeEXUKF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:10:05 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:43024 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967240AbeEXUKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:10:00 -0400
X-Google-Smtp-Source: AB8JxZppYB5WvPmjoBlPe5w3reSwKPurpE2rnJeeI9dZcHmrzOAI86e7MpNdKPRN7LDWTQKmHGCJEiFGcvNXgZdEb8I=
MIME-Version: 1.0
In-Reply-To: <1526997879.3671.27.camel@pengutronix.de>
References: <CAK7LNATZgJ4MxOFLUCNARWv3Zz=gpL-jGReDnBnArquiaXRWoQ@mail.gmail.com>
 <CAFBinCADQsXoc6CUKabH6VX3ZBYb5apo-xBbe1w0BiO8wBAsPw@mail.gmail.com>
 <CAK7LNAR1b_F_eLEWAdQc3L=daGz=ttKq0mQP78BkjzTOssaXvw@mail.gmail.com>
 <CAFBinCBTTmPqD0UP8zzMBjsjzP9fJx9_pmhGz0_Vy-V+wmhLXQ@mail.gmail.com> <1526997879.3671.27.camel@pengutronix.de>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Thu, 24 May 2018 22:09:38 +0200
Message-ID: <CAFBinCBAoRebScz+DTSKSgiU5DjeSHS1F3=2vt8KM-yCv+2A8g@mail.gmail.com>
Subject: Re: [reset-control] How to initialize hardware state with the shared
 reset line?
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        DTML <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On Tue, May 22, 2018 at 4:04 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Hi Martin,
>
> On Mon, 2018-05-21 at 12:40 +0200, Martin Blumenstingl wrote:
>> Hello,
>>
>> On Mon, May 21, 2018 at 3:27 AM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>> > Hi.
>> >
>> >
>> > 2018-05-20 19:57 GMT+09:00 Martin Blumenstingl
>> > <martin.blumenstingl@googlemail.com>:
>> > > Hi,
>> > >
>> > > On Thu, May 10, 2018 at 11:16 AM, Masahiro Yamada
>> > > <yamada.masahiro@socionext.com> wrote:
>> > > [snip]
>> > > > I may be missing something, but
>> > > > one solution might be reset hogging on the
>> > > > reset provider side.  This allows us to describe
>> > > > the initial state of reset lines in the reset controller.
>> > > >
>> > > > The idea for "reset-hog" is similar to:
>> > > >  - "gpio-hog" defined in
>> > > >    Documentation/devicetree/bindings/gpio/gpio.txt
>> > > >  - "assigned-clocks" defined in
>> > > >    Documetation/devicetree/bindings/clock/clock-bindings.txt
>> > > >
>> > > >
>> > > >
>> > > > For example,
>> > > >
>> > > >    reset-controller {
>> > > >             ....
>> > > >
>> > > >             line_a {
>> > > >                   reset-hog;
>> > > >                   resets = <1>;
>> > > >                   reset-assert;
>> > > >             };
>> > > >    }
>> > > >
>> > > >
>> > > > When the reset controller is registered,
>> > > > the reset ID '1' is asserted.
>> > > >
>> > > >
>> > > > So, all reset consumers that share the reset line '1'
>> > > > will start from the asserted state
>> > > > (i.e. defined state machine state).
>> > >
>> > > I wonder if a "reset hog" can be board specific:
>> > > - GPIO hogs are definitely board specific (meson-gxbb-odroidc2.dts for
>> > > example uses it to take the USB hub out of reset)
>> > > - assigned-clock-parents (and the like) can also be board specific (I
>> > > made up a use-case since I don't know of any actual examples: board A
>> > > uses an external XTAL while board B uses some other internal
>> > > clock-source because it doesn't have an external XTAL)
>> > >
>> > > however, can reset lines be board specific? or in other words: do we
>> > > need to describe them in device-tree?
>> >
>> > Indeed.
>> >
>> > I did not come up with board-specific cases.
>> >
>> > The problem we are discussing is SoC-specific,
>> > and reset-controller drivers are definitely SoC-specific.
>> >
>> > So, I think the initial state can be coded in drivers instead of DT.
>>
>> OK, let's also hear Philipp's (reset framework maintainer) opinion on this
>
> I'd like to know if there are other SoC families besides Amlogic Meson
> that potentially could have this problem and about how many of the
> resets that are documented in include/dt-bindings/reset/amlogic,meson*
> we are actually talking. Are all of those initially deasserted and none
> of the connected peripherals have power-on reset mechanisms?
I cannot speak for other SoC families besides Amlogic
Meson8/Meson8b/Meson8m2 and GX (disclaimer: I am a community
contributor, I don't have access to Amlogic's internal datasheets - my
knowledge is based on their public datasheets, their GPL kernel/u-boot
sources and trial and error)

it seems that at least "some" (but I don't know the exact number)
resets are de-asserted by the bootloader
Amlogic's u-boot for example also enables all gate clocks by default

I CC'ed the Amlogic mailing list because I'm not sure if everyone
working on that SoC family is watching the linux-arm-kernel mailing
list

>> > > we could extend struct reset_controller_dev (= reset controller
>> > > driver) if they are not board specific:
>> > > - either assert all reset lines by default except if they are listed
>> > > in a new field (may break backwards compatibility, requires testing of
>> > > all reset controller drivers)
>> >
>> > This is quite simple, but I am afraid there are some cases where the forcible
>> > reset-assert is not preferred.
>> >
>> > For example, the earlycon.  When we use earlycon, we would expect it has been
>> > initialized by a boot-loader, or something.
>> > If it is reset-asserted on the while, the console output
>> > will not be good.
>>
>> indeed, so let's skip this idea
>
> Maybe we should at first add initial reset assertion to the Meson driver
> on a case by case bases?
this seems simple enough to test it - we can still generalize this
later on (either by adding support to the reset framework, DT bindings
or something else)

> We can't add required reset hog DT bindings to the Meson reset
> controller anyway without breaking DT backwards compatibility.
>
>> > > - specify a list of reset lines and their desired state (or to keep it
>> > > easy: specify a list of reset lines that should be asserted)
>> > > (I must admit that this is basically your idea but the definition is
>> > > moved from device-tree to the reset controller driver)
>> >
>> > Yes, I think the list of "reset line ID" and "init state" pairs
>> > would be nicer.
>>
>> $ grep -R "of_reset_n_cells = [^1]" drivers/reset/
>> drivers/reset/reset-berlin.c:   priv->rcdev.of_reset_n_cells = 2;
>> drivers/reset/hisilicon/reset-hi3660.c: rc->rst.of_reset_n_cells = 2;
>> drivers/reset/reset-ti-sci.c:   data->rcdev.of_reset_n_cells = 2;
>> drivers/reset/reset-lantiq.c:   priv->rcdev.of_reset_n_cells = 2;
>>
>> everything else uses only one reset cell
>> from the lantiq reset dt-binding documentation: "The first cell takes
>> the reset set bit and the second cell takes the status bit."
>>
>> I'm not sure what to do with drivers that specify != 1 reset-cell
>> though if we use a simple "init state pair"
>> maybe Philipp can share his opinion on this one as well
>
> See above, so far I am not convinced (either way) whether this should be
> described in the DT at all.
>
>> > > any "chip" specific differences could be expressed by using a
>> > > different of_device_id
>> > >
>> > > one the other hand: your "reset hog" solution looks fine to me if
>> > > reset lines can be board specific
>> > >
>> > > > From the discussion with Martin Blumenstingl
>> > > > (https://lkml.org/lkml/2018/4/28/115),
>> > > > the problem for Amlogic is that
>> > > > the reset line is "de-asserted" by default.
>> > > > If so, the 'reset-hog' would fix the problem,
>> > > > and DWC3 driver would be able to use
>> > > > shared, level reset, I think.
>> > >
>> > > I think you are right: if we could control the initial state then we
>> > > should be able to use level resets
>> >
>> >
>> > Even further, can we drop the shared reset_control_reset() support, maybe?
>> > (in other words, revert commit 7da33a37b48f11)
>>
>> I believe we need to keep this if there's hardware out there:
>> - where the reset controller only supports reset pulses
>> - at least one reset line is shared between multiple devices
>>
>> I didn't have a closer look at the Amlogic Meson6 SoC yet, but I think
>> it matches above criteria. as far as I know:
>> - the USB situation there is similar to Meson8b (USB controllers and
>> PHYs share a reset line)
>> - it uses an older reset controller IP block which does not support
>> level resets (only reset pulses)
>
> See my answer to Masahiro's first mail. I think somebody suggested in
> the past to add a fallback from the deassert to the reset op. I think
> this is something that should work in this case.
this is an interesting idea - it should work for Meson6 (in case
mainline ever gains support for this old SoC)


Regards
Martin
