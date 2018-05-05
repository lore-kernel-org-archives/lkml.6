Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeEEDOl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 23:14:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751508AbeEEDOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 23:14:39 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Amit Nischal <anischal@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <a56ffa424689ff354a63642bf2998088@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1525105210-8689-1-git-send-email-anischal@codeaurora.org>
 <1525105210-8689-4-git-send-email-anischal@codeaurora.org>
 <152524580953.138124.2159165461856101134@swboyd.mtv.corp.google.com>
 <a56ffa424689ff354a63642bf2998088@codeaurora.org>
Message-ID: <152549007801.138124.1209193202019560634@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 3/3] clk: qcom: Add Global Clock controller (GCC) driver for
 SDM845
Date: Fri, 04 May 2018 20:14:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w453EkGG003049

Quoting Amit Nischal (2018-05-04 03:45:12)
> On 2018-05-02 12:53, Stephen Boyd wrote:
> > Quoting Amit Nischal (2018-04-30 09:20:10)
> >> +
> >> +static struct clk_branch gcc_disp_gpll0_clk_src = {
> >> +       .halt_reg = 0x52004,
> >> +       .halt_check = BRANCH_HALT_DELAY,
> > 
> > What about this one? It's not a phy so I'm confused again why we're
> > unable to check the halt bit. To be clear(er), I don't see why we ever
> > want to have HALT_DELAY used. Hopefully we can remove that flag.
> > 
> > From what I recall, the flag is there for clks that don't toggle their
> > status bit at all, but that we know take a few cycles to ungate the
> > upstream clk. So we threw a delay into the code to make sure that when
> > clk_enable() returned, a driver wouldn't try to use hardware before the
> > clk was actually on. But these cases should pretty much never happen,
> > hence all the pushback against this flag.
> > 
> 
> For these "*gpll0_clk_src" and "*gpll0_div_clk" clocks, there is no halt
> bit to check the status and it is required to have delay for few cycles
> so that clock gets turned on before a client driver to use the hardware.

Ok.. but then why is there a 'halt_reg' configured for the clk?

> >> +
> >> +static struct clk_branch gcc_ufs_card_rx_symbol_0_clk = {
> >> +       .halt_reg = 0x75018,
> >> +       .halt_check = BRANCH_HALT_DELAY,
> > 
> > There are still HALT_DELAY flags for UFS though? Why?
> 
> For ufs_card tx/rx symbol clocks, we don't poll the status bit as
> per the recommendation from the HW team. We can change the halt_check
> type to newly implemented flag "BRANCH_HALT_SKIP". Please update us with
> your thoughts to change the flag to "BRANCH_HALT_SKIP".

Yes use HALT_SKIP please.

> 
> > 
> > Also, are you going to send DFS support for the QUP clks? I would like
> > to see that code merged soon.
> 
> Taniya has sent the patches for DFS support for QUP clocks.
> https://patchwork.kernel.org/patch/10376951/
> 

I'll take a look.
