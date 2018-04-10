Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+gVkieWseEjIXIRTxj6C57FlH3JZ26Hg/EhdywXrynPpFctQ4eSyLxg+8M3XVCtw1azzFb
ARC-Seal: i=1; a=rsa-sha256; t=1523399665; cv=none;
        d=google.com; s=arc-20160816;
        b=ouFm+g8e7qXvcDqN6h8mqwfpn+2tM6IryVP00M9uZIJIzQZgrXzPGA5jR45PfPlZbc
         ZRYw/jX87xhz93IHpHI6iXUb01moILwloAo1QaFWVx3+y3IsYHkfNkGVb/LL0zNj9CaQ
         0jadXffBjU05+VdauVvO/SAEXQtdkAvWmZAAGaWvTGdgTVOTEt8w3unOMODS/mCYsNTd
         fKlAIy9zin/3bhH4cX+Ss3wfAN9XlkU/9xOh3EkZ8cetNvCDPl8jO1Z7T0JPIPHe6t5f
         Tdv9EyVm6SSlMSDw6staS/DAaRU/NF2ACSuIwkcDJkDgkfxZwkOvJgJnbTsGnvIkpRhZ
         nvzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1w15hJIRx5N/VmzraqBeEnR6PP/4/2pzRohSvB2zWkU=;
        b=W9BZh/ckWwOKq+r95Mxbf2IQCnrqmB9Sox4aE6Y7kWKoYSm+WLWSh1fsn7UvnGfj9n
         GLf8DOdoXgdn0Acx1vAV97GTwSaR8ou/2zE8FmhxK9XhyWle2SaebbLKLFx43XOcyNSq
         yQAGlV2NCLDHQ6F93UgMk1syUhv6hQdf4ANHW7b6ldhg4aOSAUmX12f81KRAKhJQH3Sx
         XCUDSKzEdc0rRfmFxI85ukb7jmyzt3E9Wc7RqpQZIhwXszvuh/fknIC8hkhXcIde2NnK
         eiap2Y/RLZXVW4e6SHjUvLGxedcnKp0g4jOx09OQFITCdhrD+u7HNII86omY1/oF7Idq
         1D3w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Sylvain Lemieux <slemieux.tyco@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 020/138] clk: divider: fix incorrect usage of container_of
Date: Wed, 11 Apr 2018 00:23:30 +0200
Message-Id: <20180410212904.451442375@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399841340968500?=
X-GMAIL-MSGID: =?utf-8?q?1597400328113171490?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerome Brunet <jbrunet@baylibre.com>


[ Upstream commit 12a26c298d2a8b1cab498533fa65198e49e3afd3 ]

divider_recalc_rate() is an helper function used by clock divider of
different types, so the structure containing the 'hw' pointer is not
always a 'struct clk_divider'

At the following line:
> div = _get_div(table, val, flags, divider->width);

in several cases, the value of 'divider->width' is garbage as the actual
structure behind this memory is not a 'struct clk_divider'

Fortunately, this width value is used by _get_val() only when
CLK_DIVIDER_MAX_AT_ZERO flag is set. This has never been the case so
far when the structure is not a 'struct clk_divider'. This is probably
why we did not notice this bug before

Fixes: afe76c8fd030 ("clk: allow a clk divider with max divisor when zero")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/clk-divider.c                  |    7 +++----
 drivers/clk/hisilicon/clkdivider-hi6220.c  |    2 +-
 drivers/clk/nxp/clk-lpc32xx.c              |    2 +-
 drivers/clk/qcom/clk-regmap-divider.c      |    2 +-
 drivers/clk/sunxi-ng/ccu_div.c             |    2 +-
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c |    2 +-
 drivers/rtc/rtc-ac100.c                    |    6 ++++--
 include/linux/clk-provider.h               |    2 +-
 8 files changed, 13 insertions(+), 12 deletions(-)

