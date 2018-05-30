Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932555AbeE3Vtg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:49:36 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:39684 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932382AbeE3Vtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:49:33 -0400
X-Google-Smtp-Source: ADUXVKK0JjoBB7J7rmPxpovu0SqzrqSHWpiTxd6Jojog0mfBEHRAAuyEQ1wKjzo32JQYgg10dHEx3K4gzbDA7JT0II8=
MIME-Version: 1.0
In-Reply-To: <1527158731-17685-5-git-send-email-rplsssn@codeaurora.org>
References: <1527158731-17685-1-git-send-email-rplsssn@codeaurora.org> <1527158731-17685-5-git-send-email-rplsssn@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 May 2018 14:49:31 -0700
X-Google-Sender-Auth: kKmunvuWJAQ7FI3smE13hAmV8sY
Message-ID: <CAD=FV=V9TP-d33nc8Wq53C+KaDZffi7Vjtp5yDwdjvTP+aeb6A@mail.gmail.com>
Subject: Re: [PATCH v9 04/10] drivers: qcom: rpmh: add RPMH helper functions
To: Raju P L S S S N <rplsssn@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 24, 2018 at 3:45 AM, Raju P L S S S N
<rplsssn@codeaurora.org> wrote:
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -61,6 +61,8 @@
>  #define CMD_STATUS_ISSUED              BIT(8)
>  #define CMD_STATUS_COMPL               BIT(16)
>
> +LIST_HEAD(rsc_drv_list);

I still see no point of rsc_drv_list.  Please remove it, AKA squash in
<http://crosreview.com/1042883>.

I'm also still of the opinion that we should take something like
<http://crosreview.com/1054646>, AKA "Get rid of the global array
rpmh_rsc".


> +/**
> + * __rpmh_write: send the RPMH request
> + *
> + * @dev: The device making the request
> + * @state: Active/Sleep request type
> + * @rpm_msg: The data that needs to be sent (cmds).
> + */
> +static int __rpmh_write(const struct device *dev, enum rpmh_state state,
> +                       struct rpmh_request *rpm_msg)
> +{
> +       struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
> +
> +       if (IS_ERR(ctrlr))
> +               return PTR_ERR(ctrlr);
> +
> +       rpm_msg->msg.state = state;
> +
> +       if (state != RPMH_ACTIVE_ONLY_STATE)
> +               return -EINVAL;
> +
> +       WARN_ON(irqs_disabled());
> +
> +       return rpmh_rsc_send_data(ctrlr->drv, &rpm_msg->msg);
> +}

You went too far in the removal of EXPORT_SYMBOL I think.  This symbol
needs to be exported because other code that could be compiled as a
module might need to call into it.  To explain:

* If two files that are always built-in to Linux need to call into
each other: no need for EXPORT_SYMBOL.

* If two files that are always part of the same module need to call
into each other: no need for EXPORT_SYMBOL.

* If one file that might be built-into a module needs to call another
that's builtin to the kernel: need EXPORT_SYMBOL.


-Doug
