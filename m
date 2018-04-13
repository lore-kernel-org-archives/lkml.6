Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeDMPhc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 11:37:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46458 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeDMPha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 11:37:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5DE0560717
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Fri, 13 Apr 2018 09:37:25 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH v5 01/10] drivers: qcom: rpmh-rsc: add RPMH controller
 for QCOM SoCs
Message-ID: <20180413153725.GA1209@codeaurora.org>
References: <20180405161834.3850-1-ilina@codeaurora.org>
 <20180405161834.3850-2-ilina@codeaurora.org>
 <152342153642.180276.4927130412537860735@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <152342153642.180276.4927130412537860735@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10 2018 at 22:39 -0600, Stephen Boyd wrote:
>Quoting Lina Iyer (2018-04-05 09:18:25)
>> Add controller driver for QCOM SoCs that have hardware based shared
>> resource management. The hardware IP known as RSC (Resource State
>> Coordinator) houses multiple Direct Resource Voter (DRV) for different
>> execution levels. A DRV is a unique voter on the state of a shared
>> resource. A Trigger Control Set (TCS) is a bunch of slots that can house
>> multiple resource state requests, that when triggered will issue those
>> requests through an internal bus to the Resource Power Manager Hardened
>> (RPMH) blocks. These hardware blocks are capable of adjusting clocks,
>> voltages, etc. The resource state request from a DRV are aggregated along
>> with state requests from other processors in the SoC and the aggregate
>> value is applied on the resource.
>>
>> Some important aspects of the RPMH communication -
>> - Requests are <addr, value> with some header information
>> - Multiple requests (upto 16) may be sent through a TCS, at a time
>> - Requests in a TCS are sent in sequence
>> - Requests may be fire-n-forget or completion (response expected)
>> - Multiple TCS from the same DRV may be triggered simultaneously
>> - Cannot send a request if another requesit for the same addr is in
>
>s/requesit/request/
>
Ok.
>>   progress from the same DRV
>> - When all the requests from a TCS are complete, an IRQ is raised
>> - The IRQ handler needs to clear the TCS before it is available for
>>   reuse
>> - TCS configuration is specific to a DRV
>> - Platform drivers may use DRV from different RSCs to make requests
>
>This last point is sort of not true anymore? At least my understanding
>is that platform drivers are children of the rsc and that they can only
>use that rsc to do anything with rpmh.
>
Platform drivers may talk to multiple RSC+DRV instances and make
requests from those DRVs.

>>
>> Resource state requests made when CPUs are active are called 'active'
>> state requests. Requests made when all the CPUs are powered down (idle
>> state) are called 'sleep' state requests. They are matched by a
>> corresponding 'wake' state requests which puts the resources back in to
>> previously requested active state before resuming any CPU. TCSes are
>> dedicated for each type of requests. Control TCS are used to provide
>> specific information to the controller.
>
>Can you mention AMC here too? I see the acronym but no definition of
>what it is besides "Active or AMC" which may indicate A == Active.
>
Ok.

