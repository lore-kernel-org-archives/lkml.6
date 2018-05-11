Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752049AbeEKUPr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 16:15:47 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:45986 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeEKUPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 16:15:45 -0400
X-Google-Smtp-Source: AB8JxZrKzBXeN8exMdwO8Gsxl8FA7A48eBb6xglOjRzgD2yHYAgSEzai+RmPKtHffhFGJjmIcLv+9rRRu5kMFBA83rY=
MIME-Version: 1.0
In-Reply-To: <20180509170159.29682-2-ilina@codeaurora.org>
References: <20180509170159.29682-1-ilina@codeaurora.org> <20180509170159.29682-2-ilina@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 11 May 2018 13:15:43 -0700
X-Google-Sender-Auth: STkCBZE33PCvIrjl0lDlrufdYG0
Message-ID: <CAD=FV=UV9tGt9Pvj-zb0CP692=BxgqYVkb4iTj+R4qjjn34tgQ@mail.gmail.com>
Subject: Re: [PATCH v8 01/10] drivers: qcom: rpmh-rsc: add RPMH controller for
 QCOM SoCs
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
> +int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
> +{
> +       int ret;
> +
> +       if (!msg || !msg->cmds || !msg->num_cmds ||
> +           msg->num_cmds > MAX_RPMH_PAYLOAD) {
> +               WARN_ON(1);
> +               return -EINVAL;
> +       }
> +
> +       do {
> +               ret = tcs_write(drv, msg);
> +               if (ret == -EBUSY) {
> +                       pr_info_ratelimited("TCS Busy, retrying RPMH message send: addr=%#x\n",
> +                                           msg->cmds[0].addr);
> +                       udelay(10);
> +               }
> +       } while (ret == -EBUSY);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL(rpmh_rsc_send_data);

Here and elsewhere in this series: why EXPORT_SYMBOL in this case?
This is only exported to rpmh.c, right?  You don't need EXPORT_SYMBOL
for that.  The Makefile puts rpmh.c and rpmh-rsc.c together in the
same "qcom_rpmh.o", and then even further the KConfig lists this as
bool so both are builtin to the kernel.

-Doug
