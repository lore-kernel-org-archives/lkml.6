Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968323AbeEXOeh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:34:37 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2091 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935668AbeEXOef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:34:35 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 24 May 2018 07:34:37 -0700
Subject: Re: [PATCH 8/9] PM / Domains: Add support for multi PM domains per
 device to genpd
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Rajendra Nayak <rnayak@codeaurora.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, <linux-tegra@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
 <1526639490-12167-9-git-send-email-ulf.hansson@linaro.org>
 <f5589b88-acf8-b491-df79-e359e596c8d0@nvidia.com>
 <CAPDyKFr_7hbs-MC1jQn5uAgSnb1UGufXZdEmUqNTM63KemTe1g@mail.gmail.com>
 <5a79d3a2-d090-645b-da69-524b7e7a4d90@nvidia.com>
 <51f7de26-579a-8b9e-4e79-f4eee923ab38@codeaurora.org>
 <CAPDyKFo_69kSS6UzdsJeyeiiED=S=chsdkP+R43qMHDEbZ8n_A@mail.gmail.com>
 <3838f17a-2ac8-bf3f-f0b1-f69bbe17629c@nvidia.com>
 <CAPDyKFo8e5FMrxF2ggxVZ+HQjw4s1Wtx-tMf5ka67knJpZMQcA@mail.gmail.com>
 <1687797a-93f1-7e5c-6060-01c12c070964@nvidia.com>
 <CAPDyKFravSx3h6UnsjNGM2ViZtkxvPMULyVQnoVT9jsEP5az+A@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <96169281-49b2-121f-0b7e-f54aae66db91@nvidia.com>
Date: Thu, 24 May 2018 15:34:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFravSx3h6UnsjNGM2ViZtkxvPMULyVQnoVT9jsEP5az+A@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL102.nvidia.com (172.18.146.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/05/18 13:17, Ulf Hansson wrote:
> On 24 May 2018 at 11:36, Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>> On 24/05/18 08:04, Ulf Hansson wrote:
>>
>> ...
>>
>>>> Any reason why we could not add a 'boolean' argument to the API to
>>>> indicate
>>>> whether the new device should be linked? I think that I prefer the API
>>>> handles it, but I can see there could be instances where drivers may wish
>>>> to
>>>> handle it themselves.
>>>
>>>
>>> Coming back to this question. Both Tegra XUSB and Qcom Camera use
>>> case, would benefit from doing the linking themselves, as it needs
>>> different PM domains to be powered on depending on the current use
>>> case - as to avoid wasting power.
>>>
>>> However, I can understand that you prefer some simplicity over
>>> optimizations, as you told us. Then, does it mean that you are
>>> insisting on extending the APIs with a boolean for linking, or are you
>>> fine with the driver to call device_link_add()?
>>
>>
>> I am fine with the driver calling device_link_add(), but I just wonder if we
>> will find a several drivers doing this and then we will end up doing this
>> later anyway.
> 
> Okay.
> 
>>
>> The current API is called ...
>>
>> * genpd_dev_pm_attach_by_id() - Attach a device to one of its PM domain.
>> * @dev: Device to attach.
>> * @index: The index of the PM domain.
>>
>> This naming and description is a bit misleading, because really it is not
>> attaching the device that is passed, but creating a new device to attach a
>> PM domain to. So we should consider renaming and changing the description
>> and indicate that users need to link the device.
> 
> I picked the name to be consistent with the existing
> genpd_dev_pm_attach(). Do you have a better suggestion?

Well, it appears to get more of a 'get' function and so I don't see why 
we could not have 'genpd_dev_get_by_id()' and then we could have a 
genpd_dev_put() as well (which would call genpd_dev_pm_detach).

> I agree, some details is missing to the description, let me try to
> improve it. Actually, I was trying to follow existing descriptions
> from genpd_dev_pm_attach(), so perhaps that also needs a little
> update.
> 
> However, do note that, neither genpd_dev_pm_attach() or
> genpd_dev_pm_attach_by_id() is supposed to be called by drivers, but
> rather only by the driver core. So description may not be so
> important.
> 
> In regards to good descriptions, for sure the API added in patch9,
> dev_pm_domain_attach_by_id(), needs a good one, as this is what
> drivers should be using.

OK. Same appears to apply here to the description as I mentioned above. 
Still seems to be more of a 'get' than an attach. So I wonder if it 
should be dev_pm_domain_get_by_id() instead?

>> Finally, how is a PM domain attached via calling genpd_dev_pm_attach_by_id()
>> detached?
> 
> Via the existing genpd_dev_pm_detach(), according to what I have
> described in the change log. I clarify the description in regards to
> this as well.

OK, so this bit is a to-do as that is not yet exposed AFAICT. I see that 
you said 'although we need to extend it to cover cleanup of the earlier 
registered device, via calling device_unregister().' So if we do this 
then that would be fine.

Cheers!
Jon

-- 
nvpublic
