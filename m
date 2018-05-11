Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeEKURT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 16:17:19 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:41286 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeEKURQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 16:17:16 -0400
X-Google-Smtp-Source: AB8JxZpvRDjrG8WO78hmIi3tGJ+Zz3ik2vG48Xj36lNrPJi7gcqr5pd4ihKhw5KrDxs7yoZlI8sASbju6FjanMEpnys=
MIME-Version: 1.0
In-Reply-To: <20180509170159.29682-5-ilina@codeaurora.org>
References: <20180509170159.29682-1-ilina@codeaurora.org> <20180509170159.29682-5-ilina@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 11 May 2018 13:17:14 -0700
X-Google-Sender-Auth: WavOYWhSfQUMX-ZGj3xy6v9pNlM
Message-ID: <CAD=FV=VCAaGsRH1e46e+YSPJMYHgHGWf9TcH5UrcuJadQGsLtw@mail.gmail.com>
Subject: Re: [PATCH v8 04/10] drivers: qcom: rpmh: add RPMH helper functions
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
> +int rpmh_write(const struct device *dev, enum rpmh_state state,
> +              const struct tcs_cmd *cmd, u32 n)
> +{
> +       DECLARE_COMPLETION_ONSTACK(compl);
> +       DEFINE_RPMH_MSG_ONSTACK(dev, state, &compl, rpm_msg);
> +       int ret;
> +
> +       if (!cmd || !n || n > MAX_RPMH_PAYLOAD)
> +               return -EINVAL;
> +
> +       memcpy(rpm_msg.cmd, cmd, n * sizeof(*cmd));
> +       rpm_msg.msg.num_cmds = n;
> +
> +       ret = __rpmh_write(dev, state, &rpm_msg);
> +       if (ret)
> +               return ret;
> +
> +       ret = wait_for_completion_timeout(&compl, RPMH_TIMEOUT_MS);

IMO it's almost never a good idea to use wait_for_completion_timeout()
together with a completion that's declared on the stack.  If you
somehow insist that this is a good idea then I need to see incredibly
clear and obvious code/comments that say why it's impossible that the
process might somehow try to signal the completion _after_
RPMH_TIMEOUT_MS has expired.

Specifically if the timeout happens but the process could still signal
a completion later then they will access random data on the stack of a
function that has already returned.  This causes ridiculously
difficult-to-debug crashes.


NOTE: You've got timeout set to 10 seconds here.  Is that really even
useful?  IMO just call wait_for_completion() without a timeout.  It's
much better to have a nice clean hang than a random stack corruption.


-Doug
