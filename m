Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751056AbeBPVaL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 16:30:11 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43752 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbeBPVaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 16:30:05 -0500
X-Google-Smtp-Source: AH8x225Llo2vT/h5igJ2gU/Zo/vs+fE5d6eT5RD5qxnwqoRz0X6N/D2zcgiW0OFeVkY73UElraoxiA==
MIME-Version: 1.0
In-Reply-To: <20180215173507.10989-2-ilina@codeaurora.org>
References: <20180215173507.10989-1-ilina@codeaurora.org> <20180215173507.10989-2-ilina@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Fri, 16 Feb 2018 13:29:21 -0800
X-Gmail-Original-Message-ID: <CAE=gft4Sd5rCqf-UQzAx7E4UQ97gpJ-2u55dffT_Sf+EEoYciQ@mail.gmail.com>
Message-ID: <CAE=gft4Sd5rCqf-UQzAx7E4UQ97gpJ-2u55dffT_Sf+EEoYciQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] drivers: qcom: rpmh-rsc: add RPMH controller for
 QCOM SoCs
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

Hi Lina,

On Thu, Feb 15, 2018 at 9:34 AM, Lina Iyer <ilina@codeaurora.org> wrote:
> Add controller driver for QCOM SoCs that have hardware based shared
> resource management. The hardware IP known as RSC (Resource State
> Coordinator) houses multiple Direct Resource Voter (DRV) for different
> execution levels. A DRV is a unique voter on the state of a shared
> resource. A Trigger Control Set (TCS) is a bunch of slots that can house
> multiple resource state requests, that when triggered will issue those
> requests through an internal bus to the Resource Power Manager Hardened
> (RPMH) blocks. These hardware blocks are capable of adjusting clocks,
> voltages etc. The resource state request from a DRV are aggregated along
> with state requests from other processors in the SoC and the aggregate
> value is applied on the resource.
>
> Some important aspects of the RPMH communication -
> - Requests are <addr, value> with some header information
> - Multiple requests (upto 16) may be sent through a TCS, at a time
> - Requests in a TCS are sent in sequence
> - Requests may be fire-n-forget or completion (response expected)
> - Multiple TCS from the same DRV may be triggered simultaneously
> - Cannot send a request if another reques for the same addr is in
>   progress from the same DRV
> - When all the requests from a TCS are complete, an IRQ is raised
> - The IRQ handler needs to clear the TCS before it is available for
>   reuse
> - TCS configuration is specific to a DRV
> - Platform drivers may use DRV from different RSCs to make requests
>
> Resource state requests made when CPUs are active are called 'active'
> state requests. Requests made when all the CPUs are powered down (idle
> state) are called 'sleep' state requests. They are matched by a
> corresponding 'wake' state requests which puts the resources back in to
> previously requested active state before resuming any CPU. TCSes are
> dedicated for each type of requests. Control TCS are used to provide
> specific information to the controller.
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  drivers/soc/qcom/Kconfig                |  10 +
>  drivers/soc/qcom/Makefile               |   1 +
>  drivers/soc/qcom/rpmh-internal.h        |  86 +++++
>  drivers/soc/qcom/rpmh-rsc.c             | 593 ++++++++++++++++++++++++++++++++
>  include/dt-bindings/soc/qcom,rpmh-rsc.h |  14 +
>  include/soc/qcom/tcs.h                  |  56 +++
>  6 files changed, 760 insertions(+)
>  create mode 100644 drivers/soc/qcom/rpmh-internal.h
>  create mode 100644 drivers/soc/qcom/rpmh-rsc.c
>  create mode 100644 include/dt-bindings/soc/qcom,rpmh-rsc.h
>  create mode 100644 include/soc/qcom/tcs.h
>
[...]
> diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
> new file mode 100644
> index 000000000000..dccf9de1a75f
> --- /dev/null
> +++ b/drivers/soc/qcom/rpmh-internal.h
> @@ -0,0 +1,86 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> + */
> +
> +
> +#ifndef __RPM_INTERNAL_H__
> +#define __RPM_INTERNAL_H__
> +
> +#include <soc/qcom/tcs.h>
> +
> +#define TCS_TYPE_NR                    4
> +#define MAX_CMDS_PER_TCS               16
> +#define MAX_TCS_PER_TYPE               3
> +#define MAX_TCS_NR                     (MAX_TCS_PER_TYPE * TCS_TYPE_NR)
> +
> +struct rsc_drv;
> +
> +/**
> + * tcs_response: Response object for a request

Can you embed the acronym definition, ie: tcs_response: Responses for
a Trigger Command Set.

> + *
> + * @drv: the controller
> + * @msg: the request for this response
> + * @m: the tcs identifier
> + * @err: error reported in the response
> + * @list: link list object.
> + */
> +struct tcs_response {
> +       struct rsc_drv *drv;
> +       struct tcs_request *msg;
> +       u32 m;
> +       int err;
> +       struct list_head list;
> +};
> +
> +/**
> + * tcs_group: group of TCSes for a request state
> + *

Document @drv.

> + * @type: type of the TCS in this group - active, sleep, wake
> + * @tcs_mask: mask of the TCSes relative to all the TCSes in the RSC
> + * @tcs_offset: start of the TCS group relative to the TCSes in the RSC
> + * @num_tcs: number of TCSes in this type
> + * @ncpt: number of commands in each TCS
> + * @tcs_lock: lock for synchronizing this TCS writes
> + * @responses: response objects for requests sent from each TCS
> + */
> +struct tcs_group {
> +       struct rsc_drv *drv;
> +       int type;
> +       u32 tcs_mask;
> +       u32 tcs_offset;
> +       int num_tcs;
> +       int ncpt;
> +       spinlock_t tcs_lock;
> +       struct tcs_response *responses[MAX_TCS_PER_TYPE];
> +};
> +
> +/**
> + * rsc_drv: the RSC controller

Would be more helpfully described as Resource State Coordinator controller.

> + *
> + * @name: controller identifier
> + * @tcs_base: start address of the TCS registers in this controller
> + * @drv_id: instance id in the controller (DRV)
> + * @num_tcs: number of TCSes in this DRV
> + * @tasklet: handle responses, off-load work from IRQ handler
> + * @response_pending: list of responses that needs to be sent to caller
> + * @tcs: TCS groups
> + * @tcs_in_use: s/w state of the TCS
> + * @drv_lock: synchronize state of the controller
> + */
> +struct rsc_drv {
> +       const char *name;
> +       void __iomem *tcs_base;
> +       int drv_id;
> +       int num_tcs;
> +       struct tasklet_struct tasklet;
> +       struct list_head response_pending;
> +       struct tcs_group tcs[TCS_TYPE_NR];
> +       atomic_t tcs_in_use[MAX_TCS_NR];
> +       spinlock_t drv_lock;
> +};
> +
> +
> +int rpmh_rsc_send_data(struct rsc_drv *drv, struct tcs_request *msg);
> +
> +#endif /* __RPM_INTERNAL_H__ */
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> new file mode 100644
> index 000000000000..ceb8aea237d6
> --- /dev/null
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -0,0 +1,593 @@
> +// SPDX-License-Identifier: GPL-2.0
[...]
> +
> +static struct tcs_group *get_tcs_from_index(struct rsc_drv *drv, int m)
> +{
> +       struct tcs_group *tcs = NULL;
> +       int i;
> +
> +       for (i = 0; i < drv->num_tcs; i++) {
> +               tcs = &drv->tcs[i];
> +               if (tcs->tcs_mask & BIT(m))
> +                       break;
> +       }
> +
> +       if (i == drv->num_tcs) {
> +               WARN(1, "Incorrect TCS index %d", m);
> +               tcs = NULL;
> +       }
> +
> +       return tcs;
> +}
> +
> +static struct tcs_response *setup_response(struct rsc_drv *drv,
> +                                         struct tcs_request *msg, int m)
> +{
> +       struct tcs_response *resp;
> +       struct tcs_group *tcs;
> +
> +       resp = kcalloc(1, sizeof(*resp), GFP_ATOMIC);
> +       if (!resp)
> +               return ERR_PTR(-ENOMEM);
> +
> +       resp->drv = drv;
> +       resp->msg = msg;
> +       resp->err = 0;
> +
> +       tcs = get_tcs_from_index(drv, m);
> +       if (!tcs)
> +               return ERR_PTR(-EINVAL);
> +
> +       /*
> +        * We should have been called from a TCS-type locked context, and
> +        * we overwrite the previously saved response.
> +        */
> +       tcs->responses[m - tcs->tcs_offset] = resp;
> +
> +       return resp;
> +}
> +
> +static void free_response(struct tcs_response *resp)
> +{
> +       kfree(resp);
> +}
> +
> +static struct tcs_response *get_response(struct rsc_drv *drv, u32 m)
> +{
> +       struct tcs_group *tcs = get_tcs_from_index(drv, m);
> +
> +       return tcs->responses[m - tcs->tcs_offset];
> +}
> +
> +static u32 read_tcs_reg(struct rsc_drv *drv, int reg, int m, int n)
> +{
> +       return readl_relaxed(drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * m +
> +                           RSC_DRV_CMD_OFFSET * n);
> +}
> +
> +static void write_tcs_reg(struct rsc_drv *drv, int reg, int m, int n,
> +                               u32 data)
> +{
> +       writel_relaxed(data, drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * m +
> +                     RSC_DRV_CMD_OFFSET * n);
> +}
> +
> +static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int m, int n,
> +                             u32 data)
> +{
> +       write_tcs_reg(drv, reg, m, n, data);
> +       for (;;) {
> +               if (data == read_tcs_reg(drv, reg, m, n))
> +                       break;
> +               udelay(1);

Should this time out and return a failure?

> +       }
> +}
> +
> +static bool tcs_is_free(struct rsc_drv *drv, int m)
> +{
> +       return !atomic_read(&drv->tcs_in_use[m]) &&
> +              read_tcs_reg(drv, RSC_DRV_STATUS, m, 0);
> +}
> +
> +static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
> +{
> +       int i;
> +       struct tcs_group *tcs;
> +
> +       for (i = 0; i < TCS_TYPE_NR; i++) {
> +               if (type == drv->tcs[i].type)
> +                       break;
> +       }
> +
> +       if (i == TCS_TYPE_NR)
> +               return ERR_PTR(-EINVAL);
> +
> +       tcs = &drv->tcs[i];
> +       if (!tcs->num_tcs)
> +               return ERR_PTR(-EINVAL);
> +
> +       return tcs;
> +}
> +
> +static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
> +                                       struct tcs_request *msg)
> +{
> +       int type;
> +
> +       switch (msg->state) {
> +       case RPMH_ACTIVE_ONLY_STATE:
> +               type = ACTIVE_TCS;
> +               break;
> +       default:
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       return get_tcs_of_type(drv, type);
> +}
> +
> +static void send_tcs_response(struct tcs_response *resp)
> +{
> +       struct rsc_drv *drv = resp->drv;
> +       unsigned long flags;
> +
> +       if (!resp)
> +               return;

Does this ever happen? Ah, I see that it might in the irq handler. But
get_response already assumes that there is a response, and reaches
through it. So I don't think you need this here nor the check+label in
the irq handler.

Is requesting an index out of range purely a developer error, or could
it happen in some sort of runtime scarcity situation? If it's a
developer error, I'd get rid of all the null checking. If it's
something that might really happen under the right circumstances, then
my comment above doesn't stand and you'd want to fix the null
dereference in get_response instead.

> +
> +       spin_lock_irqsave(&drv->drv_lock, flags);
> +       INIT_LIST_HEAD(&resp->list);
> +       list_add_tail(&resp->list, &drv->response_pending);
> +       spin_unlock_irqrestore(&drv->drv_lock, flags);
> +
> +       tasklet_schedule(&drv->tasklet);
> +}
> +
> +/**
> + * tcs_irq_handler: TX Done interrupt handler
> + */
> +static irqreturn_t tcs_irq_handler(int irq, void *p)
> +{
> +       struct rsc_drv *drv = p;
> +       int m, i;
> +       u32 irq_status, sts;
> +       struct tcs_response *resp;
> +       struct tcs_cmd *cmd;
> +       int err;
> +
> +       irq_status = read_tcs_reg(drv, RSC_DRV_IRQ_STATUS, 0, 0);
> +
> +       for (m = 0; m < drv->num_tcs; m++) {
> +               if (!(irq_status & (u32)BIT(m)))
> +                       continue;
> +
> +               err = 0;
> +               resp = get_response(drv, m);
> +               if (!resp) {

I mention this above, but I don't think get_response can gracefully
return null, so is this needed?

> +                       WARN_ON(1);
> +                       goto skip_resp;
> +               }
> +
> +               for (i = 0; i < resp->msg->num_payload; i++) {
> +                       cmd = &resp->msg->payload[i];
> +                       sts = read_tcs_reg(drv, RSC_DRV_CMD_STATUS, m, i);
> +                       if ((!(sts & CMD_STATUS_ISSUED)) ||
> +                               ((resp->msg->is_complete || cmd->complete) &&
> +                               (!(sts & CMD_STATUS_COMPL)))) {
> +                               resp->err = -EIO;

You're trying to set this to -EIO, but then you clobber it to err
(which is zero) below

> +                               break;
> +                       }
> +               }
> +
> +               resp->err = err;
> +skip_resp:
> +               /* Reclaim the TCS */
> +               write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, m, 0, 0);
> +               write_tcs_reg(drv, RSC_DRV_IRQ_CLEAR, 0, 0, BIT(m));
> +               atomic_set(&drv->tcs_in_use[m], 0);
> +               send_tcs_response(resp);
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
[...]
> +
> +static void __tcs_trigger(struct rsc_drv *drv, int m)
> +{
> +       u32 enable;
> +
> +       /*
> +        * HW req: Clear the DRV_CONTROL and enable TCS again
> +        * While clearing ensure that the AMC mode trigger is cleared
> +        * and then the mode enable is cleared.
> +        */
> +       enable = read_tcs_reg(drv, RSC_DRV_CONTROL, m, 0);
> +       enable &= ~TCS_AMC_MODE_TRIGGER;
> +       write_tcs_reg_sync(drv, RSC_DRV_CONTROL, m, 0, enable);

If write_tcs_reg_sync can fail as I suggest, you'd have to fail out of here too.

[...]
> diff --git a/include/soc/qcom/tcs.h b/include/soc/qcom/tcs.h
> new file mode 100644
> index 000000000000..9465f0560f7a
> --- /dev/null
> +++ b/include/soc/qcom/tcs.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef __SOC_QCOM_TCS_H__
> +#define __SOC_QCOM_TCS_H__
> +
> +#define MAX_RPMH_PAYLOAD       16
> +
> +/**
> + * rpmh_state: state for the request
> + *
> + * RPMH_WAKE_ONLY_STATE:   Resume resource state to the value previously
> + *                         requested before the processor was powered down.
> + * RPMH_SLEEP_STATE:       State of the resource when the processor subsystem
> + *                         is powered down. There is no client using the
> + *                         resource actively.
> + * RPMH_ACTIVE_ONLY_STATE: Active or AMC mode requests. Resource state
> + *                         is aggregated immediately.
> + */
> +enum rpmh_state {
> +       RPMH_SLEEP_STATE,
> +       RPMH_WAKE_ONLY_STATE,
> +       RPMH_ACTIVE_ONLY_STATE,
> +};
> +
> +/**
> + * tcs_cmd: an individual request to RPMH.
> + *
> + * @addr:     the address of the resource slv_id:18:16 | offset:0:15
> + * @data:     the resource state request
> + * @complete: wait for this request to be complete before sending the next
> + */
> +struct tcs_cmd {
> +       u32 addr;
> +       u32 data;
> +       bool complete;
> +};
> +
> +/**
> + * tcs_request: A set of tcs_cmds sent togther in a TCS
> + *
> + * @state:       state for the request.
> + * @is_complete: expect a response from the h/w accelerator
> + * @num_payload: the number of tcs_cmds in thsi payload
> + * @payload:     an array of tcs_cmds
> + */
> +struct tcs_request {
> +       enum rpmh_state state;
> +       bool is_complete;

is_complete is kind of a misleading name. I would expect this to
indicate "the request is complete", not "expecting a completion
interrupt". Maybe everybody knows this and I'm just the confused
newbie.

Thanks,
Evan