--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -118,12 +118,11 @@ static unsigned int _get_val(const struc
 unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate,
 				  unsigned int val,
 				  const struct clk_div_table *table,
-				  unsigned long flags)
+				  unsigned long flags, unsigned long width)
 {
-	struct clk_divider *divider = to_clk_divider(hw);
 	unsigned int div;
 
-	div = _get_div(table, val, flags, divider->width);
+	div = _get_div(table, val, flags, width);
 	if (!div) {
 		WARN(!(flags & CLK_DIVIDER_ALLOW_ZERO),
 			"%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set\n",
@@ -145,7 +144,7 @@ static unsigned long clk_divider_recalc_
 	val &= div_mask(divider->width);
 
 	return divider_recalc_rate(hw, parent_rate, val, divider->table,
-				   divider->flags);
+				   divider->flags, divider->width);
 }
 
 static bool _is_valid_table_div(const struct clk_div_table *table,
--- a/drivers/clk/hisilicon/clkdivider-hi6220.c
+++ b/drivers/clk/hisilicon/clkdivider-hi6220.c
@@ -56,7 +56,7 @@ static unsigned long hi6220_clkdiv_recal
 	val &= div_mask(dclk->width);
 
 	return divider_recalc_rate(hw, parent_rate, val, dclk->table,
-				   CLK_DIVIDER_ROUND_CLOSEST);
+				   CLK_DIVIDER_ROUND_CLOSEST, dclk->width);
 }
 
 static long hi6220_clkdiv_round_rate(struct clk_hw *hw, unsigned long rate,
--- a/drivers/clk/nxp/clk-lpc32xx.c
+++ b/drivers/clk/nxp/clk-lpc32xx.c
@@ -956,7 +956,7 @@ static unsigned long clk_divider_recalc_
 	val &= div_mask(divider->width);
 
 	return divider_recalc_rate(hw, parent_rate, val, divider->table,
-				   divider->flags);
+				   divider->flags, divider->width);
 }
 
 static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
--- a/drivers/clk/qcom/clk-regmap-divider.c
+++ b/drivers/clk/qcom/clk-regmap-divider.c
@@ -59,7 +59,7 @@ static unsigned long div_recalc_rate(str
 	div &= BIT(divider->width) - 1;
 
 	return divider_recalc_rate(hw, parent_rate, div, NULL,
-				   CLK_DIVIDER_ROUND_CLOSEST);
+				   CLK_DIVIDER_ROUND_CLOSEST, divider->width);
 }
 
 const struct clk_ops clk_regmap_div_ops = {
--- a/drivers/clk/sunxi-ng/ccu_div.c
+++ b/drivers/clk/sunxi-ng/ccu_div.c
@@ -71,7 +71,7 @@ static unsigned long ccu_div_recalc_rate
 						  parent_rate);
 
 	val = divider_recalc_rate(hw, parent_rate, val, cd->div.table,
-				  cd->div.flags);
+				  cd->div.flags, cd->div.width);
 
 	if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		val /= cd->fixed_post_div;
--- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c
+++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c
@@ -698,7 +698,7 @@ static unsigned long dsi_pll_14nm_postdi
 	val &= div_mask(width);
 
 	return divider_recalc_rate(hw, parent_rate, val, NULL,
-				   postdiv->flags);
+				   postdiv->flags, width);
 }
 
 static long dsi_pll_14nm_postdiv_round_rate(struct clk_hw *hw,
--- a/drivers/rtc/rtc-ac100.c
+++ b/drivers/rtc/rtc-ac100.c
@@ -137,13 +137,15 @@ static unsigned long ac100_clkout_recalc
 		div = (reg >> AC100_CLKOUT_PRE_DIV_SHIFT) &
 			((1 << AC100_CLKOUT_PRE_DIV_WIDTH) - 1);
 		prate = divider_recalc_rate(hw, prate, div,
-					    ac100_clkout_prediv, 0);
+					    ac100_clkout_prediv, 0,
+					    AC100_CLKOUT_PRE_DIV_WIDTH);
 	}
 
 	div = (reg >> AC100_CLKOUT_DIV_SHIFT) &
 		(BIT(AC100_CLKOUT_DIV_WIDTH) - 1);
 	return divider_recalc_rate(hw, prate, div, NULL,
-				   CLK_DIVIDER_POWER_OF_TWO);
+				   CLK_DIVIDER_POWER_OF_TWO,
+				   AC100_CLKOUT_DIV_WIDTH);
 }
 
 static long ac100_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -412,7 +412,7 @@ extern const struct clk_ops clk_divider_
 
 unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate,
 		unsigned int val, const struct clk_div_table *table,
-		unsigned long flags);
+		unsigned long flags, unsigned long width);
 long divider_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
 			       unsigned long rate, unsigned long *prate,
 			       const struct clk_div_table *table,
