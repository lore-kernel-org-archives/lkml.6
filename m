Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752830AbeDEW5D convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 18:57:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbeDEW5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 18:57:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E788E208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Amit Nischal <anischal@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <624665d7af39686d331c863ba7b9af4d@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk-owner@vger.kernel.org
References: <1520493495-3084-1-git-send-email-anischal@codeaurora.org>
 <1520493495-3084-5-git-send-email-anischal@codeaurora.org>
 <152150657982.254778.14132033041219278756@swboyd.mtv.corp.google.com>
 <624665d7af39686d331c863ba7b9af4d@codeaurora.org>
Message-ID: <152296902025.143116.550838977705296456@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 4/4] clk: qcom: Add Global Clock controller (GCC) driver for
 SDM845
Date: Thu, 05 Apr 2018 15:57:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Nischal (2018-04-03 05:24:41)
> On 2018-03-20 06:12, Stephen Boyd wrote:
> > Quoting Amit Nischal (2018-03-07 23:18:15)
> >> +};
> >> +
> >> +static struct clk_rcg2 gcc_sdcc4_apps_clk_src = {
> >> +       .cmd_rcgr = 0x1600c,
> >> +       .mnd_width = 8,
> >> +       .hid_width = 5,
> >> +       .parent_map = gcc_parent_map_0,
> >> +       .freq_tbl = ftbl_gcc_sdcc4_apps_clk_src,
> >> +       .safe_src_freq_tbl = &cxo_safe_src_f,
> > 
> > Why does sdcc have safe src stuff? Is something turning on the sdcc clk
> > outside of our control?
> 
> I will get more details on this and will get back.

Any news?

> 
> > 
> >> +       .clkr.hw.init = &(struct clk_init_data){
> >> +               .name = "gcc_sdcc4_apps_clk_src",
> >> +               .parent_names = gcc_parent_names_0,
> >> +               .num_parents = 4,
> >> +               .flags = CLK_SET_RATE_PARENT,
> >> +               .ops = &clk_rcg2_shared_ops,
> >> +       },
> >> +};
> >> +
> > [...]
> >> +
> >> +static struct clk_branch gcc_video_xo_clk = {
> >> +       .halt_reg = 0xb028,
> >> +       .halt_check = BRANCH_HALT,
> >> +       .clkr = {
> >> +               .enable_reg = 0xb028,
> >> +               .enable_mask = BIT(0),
> >> +               .hw.init = &(struct clk_init_data){
> >> +                       .name = "gcc_video_xo_clk",
> >> +                       .flags = CLK_IS_CRITICAL,
> >> +                       .ops = &clk_branch2_ops,
> >> +
> > 
> > These things have no parents and we mark them critical. Why are we
> > even exposing them to the kernel? Are they not on by default? Are we
> > going to change these to non-critical at some point in the future?
> 
> These clocks are not enabled by default and going to video or other
> multimedia cores so we are marking them as critical and need to expose
> to the kernel. As of now, there is no plan to change these to 
> non-critical.

Ok. Can we open code enabling these branches in the driver probe then?
Still seems wasteful if nobody uses these.

Put another way, either a driver (or other clk controller) should be
toggling these gates at runtime or we should enable them once and leave
them out of the framework. If the driver approach is taken, then the
drivers should be able to turn the clks on and off to save some power.
