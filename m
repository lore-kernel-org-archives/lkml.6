Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeFETHT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:07:19 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:46871 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbeFETHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:07:17 -0400
X-Google-Smtp-Source: ADUXVKK8Ab8hABsfXry0GTTYK71l8fr9WMSxPCpKSak/wfLNiAVyGhQJsZ3n7rabldKKrylWYxIw7vmkeuxdrWzL/lI=
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iu23LqdKUJA5OQGF3Yqq3=k+nfNUVn-LFpYgkDrgokCg@mail.gmail.com>
References: <20180601180053.120202-1-ravisadineni@chromium.org>
 <20180602010708.152025-1-ravisadineni@chromium.org> <20180604215339.GG164893@dtor-ws>
 <CAJZ5v0iu23LqdKUJA5OQGF3Yqq3=k+nfNUVn-LFpYgkDrgokCg@mail.gmail.com>
From: Ravi Chandra Sadineni <ravisadineni@google.com>
Date: Tue, 5 Jun 2018 12:06:53 -0700
Message-ID: <CAOGSYL0JJOoCnE7bjXZ8XPRJWmSyQ5nMQDO_0L708=r9MNX5BQ@mail.gmail.com>
Subject: Re: [PATCH V2] i8042: Increment wakeup_count for the respective port.
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        chenhong3@huawei.com, Dmitry Torokhov <dtor@google.com>,
        Todd Broch <tbroch@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, Rajat Jain <rajatja@google.com>,
        Benson Leung <bleung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 2:14 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, Jun 4, 2018 at 11:53 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Fri, Jun 01, 2018 at 06:07:08PM -0700, Ravi Chandra Sadineni wrote:
>>> Call pm_wakeup_event on every irq. This should help us in identifying if
>>> keyboard was a potential wake reason for the last resume.
>>>
>>> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
>>> ---
>>> V2: Increment the wakeup count only when there is a irq and not when the
>>> method is called internally.
>>>
>>> drivers/input/serio/i8042.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
>>> index 824f4c1c1f310..2bd6f2633e29a 100644
>>> --- a/drivers/input/serio/i8042.c
>>> +++ b/drivers/input/serio/i8042.c
>>> @@ -573,6 +573,9 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id)
>>>       port = &i8042_ports[port_no];
>>>       serio = port->exists ? port->serio : NULL;
>>>
>>> +     if (irq && serio && device_may_wakeup(&serio->dev))
>>> +             pm_wakeup_event(&serio->dev, 0);
>>
>> The constant checks for device_may_wakeup() before calling
>> pm_wakeup_event()needed to avoid warnings in wakeup_source_activate()
>> (?) are annoying.
>
> I'm not following you here.
>
> pm_wakeup_event() ->
>     pm_wakeup_dev_event() ->
>         pm_wakeup_ws_event(dev->power.wakeup, ...)
>             Checks if the first arg is NULL and returns quietly if so.
>
> I don't see why you need the device_may_wakeup() check.
Just realized that device_may_wakeup check is not needed. Removed the
check in V3. Thanks.
>
>> Rafael, can we move the check into pm_wakeup_dev_event()?
>
> That would be redundant, wouldn't it?
>
>> I am also confused when pm_wakeup_event() vs pm_wakeup_hard_event() vs
>> pm_wakeup_dev_event() should be used, if any. Is there any guidance?
>
> First off, the "hard" variant is for when you want to abort suspends
> in progress or wake up from suspend to idle regardless of whether or
> not wakeup source tracking is enabled.
>
> Second, use pm_wakeup_dev_event() if the decision on "hard" vs "soft"
> needs to be made at run time.
>
> Thanks,
> Rafael