>>
>> diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
>> new file mode 100644
>> index 000000000000..aa73ec4b3e42
>> --- /dev/null
>> +++ b/drivers/soc/qcom/rpmh-internal.h
>> @@ -0,0 +1,89 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +
>> +#ifndef __RPM_INTERNAL_H__
>> +#define __RPM_INTERNAL_H__
>> +
>> +#include <linux/bitmap.h>
>> +#include <soc/qcom/tcs.h>
>> +
>> +#define TCS_TYPE_NR                    4
>> +#define MAX_CMDS_PER_TCS               16
>> +#define MAX_TCS_PER_TYPE               3
>> +#define MAX_TCS_NR                     (MAX_TCS_PER_TYPE * TCS_TYPE_NR)
>> +
>> +struct rsc_drv;
>> +
>> +/**
>> + * struct tcs_response: Response object for a request
>> + *
>> + * @drv:   the controller
>> + * @msg:   the request for this response
>> + * @m:     the tcs identifier
>> + * @err:   error reported in the response
>> + * @list:  element in list of pending response objects
>> + */
>> +struct tcs_response {
>> +       struct rsc_drv *drv;
>> +       const struct tcs_request *msg;
>> +       u32 m;
>> +       int err;
>> +       struct list_head list;
>> +};
>> +
>> +/**
>> + * struct tcs_group: group of Trigger Command Sets for a request state
>
>Put (ACRONYM) for the acronyms that are spelled out the first time
>please. Also, make sure we know what 'request state' is.
>
Its already in the commit text, but sure.

>> + *
>> + * @drv:       the controller
>> + * @type:      type of the TCS in this group - active, sleep, wake
>
>Now 'group' means 'request state'?
>
Group of TCSes. TCSes are grouped based on their use - sending requests
for active, sleep and wake.

>> + * @mask:      mask of the TCSes relative to all the TCSes in the RSC
>> + * @offset:    start of the TCS group relative to the TCSes in the RSC
>> + * @num_tcs:   number of TCSes in this type
>> + * @ncpt:      number of commands in each TCS
>> + * @lock:      lock for synchronizing this TCS writes
>> + * @responses: response objects for requests sent from each TCS
>> + */
>> +struct tcs_group {
>> +       struct rsc_drv *drv;
>> +       int type;
>
>Is type supposed to be an enum?
>
Uses the #defines from include/dt-bindings/qcom,rpmh-rsc.txt.

>> +       u32 mask;
>> +       u32 offset;
>> +       int num_tcs;
>> +       int ncpt;
>> +       spinlock_t lock;
>> +       struct tcs_response *responses[MAX_TCS_PER_TYPE];
>> +};
>> +
>> +/**
>> + * struct rsc_drv: the Resource State Coordinator controller
>> + *
>> + * @name:       controller identifier
>> + * @tcs_base:   start address of the TCS registers in this controller
>> + * @id:         instance id in the controller (Direct Resource Voter)
>> + * @num_tcs:    number of TCSes in this DRV
>
>It changed from an RSC to a DRV here?
>
RSC has DRVs. A DRV has TCS(es).

>> + * @tasklet:    handle responses, off-load work from IRQ handler
>> + * @response_pending:
>> + *              list of responses that needs to be sent to caller
>> + * @tcs:        TCS groups
>> + * @tcs_in_use: s/w state of the TCS
>> + * @drv_lock:  synchronize state of the controller
>> + */
>> +struct rsc_drv {
>
>Is 'drv' in here talking about the DRV acronym?
>
Yes.

>> +       const char *name;
>> +       void __iomem *tcs_base;
>> +       int id;
>> +       int num_tcs;
>> +       struct tasklet_struct tasklet;
>> +       struct list_head response_pending;
>> +       struct tcs_group tcs[TCS_TYPE_NR];
>> +       DECLARE_BITMAP(tcs_in_use, MAX_TCS_NR);
>> +       spinlock_t drv_lock;
>
>s/drv_lock/lock/
>
>? Because otherwise it looks like drv->drv_lock.
>
Ok.

>> +};
>> +
>> +
>> +int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg);
>
>Do we send data to anything else in rpmh? Maybe it could just be called
>rpmh_send_data(), or rpmh_send().
>
No, but this file is rpmh_rsc. Hence the rpmh_rsc_ functions.

>> +
>> +#endif /* __RPM_INTERNAL_H__ */
>> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>> new file mode 100644
>> index 000000000000..8bde1e9bd599
>> --- /dev/null
>> +++ b/drivers/soc/qcom/rpmh-rsc.c
>> @@ -0,0 +1,571 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#define pr_fmt(fmt) "%s " fmt, KBUILD_MODNAME
>> +
>> +#include <linux/atomic.h>
>
>Is this used?
>
Will remove.

