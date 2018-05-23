Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932247AbeEWJrl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:47:41 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:32914 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754411AbeEWJrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:47:22 -0400
X-Google-Smtp-Source: AB8JxZqtdAa5hBgPJWRTljlWxGOQxrjV98EvKsVzwrmiN21tanCU91DB8WPK9W2CXvvtrQZKZtsI6f1IUdm5Nc3udDQ=
MIME-Version: 1.0
In-Reply-To: <22068fb1-f6e8-f2ec-d7f4-ab9e93469d7f@nvidia.com>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
 <1526639490-12167-9-git-send-email-ulf.hansson@linaro.org>
 <f5589b88-acf8-b491-df79-e359e596c8d0@nvidia.com> <CAPDyKFr_7hbs-MC1jQn5uAgSnb1UGufXZdEmUqNTM63KemTe1g@mail.gmail.com>
 <5a79d3a2-d090-645b-da69-524b7e7a4d90@nvidia.com> <51f7de26-579a-8b9e-4e79-f4eee923ab38@codeaurora.org>
 <CAPDyKFo_69kSS6UzdsJeyeiiED=S=chsdkP+R43qMHDEbZ8n_A@mail.gmail.com>
 <3838f17a-2ac8-bf3f-f0b1-f69bbe17629c@nvidia.com> <00ba829d-faf4-168c-db00-531621b9280f@codeaurora.org>
 <CAPDyKFoqLPRwEJ9b+XBpB4Zy79SGEC-a8V8shNhMkYOCQa0=oA@mail.gmail.com> <22068fb1-f6e8-f2ec-d7f4-ab9e93469d7f@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 23 May 2018 11:47:21 +0200
Message-ID: <CAPDyKFoHwujfL4vpB8kq+rxDP4cThW4xB4nwb8Qc6_bZwTPbzA@mail.gmail.com>
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

On 23 May 2018 at 11:45, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> On 23/05/18 10:33, Ulf Hansson wrote:
>>
>> On 23 May 2018 at 11:27, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>>>
>>>
>>>
>>> On 05/23/2018 02:37 PM, Jon Hunter wrote:
>>>>
>>>>
>>>> On 23/05/18 07:12, Ulf Hansson wrote:
>>>>
>>>> ...
>>>>
>>>>>>>>> Thanks for sending this. Believe it or not this has still been on
>>>>>>>>> my to-do list
>>>>>>>>> and so we definitely need a solution for Tegra.
>>>>>>>>>
>>>>>>>>> Looking at the above it appears that additional power-domains
>>>>>>>>> exposed as devices
>>>>>>>>> to the client device. So I assume that this means that the drivers
>>>>>>>>> for devices
>>>>>>>>> with multiple power-domains will need to call RPM APIs for each of
>>>>>>>>> these
>>>>>>>>> additional power-domains. Is that correct?
>>>>>>>>
>>>>>>>>
>>>>>>>> They can, but should not!
>>>>>>>>
>>>>>>>> Instead, the driver shall use device_link_add() and
>>>>>>>> device_link_del(),
>>>>>>>> dynamically, depending on what PM domain that their original device
>>>>>>>> needs for the current running use case.
>>>>>>>>
>>>>>>>> In that way, they keep existing runtime PM deployment, operating on
>>>>>>>> its original device.
>>>>>>>
>>>>>>>
>>>>>>> OK, sounds good. Any reason why the linking cannot be handled by the
>>>>>>> above API? Is there a use-case where you would not want it linked?
>>>>>>
>>>>>>
>>>>>> I am guessing the linking is what would give the driver the ability to
>>>>>> decide which subset of powerdomains it actually wants to control
>>>>>> at any point using runtime PM. If we have cases wherein the driver
>>>>>> would want to turn on/off _all_ its associated powerdomains _always_
>>>>>> then a default linking of all would help.
>>>>>
>>>>>
>>>>> First, I think we need to decide on *where* the linking should be
>>>>> done, not at both places, as that would just mess up synchronization
>>>>> of who is responsible for calling the device_link_del() at detach.
>>>>>
>>>>> Second, It would in principle be fine to call device_link_add() and
>>>>> device_link_del() as a part of the attach/detach APIs. However, there
>>>>> is a downside to such solution, which would be that the driver then
>>>>> needs call the detach API, just to do device_link_del(). Of course
>>>>> then it would also needs to call the attach API later if/when needed.
>>>>> Doing this adds unnecessary overhead - comparing to just let the
>>>>> driver call device_link_add|del() when needed. On the upside, yes, it
>>>>> would put less burden on the drivers as it then only needs to care
>>>>> about using one set of functions.
>>>>>
>>>>> Which solution do you prefer?
>>>>
>>>>
>>>> Any reason why we could not add a 'boolean' argument to the API to
>>>> indicate whether the new device should be linked? I think that I prefer the
>>>> API handles it, but I can see there could be instances where drivers may
>>>> wish to handle it themselves.
>>>>
>>>> Rajendra, do you have a use-case right now where the driver would want
>>>> to handle the linking?
>>>
>>>
>>> So if I understand this right, any driver which does want to control
>>> individual powerdomain state would
>>> need to do the linking itself right?
>>>
>>> What I am saying is, if I have device A, with powerdomains X and Y, and
>>> if I want to turn on only X,
>>> then I would want only X to be linked with A, and at a later point if I
>>> want both X and Y to be turned on,
>>> I would then go ahead and link both X and Y to A? Is that correct or did
>>> I get it all wrong?
>>
>>
>> Correct!
>>
>>>
>>> I know atleast Camera on msm8996 would need to do this since it has 2 vfe
>>> powerdoamins, which can be
>>> turned on one at a time (depending on what resolution needs to be
>>> supported) or both together if we
>>> really need very high resolution using both vfe modules.
>>
>>
>> I think this is also the case for the Tegra XUSB subsystem.
>>
>> The usb device is always attached to one PM domain, but depending on
>> if super-speed mode is used, another PM domain for that logic needs to
>> be powered on as well.
>>
>> Jon, please correct me if I am wrong!
>
>
> Yes this is technically correct, however, in reality I think we are always
> going to enable the superspeed domain if either the host or device domain is
> enabled. So we would probably always link the superspeed with the host and
> device devices.

Why? Wouldn't that waste power if the superspeed mode isn't used?

Kind regards
Uffe
