Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751111AbeBPXwA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 18:52:00 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48148 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbeBPXv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 18:51:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1E74860385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Fri, 16 Feb 2018 23:51:55 +0000
From: Lina Iyer <ilina@codeaurora.org>
To: Evan Green <evgreen@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] drivers: qcom: rpmh-rsc: add RPMH controller
 for QCOM SoCs
Message-ID: <20180216235155.GA28504@codeaurora.org>
References: <20180215173507.10989-1-ilina@codeaurora.org>
 <20180215173507.10989-2-ilina@codeaurora.org>
 <CAE=gft4Sd5rCqf-UQzAx7E4UQ97gpJ-2u55dffT_Sf+EEoYciQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAE=gft4Sd5rCqf-UQzAx7E4UQ97gpJ-2u55dffT_Sf+EEoYciQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Evan for your review.

On Fri, Feb 16 2018 at 21:30 +0000, Evan Green wrote:
>Hi Lina,
>
>On Thu, Feb 15, 2018 at 9:34 AM, Lina Iyer <ilina@codeaurora.org> wrote:

>> +
>> +/**
>> + * tcs_response: Response object for a request
>
>Can you embed the acronym definition, ie: tcs_response: Responses for
>a Trigger Command Set.
>
Sure.

>> + *
>> + * @drv: the controller
>> + * @msg: the request for this response
>> + * @m: the tcs identifier
>> + * @err: error reported in the response
>> + * @list: link list object.
>> + */
>> +struct tcs_response {
>> +       struct rsc_drv *drv;
>> +       struct tcs_request *msg;
>> +       u32 m;
>> +       int err;
>> +       struct list_head list;
>> +};
>> +
>> +/**
>> + * tcs_group: group of TCSes for a request state
>> + *
>
>Document @drv.
>
OK

>> + * @type: type of the TCS in this group - active, sleep, wake
>> + * @tcs_mask: mask of the TCSes relative to all the TCSes in the RSC
>> + * @tcs_offset: start of the TCS group relative to the TCSes in the RSC
>> + * @num_tcs: number of TCSes in this type
>> + * @ncpt: number of commands in each TCS
>> + * @tcs_lock: lock for synchronizing this TCS writes
>> + * @responses: response objects for requests sent from each TCS
>> + */
>> +struct tcs_group {
>> +       struct rsc_drv *drv;
>> +       int type;
>> +       u32 tcs_mask;
>> +       u32 tcs_offset;
>> +       int num_tcs;
>> +       int ncpt;
>> +       spinlock_t tcs_lock;
>> +       struct tcs_response *responses[MAX_TCS_PER_TYPE];
>> +};
>> +
>> +/**
>> + * rsc_drv: the RSC controller
>
>Would be more helpfully described as Resource State Coordinator controller.
>
OK


>> +static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int m, int n,
>> +                             u32 data)
>> +{
>> +       write_tcs_reg(drv, reg, m, n, data);
>> +       for (;;) {
>> +               if (data == read_tcs_reg(drv, reg, m, n))
>> +                       break;
>> +               udelay(1);
>
>Should this time out and return a failure?
>
There is no reason for this fail. We just need to ensure that it is
written. Sometimes writes going through the bus, takes time to complete
the write. When we exit this function, we are assured that it is
written.

>> +       }
>> +}
>> +
>> +static bool tcs_is_free(struct rsc_drv *drv, int m)
>> +{
>> +       return !atomic_read(&drv->tcs_in_use[m]) &&
>> +              read_tcs_reg(drv, RSC_DRV_STATUS, m, 0);
>> +}
>> +
>> +static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
>> +{
>> +       int i;
>> +       struct tcs_group *tcs;
>> +
>> +       for (i = 0; i < TCS_TYPE_NR; i++) {
>> +               if (type == drv->tcs[i].type)
>> +                       break;
>> +       }
>> +
>> +       if (i == TCS_TYPE_NR)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       tcs = &drv->tcs[i];
>> +       if (!tcs->num_tcs)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       return tcs;
>> +}
>> +
>> +static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
>> +                                       struct tcs_request *msg)
>> +{
>> +       int type;
>> +
>> +       switch (msg->state) {
>> +       case RPMH_ACTIVE_ONLY_STATE:
>> +               type = ACTIVE_TCS;
>> +               break;
>> +       default:
>> +               return ERR_PTR(-EINVAL);
>> +       }
>> +
>> +       return get_tcs_of_type(drv, type);
>> +}
>> +
>> +static void send_tcs_response(struct tcs_response *resp)
>> +{
>> +       struct rsc_drv *drv = resp->drv;
>> +       unsigned long flags;
>> +
>> +       if (!resp)
>> +               return;
>
>Does this ever happen? Ah, I see that it might in the irq handler. But
>get_response already assumes that there is a response, and reaches
>through it. So I don't think you need this here nor the check+label in
>the irq handler.
>
>Is requesting an index out of range purely a developer error, or could
>it happen in some sort of runtime scarcity situation? If it's a
>developer error, I'd get rid of all the null checking. If it's
>something that might really happen under the right circumstances, then
>my comment above doesn't stand and you'd want to fix the null
>dereference in get_response instead.
>
I added the check so that I dont have confusing goto in the IRQ handler.

>> +
>> +       spin_lock_irqsave(&drv->drv_lock, flags);
>> +       INIT_LIST_HEAD(&resp->list);
>> +       list_add_tail(&resp->list, &drv->response_pending);
>> +       spin_unlock_irqrestore(&drv->drv_lock, flags);
>> +
>> +       tasklet_schedule(&drv->tasklet);
>> +}
>> +
>> +/**
>> + * tcs_irq_handler: TX Done interrupt handler
>> + */
>> +static irqreturn_t tcs_irq_handler(int irq, void *p)
>> +{
>> +       struct rsc_drv *drv = p;
>> +       int m, i;
>> +       u32 irq_status, sts;
>> +       struct tcs_response *resp;
>> +       struct tcs_cmd *cmd;
>> +       int err;
>> +
>> +       irq_status = read_tcs_reg(drv, RSC_DRV_IRQ_STATUS, 0, 0);
>> +
>> +       for (m = 0; m < drv->num_tcs; m++) {
>> +               if (!(irq_status & (u32)BIT(m)))
>> +                       continue;
>> +
>> +               err = 0;
>> +               resp = get_response(drv, m);
>> +               if (!resp) {
>
>I mention this above, but I don't think get_response can gracefully
>return null, so is this needed?
>
>> +                       WARN_ON(1);
>> +                       goto skip_resp;
>> +               }
>> +
>> +               for (i = 0; i < resp->msg->num_payload; i++) {
>> +                       cmd = &resp->msg->payload[i];
>> +                       sts = read_tcs_reg(drv, RSC_DRV_CMD_STATUS, m, i);
>> +                       if ((!(sts & CMD_STATUS_ISSUED)) ||
>> +                               ((resp->msg->is_complete || cmd->complete) &&
>> +                               (!(sts & CMD_STATUS_COMPL)))) {
>> +                               resp->err = -EIO;
>
>You're trying to set this to -EIO, but then you clobber it to err
>(which is zero) below
>
Good catch. Will fix.

>> +                               break;
>> +                       }
>> +               }
>> +
>> +               resp->err = err;
>> +skip_resp:
>> +               /* Reclaim the TCS */
>> +               write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, m, 0, 0);
>> +               write_tcs_reg(drv, RSC_DRV_IRQ_CLEAR, 0, 0, BIT(m));
>> +               atomic_set(&drv->tcs_in_use[m], 0);
>> +               send_tcs_response(resp);
>> +       }
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>[...]
>> +
>> +static void __tcs_trigger(struct rsc_drv *drv, int m)
>> +{
>> +       u32 enable;
>> +
>> +       /*
>> +        * HW req: Clear the DRV_CONTROL and enable TCS again
>> +        * While clearing ensure that the AMC mode trigger is cleared
>> +        * and then the mode enable is cleared.
>> +        */
>> +       enable = read_tcs_reg(drv, RSC_DRV_CONTROL, m, 0);
>> +       enable &= ~TCS_AMC_MODE_TRIGGER;
>> +       write_tcs_reg_sync(drv, RSC_DRV_CONTROL, m, 0, enable);
>
>If write_tcs_reg_sync can fail as I suggest, you'd have to fail out of here too.
>
Explained above.

>[...]
>> diff --git a/include/soc/qcom/tcs.h b/include/soc/qcom/tcs.h
>> new file mode 100644
>> index 000000000000..9465f0560f7a
>> --- /dev/null
>> +++ b/include/soc/qcom/tcs.h
>> @@ -0,0 +1,56 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#ifndef __SOC_QCOM_TCS_H__
>> +#define __SOC_QCOM_TCS_H__
>> +
>> +#define MAX_RPMH_PAYLOAD       16
>> +
>> +/**
>> + * rpmh_state: state for the request
>> + *
>> + * RPMH_WAKE_ONLY_STATE:   Resume resource state to the value previously
>> + *                         requested before the processor was powered down.
>> + * RPMH_SLEEP_STATE:       State of the resource when the processor subsystem
>> + *                         is powered down. There is no client using the
>> + *                         resource actively.
>> + * RPMH_ACTIVE_ONLY_STATE: Active or AMC mode requests. Resource state
>> + *                         is aggregated immediately.
>> + */
>> +enum rpmh_state {
>> +       RPMH_SLEEP_STATE,
>> +       RPMH_WAKE_ONLY_STATE,
>> +       RPMH_ACTIVE_ONLY_STATE,
>> +};
>> +
>> +/**
>> + * tcs_cmd: an individual request to RPMH.
>> + *
>> + * @addr:     the address of the resource slv_id:18:16 | offset:0:15
>> + * @data:     the resource state request
>> + * @complete: wait for this request to be complete before sending the next
>> + */
>> +struct tcs_cmd {
>> +       u32 addr;
>> +       u32 data;
>> +       bool complete;
>> +};
>> +
>> +/**
>> + * tcs_request: A set of tcs_cmds sent togther in a TCS
>> + *
>> + * @state:       state for the request.
>> + * @is_complete: expect a response from the h/w accelerator
>> + * @num_payload: the number of tcs_cmds in thsi payload
>> + * @payload:     an array of tcs_cmds
>> + */
>> +struct tcs_request {
>> +       enum rpmh_state state;
>> +       bool is_complete;
>
>is_complete is kind of a misleading name. I would expect this to
>indicate "the request is complete", not "expecting a completion
>interrupt". Maybe everybody knows this and I'm just the confused
>newbie.
>
It is used to distinguish between a request that is fire and forget or a
completion request where you are waiting for a response from the
accelerator. It might a be a bit of a misnomer though.

Thanks,
Lina
