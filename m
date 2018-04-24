Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeDXPkN convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750935AbeDXPkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:40:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB22521735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Taniya Das <tdas@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <2b0ba677-921c-c6e0-00d2-ac5bdefd2d6b@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>
References: <1523673401-21611-1-git-send-email-tdas@codeaurora.org>
 <1523673401-21611-3-git-send-email-tdas@codeaurora.org>
 <152390031768.51482.12790579493617671456@swboyd.mtv.corp.google.com>
 <2b0ba677-921c-c6e0-00d2-ac5bdefd2d6b@codeaurora.org>
Message-ID: <152458440904.46528.10430507697972810594@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 2/2] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
Date: Tue, 24 Apr 2018 08:40:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-04-23 09:50:22)
> On 4/16/2018 11:08 PM, Stephen Boyd wrote:
> > Quoting Taniya Das (2018-04-13 19:36:41)
> 
> >> +struct clk_rpmh {
> >> +       struct clk_hw hw;
> >> +       const char *res_name;
> >> +       u32 res_addr;
> >> +       u32 res_en_offset;
> > 
> > Why do we store both res_addr and res_en_offset? Can't we just store
> > res_en_offset and then use that all the time? I don't see a user of
> > res_addr anywhere.
> > 
> 
> The res_addr would be the address for the resource returned by the 
> cmd_db_read_addr. And the res_en_offset would be the offsets of ARC_EN 
> or VRM_EN.

Yes. But why can't we store the combination of the two?

> 
> >> +       u32 res_on_val;
> >> +       u32 res_off_val;
> > 
> > Is this used?
> 
> Yes the above are used.

I just meant res_off_val. Which looks unused.

> > 
> >> +       u32 state;
> >> +       u32 aggr_state;
> >> +       u32 last_sent_aggr_state;
> >> +       u32 valid_state_mask;
> >> +       struct rpmh_client *rpmh_client;
> >> +       struct device *dev;
> >> +       struct clk_rpmh *peer;
> >> +       unsigned long rate;
> >> +};
> > 
> > Can you add some kernel-doc on these structure members?
> > 
> Sure will add the same.

Great! Hopefully that clarifies things.

> >> +       /*
> >> +        * RPMh clocks have a fixed rate. Return static rate set
> >> +        * at init time.
> >> +        */
> >> +       return r->rate;
> > 
> > The rate should come from the parent. In the case of tcxo it would be
> > board_xo clk rate (or maybe some fixed div-2 on the board XO that's also
> > defined in DT because the board_xo seems to be two times 19.2 MHz?).
> > 
> 
> There would not be any parent for the RPMH clock, they would be the 
> parent for other clocks.
> 
> The TCXO is 19.2MHz and once we have the RPMH clocks, we would remove 
> the DT reference for board_xo.

No that's wrong. There is a parent of the RPMh clks, and that's the
board XO clk in the DT file. We will never remove the board clks.
