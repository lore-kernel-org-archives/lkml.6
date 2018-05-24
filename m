Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971553AbeEXVLv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 17:11:51 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37721 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967133AbeEXVLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 17:11:46 -0400
X-Google-Smtp-Source: AB8JxZpGUuGwJgCCnJerdWTKC1Warq8lGqhK88BxDJsQGcYTLp1qfMi7om8y1N5BbCKrcNWZw/iGQr30wS20sWjAgaA=
MIME-Version: 1.0
In-Reply-To: <1c21d18e-954a-f3a8-9817-0117b7cb7e4f@nvidia.com>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
 <1526639490-12167-10-git-send-email-ulf.hansson@linaro.org> <1c21d18e-954a-f3a8-9817-0117b7cb7e4f@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 24 May 2018 23:11:44 +0200
Message-ID: <CAPDyKFozm88OM8cDFXXwvgdMirrt2=HhZtBdyhNjo2bgjHV2Mg@mail.gmail.com>
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

On 24 May 2018 at 17:48, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> On 18/05/18 11:31, Ulf Hansson wrote:
>>
>> The existing dev_pm_domain_attach() function, allows a single PM domain to
>> be attached per device. To be able to support devices that are partitioned
>> across multiple PM domains, let's introduce a new interface,
>> dev_pm_domain_attach_by_id().
>>
>> The dev_pm_domain_attach_by_id() returns a new allocated struct device
>> with
>> the corresponding attached PM domain. This enables for example a driver to
>> operate on the new device from a power management point of view. The
>> driver
>> may then also benefit from using the received device, to set up so called
>> device-links towards its original device. Depending on the situation,
>> these
>> links may then be dynamically changed.
>>
>> The new interface is typically called by drivers during their probe phase,
>> in case they manages devices which uses multiple PM domains. If that is
>> the
>> case, the driver also becomes responsible of managing the detaching of the
>> PM domains, which typically should be done at the remove phase. Detaching
>> is done by calling the existing dev_pm_domain_detach() function and for
>> each of the received devices from dev_pm_domain_attach_by_id().
>>
>> Note, currently its only genpd that supports multiple PM domains per
>> device, but dev_pm_domain_attach_by_id() can easily by extended to cover
>> other PM domain types, if/when needed.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>   drivers/base/power/common.c | 33 ++++++++++++++++++++++++++++++++-
>>   include/linux/pm_domain.h   |  7 +++++++
>>   2 files changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
>> index 7ae62b6..d3db974 100644
>> --- a/drivers/base/power/common.c
>> +++ b/drivers/base/power/common.c
>> @@ -117,13 +117,44 @@ int dev_pm_domain_attach(struct device *dev, bool
>> power_on)
>>   EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
>>     /**
>> + * dev_pm_domain_attach_by_id - Attach a device to one of its PM domains.
>
>
> Isn't this more of a 'get'?

I don't think so, at least according to the common understanding of
how we use get and put APIs.

For example, clk_get() returns a cookie to a clk, which you then can
do a hole bunch of different clk specific operations on.

This is different, there are no specific PM domain operations the
caller can or should do. Instead the idea is to keep drivers more or
less transparent, still using runtime PM as before. The only care the
caller need to take is to use device links, which BTW isn't a PM
domain specific thing.

>
>> + * @index: The index of the PM domain.
>> + * @dev: Device to attach.
>
>
> Isn't this just the device associated with the PM domain we are getting?

Correct, but please note, as stated above, I don't think it's a good
idea to return a special PM domain cookie, because we don't want the
caller to run special PM domain operations.

>
>> + *
>> + * As @dev may only be attached to a single PM domain, the backend PM
>> domain
>> + * provider should create a virtual device to attach instead. As
>> attachment
>> + * succeeds, the ->detach() callback in the struct dev_pm_domain should
>> be
>> + * assigned by the corresponding backend attach function.
>> + *
>> + * This function should typically be invoked from drivers during probe
>> phase.
>> + * Especially for those that manages devices which requires power
>> management
>> + * through more than one PM domain.
>> + *
>> + * Callers must ensure proper synchronization of this function with power
>> + * management callbacks.
>> + *
>> + * Returns the virtual attached device in case successfully attached PM
>> domain,
>> + * NULL in case @dev don't need a PM domain, else a PTR_ERR().
>
>
> Should this be 'NULL in the case where the @dev already has a power-domain'?

Yes, I think so. The intent is to be consistent with how
dev_pm_domain_attach() works and according to the latest changes I did
for it. It's queued for 4.18, please have a look in Rafael's tree and
you will see.

>
>> + */
>> +struct device *dev_pm_domain_attach_by_id(struct device *dev,
>> +                                         unsigned int index)
>> +{
>> +       if (dev->pm_domain)
>
>
> I wonder if this is worthy of a ...
>
>         if (WARN_ON(dev->pm_domain))
>
>> +               return NULL;
>
>
> Don't we consider this an error case? I wonder why not return PTR_ERR here
> as well? This would be consistent with dev_pm_domain_attach().

Please see above comment.

Kind regards
Uffe
