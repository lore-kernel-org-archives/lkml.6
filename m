Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752386AbeDMRnb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 13:43:31 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38502 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752270AbeDMRn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 13:43:28 -0400
X-Google-Smtp-Source: AIpwx4+zhPYvjU1fCWtxDSgq946Ca+AC1ZkdYgauVoZYle2HztdNcpozR4Nf3PFwltYJmrDWdJ2GZw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Lina Iyer <ilina@codeaurora.org>
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180413153725.GA1209@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org
References: <20180405161834.3850-1-ilina@codeaurora.org>
 <20180405161834.3850-2-ilina@codeaurora.org>
 <152342153642.180276.4927130412537860735@swboyd.mtv.corp.google.com>
 <20180413153725.GA1209@codeaurora.org>
Message-ID: <152364140661.51482.261490347611407195@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 01/10] drivers: qcom: rpmh-rsc: add RPMH controller for QCOM
 SoCs
Date: Fri, 13 Apr 2018 10:43:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3DHhZQC024996

Quoting Lina Iyer (2018-04-13 08:37:25)
> On Tue, Apr 10 2018 at 22:39 -0600, Stephen Boyd wrote:
> >Quoting Lina Iyer (2018-04-05 09:18:25)
> >>
> >> diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
> >> new file mode 100644
> >> index 000000000000..aa73ec4b3e42
> >> --- /dev/null
> >> +++ b/drivers/soc/qcom/rpmh-internal.h
> >> @@ -0,0 +1,89 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> >> + */
> >> +
> >> +
> >> +#ifndef __RPM_INTERNAL_H__
> >> +#define __RPM_INTERNAL_H__
> >> +
> >> +#include <linux/bitmap.h>
> >> +#include <soc/qcom/tcs.h>
> >> +
> >> +#define TCS_TYPE_NR                    4
> >> +#define MAX_CMDS_PER_TCS               16
> >> +#define MAX_TCS_PER_TYPE               3
> >> +#define MAX_TCS_NR                     (MAX_TCS_PER_TYPE * TCS_TYPE_NR)
> >> +
> >> +struct rsc_drv;
> >> +
> >> +/**
> >> + * struct tcs_response: Response object for a request
> >> + *
> >> + * @drv:   the controller
> >> + * @msg:   the request for this response
> >> + * @m:     the tcs identifier
> >> + * @err:   error reported in the response
> >> + * @list:  element in list of pending response objects
> >> + */
> >> +struct tcs_response {
> >> +       struct rsc_drv *drv;
> >> +       const struct tcs_request *msg;
> >> +       u32 m;
> >> +       int err;
> >> +       struct list_head list;
> >> +};
> >> +
> >> +/**
> >> + * struct tcs_group: group of Trigger Command Sets for a request state
> >
> >Put (ACRONYM) for the acronyms that are spelled out the first time
> >please. Also, make sure we know what 'request state' is.
> >
> Its already in the commit text, but sure.

Thanks!

> 
> >> + *
> >> + * @drv:       the controller
> >> + * @type:      type of the TCS in this group - active, sleep, wake
> >
> >Now 'group' means 'request state'?
> >
> Group of TCSes. TCSes are grouped based on their use - sending requests
> for active, sleep and wake.

Ok so maybe "type of the TCSes in this group, either active, sleep,
wake, etc."

> 
> >> + * @mask:      mask of the TCSes relative to all the TCSes in the RSC
> >> + * @offset:    start of the TCS group relative to the TCSes in the RSC
> >> + * @num_tcs:   number of TCSes in this type
> >> + * @ncpt:      number of commands in each TCS
> >> + * @lock:      lock for synchronizing this TCS writes
> >> + * @responses: response objects for requests sent from each TCS
> >> + */
> >> +struct tcs_group {
> >> +       struct rsc_drv *drv;
> >> +       int type;
> >
> >Is type supposed to be an enum?
> >
> Uses the #defines from include/dt-bindings/qcom,rpmh-rsc.txt.
> 
> >> +       u32 mask;
> >> +       u32 offset;
> >> +       int num_tcs;
> >> +       int ncpt;
> >> +       spinlock_t lock;
> >> +       struct tcs_response *responses[MAX_TCS_PER_TYPE];
> >> +};
> >> +
> >> +/**
> >> + * struct rsc_drv: the Resource State Coordinator controller
> >> + *
> >> + * @name:       controller identifier
> >> + * @tcs_base:   start address of the TCS registers in this controller
> >> + * @id:         instance id in the controller (Direct Resource Voter)
> >> + * @num_tcs:    number of TCSes in this DRV
> >
> >It changed from an RSC to a DRV here?
> >
> RSC has DRVs. A DRV has TCS(es).

It seems like RSC and DRV are pretty much interchangeable then?

> 
> >> +
> >> +#endif /* __RPM_INTERNAL_H__ */
> >> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> >> new file mode 100644
> >> index 000000000000..8bde1e9bd599
> >> --- /dev/null
> >> +++ b/drivers/soc/qcom/rpmh-rsc.c
> >> @@ -0,0 +1,571 @@
> 
> >> +{
> >> +       kfree(resp);
> >> +}
> >> +
> >> +static struct tcs_response *get_response(struct rsc_drv *drv, u32 m)
> >> +{
> >> +       struct tcs_group *tcs = get_tcs_from_index(drv, m);
> >> +
> >> +       return tcs->responses[m - tcs->offset];
> >> +}
> >> +
> >> +static u32 read_tcs_reg(struct rsc_drv *drv, int reg, int m, int n)
> >> +{
> >> +       return readl_relaxed(drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * m +
> >> +                            RSC_DRV_CMD_OFFSET * n);
> >> +}
> >> +
> >> +static void write_tcs_reg(struct rsc_drv *drv, int reg, int m, int n, u32 data)
> >
> >Is m the type of TCS (sleep, active, wake) and n is just an offset?
> >Maybe you can replace m with 'tcs_type' and n with 'index' or 'i' or
> >'offset'. And then don't use this function to write the random TCS
> >registers that don't have to do with the TCS command slots? I see
> >various places where there are things like:
> >
> If you look at the spec and the registers, this representation matches
> the usage there.
> d = DRV
> m = TCS number in the DRV
> n = Command slot in the TCS

