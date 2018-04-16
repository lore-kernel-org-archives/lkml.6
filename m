Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753398AbeDPTvr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 15:51:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38730 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbeDPTvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 15:51:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ADB75601E8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Mon, 16 Apr 2018 13:51:42 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH v5 01/10] drivers: qcom: rpmh-rsc: add RPMH controller
 for QCOM SoCs
Message-ID: <20180416195142.GF1209@codeaurora.org>
References: <20180405161834.3850-1-ilina@codeaurora.org>
 <20180405161834.3850-2-ilina@codeaurora.org>
 <152342153642.180276.4927130412537860735@swboyd.mtv.corp.google.com>
 <20180413153725.GA1209@codeaurora.org>
 <152364140661.51482.261490347611407195@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <152364140661.51482.261490347611407195@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13 2018 at 11:43 -0600, Stephen Boyd wrote:
>Quoting Lina Iyer (2018-04-13 08:37:25)
>> On Tue, Apr 10 2018 at 22:39 -0600, Stephen Boyd wrote:
>> >Quoting Lina Iyer (2018-04-05 09:18:25)
>> >>
>> >> + */
>> >> +static irqreturn_t tcs_irq_handler(int irq, void *p)
>> >> +{
>> >> +       struct rsc_drv *drv = p;
>> >> +       int m, i;
>> >> +       u32 irq_status, sts;
>> >> +       struct tcs_response *resp;
>> >> +       struct tcs_cmd *cmd;
>> >> +
>> >> +       irq_status = read_tcs_reg(drv, RSC_DRV_IRQ_STATUS, 0, 0);
>> >> +
>> >> +       for (m = 0; m < drv->num_tcs; m++) {
>> >> +               if (!(irq_status & (u32)BIT(m)))
>
>This u32 cast looks out of place. And can't we do for_each_set_bit() in
>this loop instead of looping through num_tcs?
>
Ok.

>> >> +                       continue;
>> >> +
>> >> +               resp = get_response(drv, m);
>> >> +               if (WARN_ON(!resp))
>> >> +                       goto skip_resp;
>> >> +
>> >> +               resp->err = 0;
>> >> +               for (i = 0; i < resp->msg->num_cmds; i++) {
>> >> +                       cmd = &resp->msg->cmds[i];
>> >> +                       sts = read_tcs_reg(drv, RSC_DRV_CMD_STATUS, m, i);
>> >> +                       if (!(sts & CMD_STATUS_ISSUED) ||
>> >> +                          ((resp->msg->wait_for_compl || cmd->wait) &&
>> >> +                          !(sts & CMD_STATUS_COMPL))) {
>> >> +                               resp->err = -EIO;
>> >> +                               break;
>> >> +                       }
>> >> +               }
>> >> +skip_resp:
>> >> +               /* Reclaim the TCS */
>> >> +               write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, m, 0, 0);
>> >> +               write_tcs_reg(drv, RSC_DRV_IRQ_CLEAR, 0, 0, BIT(m));
>> >> +               clear_bit(m, drv->tcs_in_use);
>> >
>> >Should we reclaim the TCS if the above for loop fails too? It may make
>> >more sense to look up the response, reclaim, check if it's NULL and
>> >execute a 'continue' and otherwise look through resp->msg->cmds for
>> >something that was done and then send_tcs_response(). At the least,
>> The TCS will will be reclaimed, even if the for loop fails. We can't
>> read the CMD_STATUS reliably after reclaiming the TCS.
>> >don't call send_tcs_response() if resp == NULL.
>> >
>> I could do that.
>
>Ah right, the break is for the inner for-loop. Can we push the for-loop
>and reclaim into the get_response() function so that the goto inside the
>loop is avoided?
>
>	resp = get_response(drv, m);
>	if (WARN_ON(!resp))
>		continue;
>	send_tcs_response(resp);
>
>
I needed the resp object to get the resp->msg and send_tcs_response()
could happen only after we have reclaimed the TCS.
I removed the response object based on comments from Bjorn, but the idea
would still need to be the same.

>> >> +/**
>> >> + * rpmh_rsc_send_data: Validate the incoming message and write to the
>> >> + * appropriate TCS block.
>> >> + *
>> >> + * @drv: the controller
>> >> + * @msg: the data to be sent
>> >> + *
>> >> + * Return: 0 on success, -EINVAL on error.
>> >> + * Note: This call blocks until a valid data is written to the TCS.
>> >> + */
>> >> +int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
>> >> +{
>> >> +       int ret;
>> >> +
>> >> +       if (!msg || !msg->cmds || !msg->num_cmds ||
>> >> +           msg->num_cmds > MAX_RPMH_PAYLOAD)
>> >> +               return -EINVAL;
>> >> +
>> >> +       do {
>> >> +               ret = tcs_mbox_write(drv, msg);
>> >> +               if (ret == -EBUSY) {
>> >> +                       pr_info_ratelimited("TCS Busy, retrying RPMH message send: addr=%#x\n",
>> >> +                                           msg->cmds[0].addr);
>> >> +                       udelay(10);
>> >> +               }
>> >> +       } while (ret == -EBUSY);
>> >
>> >This loop never breaks if we can't avoid the BUSY loop. And that printk
>> >is informational, shouldn't it be an error? Is there some number of
>> >tries we can make and then just give up?
>> >
>> I could do that. Generally, there are some transient conditions the
>> causes these loops to spin for a while, before we get a free TCS to
>> write to. Failing after just a handful tries may be calling it quits
>> early. If we increase the delay to compensate for it, then we end
>> slowing up requests that could have otherwise been faster.
>
>So a 10 second timeout with a 10uS delay between attempts? I'm not
>asking to increase the delay between attempts, instead I'm asking for
>this loop to not go forever in case something goes wrong. Getting stuck
>here would not be much fun.
>
There is no recoverable situtation if we are unable to send RPMH
requests. I can timeout here, but then most drivers have no way to
recover from that. The only reason why we would timeout is when the
TCSes are otherwise engaged and the requests that were hung. You cannot
clear the TCSes to continue the system.

>>
>> >> +
>> >> +       return ret;
>> >> +}
>> >> +EXPORT_SYMBOL(rpmh_rsc_send_data);
>> >> +
>> >> diff --git a/include/dt-bindings/soc/qcom,rpmh-rsc.h b/include/dt-bindings/soc/qcom,rpmh-rsc.h
>> >> new file mode 100644
>> >> index 000000000000..868f998ea998
>> >> --- /dev/null
>> >> +++ b/include/dt-bindings/soc/qcom,rpmh-rsc.h
>> >> @@ -0,0 +1,14 @@
>> >> +/* SPDX-License-Identifier: GPL-2.0 */
>> >> +/*
>> >> + * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
>> >> + */
>> >> +
>> >> +#ifndef __DT_QCOM_RPMH_RSC_H__
>> >> +#define __DT_QCOM_RPMH_RSC_H__
>> >> +
>> >> +#define SLEEP_TCS      0
>> >> +#define WAKE_TCS       1
>> >> +#define ACTIVE_TCS     2
>> >> +#define CONTROL_TCS    3
>> >
>> >Is anything besides the RSC node going to use these defines? Typically
>> >we have defines for things that are used by many nodes in many places
>> >and also in C code by drivers so this looks odd if it's mostly used for
>> >packing many properties into a single property on the DT side.
>> >
>> This definition is shared between the DT and the driver. Do you have
>> recommendation on sharing enums between DT and driver?
>
>I'm not aware of anything. I suppose the enum in the kernel header file
>could be assigned to the value of the DT binding defines?
>
>	#include <dt-bindings/soc/qcom,rpmh-rsc.h>
>
>	enum rpmh_state {
>		RPMH_SLEEP_STATE = SLEEP_TCS,
>		RPMH_WAKE_ONLY_STATE = WAKE_TCS,
>		...
>	};
>
I wasn't talking about these enums. The driver uses the SLEEP_TCS,
WAKE_TCS etc to probe the TCS types.

-- Lina

>	#undef SLEEP_TCS
>	#undef WAKE_TCS
>	#undef ...
>
>This sort of defeats the point of the defines, but I suppose it works.
