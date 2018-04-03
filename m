Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbeDCR4f (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:56:35 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:45720 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751773AbeDCR4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:56:34 -0400
X-Google-Smtp-Source: AIpwx4815vF56Ddh5OCu42908HbkUt4isdUgu4Kz8ZZBWAQp5QeVUPz7KJmds/1kgRHXk7PSvuqp1A==
MIME-Version: 1.0
References: <1522304274-18989-1-git-send-email-tdas@codeaurora.org>
 <1522304274-18989-2-git-send-email-tdas@codeaurora.org> <CAE=gft6-FggNjP0nj6XrLN1rQqnep_PHHWg2fiRUrM8ZBf36Sg@mail.gmail.com>
 <65abfb98-802a-d7aa-5213-9fcd531b18d9@codeaurora.org>
In-Reply-To: <65abfb98-802a-d7aa-5213-9fcd531b18d9@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Tue, 03 Apr 2018 17:55:55 +0000
X-Gmail-Original-Message-ID: <CAE=gft5WsHBkt3N=pMRmKqtw4SOks9xm4J9bv8b74nMatF5_7Q@mail.gmail.com>
Message-ID: <CAE=gft5WsHBkt3N=pMRmKqtw4SOks9xm4J9bv8b74nMatF5_7Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
To: tdas@codeaurora.org
Cc: sboyd@codeaurora.org, Michael Turquette <mturquette@baylibre.com>,
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

Hi Taniya,

On Mon, Apr 2, 2018 at 3:33 AM Taniya Das <tdas@codeaurora.org> wrote:

> Hello Evan,

> Thanks for the review comments.

> On 3/30/2018 3:19 AM, Evan Green wrote:
> > Hi Taniya,
> >
> > On Wed, Mar 28, 2018 at 11:19 PM Taniya Das <tdas@codeaurora.org> wrote:
> >
> >> From: Amit Nischal <anischal@codeaurora.org>

> >> +static int clk_rpmh_send_aggregate_command(struct clk_rpmh *c)
> >> +{
> >> +       struct tcs_cmd cmd = { 0 };
> >> +       int ret = 0;
> >> +
> >> +       cmd.addr = c->res_addr + c->res_en_offset;
> >> +
> >> +       if (has_state_changed(c, RPMH_SLEEP_STATE)) {
> >> +               cmd.data = (c->aggr_state >> RPMH_SLEEP_STATE) & 1
> >> +                       ? c->res_on_val : c->res_off_val;
> >
> > I found it quite confusing that you're shifting in the opposite
direction
> > than in has_state_changed. How about this:
> >
> > cmd.data = (c->aggr_state & BIT(RPMH_SLEEP_STATE)) ? c->res_on_val :
> > c->res_off_val;
> >

> It is kept keeping in mind the consistency of the command data for all
> the different states.

> Would it be better if I define a new macro ?

> #define RPMH_CMD_DATA(aggr_state, rpmh_state) \
>           ((aggr_state >> rpmh_state) & 1)

> If you agree, I could use the new macro in the next series.


I'm afraid I don't really understand the "consistency of command data for
all the different states". It seems like every other time you refer to a
state mask (eg state, valid_state_mask, and all the *_STATE_MASK defines,
you use BIT(state). The version above seemed like an unnecessarily
confusing variant. In this case, aggr_state is only being used as a
conditional to determine whether to put the res_on or off value, so it's
not like that form is needed because of hardware bitfields or something.
All of the state-like members seem to be purely software masks.

Anyway, I'll leave it to you after this. If you choose to keep the shifts
as written and hide them behind a macro, the name as you've suggested isn't
great, as that macro only gives you the conditional for which data to use,
not the data itself as the macro name might have you believe.

-Evan
