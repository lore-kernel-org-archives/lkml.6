Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeDKAB1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 20:01:27 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42440 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeDKABY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 20:01:24 -0400
X-Google-Smtp-Source: AIpwx4+tpUX6qseY/VP4m0W1Xv8tdVwr1Ulr72oDUJGwWNNRJEWY0Zl9QVrNgjOB9ZIwySHZQ4DWSg==
Date: Tue, 10 Apr 2018 17:01:20 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org
Subject: Re: [PATCH v5 04/10] drivers: qcom: rpmh: add RPMH helper functions
Message-ID: <20180411000120.GD6727@builder>
References: <20180405161834.3850-1-ilina@codeaurora.org>
 <20180405161834.3850-5-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405161834.3850-5-ilina@codeaurora.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05 Apr 09:18 PDT 2018, Lina Iyer wrote:

> Sending RPMH requests and waiting for response from the controller
> through a callback is common functionality across all platform drivers.
> To simplify drivers, add a library functions to create RPMH client and
> send resource state requests.
> 
> rpmh_write() is a synchronous blocking call that can be used to send
> active state requests.
> 
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> 
> Changes in v4:
> 	- use const struct tcs_cmd in API
> 	- remove wait count from this patch
> 	- changed -EFAULT to -EINVAL
> ---
>  drivers/soc/qcom/Makefile        |   4 +-
>  drivers/soc/qcom/rpmh-internal.h |   2 +
>  drivers/soc/qcom/rpmh-rsc.c      |   7 ++
>  drivers/soc/qcom/rpmh.c          | 253 +++++++++++++++++++++++++++++++++++++++
>  include/soc/qcom/rpmh.h          |  34 ++++++
>  5 files changed, 299 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/soc/qcom/rpmh.c
>  create mode 100644 include/soc/qcom/rpmh.h
> 
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index cb6300f6a8e9..bb395c3202ca 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -7,7 +7,9 @@ obj-$(CONFIG_QCOM_PM)	+=	spm.o
>  obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
>  qmi_helpers-y	+= qmi_encdec.o qmi_interface.o
>  obj-$(CONFIG_QCOM_RMTFS_MEM)	+= rmtfs_mem.o
> -obj-$(CONFIG_QCOM_RPMH)	+=	rpmh-rsc.o
> +obj-$(CONFIG_QCOM_RPMH)		+= qcom_rpmh.o
> +qcom_rpmh-y			+= rpmh-rsc.o
> +qcom_rpmh-y			+= rpmh.o
>  obj-$(CONFIG_QCOM_SMD_RPM)	+= smd-rpm.o
>  obj-$(CONFIG_QCOM_SMEM) +=	smem.o
>  obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
> diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
> index aa73ec4b3e42..125f9faec536 100644
> --- a/drivers/soc/qcom/rpmh-internal.h
> +++ b/drivers/soc/qcom/rpmh-internal.h
> @@ -86,4 +86,6 @@ struct rsc_drv {
>  
>  int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg);
>  
> +void rpmh_tx_done(const struct tcs_request *msg, int r);
> +
>  #endif /* __RPM_INTERNAL_H__ */
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index f604101a4fc2..c5cde917dba6 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -252,6 +252,8 @@ static void tcs_notify_tx_done(unsigned long data)
>  	struct rsc_drv *drv = (struct rsc_drv *)data;
>  	struct tcs_response *resp;
>  	unsigned long flags;
> +	const struct tcs_request *msg;
> +	int err;
>  
>  	for (;;) {
>  		spin_lock_irqsave(&drv->drv_lock, flags);
> @@ -264,7 +266,10 @@ static void tcs_notify_tx_done(unsigned long data)
>  		list_del(&resp->list);
>  		spin_unlock_irqrestore(&drv->drv_lock, flags);
>  		trace_rpmh_notify_tx_done(drv, resp);
> +		msg = resp->msg;
> +		err = resp->err;
>  		free_response(resp);
> +		rpmh_tx_done(msg, err);
>  	}
>  }
>  
> @@ -554,6 +559,8 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
>  	/* Enable the active TCS to send requests immediately */
>  	write_tcs_reg(drv, RSC_DRV_IRQ_ENABLE, 0, 0, drv->tcs[ACTIVE_TCS].mask);
>  
> +	dev_set_drvdata(&pdev->dev, drv);
> +
>  	return devm_of_platform_populate(&pdev->dev);
>  }
>  
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> new file mode 100644
> index 000000000000..e3c7491e7baf
> --- /dev/null
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -0,0 +1,253 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/atomic.h>
> +#include <linux/interrupt.h>
> +#include <linux/jiffies.h>
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
> +#define RPMH_MAX_MBOXES			2
> +#define RPMH_TIMEOUT_MS			10000

