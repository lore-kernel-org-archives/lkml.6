Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751161AbeECWKm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 18:10:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:51669 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750829AbeECWKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 18:10:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400";
   d="scan'208";a="196563627"
Date: Fri, 4 May 2018 06:09:45 +0800
From: kbuild test robot <lkp@intel.com>
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: kbuild-all@01.org, djkurtz@chromium.org, akshu.agrawal@amd.com,
        Alexander.Deucher@amd.com, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Shaoyun Liu <Shaoyun.Liu@amd.com>, Dave Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2] clk: x86: Add ST oscout platform clock
Message-ID: <201805040610.d3xMxCsO%fengguang.wu@intel.com>
References: <1525336264-29243-1-git-send-email-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525336264-29243-1-git-send-email-akshu.agrawal@amd.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akshu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on v4.17-rc3 next-20180503]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Akshu-Agrawal/clk-x86-Add-ST-oscout-platform-clock/20180503-214044
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next

smatch warnings:
drivers/clk/x86/clk-st.c:60 st_clk_probe() error: potential null dereference 'hws'.  (kzalloc returns null)

vim +/hws +60 drivers/clk/x86/clk-st.c

    48	
    49	static int st_clk_probe(struct platform_device *pdev)
    50	{
    51		struct st_clk_data *st_data;
    52		struct clk_hw **hws;
    53	
    54		st_data = dev_get_platdata(&pdev->dev);
    55		if (!st_data || !st_data->base)
    56			return -EINVAL;
    57	
    58		hws = kzalloc(sizeof(*hws) * ST_MAX_CLKS, GFP_KERNEL);
    59	
  > 60		hws[ST_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz", NULL, 0,
    61							     48000000);
    62		hws[ST_CLK_25M] = clk_hw_register_fixed_rate(NULL, "clk25MHz", NULL, 0,
    63							     25000000);
    64	
    65		hws[ST_CLK_MUX] = clk_hw_register_mux(NULL, "oscout1_mux",
    66			clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
    67			0, st_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0, NULL);
    68	
    69		clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_25M]->clk);
    70	
    71		hws[ST_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1", "oscout1_mux",
    72			0, st_data->base + MISCCLKCNTL1, OSCCLKENB,
    73			CLK_GATE_SET_TO_DISABLE, NULL);
    74	
    75		clk_hw_register_clkdev(hws[ST_CLK_GATE], "oscout1", NULL);
    76	
    77		return 0;
    78	}
    79	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
