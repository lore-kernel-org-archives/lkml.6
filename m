Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967482AbeEYRfZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 13:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967305AbeEYRfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 13:35:23 -0400
X-Google-Smtp-Source: ADUXVKLNHdStzNZVkvCqFnAK2CVLg7iswsjSXDdLhJR+efaUrKan6rQnpR287Ana8XpVAtJ8BFMPj3td4BWpvmrRtFY=
MIME-Version: 1.0
In-Reply-To: <92e3be10-e65a-99e9-6ef7-f11ded6a35f9@arm.com>
References: <20180524175024.19874-1-robh@kernel.org> <20180524175024.19874-2-robh@kernel.org>
 <20180524190031.GB31019@kroah.com> <CAL_JsqJK69A3W=YrSfvPetM95CROOJhU1bW1rMEOGtji=t0ORQ@mail.gmail.com>
 <92e3be10-e65a-99e9-6ef7-f11ded6a35f9@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 25 May 2018 12:35:00 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKXyBZjpz3dvR+7Hign7Z3iwnvKWrAUdoPDWWBgjWmQLg@mail.gmail.com>
Message-ID: <CAL_JsqKXyBZjpz3dvR+7Hign7Z3iwnvKWrAUdoPDWWBgjWmQLg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] driver core: make deferring probe after init optional
To: Robin Murphy <robin.murphy@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Joerg Roedel <joro@8bytes.org>,
        Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Architecture Mailman List <boot-architecture@lists.linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 7:20 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 24/05/18 21:57, Rob Herring wrote:
>>
>> On Thu, May 24, 2018 at 2:00 PM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>>
>>> On Thu, May 24, 2018 at 12:50:17PM -0500, Rob Herring wrote:
>>>>
>>>> Deferred probe will currently wait forever on dependent devices to
>>>> probe,
>>>> but sometimes a driver will never exist. It's also not always critical
>>>> for
>>>> a driver to exist. Platforms can rely on default configuration from the
>>>> bootloader or reset defaults for things such as pinctrl and power
>>>> domains.
>>>> This is often the case with initial platform support until various
>>>> drivers
>>>> get enabled. There's at least 2 scenarios where deferred probe can
>>>> render
>>>> a platform broken. Both involve using a DT which has more devices and
>>>> dependencies than the kernel supports. The 1st case is a driver may be
>>>> disabled in the kernel config. The 2nd case is the kernel version may
>>>> simply not have the dependent driver. This can happen if using a newer
>>>> DT
>>>> (provided by firmware perhaps) with a stable kernel version.
>>>>
>>>> Subsystems or drivers may opt-in to this behavior by calling
>>>> driver_deferred_probe_check_init_done() instead of just returning
>>>> -EPROBE_DEFER. They may use additional information from DT or kernel's
>>>> config to decide whether to continue to defer probe or not.
>>>>
>>>> Cc: Alexander Graf <agraf@suse.de>
>>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>>> ---
>>>>   drivers/base/dd.c      | 17 +++++++++++++++++
>>>>   include/linux/device.h |  2 ++
>>>>   2 files changed, 19 insertions(+)
>>>>
>>>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>>>> index c9f54089429b..d6034718da6f 100644
>>>> --- a/drivers/base/dd.c
>>>> +++ b/drivers/base/dd.c
>>>> @@ -226,6 +226,16 @@ void device_unblock_probing(void)
>>>>        driver_deferred_probe_trigger();
>>>>   }
>>>>
>>>> +int driver_deferred_probe_check_init_done(struct device *dev, bool
>>>> optional)
>>>> +{
>>>> +     if (optional && initcalls_done) {
>>>
>>>
>>> Wait, what's the "optional" mess here?
>>
>>
>> My intent was that subsystems just always call this function and never
>> return EPROBE_DEFER themselves. Then the driver core can make
>> decisions as to what to do (such as the timeout added in the next
>> patch). Or it can print common error/debug messages. So optional is a
>> hint to allow subsystems per device control.
>
>
> Maybe just driver_defer_probe() might be a more descriptive name? To me,
> calling "foo_check_x()" with a parameter that says "I don't actually care
> about x" is the really unintuitive bit.

All the other (though static or internal to driver core) functions are
prefixed driver_deferred_probe_* so I was trying to remain consistent
there. You're right though, with the timeout it's not just whether
initcalls are done. It's really "get the return value depending on the
core's deferred probe state". So perhaps one of these:

driver_deferred_probe_get_return_val()
driver_deferred_probe_handle_return()

The other option would be a more straight-forward functions that just
returns a bool on whether to continue deferring and leave the return
code handling to the caller:

if (driver_deferred_probe_enabled_for_builtin(dev))
  return -EPROBE_DEFER;
else
  return -ENODEV;

The pinctrl case would look like this:

builtin_only = of_property_read_bool(np_pctldev, "pinctrl-use-default");
if (builtin_only && driver_deferred_probe_enabled_for_builtin(dev))
  return -EPROBE_DEFER;
else if (!builtin_only && driver_deferred_probe_enabled(dev))
  return -EPROBE_DEFER;
else
  return -ENODEV;

I still prefer the former, picking the bike shed color is easier with
the latter.

>>>
>>> The caller knows this value, so why do you need to even pass it in here?
>>
>>
>> Because regardless of the value, we always stop deferring when/if we
>> hit the timeout and the caller doesn't know about the timeout. If we
>> get rid of it, we'd need functions for both init done and for deferred
>> timeout.
>>
>>> And bool values that are not obvious are horrid.  I had to go look this
>>> up when reading the later patches that just passed "true" in this
>>> variable as I had no idea what that meant.
>>
>>
>> Perhaps inverting it and calling it "keep_deferring" would be better.
>> However, the flag is ignored if we have timed out.
>
>
> Perhaps an enum (or bitmask of named flags) then? That would allow the most
> readability at callsites, plus it seems quite likely that we may want
> intermediate degrees of "deferral strictness" eventually.

A bitmask is just 32 booleans stuffed into one parameter which I can
guess Greg's opinion on.

I can't really think of other flags we might need here. If we added
some userspace trigger saying module loading is done, I don't think
we'd need that to be per caller.

Rob
