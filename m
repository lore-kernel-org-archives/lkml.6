Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753587AbeCYQ3v (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 12:29:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:20798 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753281AbeCYQ3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 12:29:49 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,360,1517904000";
   d="scan'208";a="214689344"
Date: Mon, 26 Mar 2018 00:29:40 +0800
From: kbuild test robot <lkp@intel.com>
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: kbuild-all@01.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linux@armlinux.org.uk, linux-fbdev@vger.kernel.org, linux-imx@nxp.com,
        sboyd@kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 4/4] video: simplefb: switch to use clk_bulk API to
 simplify clock operations
Message-ID: <201803260023.gnm8GYCI%fengguang.wu@intel.com>
References: <1521600894-29919-5-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521600894-29919-5-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dong,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on v4.16-rc6 next-20180323]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dong-Aisheng/clk-new-APIs-to-handle-all-available-clocks/20180323-185821
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next

smatch warnings:
drivers/video/fbdev/simplefb.c:222 simplefb_clocks_get() warn: unsigned 'par->clk_count' is never less than zero.

vim +222 drivers/video/fbdev/simplefb.c

   193	
   194	#if defined CONFIG_OF && defined CONFIG_COMMON_CLK
   195	/*
   196	 * Clock handling code.
   197	 *
   198	 * Here we handle the clocks property of our "simple-framebuffer" dt node.
   199	 * This is necessary so that we can make sure that any clocks needed by
   200	 * the display engine that the bootloader set up for us (and for which it
   201	 * provided a simplefb dt node), stay up, for the life of the simplefb
   202	 * driver.
   203	 *
   204	 * When the driver unloads, we cleanly disable, and then release the clocks.
   205	 *
   206	 * We only complain about errors here, no action is taken as the most likely
   207	 * error can only happen due to a mismatch between the bootloader which set
   208	 * up simplefb, and the clock definitions in the device tree. Chances are
   209	 * that there are no adverse effects, and if there are, a clean teardown of
   210	 * the fb probe will not help us much either. So just complain and carry on,
   211	 * and hope that the user actually gets a working fb at the end of things.
   212	 */
   213	static int simplefb_clocks_get(struct simplefb_par *par,
   214				       struct platform_device *pdev)
   215	{
   216		struct device_node *np = pdev->dev.of_node;
   217	
   218		if (dev_get_platdata(&pdev->dev) || !np)
   219			return 0;
   220	
   221		par->clk_count = clk_bulk_get_all(&pdev->dev, &par->clks);
 > 222		if ((par->clk_count < 0) && (par->clk_count == -EPROBE_DEFER))
   223			return -EPROBE_DEFER;
   224	
   225		return 0;
   226	}
   227	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
