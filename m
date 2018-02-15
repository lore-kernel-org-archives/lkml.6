Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1167258AbeBOVB4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 16:01:56 -0500
Received: from gloria.sntech.de ([95.129.55.99]:37532 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162995AbeBOVBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 16:01:55 -0500
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        Shawn Guo <shawnguo@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>
Subject: Re: [PATCH v2 4/8] clk: migrate the count of orphaned clocks at init
Date: Thu, 15 Feb 2018 22:01:52 +0100
Message-ID: <1970074.VYjjbDuVRv@diego>
In-Reply-To: <20180214134340.17242-5-jbrunet@baylibre.com>
References: <20180214134340.17242-1-jbrunet@baylibre.com> <20180214134340.17242-5-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 14. Februar 2018, 14:43:36 CET schrieb Jerome Brunet:
> The orphan clocks reparents should migrate any existing count from the
> orphan clock to its new acestor clocks, otherwise we may have
> inconsistent counts in the tree and end-up with gated critical clocks
> 
> Assuming we have two clocks, A and B.
> * Clock A has CLK_IS_CRITICAL flag set.
> * Clock B is an ancestor of A which can gate. Clock B gate is left
>   enabled by the bootloader.
> 
> Step 1: Clock A is registered. Since it is a critical clock, it is
> enabled. The clock being still an orphan, no parent are enabled.
> 
> Step 2: Clock B is registered and reparented to clock A (potentially
> through several other clocks). We are now in situation where the enable
> count of clock A is 1 while the enable count of its ancestors is 0, which
> is not good.
> 
> Step 3: in lateinit, clk_disable_unused() is called, the enable_count of
> clock B being 0, clock B is gated and and critical clock A actually gets
> disabled.
> 
> This situation was found while adding fdiv_clk gates to the meson8b
> platform.  These clocks parent clk81 critical clock, which is the mother
> of all peripheral clocks in this system. Because of the issue described
> here, the system is crashing when clk_disable_unused() is called.
> 
> The situation is solved by reverting
> commit f8f8f1d04494 ("clk: Don't touch hardware when reparenting during
> registration"). To avoid breaking again the situation described in this
> commit
> description, enabling critical clock should be done before walking the
> orphan list. This way, a parent critical clock may not be accidentally
> disabled due to the CLK_OPS_PARENT_ENABLE mechanism.
> 
> Fixes: f8f8f1d04494 ("clk: Don't touch hardware when reparenting during
> registration") Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

On a rk3288-veyron Chromebook
Tested-by: Heiko Stuebner <heiko@sntech.de>

This made the hdmi on the machine work again with 4.16-rc1 .
(hdmi-cec clock is sourced from the i2c connected pmic which provides
the 32kHz clock needed)

So it would be really cool if this could make it into 4.16-rc :-)


Heiko
