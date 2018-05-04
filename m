Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbeEDM3A (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 08:29:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:47667 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751287AbeEDM24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 08:28:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,362,1520924400";
   d="scan'208";a="37425912"
Date: Fri, 4 May 2018 20:27:56 +0800
From: kbuild test robot <lkp@intel.com>
To: Ilia Lin <ilialin@codeaurora.org>
Cc: kbuild-all@01.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rnayak@codeaurora.org, ilialin@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: Re: [PATCH v5 03/14] clk: qcom: Add CPU clock driver for msm8996
Message-ID: <201805042040.jFAZvC33%fengguang.wu@intel.com>
References: <1525348355-25471-4-git-send-email-ilialin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525348355-25471-4-git-send-email-ilialin@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilia,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on v4.17-rc3 next-20180503]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ilia-Lin/CPU-scaling-support-for-msm8996/20180504-174840
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/clk/qcom/clk-cpu-8996.c:142:9: sparse: constant 2150400000 is so big it is long
>> drivers/clk/qcom/clk-cpu-8996.c:239:22: sparse: symbol 'clk_cpu_8996_mux_ops' was not declared. Should it be static?
   drivers/clk/qcom/clk-cpu-8996.c:324:19: sparse: symbol 'clks' was not declared. Should it be static?

vim +142 drivers/clk/qcom/clk-cpu-8996.c

   137	
   138	static const struct pll_vco alt_pll_vco_modes[] = {
   139		VCO(3,  250000000,  500000000),
   140		VCO(2,  500000000,  750000000),
   141		VCO(1,  750000000, 1000000000),
 > 142		VCO(0, 1000000000, 2150400000),
   143	};
   144	
   145	static const struct alpha_pll_config altpll_config = {
   146		.l = 16,
   147		.vco_val = 0x3 << 20,
   148		.vco_mask = 0x3 << 20,
   149		.config_ctl_val = 0x4001051b,
   150		.post_div_mask = 0x3 << 8,
   151		.post_div_val = 0x1,
   152		.main_output_mask = BIT(0),
   153		.early_output_mask = BIT(3),
   154	};
   155	
   156	static struct clk_alpha_pll perfcl_alt_pll = {
   157		.offset = 0x80100,
   158		.regs = alt_pll_regs,
   159		.vco_table = alt_pll_vco_modes,
   160		.num_vco = ARRAY_SIZE(alt_pll_vco_modes),
   161		.flags = SUPPORTS_OFFLINE_REQ | SUPPORTS_FSM_MODE,
   162		.clkr.hw.init = &(struct clk_init_data) {
   163			.name = "perfcl_alt_pll",
   164			.parent_names = (const char *[]){ "xo" },
   165			.num_parents = 1,
   166			.ops = &clk_alpha_pll_hwfsm_ops,
   167		},
   168	};
   169	
   170	static struct clk_alpha_pll pwrcl_alt_pll = {
   171		.offset = 0x100,
   172		.regs = alt_pll_regs,
   173		.vco_table = alt_pll_vco_modes,
   174		.num_vco = ARRAY_SIZE(alt_pll_vco_modes),
   175		.flags = SUPPORTS_OFFLINE_REQ | SUPPORTS_FSM_MODE,
   176		.clkr.hw.init = &(struct clk_init_data) {
   177			.name = "pwrcl_alt_pll",
   178			.parent_names = (const char *[]){ "xo" },
   179			.num_parents = 1,
   180			.ops = &clk_alpha_pll_hwfsm_ops,
   181		},
   182	};
   183	
   184	/* Mux'es */
   185	
   186	struct clk_cpu_8996_mux {
   187		u32	reg;
   188		u8	shift;
   189		u8	width;
   190		struct clk_hw	*pll;
   191		struct clk_regmap clkr;
   192	};
   193	
   194	static inline
   195	struct clk_cpu_8996_mux *to_clk_cpu_8996_mux_hw(struct clk_hw *hw)
   196	{
   197		return container_of(to_clk_regmap(hw), struct clk_cpu_8996_mux, clkr);
   198	}
   199	
   200	static u8 clk_cpu_8996_mux_get_parent(struct clk_hw *hw)
   201	{
   202		u32 val;
   203		struct clk_regmap *clkr = to_clk_regmap(hw);
   204		struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_hw(hw);
   205		u32 mask = (u32)GENMASK(cpuclk->width - 1, 0);
   206	
   207		regmap_read(clkr->regmap, cpuclk->reg, &val);
   208		val >>= (u32)(cpuclk->shift);
   209	
   210		return (u8)(val & mask);
   211	}
   212	
   213	static int clk_cpu_8996_mux_set_parent(struct clk_hw *hw, u8 index)
   214	{
   215		u32 val;
   216		struct clk_regmap *clkr = to_clk_regmap(hw);
   217		struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_hw(hw);
   218		unsigned int mask = GENMASK(cpuclk->width + cpuclk->shift - 1,
   219					    cpuclk->shift);
   220	
   221		val = (u32)index;
   222		val <<= (u32)(cpuclk->shift);
   223	
   224		return regmap_update_bits(clkr->regmap, cpuclk->reg, mask, val);
   225	}
   226	
   227	static int
   228	clk_cpu_8996_mux_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
   229	{
   230		struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_hw(hw);
   231		struct clk_hw *parent = cpuclk->pll;
   232	
   233		req->best_parent_rate = clk_hw_round_rate(parent, req->rate);
   234		req->best_parent_hw = parent;
   235	
   236		return 0;
   237	}
   238	
 > 239	const struct clk_ops clk_cpu_8996_mux_ops = {
   240		.set_parent = clk_cpu_8996_mux_set_parent,
   241		.get_parent = clk_cpu_8996_mux_get_parent,
   242		.determine_rate = clk_cpu_8996_mux_determine_rate,
   243	};
   244	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
