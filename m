Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeDENKm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:10:42 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:25324 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751251AbeDENKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:10:40 -0400
Subject: Re: [PATCH v5 12/44] clk: davinci: Add platform information for TI
 DA850 PSC
To: Michael Turquette <mturquette@baylibre.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC: David Lechner <david@lechnology.com>,
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
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <a4d84be0-e3d3-4e39-40f9-cae9006cb6ee@ti.com>
Date: Thu, 5 Apr 2018 18:39:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAEG3pND6Cu0P_t3y_VM9Sm-GCb3yW0Pa8q4cRUOXYxa5=2nWUQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On Friday 09 February 2018 10:18 PM, Michael Turquette wrote:
> On Fri, Feb 9, 2018 at 8:22 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> 2018-01-08 3:17 GMT+01:00 David Lechner <david@lechnology.com>:

>> Hi David,
>>
>> I've been working on moving the genpd code from its own driver to the
>> psc one. I couldn't get the system to boot though and problems
>> happened very early in the boot sequence. I struggled to figure out
>> what's happening, but eventually I noticed that psc uses
>> CLK_OF_DECLARE() to initialize clocks. The functions registered this
>> way are called very early in the boot sequence, way before
>> late_initcall() in which the genpd framework is initialized. This of

late_initcall() is too late for genpd to be initialized. As you may have
seen with the latest set of patches, we have problems with timer
initialization. After converting to platform devices, PSC and PLL clocks
get initialized post time_init(). We are working that around using
fixed-clocks, which hopefully will work (I still need to test many of
the affected platforms).

Can you please reply with the exact issue you faced with genpd framework
initialization so we do have that on record.

Thanks,
Sekhar

>> course makes it impossible to register genpd at the same time we
>> register PSCs.
>>
>> Mike, Stephen - it would be great if you could confirm, but I believe
>> the clock framework now only accepts clock drivers which create real
>> platform drivers, in which case this series would need to be modified.
> 
> You are correct. All new uses of CLK_OF_DECLARE are met with high
> suspicion, and all new drivers should be platform drivers.
> 
> There are cases when CLK_OF_DECLARE is necessary (sometimes
> temporarily while things are reworked), but it seems this is not the
> case for this driver based on your testing of the platform driver
> approach. Please use the platform driver approach instead.
> 
> Thanks,
> Mike
> 
>>
>> David: FYI I quickly converted the functions in psc-da850.c to actual
>> probe callbacks and it worked just fine on a da850-lcdk board.
>>
>> Best regards,
>> Bartosz Golaszewski
