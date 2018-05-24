Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935539AbeEXHFB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 03:05:01 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40846 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754940AbeEXHE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 03:04:56 -0400
X-Google-Smtp-Source: AB8JxZrRxUFNAbUvsCKRUgKVz7S6vuIlYY72uZZOK3wpAy+Qv//ENr977H3kD4tfODcxapqaU9p38057vCQXUUNVA3E=
MIME-Version: 1.0
In-Reply-To: <3838f17a-2ac8-bf3f-f0b1-f69bbe17629c@nvidia.com>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
 <1526639490-12167-9-git-send-email-ulf.hansson@linaro.org>
 <f5589b88-acf8-b491-df79-e359e596c8d0@nvidia.com> <CAPDyKFr_7hbs-MC1jQn5uAgSnb1UGufXZdEmUqNTM63KemTe1g@mail.gmail.com>
 <5a79d3a2-d090-645b-da69-524b7e7a4d90@nvidia.com> <51f7de26-579a-8b9e-4e79-f4eee923ab38@codeaurora.org>
 <CAPDyKFo_69kSS6UzdsJeyeiiED=S=chsdkP+R43qMHDEbZ8n_A@mail.gmail.com> <3838f17a-2ac8-bf3f-f0b1-f69bbe17629c@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 24 May 2018 09:04:54 +0200
Message-ID: <CAPDyKFo8e5FMrxF2ggxVZ+HQjw4s1Wtx-tMf5ka67knJpZMQcA@mail.gmail.com>
Subject: Re: [PATCH 8/9] PM / Domains: Add support for multi PM domains per
 device to genpd
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Rajendra Nayak <rnayak@codeaurora.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-tegra@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 May 2018 at 11:07, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> On 23/05/18 07:12, Ulf Hansson wrote:
>
> ...
>
>
>>>>>> Thanks for sending this. Believe it or not this has still been on my
>>>>>> to-do list
>>>>>> and so we definitely need a solution for Tegra.
>>>>>>
>>>>>> Looking at the above it appears that additional power-domains exposed
>>>>>> as devices
>>>>>> to the client device. So I assume that this means that the drivers for
>>>>>> devices
>>>>>> with multiple power-domains will need to call RPM APIs for each of
>>>>>> these
>>>>>> additional power-domains. Is that correct?
>>>>>
>>>>>
>>>>> They can, but should not!
>>>>>
>>>>> Instead, the driver shall use device_link_add() and device_link_del(),
>>>>> dynamically, depending on what PM domain that their original device
>>>>> needs for the current running use case.
>>>>>
>>>>> In that way, they keep existing runtime PM deployment, operating on
>>>>> its original device.
>>>>
>>>>
>>>> OK, sounds good. Any reason why the linking cannot be handled by the
>>>> above API? Is there a use-case where you would not want it linked?
>>>
>>>
>>> I am guessing the linking is what would give the driver the ability to
>>> decide which subset of powerdomains it actually wants to control
>>> at any point using runtime PM. If we have cases wherein the driver would
>>> want to turn on/off _all_ its associated powerdomains _always_
>>> then a default linking of all would help.
>>
>>
>> First, I think we need to decide on *where* the linking should be
>> done, not at both places, as that would just mess up synchronization
>> of who is responsible for calling the device_link_del() at detach.
>>
>> Second, It would in principle be fine to call device_link_add() and
>> device_link_del() as a part of the attach/detach APIs. However, there
>> is a downside to such solution, which would be that the driver then
>> needs call the detach API, just to do device_link_del(). Of course
>> then it would also needs to call the attach API later if/when needed.
>> Doing this adds unnecessary overhead - comparing to just let the
>> driver call device_link_add|del() when needed. On the upside, yes, it
>> would put less burden on the drivers as it then only needs to care
>> about using one set of functions.
>>
>> Which solution do you prefer?
>
>
> Any reason why we could not add a 'boolean' argument to the API to indicate
> whether the new device should be linked? I think that I prefer the API
> handles it, but I can see there could be instances where drivers may wish to
> handle it themselves.

Coming back to this question. Both Tegra XUSB and Qcom Camera use
case, would benefit from doing the linking themselves, as it needs
different PM domains to be powered on depending on the current use
case - as to avoid wasting power.

However, I can understand that you prefer some simplicity over
optimizations, as you told us. Then, does it mean that you are
insisting on extending the APIs with a boolean for linking, or are you
fine with the driver to call device_link_add()?

[...]

Kind regards
Uffe
