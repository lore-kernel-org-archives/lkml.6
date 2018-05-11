Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeEKUQX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 16:16:23 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:41244 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeEKUQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 16:16:21 -0400
X-Google-Smtp-Source: AB8JxZr2bEKcpt3eZmUKIm4ZfncyBT54U0YrOi55oEPDzoenTjEYDrAt1tEBvBvPZlRq2eWFWlZuXSyF3YzHh88C12c=
MIME-Version: 1.0
In-Reply-To: <20180509170159.29682-9-ilina@codeaurora.org>
References: <20180509170159.29682-1-ilina@codeaurora.org> <20180509170159.29682-9-ilina@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 11 May 2018 13:16:19 -0700
X-Google-Sender-Auth: CzZ5QuVXHyen0Da5cACUGWTwLL0
Message-ID: <CAD=FV=WmXkW1ms=4=25z=o7wt_uBZgS2t1SZr6qRLhP=B_bBMg@mail.gmail.com>
Subject: Re: [PATCH v8 08/10] drivers: qcom: rpmh: allow requests to be sent asynchronously
To: Lina Iyer <ilina@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, rplsssn@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 9, 2018 at 10:01 AM, Lina Iyer <ilina@codeaurora.org> wrote:
>  /**
> @@ -137,6 +140,8 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
>                 dev_err(rpm_msg->dev, "RPMH TX fail in msg addr=%#x, err=%d\n",
>                         rpm_msg->msg.cmds[0].addr, r);
>
> +       kfree(rpm_msg->free);
> +

The way the code is written makes it seem like you could free memory
_and_ have a completion but you can't.  Specifically:

* The only plausible thing that "rpm_msg->free" could point to is "rpm_msg".

* The complete(compl) would then be accessing freed memory.


I believe the kfree() should be at the end of the function.
Personally I'd make it more obvious that this is just a boolean value
and change to:

if (rpm_msg->needs_free)
  kgree(rpm_msg)

...then the reader of the code doesn't need to go figure out what
you're trying to free.


-Doug
