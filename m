Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbeDEPhl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 11:37:41 -0400
Received: from vern.gendns.com ([206.190.152.46]:52792 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbeDEPhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 11:37:39 -0400
Subject: Re: [PATCH v5 12/44] clk: davinci: Add platform information for TI
 DA850 PSC
To: Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-13-git-send-email-david@lechnology.com>
 <CAMRc=MfQuqTK+mDT0Gawa6J-3d1z6djLutaHREKfVm+3hATEqQ@mail.gmail.com>
 <CAEG3pND6Cu0P_t3y_VM9Sm-GCb3yW0Pa8q4cRUOXYxa5=2nWUQ@mail.gmail.com>
 <a4d84be0-e3d3-4e39-40f9-cae9006cb6ee@ti.com>
 <CAMRc=Mc228JAxxBXcObmokh2h-toojG8OHrmbunm_ORqbGWUnA@mail.gmail.com>
 <69bc0848-0698-b936-96a3-2257a5e27809@ti.com>
From: David Lechner <david@lechnology.com>
Message-ID: <366610a6-8983-d744-01e5-a00592bef479@lechnology.com>
Date: Thu, 5 Apr 2018 10:37:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <69bc0848-0698-b936-96a3-2257a5e27809@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2018 09:36 AM, Sekhar Nori wrote:
> On Thursday 05 April 2018 07:14 PM, Bartosz Golaszewski wrote:
>> 2018-04-05 15:09 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
>>> Hi Bartosz,
>>>
>>> On Friday 09 February 2018 10:18 PM, Michael Turquette wrote:
>>>> On Fri, Feb 9, 2018 at 8:22 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>>> 2018-01-08 3:17 GMT+01:00 David Lechner <david@lechnology.com>:
>>>
>>>>> Hi David,
>>>>>
>>>>> I've been working on moving the genpd code from its own driver to the
>>>>> psc one. I couldn't get the system to boot though and problems
>>>>> happened very early in the boot sequence. I struggled to figure out
>>>>> what's happening, but eventually I noticed that psc uses
>>>>> CLK_OF_DECLARE() to initialize clocks. The functions registered this
>>>>> way are called very early in the boot sequence, way before
>>>>> late_initcall() in which the genpd framework is initialized. This of
>>>
>>> late_initcall() is too late for genpd to be initialized. As you may have
>>> seen with the latest set of patches, we have problems with timer
>>> initialization. After converting to platform devices, PSC and PLL clocks
>>> get initialized post time_init(). We are working that around using
>>> fixed-clocks, which hopefully will work (I still need to test many of
>>> the affected platforms).
>>>
>>> Can you please reply with the exact issue you faced with genpd framework
>>> initialization so we do have that on record.
>>>
>>
>> The exact issue manifested itself in a NULL-pointer dereference panic
>> when I tried moving the genpd code I had initially implemented as a
>> separate platform driver to what I believe was v6 or v7 of David's
>> series (before the psc driver became a platform driver, when it was
>> still using CLK_OF_DECLARE()). When I had tested a simple conversion
>> of that version to a platform_driver, genpd worked fine.
>>
>> I don't have the stack traces from these panics, but I recall some
>> debugfs functions being involved and the genpd late_initcalls are
>> related to debugfs. Looking at it now I don't see how exactly it could
>> fail though.
> 
> Do you have the code where you faced the problem stashed somewhere? I am
> not (yet) advocating going back to CLK_OF_DECLARE(). But there is a
> definite issue with timer being ready when not using CLK_OF_DECLARE().
> So, I want to make sure there the reason why we are going down the
> platform device path is a amply clear.
> 
> Thanks,
> Sekhar
> 
This is the thread that led to the conversion to platform devices:

https://lkml.org/lkml/2018/2/9/541