>> +#include <linux/delay.h>
>> +#include <linux/export.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/list.h>
>> +#include <linux/of.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +
>> +#include <soc/qcom/tcs.h>
>> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> +
>> +#include "rpmh-internal.h"
>> +
>> +#define RSC_DRV_TCS_OFFSET             672
>> +#define RSC_DRV_CMD_OFFSET             20
>> +
>> +/* DRV Configuration Information Register */
>> +#define DRV_PRNT_CHLD_CONFIG           0x0C
>> +#define DRV_NUM_TCS_MASK               0x3F
>> +#define DRV_NUM_TCS_SHIFT              6
>> +#define DRV_NCPT_MASK                  0x1F
>> +#define DRV_NCPT_SHIFT                 27
>> +
>> +/* Register offsets */
>> +#define RSC_DRV_IRQ_ENABLE             0x00
>> +#define RSC_DRV_IRQ_STATUS             0x04
>> +#define RSC_DRV_IRQ_CLEAR              0x08
>> +#define RSC_DRV_CMD_WAIT_FOR_CMPL      0x10
>> +#define RSC_DRV_CONTROL                        0x14
>> +#define RSC_DRV_STATUS                 0x18
>> +#define RSC_DRV_CMD_ENABLE             0x1C
>> +#define RSC_DRV_CMD_MSGID              0x30
>> +#define RSC_DRV_CMD_ADDR               0x34
>> +#define RSC_DRV_CMD_DATA               0x38
>> +#define RSC_DRV_CMD_STATUS             0x3C
>> +#define RSC_DRV_CMD_RESP_DATA          0x40
>> +
>> +#define TCS_AMC_MODE_ENABLE            BIT(16)
>> +#define TCS_AMC_MODE_TRIGGER           BIT(24)
>> +
>> +/* TCS CMD register bit mask */
>> +#define CMD_MSGID_LEN                  8
>> +#define CMD_MSGID_RESP_REQ             BIT(8)
>> +#define CMD_MSGID_WRITE                        BIT(16)
>> +#define CMD_STATUS_ISSUED              BIT(8)
>> +#define CMD_STATUS_COMPL               BIT(16)
>> +
>> +static struct tcs_group *get_tcs_from_index(struct rsc_drv *drv, int m)
>> +{
>> +       struct tcs_group *tcs;
>> +       int i;
>> +
>> +       for (i = 0; i < drv->num_tcs; i++) {
>> +               tcs = &drv->tcs[i];
>> +               if (tcs->mask & BIT(m))
>> +                       return tcs;
>> +       }
>> +
>> +       WARN(i == drv->num_tcs, "Incorrect TCS index %d", m);
>> +
>> +       return NULL;
>> +}
>> +
>> +static struct tcs_response *setup_response(struct rsc_drv *drv,
>> +                                          const struct tcs_request *msg, int m)
>> +{
>> +       struct tcs_response *resp;
>> +       struct tcs_group *tcs;
>> +
>> +       resp = kzalloc(sizeof(*resp), GFP_ATOMIC);
>> +       if (!resp)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       resp->drv = drv;
>> +       resp->msg = msg;
>> +       resp->err = 0;
>> +
>> +       tcs = get_tcs_from_index(drv, m);
>> +       if (!tcs)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       assert_spin_locked(&tcs->lock);
>> +       tcs->responses[m - tcs->offset] = resp;
>> +
>> +       return resp;
>> +}
>> +
>> +static void free_response(struct tcs_response *resp)
>
>const?
>
Ok

>> +{
>> +       kfree(resp);
>> +}
>> +
>> +static struct tcs_response *get_response(struct rsc_drv *drv, u32 m)
>> +{
>> +       struct tcs_group *tcs = get_tcs_from_index(drv, m);
>> +
>> +       return tcs->responses[m - tcs->offset];
>> +}
>> +
>> +static u32 read_tcs_reg(struct rsc_drv *drv, int reg, int m, int n)
>> +{
>> +       return readl_relaxed(drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * m +
>> +                            RSC_DRV_CMD_OFFSET * n);
>> +}
>> +
>> +static void write_tcs_reg(struct rsc_drv *drv, int reg, int m, int n, u32 data)
>
>Is m the type of TCS (sleep, active, wake) and n is just an offset?
>Maybe you can replace m with 'tcs_type' and n with 'index' or 'i' or
>'offset'. And then don't use this function to write the random TCS
>registers that don't have to do with the TCS command slots? I see
>various places where there are things like:
>
If you look at the spec and the registers, this representation matches
the usage there.
d = DRV
m = TCS number in the DRV
n = Command slot in the TCS

