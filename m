Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936504AbeBUNPq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 08:15:46 -0500
Received: from ozlabs.org ([103.22.144.67]:59407 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754542AbeBUNNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 08:13:09 -0500
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] cpufreq: powernv: Check negative value returned by cpufreq_table_find_index_dl()
In-Reply-To: <CAJZ5v0jEg7FELH6mBY16mB5sfo7s2mbH2SGheH4KVeKLnStjjg@mail.gmail.com>
References: <1518430876-24464-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <20180212102900.GU28462@vireshk-i7> <874lmasxxx.fsf@concordia.ellerman.id.au> <20180221055450.GO28462@vireshk-i7> <CAJZ5v0jEg7FELH6mBY16mB5sfo7s2mbH2SGheH4KVeKLnStjjg@mail.gmail.com>
Date: Thu, 22 Feb 2018 00:13:03 +1100
Message-ID: <87vaeqqye8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Wed, Feb 21, 2018 at 6:54 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> On 21-02-18, 16:39, Michael Ellerman wrote:
>>> Viresh Kumar <viresh.kumar@linaro.org> writes:
>>
>>> > AFAICT, you will get -1 here only if the freq table had no valid
>>> > frequencies (or the freq table is empty). Why would that happen ?
>>>
>>> Bugs?
>>
>> The cupfreq driver shouldn't have registered itself in that case (i.e.
>> if the cpufreq table is empty).
>
> To be precise, ->init() should fail as that's where the table is
> created.  The registration fails as a result then.
>
> But what if the bug is that ->init() doesn't fail when it should?
>
> I guess the core could double check the frequency table after ->init()
> if ->target_index is not NULL.
>
> The overall point here is that if you get a negative index in
> ->fast_switch(), that's way too late anyway and we should be able to
> catch that error much earlier.

OK.

Still it's one thing for the driver to print a warning and bail out,
it's another to access off the front of an array and keep running using
some junk values, or oops (though not in this case because the array
happens to be static).

cheers