Just define this in jiffies and you don't need to do msecs_to_jiffies()
every time you use it.

> +
> +#define DEFINE_RPMH_MSG_ONSTACK(rc, s, q, name)		\
> +	struct rpmh_request name = {			\
> +		.msg = {				\
> +			.state = s,			\
> +			.cmds = name.cmd,		\
> +			.num_cmds = 0,			\
> +			.wait_for_compl = true,		\
> +		},					\
> +		.cmd = { { 0 } },			\
> +		.completion = q,			\
> +		.rc = rc,				\
> +	}
> +
> +/**
> + * struct rpmh_request: the message to be sent to rpmh-rsc
> + *
> + * @msg: the request
> + * @cmd: the payload that will be part of the @msg
> + * @completion: triggered when request is done
> + * @err: err return from the controller
> + */
> +struct rpmh_request {
> +	struct tcs_request msg;
> +	struct tcs_cmd cmd[MAX_RPMH_PAYLOAD];
> +	struct completion *completion;
> +	struct rpmh_client *rc;
> +	int err;
> +};
> +
> +/**
> + * struct rpmh_ctrlr: our representation of the controller
> + *
> + * @drv: the controller instance
> + */
> +struct rpmh_ctrlr {
> +	struct rsc_drv *drv;
> +};
> +
> +/**
> + * struct rpmh_client: the client object
> + *
> + * @dev: the platform device that is the owner
> + * @ctrlr: the controller associated with this client.
> + */
> +struct rpmh_client {
> +	struct device *dev;
> +	struct rpmh_ctrlr *ctrlr;
> +};
> +
> +static struct rpmh_ctrlr rpmh_rsc[RPMH_MAX_MBOXES];
> +static DEFINE_MUTEX(rpmh_ctrlr_mutex);
> +
> +void rpmh_tx_done(const struct tcs_request *msg, int r)

Why do you abstract this? Just put "err" and "completion" in the
rpmh_request and fire them off as soon as you know the result of the
request.

