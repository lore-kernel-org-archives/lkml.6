Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752219AbeB1Jg2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:36:28 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18980 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeB1JgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:36:25 -0500
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 28 Feb 2018 01:36:25 -0800
Date: Wed, 28 Feb 2018 11:36:20 +0200
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
Message-ID: <20180228093620.GC6190@tbergstrom-lnx.Nvidia.com>
References: <20180222230451.15515-1-marcel@ziswiler.com>
 <31f039e8-9afc-22d1-d478-a7f41db0dace@gmail.com>
 <1519686262.6374.3.camel@toradex.com>
 <d6564dd4-de2c-5b28-81d2-6be7bd4319b2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d6564dd4-de2c-5b28-81d2-6be7bd4319b2@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.21.24.170]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To UKMAIL101.nvidia.com
 (10.26.138.13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 02:59:11PM +0300, Dmitry Osipenko wrote:
> On 27.02.2018 02:04, Marcel Ziswiler wrote:
> > On Mon, 2018-02-26 at 15:42 +0300, Dmitry Osipenko wrote:
> >> On 23.02.2018 02:04, Marcel Ziswiler wrote:
> >>> Turns out latest upstream U-Boot does not configure/enable pllu
> >>> which
> >>> leaves it at some default rate of 500 kHz:
> >>>
> >>> root@apalis-t30:~# cat /sys/kernel/debug/clk/clk_summary | grep
> >>> pll_u
> >>>        pll_u                  3        3        0      500000      
> >>>     0
> >>>
> >>> Of course this won't quite work leading to the following messages:
> >>>
> >>> [    6.559593] usb 2-1: new full-speed USB device number 2 using
> >>> tegra-
> >>> ehci
> >>> [   11.759173] usb 2-1: device descriptor read/64, error -110
> >>> [   27.119453] usb 2-1: device descriptor read/64, error -110
> >>> [   27.389217] usb 2-1: new full-speed USB device number 3 using
> >>> tegra-
> >>> ehci
> >>> [   32.559454] usb 2-1: device descriptor read/64, error -110
> >>> [   47.929777] usb 2-1: device descriptor read/64, error -110
> >>> [   48.049658] usb usb2-port1: attempt power cycle
> >>> [   48.759475] usb 2-1: new full-speed USB device number 4 using
> >>> tegra-
> >>> ehci
> >>> [   59.349457] usb 2-1: device not accepting address 4, error -110
> >>> [   59.509449] usb 2-1: new full-speed USB device number 5 using
> >>> tegra-
> >>> ehci
> >>> [   70.069457] usb 2-1: device not accepting address 5, error -110
> >>> [   70.079721] usb usb2-port1: unable to enumerate USB device
> >>>
> >>> Fix this by actually allowing the rate also being set from within
> >>> the Linux kernel.

I think the best solution to this problem would be to make pll_u a fixed
clock and enable it and program the rate if it's not enabled at boot.
This is how it's done for Tegra210. The reason is that the USB IP blocks
can control the pll_u state in hw. This means that if sw would disable
and then re-enable the pll_u clock, but there is no USB activity, pll_u
will still be disable and therefor not lock, causing an error. Today
this is worked around by not polling the lock bit for pll_u, but a better
solution would be to just remove all sw controls for pll_u.

Peter.
