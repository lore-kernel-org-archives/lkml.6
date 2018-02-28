Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeB1MAc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 07:00:32 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41171 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752390AbeB1MA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 07:00:28 -0500
X-Google-Smtp-Source: AG47ELtS5iliPIe8eh3gQ4upnd4K7KHntCoxPJ46xFYyGijya6/dbVgcBmMkcDuqG2RezV9THKySXg==
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
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <cd836479-7c30-cfbe-715b-31387679c444@gmail.com>
Date: Wed, 28 Feb 2018 15:00:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228093620.GC6190@tbergstrom-lnx.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.02.2018 12:36, Peter De Schrijver wrote:
> On Tue, Feb 27, 2018 at 02:59:11PM +0300, Dmitry Osipenko wrote:
>> On 27.02.2018 02:04, Marcel Ziswiler wrote:
>>> On Mon, 2018-02-26 at 15:42 +0300, Dmitry Osipenko wrote:
>>>> On 23.02.2018 02:04, Marcel Ziswiler wrote:
>>>>> Turns out latest upstream U-Boot does not configure/enable pllu
>>>>> which
>>>>> leaves it at some default rate of 500 kHz:
>>>>>
>>>>> root@apalis-t30:~# cat /sys/kernel/debug/clk/clk_summary | grep
>>>>> pll_u
>>>>>        pll_u                  3        3        0      500000      
>>>>>     0
>>>>>
>>>>> Of course this won't quite work leading to the following messages:
>>>>>
>>>>> [    6.559593] usb 2-1: new full-speed USB device number 2 using
>>>>> tegra-
>>>>> ehci
>>>>> [   11.759173] usb 2-1: device descriptor read/64, error -110
>>>>> [   27.119453] usb 2-1: device descriptor read/64, error -110
>>>>> [   27.389217] usb 2-1: new full-speed USB device number 3 using
>>>>> tegra-
>>>>> ehci
>>>>> [   32.559454] usb 2-1: device descriptor read/64, error -110
>>>>> [   47.929777] usb 2-1: device descriptor read/64, error -110
>>>>> [   48.049658] usb usb2-port1: attempt power cycle
>>>>> [   48.759475] usb 2-1: new full-speed USB device number 4 using
>>>>> tegra-
>>>>> ehci
>>>>> [   59.349457] usb 2-1: device not accepting address 4, error -110
>>>>> [   59.509449] usb 2-1: new full-speed USB device number 5 using
>>>>> tegra-
>>>>> ehci
>>>>> [   70.069457] usb 2-1: device not accepting address 5, error -110
>>>>> [   70.079721] usb usb2-port1: unable to enumerate USB device
>>>>>
>>>>> Fix this by actually allowing the rate also being set from within
>>>>> the Linux kernel.
> 
> I think the best solution to this problem would be to make pll_u a fixed
> clock and enable it and program the rate if it's not enabled at boot.

Oh, right. PLL_U rate is actually configurable, somehow I missed it in TRM
yesterday.. So set/round_rate() for PLL_U are actually needed and the patch is
correct. Seems only T20 misses PLL_U in the init table, probably worth to add it
there.

> This is how it's done for Tegra210. The reason is that the USB IP blocks
> can control the pll_u state in hw. This means that if sw would disable
> and then re-enable the pll_u clock, but there is no USB activity, pll_u
> will still be disable and therefor not lock, causing an error. Today
> this is worked around by not polling the lock bit for pll_u, but a better
> solution would be to just remove all sw controls for pll_u.

SW controls could be removed, but I don't think it is really necessary as in our
case SW is the PHY driver and we know what it does. Alternatively we can enable
PLL_U in the init table to keep it "always" enabled.
