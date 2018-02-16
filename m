Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751026AbeBPXvP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 18:51:15 -0500
Received: from mail-oi0-f49.google.com ([209.85.218.49]:39841 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeBPXvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 18:51:13 -0500
X-Google-Smtp-Source: AH8x224aajKCdbedBTcp643vpqAcR1NI1Zxco1rbbBFc+2wcgcr+EDFs4WW7oS5gexfAYm+4ezddAQ==
MIME-Version: 1.0
In-Reply-To: <20180215173507.10989-6-ilina@codeaurora.org>
References: <20180215173507.10989-1-ilina@codeaurora.org> <20180215173507.10989-6-ilina@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Fri, 16 Feb 2018 15:50:29 -0800
X-Gmail-Original-Message-ID: <CAE=gft5vEa69ML7mu=-=dg8Djb5dGdbs01PnwAYcJmSPioNasg@mail.gmail.com>
Message-ID: <CAE=gft5vEa69ML7mu=-=dg8Djb5dGdbs01PnwAYcJmSPioNasg@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] drivers: qcom: rpmh-rsc: write sleep/wake
 requests to TCS
To: Lina Iyer <ilina@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lina,

On Thu, Feb 15, 2018 at 9:35 AM, Lina Iyer <ilina@codeaurora.org> wrote:
> Sleep and wake requests are sent when the application processor
> subsystem of the SoC is entering deep sleep states like in suspend.
> These requests help lower the system power requirements when the
> resources are not in use.
>
> Sleep and wake requests are written to the TCS slots but are not
> triggered at the time of writing. The TCS are triggered by the firmware
> after the last of the CPUs has executed its WFI. Since these requests
> may come in different batches of requests, it is job of this controller
> driver to find arrange the requests into the available TCSes.
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmh-internal.h |   7 +++
>  drivers/soc/qcom/rpmh-rsc.c      | 126 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 133 insertions(+)
>
[...]
> +static int find_slots(struct tcs_group *tcs, struct tcs_request *msg,
> +                    int *m, int *n)
> +{
> +       int slot, offset;
> +       int i = 0;
> +
> +       /* Find if we already have the msg in our TCS */
> +       slot = find_match(tcs, msg->payload, msg->num_payload);
> +       if (slot >= 0)
> +               goto copy_data;
> +
> +       /* Do over, until we can fit the full payload in a TCS */
> +       do {
> +               slot = bitmap_find_next_zero_area(tcs->slots, MAX_TCS_SLOTS,
> +                                                i, msg->num_payload, 0);
> +               if (slot == MAX_TCS_SLOTS)
> +                       break;
> +               i += tcs->ncpt;
> +       } while (slot + msg->num_payload - 1 >= i);
> +
> +       if (slot == MAX_TCS_SLOTS)
> +               return -ENOMEM;
> +
> +copy_data:
> +       bitmap_set(tcs->slots, slot, msg->num_payload);
> +       /* Copy the addresses of the resources over to the slots */
> +       for (i = 0; tcs->cmd_addr && i < msg->num_payload; i++)

I don't think tcs->cmd_addr can be null, can it? Above, find_match()
is already reaching through cmd_addr with enthusiasm. If kept, it
could at least be moved outside of the loop.

Evan
