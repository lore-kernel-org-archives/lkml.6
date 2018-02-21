Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932789AbeBUKRS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:17:18 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:37452 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932742AbeBUKRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:17:16 -0500
X-Google-Smtp-Source: AG47ELujIG2ySkrSBu0h7S86iz0DnQvsN1QiUl2vxL1vftXgU3KY2ax/j+mDsf8uTfUtitFnUOI1CkVvVA4XTM1ZJNg=
MIME-Version: 1.0
In-Reply-To: <20180221100209.GP28462@vireshk-i7>
References: <1518430876-24464-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20180212102900.GU28462@vireshk-i7> <874lmasxxx.fsf@concordia.ellerman.id.au>
 <20180221055450.GO28462@vireshk-i7> <CAJZ5v0jEg7FELH6mBY16mB5sfo7s2mbH2SGheH4KVeKLnStjjg@mail.gmail.com>
 <20180221100209.GP28462@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 Feb 2018 11:17:15 +0100
X-Google-Sender-Auth: pjvd_SSnUpzczw7Prvons2NzQM4
Message-ID: <CAJZ5v0hCQCo3EwprC7RP5Jsn8_tMp-1fbMcPwKgujiQ8YeH0aA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: powernv: Check negative value returned by cpufreq_table_find_index_dl()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 11:02 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 21-02-18, 10:27, Rafael J. Wysocki wrote:
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
> I don't want to end up doing double checking as some of it is already
> done at init, but let me check on what can be done.

The driver is expected to call cpufreq_table_validate_and_show() at
->init() time and fail ->init() if that fails.

That's kind of fragile, because it depends on the driver to do the right thing.
