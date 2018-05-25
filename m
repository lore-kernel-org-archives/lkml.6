Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965854AbeEYKpz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:45:55 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39982 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965255AbeEYKpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:45:52 -0400
X-Google-Smtp-Source: ADUXVKLnfrOIvTLQHN+DSX5Og369llzG/IJ7HUyymLeI16BeJU3/PynZQI43XNq1vh+q0W4/xibIeAviDdW5fgubvc8=
MIME-Version: 1.0
In-Reply-To: <2c63af8c-4745-a751-8d3d-f7122e921e6f@nvidia.com>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
 <1526639490-12167-10-git-send-email-ulf.hansson@linaro.org>
 <1c21d18e-954a-f3a8-9817-0117b7cb7e4f@nvidia.com> <CAPDyKFozm88OM8cDFXXwvgdMirrt2=HhZtBdyhNjo2bgjHV2Mg@mail.gmail.com>
 <2c63af8c-4745-a751-8d3d-f7122e921e6f@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 25 May 2018 12:45:51 +0200
Message-ID: <CAPDyKFrTtvhxOhf9BPY1=cJ9VQyx9D=P3O0vCV+WXSVR82FozQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] PM / Domains: Add dev_pm_domain_attach_by_id() to
 manage multi PM domains
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Todor Tomov <todor.tomov@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 May 2018 at 10:31, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> On 24/05/18 22:11, Ulf Hansson wrote:
>>
>> On 24 May 2018 at 17:48, Jon Hunter <jonathanh@nvidia.com> wrote:
>>>
>>>
>>> On 18/05/18 11:31, Ulf Hansson wrote:
>>>>
>>>>
>>>> The existing dev_pm_domain_attach() function, allows a single PM domain
>>>> to
>>>> be attached per device. To be able to support devices that are
>>>> partitioned
>>>> across multiple PM domains, let's introduce a new interface,
>>>> dev_pm_domain_attach_by_id().
>>>>
>>>> The dev_pm_domain_attach_by_id() returns a new allocated struct device
>>>> with
>>>> the corresponding attached PM domain. This enables for example a driver
>>>> to
>>>> operate on the new device from a power management point of view. The
>>>> driver
>>>> may then also benefit from using the received device, to set up so
>>>> called
>>>> device-links towards its original device. Depending on the situation,
>>>> these
>>>> links may then be dynamically changed.
>>>>
>>>> The new interface is typically called by drivers during their probe
>>>> phase,
>>>> in case they manages devices which uses multiple PM domains. If that is
>>>> the
>>>> case, the driver also becomes responsible of managing the detaching of
>>>> the
>>>> PM domains, which typically should be done at the remove phase.
>>>> Detaching
>>>> is done by calling the existing dev_pm_domain_detach() function and for
>>>> each of the received devices from dev_pm_domain_attach_by_id().
>>>>
>>>> Note, currently its only genpd that supports multiple PM domains per
>>>> device, but dev_pm_domain_attach_by_id() can easily by extended to cover
>>>> other PM domain types, if/when needed.
>>>>
>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>> ---
>>>>    drivers/base/power/common.c | 33 ++++++++++++++++++++++++++++++++-
>>>>    include/linux/pm_domain.h   |  7 +++++++
>>>>    2 files changed, 39 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
>>>> index 7ae62b6..d3db974 100644
>>>> --- a/drivers/base/power/common.c
>>>> +++ b/drivers/base/power/common.c
>>>> @@ -117,13 +117,44 @@ int dev_pm_domain_attach(struct device *dev, bool
>>>> power_on)
>>>>    EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
>>>>      /**
>>>> + * dev_pm_domain_attach_by_id - Attach a device to one of its PM
>>>> domains.
>>>
>>>
>>>
>>> Isn't this more of a 'get'?
>>
>>
>> I don't think so, at least according to the common understanding of
>> how we use get and put APIs.
>>
>> For example, clk_get() returns a cookie to a clk, which you then can
>> do a hole bunch of different clk specific operations on.
>>
>> This is different, there are no specific PM domain operations the
>> caller can or should do. Instead the idea is to keep drivers more or
>> less transparent, still using runtime PM as before. The only care the
>> caller need to take is to use device links, which BTW isn't a PM
>> domain specific thing.
>
>
> Yes, but a user can still call pm_runtime_get/put with the device returned
> if they wish to, right?

Correct.

[...]

>>>> + */
>>>> +struct device *dev_pm_domain_attach_by_id(struct device *dev,
>>>> +                                         unsigned int index)
>>>> +{
>>>> +       if (dev->pm_domain)
>>>
>>>
>>>
>>> I wonder if this is worthy of a ...
>>>
>>>          if (WARN_ON(dev->pm_domain))
>>>
>>>> +               return NULL;
>>>
>>>
>>>
>>> Don't we consider this an error case? I wonder why not return PTR_ERR
>>> here
>>> as well? This would be consistent with dev_pm_domain_attach().
>>
>>
>> Please see above comment.
>
>
> Right, but this case still seems like an error. My understanding is that
> only drivers will use this API directly and it will not be used by the
> device driver core (unlike dev_pm_domain_attach), so if anyone calls this
> attempting to attach another PM domain when one is already attached, they
> are doing something wrong.

[...]

You may be right!

What I was thinking of is whether multiple PM domains may be optional
in some cases, but instead a PM domain have already been attached by
dev_pm_domain_attach(), prior the driver starts to probe.

Then, assuming we return an error for this case, that means the caller
then need to check the dev->pm_domain pointer, prior calling
dev_pm_domain_attach_by_id(). Wouldn't it? Perhaps that is more clear
though?

Kind regards
Uffe
