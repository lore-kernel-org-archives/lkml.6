Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030684AbeCANTT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 08:19:19 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39989 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030496AbeCANTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 08:19:16 -0500
X-Google-Smtp-Source: AG47ELuSxVLvQfQRKMc06sVYFt5FqSVPUbPIU7uYdGrUPr0faeCAyaSnhoK4bSl+rPW4xM82uzmCAg==
Subject: Re: [PATCH] clk: tegra: fix pllu rate configuration
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "pgaikwad@nvidia.com" <pgaikwad@nvidia.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
References: <20180222230451.15515-1-marcel@ziswiler.com>
 <31f039e8-9afc-22d1-d478-a7f41db0dace@gmail.com>
 <1519686262.6374.3.camel@toradex.com>
 <d6564dd4-de2c-5b28-81d2-6be7bd4319b2@gmail.com>
 <20180228093620.GC6190@tbergstrom-lnx.Nvidia.com>
 <cd836479-7c30-cfbe-715b-31387679c444@gmail.com>
 <20180228141448.GD6190@tbergstrom-lnx.Nvidia.com>
 <7d8d77ca-e18d-6e37-1aca-6dd7c6e1964d@gmail.com>
 <20180301074129.GG6190@tbergstrom-lnx.Nvidia.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <028b0ba5-33b9-d12e-77ba-aebbfa91a5fb@gmail.com>
Date: Thu, 1 Mar 2018 16:19:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301074129.GG6190@tbergstrom-lnx.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.03.2018 10:41, Peter De Schrijver wrote:
> On Wed, Feb 28, 2018 at 08:20:47PM +0300, Dmitry Osipenko wrote:
>> On 28.02.2018 17:14, Peter De Schrijver wrote:
>>> On Wed, Feb 28, 2018 at 03:00:23PM +0300, Dmitry Osipenko wrote:
>>>> On 28.02.2018 12:36, Peter De Schrijver wrote:
>>>>> On Tue, Feb 27, 2018 at 02:59:11PM +0300, Dmitry Osipenko wrote:
>>>>>> On 27.02.2018 02:04, Marcel Ziswiler wrote:
>>>>>>> On Mon, 2018-02-26 at 15:42 +0300, Dmitry Osipenko wrote:
>>>>>>>> On 23.02.2018 02:04, Marcel Ziswiler wrote:
>>>>>>>>> Turns out latest upstream U-Boot does not configure/enable pllu
>>>>>>>>> which
>>>>>>>>> leaves it at some default rate of 500 kHz:
>>>>>>>>>
>>>>>>>>> root@apalis-t30:~# cat /sys/kernel/debug/clk/clk_summary | grep
>>>>>>>>> pll_u
>>>>>>>>>        pll_u                  3        3        0      500000      
>>>>>>>>>     0
>>>>>>>>>
>>>>>>>>> Of course this won't quite work leading to the following messages:
>>>>>>>>>
>>>>>>>>> [    6.559593] usb 2-1: new full-speed USB device number 2 using
>>>>>>>>> tegra-
>>>>>>>>> ehci
>>>>>>>>> [   11.759173] usb 2-1: device descriptor read/64, error -110
>>>>>>>>> [   27.119453] usb 2-1: device descriptor read/64, error -110
>>>>>>>>> [   27.389217] usb 2-1: new full-speed USB device number 3 using
>>>>>>>>> tegra-
>>>>>>>>> ehci
>>>>>>>>> [   32.559454] usb 2-1: device descriptor read/64, error -110
>>>>>>>>> [   47.929777] usb 2-1: device descriptor read/64, error -110
>>>>>>>>> [   48.049658] usb usb2-port1: attempt power cycle
>>>>>>>>> [   48.759475] usb 2-1: new full-speed USB device number 4 using
>>>>>>>>> tegra-
>>>>>>>>> ehci
>>>>>>>>> [   59.349457] usb 2-1: device not accepting address 4, error -110
>>>>>>>>> [   59.509449] usb 2-1: new full-speed USB device number 5 using
>>>>>>>>> tegra-
>>>>>>>>> ehci
>>>>>>>>> [   70.069457] usb 2-1: device not accepting address 5, error -110
>>>>>>>>> [   70.079721] usb usb2-port1: unable to enumerate USB device
>>>>>>>>>
>>>>>>>>> Fix this by actually allowing the rate also being set from within
>>>>>>>>> the Linux kernel.
>>>>>
>>>>> I think the best solution to this problem would be to make pll_u a fixed
>>>>> clock and enable it and program the rate if it's not enabled at boot.
>>>>
>>>> Oh, right. PLL_U rate is actually configurable, somehow I missed it in TRM
>>>> yesterday.. So set/round_rate() for PLL_U are actually needed and the patch is
>>>> correct. Seems only T20 misses PLL_U in the init table, probably worth to add it
>>>> there.
>>>>
>>>
>>> AFAIK we only use one rate ever?
>>
>> IIUC, PLL_U has 3 outputs and output dividers are fixed in HW. So yes, we are
>> setting PLL_U to one rate - 480MHz to get out1-480MHz, out2-60MHz and out3-12MHz.
>>
> 
> Indeed. And given that it's hw controlled anyway, I don't see why we can't make
> it a fixed clock and handle the init at kernel boot depending on what the
> bootloader has done.

We can, I just don't think you can demand from Mark to do it. This patch is fine
on its own, everything else could be done later.

On the other hand, it's USB driver responsibility to do the right thing. Why
just not to correct the driver? It would be kinda weird to mask one driver bug
by adding workaround to another. So I'd even suggest to go other way round by
implementing PLL lock polling and removing PLL_U enabling/disabling from the USB
PHY driver (if it's really fully-controlled by HW).
