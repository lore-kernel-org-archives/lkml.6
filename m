Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751010AbeFBAQt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 20:16:49 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38144 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbeFBAQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 20:16:47 -0400
X-Google-Smtp-Source: ADUXVKIEUURQVdcZhM5dm9Y7pW+Y+P9TxBq87ngJa4ForEES7JyYH35gyNJDDN1JASa4mlVpA7HSsImvqBWlvM7E3Y0=
MIME-Version: 1.0
In-Reply-To: <20180601045433.GA17425@in.ibm.com>
References: <1527768909-32637-1-git-send-email-ego@linux.vnet.ibm.com>
 <CAKTCnz=WhC_vamKPZruEqc04WKpD5ZqZm0zTcCtagRHib6OZPw@mail.gmail.com> <20180601045433.GA17425@in.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Sat, 2 Jun 2018 10:16:45 +1000
Message-ID: <CAKTCnznToaF_b9-Z6dH95DQOAu19q3otQc8ugAYXeQj76a5SHA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle:powernv: Make the snooze timeout dynamic.
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stewart Smith <stewart@linux.vnet.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
        <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 2:54 PM, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> Hi Balbir,
>
> Thanks for reviewing the patch!
>
> On Fri, Jun 01, 2018 at 12:51:05AM +1000, Balbir Singh wrote:
>> On Thu, May 31, 2018 at 10:15 PM, Gautham R. Shenoy
>
> [..snip..]
>> >
>> > +static u64 get_snooze_timeout(struct cpuidle_device *dev,
>> > +                             struct cpuidle_driver *drv,
>> > +                             int index)
>> > +{
>> > +       int i;
>> > +
>> > +       if (unlikely(!snooze_timeout_en))
>> > +               return default_snooze_timeout;
>> > +
>> > +       for (i = index + 1; i < drv->state_count; i++) {
>> > +               struct cpuidle_state *s = &drv->states[i];
>> > +               struct cpuidle_state_usage *su = &dev->states_usage[i];
>> > +
>> > +               if (s->disabled || su->disable)
>> > +                       continue;
>> > +
>> > +               return s->target_residency * tb_ticks_per_usec;
>>
>> Can we ensure this is not prone to overflow?
>
> s->target_residency is an "unsigned int" so can take a maximum value
> of UINT_MAX. tb_ticks_per_usec is an "unsigned long" with a value in
> the range of 100-1000. The return value is a u64. The product of
> s->target_residency and tb_ticks_per_usec should be contained in u64.
>

Fair enough, looks reasonable to me

Balbir Singh.
