Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965780AbeBUNZO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 08:25:14 -0500
Received: from mail-ot0-f173.google.com ([74.125.82.173]:44629 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932126AbeBUNZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 08:25:11 -0500
X-Google-Smtp-Source: AG47ELvs79EccjeR2N6vEbW/+5cVYBLIwJ9ceVBl4PnMZwJsaipoR1z1HVpkD8QfSuKmogMQzbTqfwBQz758ywuXBF0=
MIME-Version: 1.0
In-Reply-To: <87vaeqqye8.fsf@concordia.ellerman.id.au>
References: <1518430876-24464-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20180212102900.GU28462@vireshk-i7> <874lmasxxx.fsf@concordia.ellerman.id.au>
 <20180221055450.GO28462@vireshk-i7> <CAJZ5v0jEg7FELH6mBY16mB5sfo7s2mbH2SGheH4KVeKLnStjjg@mail.gmail.com>
 <87vaeqqye8.fsf@concordia.ellerman.id.au>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 Feb 2018 14:25:10 +0100
X-Google-Sender-Auth: Cew4bkNtXHxwEF8A9kLpyqzV_MI
Message-ID: <CAJZ5v0gVUO5OMfHUrQKd0T1EKo2c9iJ+zb-v9i2tkkS0MJbntA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: powernv: Check negative value returned by cpufreq_table_find_index_dl()
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 2:13 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>
>> On Wed, Feb 21, 2018 at 6:54 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>> On 21-02-18, 16:39, Michael Ellerman wrote:
>>>> Viresh Kumar <viresh.kumar@linaro.org> writes:
>>>
>>>> > AFAICT, you will get -1 here only if the freq table had no valid
>>>> > frequencies (or the freq table is empty). Why would that happen ?
>>>>
>>>> Bugs?
>>>
>>> The cupfreq driver shouldn't have registered itself in that case (i.e.
>>> if the cpufreq table is empty).
>>
>> To be precise, ->init() should fail as that's where the table is
>> created.  The registration fails as a result then.
>>
>> But what if the bug is that ->init() doesn't fail when it should?
>>
>> I guess the core could double check the frequency table after ->init()
>> if ->target_index is not NULL.
>>
>> The overall point here is that if you get a negative index in
>> ->fast_switch(), that's way too late anyway and we should be able to
>> catch that error much earlier.
>
> OK.
>
> Still it's one thing for the driver to print a warning and bail out,
> it's another to access off the front of an array and keep running using
> some junk values, or oops (though not in this case because the array
> happens to be static).

Well, let me rephrase.  If ->fast_switch() runs, then it must not be
possible to get a negative index in it.  That has to be guaranteed by
the core.
