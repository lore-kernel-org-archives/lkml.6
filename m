Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966661AbeEYMU0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:20:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60988 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966464AbeEYMUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:20:24 -0400
Subject: Re: [PATCH v2 1/8] driver core: make deferring probe after init
 optional
To: Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
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
References: <20180524175024.19874-1-robh@kernel.org>
 <20180524175024.19874-2-robh@kernel.org> <20180524190031.GB31019@kroah.com>
 <CAL_JsqJK69A3W=YrSfvPetM95CROOJhU1bW1rMEOGtji=t0ORQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <92e3be10-e65a-99e9-6ef7-f11ded6a35f9@arm.com>
Date: Fri, 25 May 2018 13:20:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJK69A3W=YrSfvPetM95CROOJhU1bW1rMEOGtji=t0ORQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/18 21:57, Rob Herring wrote:
> On Thu, May 24, 2018 at 2:00 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Thu, May 24, 2018 at 12:50:17PM -0500, Rob Herring wrote:
>>> Deferred probe will currently wait forever on dependent devices to probe,
>>> but sometimes a driver will never exist. It's also not always critical for
>>> a driver to exist. Platforms can rely on default configuration from the
>>> bootloader or reset defaults for things such as pinctrl and power domains.
>>> This is often the case with initial platform support until various drivers
>>> get enabled. There's at least 2 scenarios where deferred probe can render
>>> a platform broken. Both involve using a DT which has more devices and
>>> dependencies than the kernel supports. The 1st case is a driver may be
>>> disabled in the kernel config. The 2nd case is the kernel version may
>>> simply not have the dependent driver. This can happen if using a newer DT
>>> (provided by firmware perhaps) with a stable kernel version.
>>>
>>> Subsystems or drivers may opt-in to this behavior by calling
>>> driver_deferred_probe_check_init_done() instead of just returning
>>> -EPROBE_DEFER. They may use additional information from DT or kernel's
>>> config to decide whether to continue to defer probe or not.
>>>
>>> Cc: Alexander Graf <agraf@suse.de>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> ---
>>>   drivers/base/dd.c      | 17 +++++++++++++++++
>>>   include/linux/device.h |  2 ++
>>>   2 files changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>>> index c9f54089429b..d6034718da6f 100644
>>> --- a/drivers/base/dd.c
>>> +++ b/drivers/base/dd.c
>>> @@ -226,6 +226,16 @@ void device_unblock_probing(void)
>>>        driver_deferred_probe_trigger();
>>>   }
>>>
>>> +int driver_deferred_probe_check_init_done(struct device *dev, bool optional)
>>> +{
>>> +     if (optional && initcalls_done) {
>>
>> Wait, what's the "optional" mess here?
> 
> My intent was that subsystems just always call this function and never
> return EPROBE_DEFER themselves. Then the driver core can make
> decisions as to what to do (such as the timeout added in the next
> patch). Or it can print common error/debug messages. So optional is a
> hint to allow subsystems per device control.

Maybe just driver_defer_probe() might be a more descriptive name? To me, 
calling "foo_check_x()" with a parameter that says "I don't actually 
care about x" is the really unintuitive bit.

>>
>> The caller knows this value, so why do you need to even pass it in here?
> 
> Because regardless of the value, we always stop deferring when/if we
> hit the timeout and the caller doesn't know about the timeout. If we
> get rid of it, we'd need functions for both init done and for deferred
> timeout.
> 
>> And bool values that are not obvious are horrid.  I had to go look this
>> up when reading the later patches that just passed "true" in this
>> variable as I had no idea what that meant.
> 
> Perhaps inverting it and calling it "keep_deferring" would be better.
> However, the flag is ignored if we have timed out.

Perhaps an enum (or bitmask of named flags) then? That would allow the 
most readability at callsites, plus it seems quite likely that we may 
want intermediate degrees of "deferral strictness" eventually.

Robin.

>>
>> So as-is, no, this isn't ok, sorry.
>>
>> And at the least, this needs some kerneldoc to explain it :)
> 
> That part is easy enough to fix.
> 
> Rob
> 
