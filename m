Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967372AbeCAKAB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:00:01 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36489 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967231AbeCAJ74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:59:56 -0500
Date: Thu, 1 Mar 2018 10:59:44 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Philipp Rossak <embed3d@gmail.com>
Cc: wens@csie.org, a.zummo@towertech.it, maxime.ripard@bootlin.com,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] rtc: ac100: Fix ac100 determine rate bug
Message-ID: <20180301095944.GT1479@piout.net>
References: <20180226211901.9805-1-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226211901.9805-1-embed3d@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2018 at 22:19:01 +0100, Philipp Rossak wrote:
> This patch fixes a bug, that prevents the Allwinner A83T and the A80
> from a successful boot.
> 
> The bug is there since v4.16-rc1 and appeared after the clk branch was
> merged.
> 
> You can find the shortend trace below:
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000
> pgd = (ptrval)
> [00000000] *pgd=00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in:
> CPU: 0 PID: 49 Comm: kworker/0:1 Not tainted 4.15.0-10190-gb89e32ccd1be #2
> Hardware name: Allwinner sun8i Family
> Workqueue: events deferred_probe_work_func
> PC is at clk_hw_get_rate+0x0/0x34
> LR is at ac100_clkout_determine_rate+0x48/0x19c
> 
> [ ... ]
> 
> (clk_hw_get_rate) from (ac100_clkout_determine_rate+0x48/0x19c)
> (ac100_clkout_determine_rate) from  (clk_core_set_rate_nolock+0x3c/0x1a0)
> (clk_core_set_rate_nolock) from (clk_set_rate+0x30/0x88)
> (clk_set_rate) from (of_clk_set_defaults+0x200/0x364)
> (of_clk_set_defaults) from (platform_drv_probe+0x18/0xb0)
> 
> To fix that bug, we first check if the return of the
> clk_hw_get_parent_by_index is non zero. If it is zero we skip that
> clock parent.
> 
> The BUG report could be found here: https://lkml.org/lkml/2018/2/10/198
> 
> Fixes: 04940631b8d2 ("rtc: ac100: Add clk output support")
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
> 
> Changes in v4:
> 	* add more information to the comment
> Changes in v3:
> 	* add information when the bug appeared 
> 	* make the comment more clear
> Changes in v2:
> 	* add tag Fixes: ... to commit message
> 	* add comment to if statement why we are doing this check
> 
>  drivers/rtc/rtc-ac100.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
