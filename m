Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbeDJRGI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 13:06:08 -0400
Received: from mail-ot0-f181.google.com ([74.125.82.181]:44103 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbeDJRGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 13:06:02 -0400
X-Google-Smtp-Source: AIpwx4/gsV3h/tF8E51YfG0BEDak9nOCq0zDTQuPdWnk9c/jA99QQ5q5+4TEqQ8pXcRXkDFH9NHYhQ==
MIME-Version: 1.0
References: <1522304274-18989-1-git-send-email-tdas@codeaurora.org>
 <1522304274-18989-2-git-send-email-tdas@codeaurora.org> <CAE=gft6-FggNjP0nj6XrLN1rQqnep_PHHWg2fiRUrM8ZBf36Sg@mail.gmail.com>
 <65abfb98-802a-d7aa-5213-9fcd531b18d9@codeaurora.org> <152297026107.143116.8868825918169537109@swboyd.mtv.corp.google.com>
In-Reply-To: <152297026107.143116.8868825918169537109@swboyd.mtv.corp.google.com>
From: Evan Green <evgreen@chromium.org>
Date: Tue, 10 Apr 2018 17:05:23 +0000
X-Gmail-Original-Message-ID: <CAE=gft6q8ELJCN5JU5svS6cYHO65GMFKTVrHT9wu_mpr-j1-xw@mail.gmail.com>
Message-ID: <CAE=gft6q8ELJCN5JU5svS6cYHO65GMFKTVrHT9wu_mpr-j1-xw@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
To: sboyd@kernel.org
Cc: tdas@codeaurora.org, sboyd@codeaurora.org,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, okukatla@codeaurora.org,
        anischal@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, collinsd@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 5, 2018 at 4:17 PM Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Taniya Das (2018-04-02 03:33:26)
> >
> > >
> > >> +
> > >> +#include "common.h"
> > >> +#include "clk-regmap.h"
> > >> +
> > >> +#define CLK_RPMH_ARC_EN_OFFSET 0
> > >> +#define CLK_RPMH_VRM_EN_OFFSET 4
> > >> +#define CLK_RPMH_VRM_OFF_VAL 0
> > >> +#define CLK_RPMH_VRM_ON_VAL 1
> > >> +#define CLK_RPMH_APPS_RSC_AO_STATE_MASK (BIT(RPMH_WAKE_ONLY_STATE)
| \
> > >> +                                        BIT(RPMH_ACTIVE_ONLY_STATE))
> > >> +#define CLK_RPMH_APPS_RSC_STATE_MASK (BIT(RPMH_WAKE_ONLY_STATE) | \
> > >> +                                     BIT(RPMH_ACTIVE_ONLY_STATE) | \
> > >> +                                     BIT(RPMH_SLEEP_STATE))
> > >> +struct clk_rpmh {
> > >> +       const char *res_name;
> > >> +       u32 res_addr;
> > >> +       u32 res_en_offset;
> > >> +       u32 res_on_val;
> > >> +       u32 res_off_val;
> > >> +       u32 state;
> > >> +       u32 aggr_state;
> > >> +       u32 last_sent_aggr_state;
> > >> +       u32 valid_state_mask;
> > >> +       struct rpmh_client *rpmh_client;
> > >> +       unsigned long rate;
> > >> +       struct clk_rpmh *peer;
> > >> +       struct clk_hw hw;
> > >
> > > I believe this member should go at the beginning of the structure. At
least
> > > that's what everyone else seems to do, and that's what the clk.txt
> > > documentation seems to ask for.
> > >
> >
> > Yes I missed that, would update it in the next patch series.

> Where is the documentation asking for that? There isn't any place that
> clk_hw should be in a structure. container_of() can figure it out all
> the time, and that macro is preferred instead of plain casts from one
> type to another because it provides slightly more type safety.

Perhaps I'm reading too strictly into the documentation, but this was the
passage that gave me that idea:

To construct a clk hardware structure for your platform you must define
the following::

struct clk_foo {
struct clk_hw hw;
... hardware specific data goes here ...
};

-Evan
