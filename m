Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57254C282D7
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 15:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28ADF20844
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 15:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfBJPuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 10:50:54 -0500
Received: from gloria.sntech.de ([185.11.138.130]:48792 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfBJPux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 10:50:53 -0500
Received: from p54b26fa7.dip0.t-ipconnect.de ([84.178.111.167] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gsrNU-0000MQ-SP; Sun, 10 Feb 2019 16:50:44 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: fractional-divider: check parent rate only if flag is set
Date:   Sun, 10 Feb 2019 16:50:10 +0100
Message-ID: <1772879.g6DUe2Ua28@phil>
In-Reply-To: <20190210153806.24201-1-katsuhiro@katsuster.net>
References: <20190210153806.24201-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 10. Februar 2019, 16:38:06 CET schrieb Katsuhiro Suzuki:
> Custom approximation of fractional-divider may not need parent clock
> rate checking. For example Rockchip SoCs work fine using grand parent
> clock rate even if target rate is greater than parent.
> 
> This patch checks parent clock rate only if CLK_SET_RATE_PARENT flag
> is set.
> 
> For detailed example, clock tree of Rockchip I2S audio hardware.
>   - Clock rate of CPLL is 1.2GHz, GPLL is 491.52MHz.
>   - i2s1_div is integer divider can divide N (N is 1~128).
>     Input clock is CPLL or GPLL. Initial divider value is N = 1.
>     Ex) PLL = CPLL, N = 10, i2s1_div output rate is
>       CPLL / 10 = 1.2GHz / 10 = 120MHz
>   - i2s1_frac is fractional divider can divide input to x/y, x and
>     y are 16bit integer.
> 
> CPLL --> | selector | ---> i2s1_div -+--> | selector | --> I2S1 MCLK
> GPLL --> |          | ,--------------'    |          |
>                       `--> i2s1_frac ---> |          |
> 
> Clock mux system try to choose suitable one from i2s1_div and
> i2s1_frac for master clock (MCLK) of I2S1.
> 
> Bad scenario as follows:
>   - Try to set MCLK to 8.192MHz (32kHz audio replay)
>     Candidate setting is
>     - i2s1_div: GPLL / 60 = 8.192MHz
>     i2s1_div candidate is exactly same as target clock rate, so mux
>     choose this clock source. i2s1_div output rate is changed
>     491.52MHz -> 8.192MHz
> 
>   - After that try to set to 11.2896MHz (44.1kHz audio replay)
>     Candidate settings are
>     - i2s1_div : CPLL / 107 = 11.214945MHz
>     - i2s1_frac: i2s1_div   = 8.192MHz
>       This is because clk_fd_round_rate() thinks target rate
>       (11.2896MHz) is higher than parent rate (i2s1_div = 8.192MHz)
>       and returns parent clock rate.
> 
> Above is current upstreamed behavior. Clock mux system choose
> i2s1_div, but this clock rate is not acceptable for I2S driver, so
> users cannot replay audio.
> 
> Expected behavior is:
>   - Try to set master clock to 11.2896MHz (44.1kHz audio replay)
>     Candidate settings are
>     - i2s1_div : CPLL / 107          = 11.214945MHz
>     - i2s1_frac: i2s1_div * 147/6400 = 11.2896MHz
>                  Change i2s1_div to GPLL / 1 = 491.52MHz at same
>                  time.
> 
> If apply this commit, clk_fd_round_rate() calls custom approximate
> function of Rockchip even if target rate is higher than parent.
> Custom function changes both grand parent (i2s1_div) and parent
> (i2s_frac) settings at same time. Clock mux system can choose
> i2s1_frac and audio works fine.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

While it took me a bit to wrap my head around fractional dividers
again :-) ... this sounds definitly sensible to do, especially
as the clock driver should really take into account potentially
setting the parent rate if possible, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/clk/clk-fractional-divider.c | 2 +-
>  drivers/clk/clk.c                    | 8 ++++++++
>  include/linux/clk-provider.h         | 1 +
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
> index 545dceec0bbf..fdfe2e423d15 100644
> --- a/drivers/clk/clk-fractional-divider.c
> +++ b/drivers/clk/clk-fractional-divider.c
> @@ -79,7 +79,7 @@ static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
>  	unsigned long m, n;
>  	u64 ret;
>  
> -	if (!rate || rate >= *parent_rate)
> +	if (!rate || (!clk_hw_can_set_rate_parent(hw) && rate >= *parent_rate))
>  		return *parent_rate;
>  
>  	if (fd->approximation)
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index d2477a5058ac..070c0cb29ee8 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -518,6 +518,14 @@ void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
>  }
>  EXPORT_SYMBOL_GPL(clk_hw_set_rate_range);
>  
> +bool clk_hw_can_set_rate_parent(struct clk_hw *hw)
> +{
> +	unsigned long flags = clk_hw_get_flags(hw);
> +
> +	return flags & CLK_SET_RATE_PARENT;
> +}
> +EXPORT_SYMBOL_GPL(clk_hw_can_set_rate_parent);
> +
>  /*
>   * Helper for finding best parent to provide a given frequency. This can be used
>   * directly as a determine_rate callback (e.g. for a mux), or from a more
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index e443fa9fa859..693a51937ded 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -808,6 +808,7 @@ int clk_mux_determine_rate_flags(struct clk_hw *hw,
>  void clk_hw_reparent(struct clk_hw *hw, struct clk_hw *new_parent);
>  void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
>  			   unsigned long max_rate);
> +bool clk_hw_can_set_rate_parent(struct clk_hw *hw);
>  
>  static inline void __clk_hw_set_clk(struct clk_hw *dst, struct clk_hw *src)
>  {
> 