>> +               write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, m, 0, 0);
>> +       write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, m, 0, cmd_complete);
>> +       write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, m, 0, cmd_enable);
>
>And 'n' is 0, meaning you rely on that 0 killing that last part of the
>equation (RSC_DRV_CMD_OFFSET * n). But if we had a write_tcs_reg(drv,
>reg, m, data) and a write_tcs_cmd(drv, reg, m, n, data) then it would be
>clearer.
>
Hmm. ok.
>Even better, add a void *base to a 'struct tcs' and then pass that
>struct to the tcs_read/write APIs and then have that pull out a
>tcs->base + reg or tcs->base + reg + RSC_DRV_CMD_OFFSET * index.
>
Based on comments from Bjorn on patch v1, I switched over to using
rsc_drv* instead of void *base.

>> +{
>> +       writel_relaxed(data, drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * m +
>> +                      RSC_DRV_CMD_OFFSET * n);
>> +}
>> +
>> +static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int m, int n,
>> +                              u32 data)
>> +{
>> +       write_tcs_reg(drv, reg, m, n, data);
>> +       for (;;) {
>> +               if (data == read_tcs_reg(drv, reg, m, n))
>> +                       break;
>> +               udelay(1);
>> +       }
>> +}
>> +
>> +static bool tcs_is_free(struct rsc_drv *drv, int m)
>> +{
>> +       return !test_bit(m, drv->tcs_in_use) &&
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
>> +                                        const struct tcs_request *msg)
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
>> +       struct rsc_drv *drv;
>> +       unsigned long flags;
>> +
>> +       if (!resp)
>> +               return;
>
>Sad.
>
>> +
>> +       drv = resp->drv;
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
>
>So call it tcs_tx_done?
>
But, but, it's an irq handler.