Ok. I don't have access to the spec and the registers so I can't really
map it to anything.

> 
> >> +               write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, m, 0, 0);
> >> +       write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, m, 0, cmd_complete);
> >> +       write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, m, 0, cmd_enable);
> >
> >And 'n' is 0, meaning you rely on that 0 killing that last part of the
> >equation (RSC_DRV_CMD_OFFSET * n). But if we had a write_tcs_reg(drv,
> >reg, m, data) and a write_tcs_cmd(drv, reg, m, n, data) then it would be
> >clearer.
> >
> Hmm. ok.
> >Even better, add a void *base to a 'struct tcs' and then pass that
> >struct to the tcs_read/write APIs and then have that pull out a
> >tcs->base + reg or tcs->base + reg + RSC_DRV_CMD_OFFSET * index.
> >
> Based on comments from Bjorn on patch v1, I switched over to using
> rsc_drv* instead of void *base.

Can we get the write_tcs_cmd() and write_tsc_reg() functions? I don't
like seeing all the random zeroes passed around when they aren't needed.

> 
> >
> >> +
> >> +       drv = resp->drv;
> >> +       spin_lock_irqsave(&drv->drv_lock, flags);
> >> +       INIT_LIST_HEAD(&resp->list);
> >> +       list_add_tail(&resp->list, &drv->response_pending);
> >> +       spin_unlock_irqrestore(&drv->drv_lock, flags);
> >> +
> >> +       tasklet_schedule(&drv->tasklet);
> >> +}
> >> +
> >> +/**
> >> + * tcs_irq_handler: TX Done interrupt handler
> >
> >So call it tcs_tx_done?
> >
> But, but, it's an irq handler.

Heh ok, tcs_tx_done_handler()? It's obviously an irqhandler, it has
irqreturn_t in the signature.

> 
> >> + */
> >> +static irqreturn_t tcs_irq_handler(int irq, void *p)
> >> +{
> >> +       struct rsc_drv *drv = p;
> >> +       int m, i;
> >> +       u32 irq_status, sts;
> >> +       struct tcs_response *resp;
> >> +       struct tcs_cmd *cmd;
> >> +
> >> +       irq_status = read_tcs_reg(drv, RSC_DRV_IRQ_STATUS, 0, 0);
> >> +
> >> +       for (m = 0; m < drv->num_tcs; m++) {
> >> +               if (!(irq_status & (u32)BIT(m)))

This u32 cast looks out of place. And can't we do for_each_set_bit() in
this loop instead of looping through num_tcs?

> >> +                       continue;
> >> +
> >> +               resp = get_response(drv, m);
> >> +               if (WARN_ON(!resp))
> >> +                       goto skip_resp;
> >> +
> >> +               resp->err = 0;
> >> +               for (i = 0; i < resp->msg->num_cmds; i++) {
> >> +                       cmd = &resp->msg->cmds[i];
> >> +                       sts = read_tcs_reg(drv, RSC_DRV_CMD_STATUS, m, i);
> >> +                       if (!(sts & CMD_STATUS_ISSUED) ||
> >> +                          ((resp->msg->wait_for_compl || cmd->wait) &&
> >> +                          !(sts & CMD_STATUS_COMPL))) {
> >> +                               resp->err = -EIO;
> >> +                               break;
> >> +                       }
> >> +               }
> >> +skip_resp:
> >> +               /* Reclaim the TCS */
> >> +               write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, m, 0, 0);
> >> +               write_tcs_reg(drv, RSC_DRV_IRQ_CLEAR, 0, 0, BIT(m));
> >> +               clear_bit(m, drv->tcs_in_use);
> >
> >Should we reclaim the TCS if the above for loop fails too? It may make
> >more sense to look up the response, reclaim, check if it's NULL and
> >execute a 'continue' and otherwise look through resp->msg->cmds for
> >something that was done and then send_tcs_response(). At the least,
> The TCS will will be reclaimed, even if the for loop fails. We can't
> read the CMD_STATUS reliably after reclaiming the TCS.
> >don't call send_tcs_response() if resp == NULL.
> >
> I could do that.

Ah right, the break is for the inner for-loop. Can we push the for-loop
and reclaim into the get_response() function so that the goto inside the
loop is avoided?

	resp = get_response(drv, m);
	if (WARN_ON(!resp))
		continue;
	send_tcs_response(resp);


> >> +/**
> >> + * rpmh_rsc_send_data: Validate the incoming message and write to the
> >> + * appropriate TCS block.
> >> + *
> >> + * @drv: the controller
> >> + * @msg: the data to be sent
> >> + *
> >> + * Return: 0 on success, -EINVAL on error.
> >> + * Note: This call blocks until a valid data is written to the TCS.
> >> + */
> >> +int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
> >> +{
> >> +       int ret;
> >> +
> >> +       if (!msg || !msg->cmds || !msg->num_cmds ||
> >> +           msg->num_cmds > MAX_RPMH_PAYLOAD)
> >> +               return -EINVAL;
> >> +
> >> +       do {
> >> +               ret = tcs_mbox_write(drv, msg);
> >> +               if (ret == -EBUSY) {
> >> +                       pr_info_ratelimited("TCS Busy, retrying RPMH message send: addr=%#x\n",
> >> +                                           msg->cmds[0].addr);
> >> +                       udelay(10);
> >> +               }
> >> +       } while (ret == -EBUSY);
> >
> >This loop never breaks if we can't avoid the BUSY loop. And that printk
> >is informational, shouldn't it be an error? Is there some number of
> >tries we can make and then just give up?
> >
> I could do that. Generally, there are some transient conditions the
> causes these loops to spin for a while, before we get a free TCS to
> write to. Failing after just a handful tries may be calling it quits
> early. If we increase the delay to compensate for it, then we end
> slowing up requests that could have otherwise been faster.

So a 10 second timeout with a 10uS delay between attempts? I'm not
asking to increase the delay between attempts, instead I'm asking for
this loop to not go forever in case something goes wrong. Getting stuck
here would not be much fun.

> 
> >> +
> >> +       return ret;
> >> +}
> >> +EXPORT_SYMBOL(rpmh_rsc_send_data);
> >> +
> >> diff --git a/include/dt-bindings/soc/qcom,rpmh-rsc.h b/include/dt-bindings/soc/qcom,rpmh-rsc.h
> >> new file mode 100644
> >> index 000000000000..868f998ea998
> >> --- /dev/null
> >> +++ b/include/dt-bindings/soc/qcom,rpmh-rsc.h
> >> @@ -0,0 +1,14 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> >> + */
> >> +
> >> +#ifndef __DT_QCOM_RPMH_RSC_H__
> >> +#define __DT_QCOM_RPMH_RSC_H__
> >> +
> >> +#define SLEEP_TCS      0
> >> +#define WAKE_TCS       1
> >> +#define ACTIVE_TCS     2
> >> +#define CONTROL_TCS    3
> >
> >Is anything besides the RSC node going to use these defines? Typically
> >we have defines for things that are used by many nodes in many places
> >and also in C code by drivers so this looks odd if it's mostly used for
> >packing many properties into a single property on the DT side.
> >
> This definition is shared between the DT and the driver. Do you have
> recommendation on sharing enums between DT and driver?

I'm not aware of anything. I suppose the enum in the kernel header file
could be assigned to the value of the DT binding defines?

	#include <dt-bindings/soc/qcom,rpmh-rsc.h>

	enum rpmh_state {
		RPMH_SLEEP_STATE = SLEEP_TCS,
		RPMH_WAKE_ONLY_STATE = WAKE_TCS,
		...
	};

	#undef SLEEP_TCS
	#undef WAKE_TCS
	#undef ...

This sort of defeats the point of the defines, but I suppose it works.
