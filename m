Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753124AbeB0L7h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 06:59:37 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37119 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752207AbeB0L7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 06:59:34 -0500
X-Google-Smtp-Source: AG47ELvZm4u7SKVQY25YfD0YXRI5CzsS71JZywz5w0uqWX9QBrpV7sLbisarcWajg7C/LznttkvkUA==
Subject: Re: [PATCH] clk: tegra: fix pllu rate configuration
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "pdeschrijver@nvidia.com" <pdeschrijver@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "pgaikwad@nvidia.com" <pgaikwad@nvidia.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
References: <20180222230451.15515-1-marcel@ziswiler.com>
 <31f039e8-9afc-22d1-d478-a7f41db0dace@gmail.com>
 <1519686262.6374.3.camel@toradex.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d6564dd4-de2c-5b28-81d2-6be7bd4319b2@gmail.com>
Date: Tue, 27 Feb 2018 14:59:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519686262.6374.3.camel@toradex.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.02.2018 02:04, Marcel Ziswiler wrote:
> On Mon, 2018-02-26 at 15:42 +0300, Dmitry Osipenko wrote:
>> On 23.02.2018 02:04, Marcel Ziswiler wrote:
>>> Turns out latest upstream U-Boot does not configure/enable pllu
>>> which
>>> leaves it at some default rate of 500 kHz:
>>>
>>> root@apalis-t30:~# cat /sys/kernel/debug/clk/clk_summary | grep
>>> pll_u
>>>        pll_u                  3        3        0      500000      
>>>     0
>>>
>>> Of course this won't quite work leading to the following messages:
>>>
>>> [    6.559593] usb 2-1: new full-speed USB device number 2 using
>>> tegra-
>>> ehci
>>> [   11.759173] usb 2-1: device descriptor read/64, error -110
>>> [   27.119453] usb 2-1: device descriptor read/64, error -110
>>> [   27.389217] usb 2-1: new full-speed USB device number 3 using
>>> tegra-
>>> ehci
>>> [   32.559454] usb 2-1: device descriptor read/64, error -110
>>> [   47.929777] usb 2-1: device descriptor read/64, error -110
>>> [   48.049658] usb usb2-port1: attempt power cycle
>>> [   48.759475] usb 2-1: new full-speed USB device number 4 using
>>> tegra-
>>> ehci
>>> [   59.349457] usb 2-1: device not accepting address 4, error -110
>>> [   59.509449] usb 2-1: new full-speed USB device number 5 using
>>> tegra-
>>> ehci
>>> [   70.069457] usb 2-1: device not accepting address 5, error -110
>>> [   70.079721] usb usb2-port1: unable to enumerate USB device
>>>
>>> Fix this by actually allowing the rate also being set from within
>>> the Linux kernel.
>>>
>>> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>>
>>> ---
>>>
>>>  drivers/clk/tegra/clk-pll.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-
>>> pll.c
>>> index 7c369e21c91c..830d1c87fa7c 100644
>>> --- a/drivers/clk/tegra/clk-pll.c
>>> +++ b/drivers/clk/tegra/clk-pll.c
>>> @@ -1151,6 +1151,8 @@ static const struct clk_ops
>>> tegra_clk_pllu_ops = {
>>>  	.enable = clk_pllu_enable,
>>>  	.disable = clk_pll_disable,
>>>  	.recalc_rate = clk_pll_recalc_rate,
>>> +	.round_rate = clk_pll_round_rate,
>>> +	.set_rate = clk_pll_set_rate,
>>>  };
>>>  
>>>  static int _pll_fixed_mdiv(struct tegra_clk_pll_params
>>> *pll_params,
>>>
>>
>> Tegra's USB PHY driver only enables clock and clk driver doesn't
>> specify the
>> clock rate in the init table. Could you please clarify where in the
>> kernels code
>> PLL_U rate is getting set?
> 
> I guess that would be according to the following table isn't it:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree
> /drivers/clk/tegra/clk-tegra30.c?h=v4.16-rc3#n287
> 

I see now that T30 has PLL_U in the init table [0], but T20 doesn't.

There is only one 480MHz rate defined in PLL_U lookup table. PLL_U also provides
12MHz and 60MHz outputs using fixed dividers and hence PLL_U shouldn't need
set/round_rate(), we can't change PLL_U rate at all and only enable / disable it.

Looks like for some reason PLL_U enabling fails without set/round_rate, but then
PHY driver should fail to probe [1]. Is it the case? Do you know why PLL_U isn't
actually getting enabled in HW? It is quite fishy, seems like clk driver /
framework bug or I'm missing something.

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/tegra/clk-tegra30.c?h=v4.16-rc3#n1274

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/phy/phy-tegra-usb.c?h=v4.16-rc3#n777
