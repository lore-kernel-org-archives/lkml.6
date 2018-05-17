Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeEQMwl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 08:52:41 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:13950 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeEQMwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 08:52:39 -0400
Subject: Re: MMC performance degradation due to too many requests
To: Linus Walleij <linus.walleij@linaro.org>,
        Will Newton <will.newton@gmail.com>,
        ext Tony Lindgren <tony@atomide.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <0ea1d2bf-fa0f-4b3d-556a-5dca5afbf2a9@ti.com>
 <CACRpkdaZ5G=gBHNwf7YMLEBOqC2UrO+YLrz09H4h8HWYN=av4w@mail.gmail.com>
 <3e2c96fa-273e-192f-1caf-788de7659592@ti.com>
 <CACRpkda+jrHgG=5qs-s7dcy4ZV4b9gQFGuf8SkwbAoGKxhBpqw@mail.gmail.com>
From: Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <44f591d4-908b-9476-6deb-0ddf77794b49@ti.com>
Date: Thu, 17 May 2018 18:24:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkda+jrHgG=5qs-s7dcy4ZV4b9gQFGuf8SkwbAoGKxhBpqw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 16 May 2018 07:59 PM, Linus Walleij wrote:
> On Tue, May 15, 2018 at 5:11 PM, Faiz Abbas <faiz_abbas@ti.com> wrote:
>> On Tuesday 15 May 2018 06:09 PM, Linus Walleij wrote:
>>> On Mon, May 14, 2018 at 1:30 PM, Faiz Abbas <faiz_abbas@ti.com> wrote:
>>>
>>>> Also, I see many times the number of interrupts for mmc1 in 4.14.
>>> (...)
>>>> I also printed out the size of the DMA transfers in the omap_hsmmc
>>>> driver during the dd command. I see that the maximum size of the dma
>>>> transfer has decreased from 1 MB to 256kB between 4.13 and 4.14.
>>>
>>> This seems like my fault for removing the bounce buffer.
>>> (The name bounce buffer is misleading, I suspect the right
>>> term for what is was doing was "merge buffer" or something,
>>> coalescing physically consecutive requests.)
>>>
>>> commit de3ee99b097dd51938276e3af388cd4ad0f2750a
>>> "mmc: Delete bounce buffer handling"
>>> should be the culprit.
>>
>> I don't think so. I checked out to the commit before that and see that
>> the interrupts are still too high.
> 
> OK phew then I'm safe :)
> 
>>> The bounce buffer only makes any performance impact if the
>>> host DMA controller is unable to handle scatter-gather lists
>>> so the number of segments is set down to 1.
>>>
>>> Can you verifty that:
>>> - mmc->max_segs == 1
>>
>> No. It is 64 in v4.14. It was 1024 in v4.13.
> 
> This smells like:
> commit 9442400486a1ec28915e9ab31517a5665ed35705
> "mmc: omap_hsmmc: Reduce max_segs for reliability"
> 

Yes. I was able to bisect the number of interrupts to the same commit as
well.

On top of v4.14,

*Without revert*:
https://pastebin.ubuntu.com/p/VJgvzrCP9g/

avg speed for 100 MB transfer: 3.7 MBps
Number of interrupts per 100 MB transfer: ~2000

*After revert*:
https://pastebin.ubuntu.com/p/ktgTmKVKkN/

avg speed for 100 MB transfer: 4.6 MBps
Number of interrupts per 100 MB transfer: ~500

Also, I'm getting 1M buffers in the omap_hsmmc DMA now.

@Will will it be OK to change the mmc_segs back to 1024?

Thanks,
Faiz
