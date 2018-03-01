Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935551AbeCAHli (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 02:41:38 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15702 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933286AbeCAHlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 02:41:35 -0500
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 28 Feb 2018 23:41:33 -0800
Date: Thu, 1 Mar 2018 09:41:29 +0200
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Dmitry Osipenko <digetx@gmail.com>
CC: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "pgaikwad@nvidia.com" <pgaikwad@nvidia.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH] clk: tegra: fix pllu rate configuration
Message-ID: <20180301074129.GG6190@tbergstrom-lnx.Nvidia.com>
References: <20180222230451.15515-1-marcel@ziswiler.com>
 <31f039e8-9afc-22d1-d478-a7f41db0dace@gmail.com>
 <1519686262.6374.3.camel@toradex.com>
 <d6564dd4-de2c-5b28-81d2-6be7bd4319b2@gmail.com>
 <20180228093620.GC6190@tbergstrom-lnx.Nvidia.com>
 <cd836479-7c30-cfbe-715b-31387679c444@gmail.com>
 <20180228141448.GD6190@tbergstrom-lnx.Nvidia.com>
 <7d8d77ca-e18d-6e37-1aca-6dd7c6e1964d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7d8d77ca-e18d-6e37-1aca-6dd7c6e1964d@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.21.24.170]
X-ClientProxiedBy: UKMAIL101.nvidia.com (10.26.138.13) To UKMAIL101.nvidia.com
 (10.26.138.13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 08:20:47PM +0300, Dmitry Osipenko wrote:
> On 28.02.2018 17:14, Peter De Schrijver wrote:
> > On Wed, Feb 28, 2018 at 03:00:23PM +0300, Dmitry Osipenko wrote:
> >> On 28.02.2018 12:36, Peter De Schrijver wrote:
> >>> On Tue, Feb 27, 2018 at 02:59:11PM +0300, Dmitry Osipenko wrote:
> >>>> On 27.02.2018 02:04, Marcel Ziswiler wrote:
> >>>>> On Mon, 2018-02-26 at 15:42 +0300, Dmitry Osipenko wrote:
> >>>>>> On 23.02.2018 02:04, Marcel Ziswiler wrote:
> >>>>>>> Turns out latest upstream U-Boot does not configure/enable pllu
> >>>>>>> which
> >>>>>>> leaves it at some default rate of 500 kHz:
> >>>>>>>
> >>>>>>> root@apalis-t30:~# cat /sys/kernel/debug/clk/clk_summary | grep
> >>>>>>> pll_u
> >>>>>>>        pll_u                  3        3        0      500000      
> >>>>>>>     0
> >>>>>>>
> >>>>>>> Of course this won't quite work leading to the following messages:
> >>>>>>>
> >>>>>>> [    6.559593] usb 2-1: new full-speed USB device number 2 using
> >>>>>>> tegra-
> >>>>>>> ehci
> >>>>>>> [   11.759173] usb 2-1: device descriptor read/64, error -110
> >>>>>>> [   27.119453] usb 2-1: device descriptor read/64, error -110
> >>>>>>> [   27.389217] usb 2-1: new full-speed USB device number 3 using
> >>>>>>> tegra-
> >>>>>>> ehci
> >>>>>>> [   32.559454] usb 2-1: device descriptor read/64, error -110
> >>>>>>> [   47.929777] usb 2-1: device descriptor read/64, error -110
> >>>>>>> [   48.049658] usb usb2-port1: attempt power cycle
> >>>>>>> [   48.759475] usb 2-1: new full-speed USB device number 4 using
> >>>>>>> tegra-
> >>>>>>> ehci
> >>>>>>> [   59.349457] usb 2-1: device not accepting address 4, error -110
> >>>>>>> [   59.509449] usb 2-1: new full-speed USB device number 5 using
> >>>>>>> tegra-
> >>>>>>> ehci
> >>>>>>> [   70.069457] usb 2-1: device not accepting address 5, error -110
> >>>>>>> [   70.079721] usb usb2-port1: unable to enumerate USB device
> >>>>>>>
> >>>>>>> Fix this by actually allowing the rate also being set from within
> >>>>>>> the Linux kernel.
> >>>
> >>> I think the best solution to this problem would be to make pll_u a fixed
> >>> clock and enable it and program the rate if it's not enabled at boot.
> >>
> >> Oh, right. PLL_U rate is actually configurable, somehow I missed it in TRM
> >> yesterday.. So set/round_rate() for PLL_U are actually needed and the patch is
> >> correct. Seems only T20 misses PLL_U in the init table, probably worth to add it
> >> there.
> >>
> > 
> > AFAIK we only use one rate ever?
> 
> IIUC, PLL_U has 3 outputs and output dividers are fixed in HW. So yes, we are
> setting PLL_U to one rate - 480MHz to get out1-480MHz, out2-60MHz and out3-12MHz.
> 

Indeed. And given that it's hw controlled anyway, I don't see why we can't make
it a fixed clock and handle the init at kernel boot depending on what the
bootloader has done.

Peter.