>> + */
>> +static irqreturn_t tcs_irq_handler(int irq, void *p)
>> +{
>> +       struct rsc_drv *drv = p;
>> +       int m, i;
>> +       u32 irq_status, sts;
>> +       struct tcs_response *resp;
>> +       struct tcs_cmd *cmd;
>> +
>> +       irq_status = read_tcs_reg(drv, RSC_DRV_IRQ_STATUS, 0, 0);
>> +
>> +       for (m = 0; m < drv->num_tcs; m++) {
>> +               if (!(irq_status & (u32)BIT(m)))
>> +                       continue;
>> +
>> +               resp = get_response(drv, m);
>> +               if (WARN_ON(!resp))
>> +                       goto skip_resp;
>> +
>> +               resp->err = 0;
>> +               for (i = 0; i < resp->msg->num_cmds; i++) {
>> +                       cmd = &resp->msg->cmds[i];
>> +                       sts = read_tcs_reg(drv, RSC_DRV_CMD_STATUS, m, i);
>> +                       if (!(sts & CMD_STATUS_ISSUED) ||
>> +                          ((resp->msg->wait_for_compl || cmd->wait) &&
>> +                          !(sts & CMD_STATUS_COMPL))) {
>> +                               resp->err = -EIO;
>> +                               break;
>> +                       }
>> +               }
>> +skip_resp:
>> +               /* Reclaim the TCS */
>> +               write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, m, 0, 0);
>> +               write_tcs_reg(drv, RSC_DRV_IRQ_CLEAR, 0, 0, BIT(m));
>> +               clear_bit(m, drv->tcs_in_use);
>
>Should we reclaim the TCS if the above for loop fails too? It may make
>more sense to look up the response, reclaim, check if it's NULL and
>execute a 'continue' and otherwise look through resp->msg->cmds for
>something that was done and then send_tcs_response(). At the least,
The TCS will will be reclaimed, even if the for loop fails. We can't
read the CMD_STATUS reliably after reclaiming the TCS.
>don't call send_tcs_response() if resp == NULL.
>
I could do that.
>> +               send_tcs_response(resp);
>> +       }
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +/**
>> + * tcs_notify_tx_done: TX Done for requests that got a response
>> + *
>> + * @data: the tasklet argument
>> + *
>> + * Tasklet function to notify MBOX that we are done with the request.
>> + * Handles all pending reponses whenever run.
>> + */
>> +static void tcs_notify_tx_done(unsigned long data)
>> +{
>> +       struct rsc_drv *drv = (struct rsc_drv *)data;
>> +       struct tcs_response *resp;
>> +       unsigned long flags;
>> +
>> +       for (;;) {
>> +               spin_lock_irqsave(&drv->drv_lock, flags);
>> +               resp = list_first_entry_or_null(&drv->response_pending,
>> +                                               struct tcs_response, list);
>> +               if (!resp) {
>> +                       spin_unlock_irqrestore(&drv->drv_lock, flags);
>> +                       break;
>> +               }
>> +               list_del(&resp->list);
>
>Someone should make a list_deqeue() API. Then this would read as:
>
>		spin_lock_irqsave()
>		resp = list_deqeue();
>		spin_unlock_irqrestore()
>		if (!resp)
>			break;
>		free_response(resp)
>
Hmm.. cleaner.

>> +               spin_unlock_irqrestore(&drv->drv_lock, flags);
>> +               free_response(resp);
>> +       }
>> +}
>> +
>> +static void __tcs_buffer_write(struct rsc_drv *drv, int m, int n,
>> +                              const struct tcs_request *msg)
>> +{
>> +       u32 msgid, cmd_msgid;
>> +       u32 cmd_enable = 0;
>> +       u32 cmd_complete;
>> +       struct tcs_cmd *cmd;
>> +       int i, j;
>> +
>> +       cmd_msgid = CMD_MSGID_LEN;
>> +       cmd_msgid |= msg->wait_for_compl ? CMD_MSGID_RESP_REQ : 0;
>> +       cmd_msgid |= CMD_MSGID_WRITE;
>> +
>> +       cmd_complete = read_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, m, 0);
>> +
>> +       for (i = 0, j = n; i < msg->num_cmds; i++, j++) {
>> +               cmd = &msg->cmds[i];
>> +               cmd_enable |= BIT(j);
>> +               cmd_complete |= cmd->wait << j;
>> +               msgid = cmd_msgid;
>> +               msgid |= cmd->wait ? CMD_MSGID_RESP_REQ : 0;
>> +               write_tcs_reg(drv, RSC_DRV_CMD_MSGID, m, j, msgid);
>> +               write_tcs_reg(drv, RSC_DRV_CMD_ADDR, m, j, cmd->addr);
>> +               write_tcs_reg(drv, RSC_DRV_CMD_DATA, m, j, cmd->data);
>> +       }
>> +
>> +       write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, m, 0, cmd_complete);
>> +       cmd_enable |= read_tcs_reg(drv, RSC_DRV_CMD_ENABLE, m, 0);
>> +       write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, m, 0, cmd_enable);
>> +}
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
>> +       enable &= ~TCS_AMC_MODE_ENABLE;
>> +       write_tcs_reg_sync(drv, RSC_DRV_CONTROL, m, 0, enable);
>> +
>> +       /* Enable the AMC mode on the TCS and then trigger the TCS */
>> +       enable = TCS_AMC_MODE_ENABLE;
>> +       write_tcs_reg_sync(drv, RSC_DRV_CONTROL, m, 0, enable);
>> +       enable |= TCS_AMC_MODE_TRIGGER;
>> +       write_tcs_reg_sync(drv, RSC_DRV_CONTROL, m, 0, enable);
>> +}
>> +
>> +static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
>> +                                 const struct tcs_request *msg)
>> +{
>> +       unsigned long curr_enabled;
>> +       u32 addr;
>> +       int i, j, k;
>> +       int m = tcs->offset;
>> +
>> +       for (i = 0; i < tcs->num_tcs; i++, m++) {
>> +               if (tcs_is_free(drv, m))
>> +                       continue;
>> +
>> +               curr_enabled = read_tcs_reg(drv, RSC_DRV_CMD_ENABLE, m, 0);
>> +
>> +               for_each_set_bit(j, &curr_enabled, MAX_CMDS_PER_TCS) {
>> +                       addr = read_tcs_reg(drv, RSC_DRV_CMD_ADDR, m, j);
>> +                       for (k = 0; k < msg->num_cmds; k++) {
>> +                               if (addr == msg->cmds[k].addr)
>> +                                       return -EBUSY;
>> +                       }
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int find_free_tcs(struct tcs_group *tcs)
>> +{
>> +       int m;
>> +
>> +       for (m = 0; m < tcs->num_tcs; m++) {
>> +               if (tcs_is_free(tcs->drv, tcs->offset + m))
>> +                       return m;
>> +       }
>> +
>> +       return -EBUSY;
>> +}
>> +
>> +static int tcs_mbox_write(struct rsc_drv *drv, const struct tcs_request *msg)
>> +{
>> +       struct tcs_group *tcs;
>> +       int m;
>> +       struct tcs_response *resp = NULL;
>> +       unsigned long flags;
>> +       int ret;
>> +
>> +       tcs = get_tcs_for_msg(drv, msg);
>> +       if (IS_ERR(tcs))
>> +               return PTR_ERR(tcs);
>> +
>> +       spin_lock_irqsave(&tcs->lock, flags);
>> +       m = find_free_tcs(tcs);
>> +       if (m < 0) {
>> +               ret = m;
>> +               goto done_write;
>> +       }
>> +
>> +       /*
>> +        * The h/w does not like if we send a request to the same address,
>> +        * when one is already in-flight or being processed.
>> +        */
>> +       ret = check_for_req_inflight(drv, tcs, msg);
>> +       if (ret)
>> +               goto done_write;
>> +
>> +       resp = setup_response(drv, msg, m);
>> +       if (IS_ERR(resp)) {
>> +               ret = PTR_ERR(resp);
>> +               goto done_write;
>> +       }
>> +       resp->m = m;
>> +
>> +       set_bit(m, drv->tcs_in_use);
>> +       __tcs_buffer_write(drv, m, 0, msg);
>> +       __tcs_trigger(drv, m);
>> +
>> +done_write:
>> +       spin_unlock_irqrestore(&tcs->lock, flags);
>> +       return ret;
>> +}
>> +
>> +/**
>> + * rpmh_rsc_send_data: Validate the incoming message and write to the
>> + * appropriate TCS block.
>> + *
>> + * @drv: the controller
>> + * @msg: the data to be sent
>> + *
>> + * Return: 0 on success, -EINVAL on error.
>> + * Note: This call blocks until a valid data is written to the TCS.
>> + */
>> +int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
>> +{
>> +       int ret;
>> +
>> +       if (!msg || !msg->cmds || !msg->num_cmds ||
>> +           msg->num_cmds > MAX_RPMH_PAYLOAD)
>> +               return -EINVAL;
>> +
>> +       do {
>> +               ret = tcs_mbox_write(drv, msg);
>> +               if (ret == -EBUSY) {
>> +                       pr_info_ratelimited("TCS Busy, retrying RPMH message send: addr=%#x\n",
>> +                                           msg->cmds[0].addr);
>> +                       udelay(10);
>> +               }
>> +       } while (ret == -EBUSY);
>
>This loop never breaks if we can't avoid the BUSY loop. And that printk
>is informational, shouldn't it be an error? Is there some number of
>tries we can make and then just give up?
>
I could do that. Generally, there are some transient conditions the
causes these loops to spin for a while, before we get a free TCS to
write to. Failing after just a handful tries may be calling it quits
early. If we increase the delay to compensate for it, then we end
slowing up requests that could have otherwise been faster.

>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL(rpmh_rsc_send_data);
>> +
>> +static int rpmh_probe_tcs_config(struct platform_device *pdev,
>> +                                struct rsc_drv *drv)
>> +{
>> +       struct tcs_type_config {
>> +               u32 type;
>> +               u32 n;
>> +       } tcs_cfg[TCS_TYPE_NR] = { { 0 } };
>> +       struct device_node *dn = pdev->dev.of_node;
>> +       u32 config, max_tcs, ncpt;
>> +       int i, ret, n, st = 0;
>> +       struct tcs_group *tcs;
>> +       struct resource *res;
>> +       void __iomem *base;
>> +
>> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "drv");
>> +       base = devm_ioremap_resource(&pdev->dev, res);
>> +       if (IS_ERR(base))
>> +               return PTR_ERR(base);
>> +
>> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "tcs");
>> +       drv->tcs_base = devm_ioremap_resource(&pdev->dev, res);
>> +       if (IS_ERR(drv->tcs_base))
>> +               return PTR_ERR(drv->tcs_base);
>> +
>> +       config = readl_relaxed(base + DRV_PRNT_CHLD_CONFIG);
>> +
>> +       max_tcs = config;
>> +       max_tcs &= DRV_NUM_TCS_MASK << (DRV_NUM_TCS_SHIFT * drv->id);
>> +       max_tcs = max_tcs >> (DRV_NUM_TCS_SHIFT * drv->id);
>> +
>> +       ncpt = config & (DRV_NCPT_MASK << DRV_NCPT_SHIFT);
>> +       ncpt = ncpt >> DRV_NCPT_SHIFT;
>> +
>> +       n = of_property_count_u32_elems(dn, "qcom,tcs-config");
>> +       if (n != 2 * TCS_TYPE_NR)
>> +               return -EINVAL;
>> +
>> +       for (i = 0; i < TCS_TYPE_NR; i++) {
>> +               ret = of_property_read_u32_index(dn, "qcom,tcs-config",
>> +                                                i * 2, &tcs_cfg[i].type);
>> +               if (ret)
>> +                       return ret;
>> +               if (tcs_cfg[i].type >= TCS_TYPE_NR)
>> +                       return -EINVAL;
>> +
>> +               ret = of_property_read_u32_index(dn, "qcom,tcs-config",
>> +                                                i * 2 + 1, &tcs_cfg[i].n);
>> +               if (ret)
>> +                       return ret;
>> +               if (tcs_cfg[i].n > MAX_TCS_PER_TYPE)
>> +                       return -EINVAL;
>> +       }
>> +
>> +       for (i = 0; i < TCS_TYPE_NR; i++) {
>> +               tcs = &drv->tcs[tcs_cfg[i].type];
>> +               if (tcs->drv)
>> +                       return -EINVAL;
>> +               tcs->drv = drv;
>> +               tcs->type = tcs_cfg[i].type;
>> +               tcs->num_tcs = tcs_cfg[i].n;
>> +               tcs->ncpt = ncpt;
>> +               spin_lock_init(&tcs->lock);
>> +
>> +               if (!tcs->num_tcs || tcs->type == CONTROL_TCS)
>> +                       continue;
>> +
>> +               if (st + tcs->num_tcs > max_tcs ||
>> +                   st + tcs->num_tcs >= BITS_PER_BYTE * sizeof(tcs->mask))
>> +                       return -EINVAL;
>> +
>> +               tcs->mask = ((1 << tcs->num_tcs) - 1) << st;
>> +               tcs->offset = st;
>> +               st += tcs->num_tcs;
>> +       }
>> +
>> +       drv->num_tcs = st;
>> +
>> +       return 0;
>> +}
>> +
>> +static int rpmh_rsc_probe(struct platform_device *pdev)
>> +{
>> +       struct device_node *dn = pdev->dev.of_node;
>> +       struct rsc_drv *drv;
>> +       int ret, irq;
>> +
>> +       drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
>> +       if (!drv)
>> +               return -ENOMEM;
>> +
>> +       ret = of_property_read_u32(dn, "qcom,drv-id", &drv->id);
>> +       if (ret)
>> +               return ret;
>> +
>> +       drv->name = of_get_property(dn, "label", NULL);
>> +       if (!drv->name)
>> +               drv->name = dev_name(&pdev->dev);
>> +
>> +       ret = rpmh_probe_tcs_config(pdev, drv);
>> +       if (ret)
>> +               return ret;
>> +
>> +       INIT_LIST_HEAD(&drv->response_pending);
>> +       spin_lock_init(&drv->drv_lock);
>> +       tasklet_init(&drv->tasklet, tcs_notify_tx_done, (unsigned long)drv);
>> +       bitmap_zero(drv->tcs_in_use, MAX_TCS_NR);
>> +
>> +       irq = platform_get_irq(pdev, 0);
>> +       if (irq < 0)
>> +               return irq;
>> +
>> +       ret = devm_request_irq(&pdev->dev, irq, tcs_irq_handler,
>> +                              IRQF_TRIGGER_HIGH | IRQF_NO_SUSPEND,
>> +                              drv->name, drv);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* Enable the active TCS to send requests immediately */
>> +       write_tcs_reg(drv, RSC_DRV_IRQ_ENABLE, 0, 0, drv->tcs[ACTIVE_TCS].mask);
>> +
>> +       return devm_of_platform_populate(&pdev->dev);
>> +}
>> +
>> diff --git a/include/dt-bindings/soc/qcom,rpmh-rsc.h b/include/dt-bindings/soc/qcom,rpmh-rsc.h
>> new file mode 100644
>> index 000000000000..868f998ea998
>> --- /dev/null
>> +++ b/include/dt-bindings/soc/qcom,rpmh-rsc.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#ifndef __DT_QCOM_RPMH_RSC_H__
>> +#define __DT_QCOM_RPMH_RSC_H__
>> +
>> +#define SLEEP_TCS      0
>> +#define WAKE_TCS       1
>> +#define ACTIVE_TCS     2
>> +#define CONTROL_TCS    3
>
>Is anything besides the RSC node going to use these defines? Typically
>we have defines for things that are used by many nodes in many places
>and also in C code by drivers so this looks odd if it's mostly used for
>packing many properties into a single property on the DT side.
>
This definition is shared between the DT and the driver. Do you have
recommendation on sharing enums between DT and driver?
>> +
>> +#endif /* __DT_QCOM_RPMH_RSC_H__ */
>> diff --git a/include/soc/qcom/tcs.h b/include/soc/qcom/tcs.h
>> new file mode 100644
>> index 000000000000..4b78f881010a
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
>> + * RPMH_SLEEP_STATE:       State of the resource when the processor subsystem
>> + *                         is powered down. There is no client using the
>> + *                         resource actively.
>> + * RPMH_WAKE_ONLY_STATE:   Resume resource state to the value previously
>> + *                         requested before the processor was powered down.
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
>> + * struct tcs_cmd: an individual request to RPMH.
>> + *
>> + * @addr: the address of the resource slv_id:18:16 | offset:0:15
>> + * @data: the resource state request
>> + * @wait: wait for this request to be complete before sending the next
>> + */
>> +struct tcs_cmd {
>> +       u32 addr;
>> +       u32 data;
>> +       bool wait;
>> +};
>> +
>> +/**
>> + * struct tcs_request: A set of tcs_cmds sent together in a TCS
>> + *
>> + * @state:          state for the request.
>
>Drop full stop please
>
OK.

Thanks for the review Stephen.

-- Lina
