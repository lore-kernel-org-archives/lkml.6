Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932173AbeCHS5g (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 13:57:36 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33523 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752072AbeCHS5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 13:57:34 -0500
X-Google-Smtp-Source: AG47ELu94zqU13GB1fThK5J5/ODZt/aa7n2PQlgCSCvlarRNeGZUa0Ch6gNOFv5gurq++/y5UYXAxg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Lina Iyer <ilina@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180302164317.10554-5-ilina@codeaurora.org>
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
References: <20180302164317.10554-1-ilina@codeaurora.org>
 <20180302164317.10554-5-ilina@codeaurora.org>
Message-ID: <152053545255.219802.8090966652300734692@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 04/10] drivers: qcom: rpmh: add RPMH helper functions
Date: Thu, 08 Mar 2018 10:57:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w28IviWe019944

Quoting Lina Iyer (2018-03-02 08:43:11)
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> new file mode 100644
> index 000000000000..d95ea3fa8b67
> --- /dev/null
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -0,0 +1,257 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/atomic.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/wait.h>
> +
> +#include <soc/qcom/rpmh.h>
> +
> +#include "rpmh-internal.h"
> +
> +#define RPMH_MAX_MBOXES                        2
> +#define RPMH_TIMEOUT                   (10 * HZ)

Can this be in ms instead of HZ units?