> +{
> +	struct rpmh_request *rpm_msg = container_of(msg, struct rpmh_request,
> +						    msg);
> +	struct completion *compl = rpm_msg->completion;
> +
> +	rpm_msg->err = r;
> +
> +	if (r)
> +		dev_err(rpm_msg->rc->dev,
> +			"RPMH TX fail in msg addr=%#x, err=%d\n",
> +			rpm_msg->msg.cmds[0].addr, r);
> +
> +	/* Signal the blocking thread we are done */
> +	if (compl)
> +		complete(compl);
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
> + */
> +static int wait_for_tx_done(struct rpmh_client *rc,
> +			    struct completion *compl, u32 addr, u32 data)
> +{
> +	int ret;
> +
> +	might_sleep();
> +
> +	ret = wait_for_completion_timeout(compl,
> +					  msecs_to_jiffies(RPMH_TIMEOUT_MS));
> +	if (ret)
> +		dev_dbg(rc->dev,
> +			"RPMH response received addr=%#x data=%#x\n",
> +			addr, data);

For the single cmd use case this printout will be correct, but in that
case there's no value printing at this level compared to higher up. For
the batch process you will in a later patch print the parameters of
cmd[0], regardless of which cmd failed - which is deceiving.

I suggest that you just drop these debug prints and have some higher
layer take care of it, if they want to.

> +	else
> +		dev_err(rc->dev,
> +			"RPMH response timeout addr=%#x data=%#x\n",
> +			addr, data);
> +
> +	return (ret > 0) ? 0 : -ETIMEDOUT;
> +}
> +
> +/**
> + * __rpmh_write: send the RPMH request
> + *
> + * @rc: The RPMH client
> + * @state: Active/Sleep request type
> + * @rpm_msg: The data that needs to be sent (cmds).
> + */
> +static int __rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
> +			struct rpmh_request *rpm_msg)
> +{
> +	int ret = -EINVAL;
> +
> +	rpm_msg->msg.state = state;
> +
> +	if (state == RPMH_ACTIVE_ONLY_STATE) {
> +		WARN_ON(irqs_disabled());

Can you please add a comment here, describing the different expectations
compared to using might_sleep() here.

> +		ret = rpmh_rsc_send_data(rc->ctrlr->drv, &rpm_msg->msg);
> +		if (!ret)
> +			dev_dbg(rc->dev,
> +				"RPMH request sent addr=%#x, data=%i#x\n",
> +				rpm_msg->msg.cmds[0].addr,
> +				rpm_msg->msg.cmds[0].data);
> +		else
> +			dev_warn(rc->dev,
> +				 "Error in RPMH request addr=%#x, data=%#x\n",
> +				 rpm_msg->msg.cmds[0].addr,
> +				 rpm_msg->msg.cmds[0].data);

As above, there's no added value in printing an error on this level.

> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * rpmh_write: Write a set of RPMH commands and block until response
> + *
> + * @rc: The RPMh handle got from rpmh_get_client
> + * @state: Active/sleep set
> + * @cmd: The payload data
> + * @n: The number of elements in @cmd
> + *
> + * May sleep. Do not call from atomic contexts.
> + */
> +int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
> +	       const struct tcs_cmd *cmd, u32 n)
> +{
> +	DECLARE_COMPLETION_ONSTACK(compl);
> +	DEFINE_RPMH_MSG_ONSTACK(rc, state, &compl, rpm_msg);
> +	int ret;
> +
> +	if (IS_ERR_OR_NULL(rc) || !cmd || !n || n > MAX_RPMH_PAYLOAD)
> +		return -EINVAL;
> +
> +	memcpy(rpm_msg.cmd, cmd, n * sizeof(*cmd));
> +	rpm_msg.msg.num_cmds = n;
> +
> +	ret = __rpmh_write(rc, state, &rpm_msg);
> +	if (ret)
> +		return ret;
> +
> +	return wait_for_tx_done(rc, &compl, cmd[0].addr, cmd[0].data);

As this is just a wait_for_completion_timeout(compl) it would be cleaner
to just call that here directly.

> +}
> +EXPORT_SYMBOL(rpmh_write);
> +
> +static struct rpmh_ctrlr *get_rpmh_ctrlr(struct platform_device *pdev)
> +{
> +	int i;
> +	struct rsc_drv *drv = dev_get_drvdata(pdev->dev.parent);
> +	struct rpmh_ctrlr *ctrlr = ERR_PTR(-EINVAL);
> +
> +	if (!drv)
> +		return ctrlr;

The only time this would fail is if pdev->dev.parent happens to be
some other device that happens to not have drvdata. It's fine to assume
that the rsc client is actually a child of the rsc device.

> +
> +	mutex_lock(&rpmh_ctrlr_mutex);
> +	for (i = 0; i < RPMH_MAX_MBOXES; i++) {
> +		if (rpmh_rsc[i].drv == drv) {

Why do you store these in a global variable? Just create one for each
rsc and store that in the drvdata. Turning this function into:

	return dev_get_drvdata(pdev->dev.parent);

> +			ctrlr = &rpmh_rsc[i];
> +			goto unlock;
> +		}
> +	}
> +
> +	for (i = 0; i < RPMH_MAX_MBOXES; i++) {
> +		if (rpmh_rsc[i].drv == NULL) {
> +			ctrlr = &rpmh_rsc[i];
> +			ctrlr->drv = drv;
> +			break;
> +		}
> +	}
> +	WARN_ON(i == RPMH_MAX_MBOXES);
> +unlock:
> +	mutex_unlock(&rpmh_ctrlr_mutex);
> +	return ctrlr;
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
> +{
> +	struct rpmh_client *rc;
> +
> +	rc = kzalloc(sizeof(*rc), GFP_KERNEL);
> +	if (!rc)
> +		return ERR_PTR(-ENOMEM);

The only thing this is used for it to keep the client's "dev" in order
to be able to print debug messages on its behalf. The cost of it is that
the clients needs to do custom error handling in probe and actually
implement a remove function.

Can you please elaborate on what kind of magic stuff will go into this
struct that makes it worth lugging around?

> +
> +	rc->dev = &pdev->dev;
> +	rc->ctrlr = get_rpmh_ctrlr(pdev);
> +	if (IS_ERR(rc->ctrlr)) {
> +		kfree(rc);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL(rpmh_get_client);
> +
> +/**
> + * rpmh_release: Release the RPMH client
> + *
> + * @rc: The RPMh handle to be freed.
> + */
> +void rpmh_release(struct rpmh_client *rc)
> +{
> +	kfree(rc);

If you really really need it, can we at least make it use devres.

> +}

Regards,
Bjorn
