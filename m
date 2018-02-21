Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932346AbeBUJ2w (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:28:52 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40985 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753350AbeBUJ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:27:40 -0500
X-Google-Smtp-Source: AH8x225BC6I776A6kzTcOnaUonwz8EKess3DX7qLwl507QNPDn30E+qYy7Mz/KlpVomHdC1uE2/em135RG467SenkUo=
MIME-Version: 1.0
In-Reply-To: <20180221055450.GO28462@vireshk-i7>
References: <1518430876-24464-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20180212102900.GU28462@vireshk-i7> <874lmasxxx.fsf@concordia.ellerman.id.au> <20180221055450.GO28462@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 Feb 2018 10:27:39 +0100
X-Google-Sender-Auth: IuX25kyZb7Jmd4lsPYf1YsDspgY
Message-ID: <CAJZ5v0jEg7FELH6mBY16mB5sfo7s2mbH2SGheH4KVeKLnStjjg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: powernv: Check negative value returned by cpufreq_table_find_index_dl()
To: Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 6:54 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 21-02-18, 16:39, Michael Ellerman wrote:
>> Viresh Kumar <viresh.kumar@linaro.org> writes:
>
>> > AFAICT, you will get -1 here only if the freq table had no valid
>> > frequencies (or the freq table is empty). Why would that happen ?
>>
>> Bugs?
>
> The cupfreq driver shouldn't have registered itself in that case (i.e.
> if the cpufreq table is empty).

To be precise, ->init() should fail as that's where the table is
created.  The registration fails as a result then.

But what if the bug is that ->init() doesn't fail when it should?

I guess the core could double check the frequency table after ->init()
if ->target_index is not NULL.

The overall point here is that if you get a negative index in
->fast_switch(), that's way too late anyway and we should be able to
catch that error much earlier.
