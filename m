Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752866AbeEUMON (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:14:13 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33142 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752734AbeEUMOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:14:07 -0400
X-Google-Smtp-Source: AB8JxZo/yxeMk1ZVBoSpB3grY+Gfq8k2qIS0v1eyxVLhAVvRFAmdq21Y+1aCpGiilT1DL+wofQxVxQ==
Subject: Re: [reset-control] How to initialize hardware state with the shared
 reset line?
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        DTML <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <CAK7LNATZgJ4MxOFLUCNARWv3Zz=gpL-jGReDnBnArquiaXRWoQ@mail.gmail.com>
 <CAFBinCADQsXoc6CUKabH6VX3ZBYb5apo-xBbe1w0BiO8wBAsPw@mail.gmail.com>
 <CAK7LNAR1b_F_eLEWAdQc3L=daGz=ttKq0mQP78BkjzTOssaXvw@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <ff14975f-92af-5e84-16cf-231b070fff9e@redhat.com>
Date: Mon, 21 May 2018 14:14:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAR1b_F_eLEWAdQc3L=daGz=ttKq0mQP78BkjzTOssaXvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21-05-18 03:27, Masahiro Yamada wrote:
> Hi.
> 
> 
> 2018-05-20 19:57 GMT+09:00 Martin Blumenstingl
> <martin.blumenstingl@googlemail.com>:
>> Hi,
>>
>> On Thu, May 10, 2018 at 11:16 AM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>> [snip]
>>> I may be missing something, but
>>> one solution might be reset hogging on the
>>> reset provider side.  This allows us to describe
>>> the initial state of reset lines in the reset controller.
>>>
>>> The idea for "reset-hog" is similar to:
>>>   - "gpio-hog" defined in
>>>     Documentation/devicetree/bindings/gpio/gpio.txt
>>>   - "assigned-clocks" defined in
>>>     Documetation/devicetree/bindings/clock/clock-bindings.txt
>>>
>>>
>>>
>>> For example,
>>>
>>>     reset-controller {
>>>              ....
>>>
>>>              line_a {
>>>                    reset-hog;
>>>                    resets = <1>;
>>>                    reset-assert;
>>>              };
>>>     }
>>>
>>>
>>> When the reset controller is registered,
>>> the reset ID '1' is asserted.
>>>
>>>
>>> So, all reset consumers that share the reset line '1'
>>> will start from the asserted state
>>> (i.e. defined state machine state).
>> I wonder if a "reset hog" can be board specific:
>> - GPIO hogs are definitely board specific (meson-gxbb-odroidc2.dts for
>> example uses it to take the USB hub out of reset)
>> - assigned-clock-parents (and the like) can also be board specific (I
>> made up a use-case since I don't know of any actual examples: board A
>> uses an external XTAL while board B uses some other internal
>> clock-source because it doesn't have an external XTAL)
>>
>> however, can reset lines be board specific? or in other words: do we
>> need to describe them in device-tree?
> 
> Indeed.
> 
> I did not come up with board-specific cases.
> 
> The problem we are discussing is SoC-specific,
> and reset-controller drivers are definitely SoC-specific.
> 
> So, I think the initial state can be coded in drivers instead of DT.
> 
> 
>> we could extend struct reset_controller_dev (= reset controller
>> driver) if they are not board specific:
>> - either assert all reset lines by default except if they are listed
>> in a new field (may break backwards compatibility, requires testing of
>> all reset controller drivers)
> 
> This is quite simple, but I am afraid there are some cases where the forcible
> reset-assert is not preferred.
> 
> For example, the earlycon.  When we use earlycon, we would expect it has been
> initialized by a boot-loader, or something.
> If it is reset-asserted on the while, the console output
> will not be good.
> 
> 
> 
>> - specify a list of reset lines and their desired state (or to keep it
>> easy: specify a list of reset lines that should be asserted)
>> (I must admit that this is basically your idea but the definition is
>> moved from device-tree to the reset controller driver)
> 
> Yes, I think the list of "reset line ID" and "init state" pairs
> would be nicer.
> 
> 
>> any "chip" specific differences could be expressed by using a
>> different of_device_id
>>
>> one the other hand: your "reset hog" solution looks fine to me if
>> reset lines can be board specific
>>
>>>  From the discussion with Martin Blumenstingl
>>> (https://lkml.org/lkml/2018/4/28/115),
>>> the problem for Amlogic is that
>>> the reset line is "de-asserted" by default.
>>> If so, the 'reset-hog' would fix the problem,
>>> and DWC3 driver would be able to use
>>> shared, level reset, I think.
>> I think you are right: if we could control the initial state then we
>> should be able to use level resets
> 
> 
> Even further, can we drop the shared reset_control_reset() support, maybe?
> (in other words, revert commit 7da33a37b48f11)

At least one some Allwinner ships shared-reset support accurately
models how the hardware works. It seems that the case you are
trying to fix is actually a special version of shared reset support,
you want shared reset behavior, combined with making sure the reset
is asserted at reset-controller-driver load time.

Regards,

Hans