> +
> +/**
> + * rpmh_ctrlr: our representation of the controller
> + *
> + * @drv: the controller instance
> + */
> +struct rpmh_ctrlr {
> +       struct rsc_drv *drv;
> +};
> +
> +/**
> + * rpmh_client: the client object

same kernel doc issues here.

> + *
> + * @dev: the platform device that is the owner
> + * @ctrlr: the controller associated with this client.
> + */
> +struct rpmh_client {
> +       struct device *dev;
> +       struct rpmh_ctrlr *ctrlr;
> +};
> +
> +static struct rpmh_ctrlr rpmh_rsc[RPMH_MAX_MBOXES];
> +static DEFINE_MUTEX(rpmh_ctrlr_mutex);
> +
> +void rpmh_tx_done(struct tcs_request *msg, int r)
> +{
> +       struct rpmh_request *rpm_msg = container_of(msg,
> +                                                  struct rpmh_request, msg);
> +       atomic_t *wc = rpm_msg->wait_count;
> +       struct completion *compl = rpm_msg->completion;
> +
> +       rpm_msg->err = r;
> +
> +       if (r)
> +               dev_err(rpm_msg->rc->dev,
> +                      "RPMH TX fail in msg addr 0x%x, err=%d\n",
> +                      rpm_msg->msg.payload[0].addr, r);
> +
> +       /* Signal the blocking thread we are done */
> +       if (wc && atomic_dec_and_test(wc) && compl)

I don't understand this whole thing. The atomic variable is always set
to 1 in this patch, and then we will do a dec and test and then complete
when that happens. There is the case where it isn't assigned, but then
this logic doesn't happen at all. There must be some future code that
uses this? Can you add the atomic counting stuff in that patch when we
need to count more than one?

And then if that future happens, maybe consider changing from a count to
a chained DMA list style type of thing, where each message has a single
element that's written, but each message can have a 'wait' bit or not
that would cause this code to call complete if it's there. Then drivers
can wait on any certain part of the message completion (or multiple of
them) without us having to do a count.

> +               complete(compl);
> +}
> +EXPORT_SYMBOL(rpmh_tx_done);
> +
> +/**
> + * wait_for_tx_done: Wait until the response is received.
> + *
> + * @rc: The RPMH client
> + * @compl: The completion object
> + * @addr: An addr that we sent in that request
> + * @data: The data for the address in that request
> + *
> + */
> +static int wait_for_tx_done(struct rpmh_client *rc,
> +                          struct completion *compl, u32 addr, u32 data)
> +{
> +       int ret;
> +
> +       ret = wait_for_completion_timeout(compl, RPMH_TIMEOUT);
> +       if (ret)
> +               dev_dbg(rc->dev,
> +                      "RPMH response received addr=0x%x data=0x%x\n",
> +                      addr, data);
> +       else
> +               dev_err(rc->dev,
> +                       "RPMH response timeout addr=0x%x data=0x%x\n",
> +                       addr, data);
> +
> +       return (ret > 0) ? 0 : -ETIMEDOUT;
> +}
> +
> +/**
> + * __rpmh_write: send the RPMH request
> + *
> + * @rc: The RPMH client
> + * @state: Active/Sleep request type
> + * @rpm_msg: The data that needs to be sent (payload).
> + */
> +static int __rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
> +                      struct rpmh_request *rpm_msg)
> +{
> +       int ret = -EFAULT;

Not sure -EFAULT is the right error value here. -EINVAL?

> +
> +       rpm_msg->msg.state = state;
> +
> +       if (state == RPMH_ACTIVE_ONLY_STATE) {
> +               WARN_ON(irqs_disabled());
> +               ret = rpmh_rsc_send_data(rc->ctrlr->drv, &rpm_msg->msg);
> +               if (!ret)
> +                       dev_dbg(rc->dev,
> +                              "RPMH request sent addr=0x%x, data=0x%x\n",
> +                              rpm_msg->msg.payload[0].addr,
> +                              rpm_msg->msg.payload[0].data);
> +               else
> +                       dev_warn(rc->dev,
> +                               "Error in RPMH request addr=0x%x, data=0x%x\n",
> +                               rpm_msg->msg.payload[0].addr,
> +                               rpm_msg->msg.payload[0].data);
> +       }
> +
> +       return ret;
> +}
> +
> +/**
> + * rpmh_write: Write a set of RPMH commands and block until response
> + *
> + * @rc: The RPMh handle got from rpmh_get_dev_channel
> + * @state: Active/sleep set
> + * @cmd: The payload data
> + * @n: The number of elements in payload
> + *
> + * May sleep. Do not call from atomic contexts.
> + */
> +int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
> +             struct tcs_cmd *cmd, int n)
> +{
> +       DECLARE_COMPLETION_ONSTACK(compl);
> +       atomic_t wait_count = ATOMIC_INIT(1);
> +       DEFINE_RPMH_MSG_ONSTACK(rc, state, &compl, &wait_count, rpm_msg);
> +       int ret;
> +
> +       if (IS_ERR_OR_NULL(rc) || !cmd || n <= 0 || n > MAX_RPMH_PAYLOAD)

How is rc IS_ERR_OR_NULL at this point?

Should n be unsigned then?

> +               return -EINVAL;
> +
> +       might_sleep();

The wait_for_tx_done() would handle this might_sleep?

> +
> +       memcpy(rpm_msg.cmd, cmd, n * sizeof(*cmd));
> +       rpm_msg.msg.num_payload = n;
> +
> +       ret = __rpmh_write(rc, state, &rpm_msg);
> +       if (ret)
> +               return ret;
> +
> +       return wait_for_tx_done(rc, &compl, cmd[0].addr, cmd[0].data);
> +}
> +EXPORT_SYMBOL(rpmh_write);
> +
> +static struct rpmh_ctrlr *get_rpmh_ctrlr(struct platform_device *pdev)
> +{
> +       int i;
> +       struct rsc_drv *drv = dev_get_drvdata(pdev->dev.parent);
> +       struct rpmh_ctrlr *ctrlr = ERR_PTR(-EFAULT);

Not sure -EFAULT is the right error value here.

> +
> +       if (!drv)
> +               return ctrlr;
> +
> +       mutex_lock(&rpmh_ctrlr_mutex);
> +       for (i = 0; i < RPMH_MAX_MBOXES; i++) {
> +               if (rpmh_rsc[i].drv == drv) {
> +                       ctrlr = &rpmh_rsc[i];
> +                       goto unlock;
> +               }
> +       }
> +
> +       for (i = 0; i < RPMH_MAX_MBOXES; i++) {
> +               if (rpmh_rsc[i].drv == NULL) {
> +                       ctrlr = &rpmh_rsc[i];
> +                       ctrlr->drv = drv;
> +                       break;
> +               }
> +       }
> +       WARN_ON(i == RPMH_MAX_MBOXES);
> +unlock:
> +       mutex_unlock(&rpmh_ctrlr_mutex);
> +       return ctrlr;
> +}
> +
> +/**
> + * rpmh_get_client: Get the RPMh handle
> + *
> + * @pdev: the platform device which needs to communicate with RPM
> + * accelerators
> + * May sleep.
> + */
> +struct rpmh_client *rpmh_get_client(struct platform_device *pdev)

Given that the child devices are fairly well aware that they're rpmh
device drivers, why do we need this set of APIs in a different file and
also why do we need to have a client cookie design? It would make sense
to have the cookie if the device hierarchy wasn't direct, but that
doesn't seem to be the case here. Also it would make things easier to
follow if the code was folded into the same C file. It looks like we may
have two files exporting symbols to each other but not anywhere else.

Take a look at clk-rpm.c in clk/qcom and you'll see that we don't do any
sort of client cookie. Instead, the parent device drv data has the
pointer we want to get, and then the rpm APIs take that pointer.

> +{
> +       struct rpmh_client *rc;
> +
> +       rc = kzalloc(sizeof(*rc), GFP_KERNEL);
> +       if (!rc)
