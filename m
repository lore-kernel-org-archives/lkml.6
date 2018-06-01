Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeFAQj2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:39:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42214 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751777AbeFAQj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:39:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1DCFF605A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [RFC PATCH 2/5] remoteproc: q6v5: Extract common resource
 handling
To: Sibi S <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>, Rohit kumar <rohitkr@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20180523052054.19025-1-bjorn.andersson@linaro.org>
 <20180523052054.19025-3-bjorn.andersson@linaro.org>
 <8c2acd62-0f3b-9167-b028-1f5149bd7937@codeaurora.org>
 <5a1ecc9e-34e8-63be-3502-5d2927fbc97c@codeaurora.org>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <be2a6425-170c-a7e2-8cfd-31847e577674@codeaurora.org>
Date: Fri, 1 Jun 2018 22:09:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5a1ecc9e-34e8-63be-3502-5d2927fbc97c@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

On 6/1/2018 8:48 PM, Sibi S wrote:
> Hi Sricharan,
> 
> On 06/01/2018 11:46 AM, Sricharan R wrote:
>> Hi Bjorn,
>>    Thanks for this much needed consolidation.
>>
>> On 5/23/2018 10:50 AM, Bjorn Andersson wrote:
>>> Shared between all Hexagon V5 based remoteprocs is the handling of the 5
>>> interrupts and the SMP2P stop request, so break this out into a separate
>>> function in order to allow these drivers to be cleaned up.
>>>
>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> ---
>>>   drivers/remoteproc/Kconfig     |   5 +
>>>   drivers/remoteproc/Makefile    |   1 +
>>>   drivers/remoteproc/qcom_q6v5.c | 243 +++++++++++++++++++++++++++++++++
>>>   drivers/remoteproc/qcom_q6v5.h |  46 +++++++
>>>   4 files changed, 295 insertions(+)
>>>   create mode 100644 drivers/remoteproc/qcom_q6v5.c
>>>   create mode 100644 drivers/remoteproc/qcom_q6v5.h
>>>
>>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>>> index cd1c168fd188..63b79ea91a21 100644
>>> --- a/drivers/remoteproc/Kconfig
>>> +++ b/drivers/remoteproc/Kconfig
>>> @@ -102,6 +102,11 @@ config QCOM_ADSP_PIL
>>>   config QCOM_RPROC_COMMON
>>>       tristate
>>>   +config QCOM_Q6V5_COMMON
>>> +    tristate
>>> +    depends on ARCH_QCOM
>>> +    depends on QCOM_SMEM
>>> +
>>>   config QCOM_Q6V5_PIL
>>>       tristate "Qualcomm Hexagon V5 Peripherial Image Loader"
>>>       depends on OF && ARCH_QCOM
>>> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
>>> index 02627ede8d4a..5dd0249cf76a 100644
>>> --- a/drivers/remoteproc/Makefile
>>> +++ b/drivers/remoteproc/Makefile
>>> @@ -16,6 +16,7 @@ obj-$(CONFIG_DA8XX_REMOTEPROC)        += da8xx_remoteproc.o
>>>   obj-$(CONFIG_KEYSTONE_REMOTEPROC)    += keystone_remoteproc.o
>>>   obj-$(CONFIG_QCOM_ADSP_PIL)        += qcom_adsp_pil.o
>>>   obj-$(CONFIG_QCOM_RPROC_COMMON)        += qcom_common.o
>>> +obj-$(CONFIG_QCOM_Q6V5_COMMON)        += qcom_q6v5.o
>>>   obj-$(CONFIG_QCOM_Q6V5_PIL)        += qcom_q6v5_pil.o
>>>   obj-$(CONFIG_QCOM_SYSMON)        += qcom_sysmon.o
>>>   obj-$(CONFIG_QCOM_WCNSS_PIL)        += qcom_wcnss_pil.o
>>> diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
>>> new file mode 100644
>>> index 000000000000..9076537a1671
>>> --- /dev/null
>>> +++ b/drivers/remoteproc/qcom_q6v5.c
>>> @@ -0,0 +1,243 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Qualcomm Peripheral Image Loader for Q6V5 WCSS
>>> + *
>>
>>    Probably just Q6V5, QCSS not needed.
>>
>>> + * Copyright (C) 2016-2018 Linaro Ltd.
>>> + * Copyright (C) 2014 Sony Mobile Communications AB
>>> + * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
>>> + */
>>> +#include <linux/kernel.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/soc/qcom/smem.h>
>>> +#include <linux/soc/qcom/smem_state.h>
>>> +#include <linux/remoteproc.h>
>>> +#include "qcom_q6v5.h"
>>> +
>>> +/**
>>> + * qcom_q6v5_prepare() - reinitialize the qcom_q6v5 context before start
>>> + * @q6v5:    reference to qcom_q6v5 context to be reinitialized
>>> + *
>>> + * Return: 0 on success, negative errno on failure
>>> + */
>>> +int qcom_q6v5_prepare(struct qcom_q6v5 *q6v5)
>>> +{
>>> +    reinit_completion(&q6v5->start_done);
>>> +    reinit_completion(&q6v5->stop_done);
>>> +
>>> +    q6v5->running = true;
>>> +    q6v5->handover_issued = false;
>>> +
>>> +    enable_irq(q6v5->handover_irq);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +/**
>>> + * qcom_q6v5_unprepare() - unprepare the qcom_q6v5 context after stop
>>> + * @q6v5:    reference to qcom_q6v5 context to be unprepared
>>> + *
>>> + * Return: 0 on success, 1 if handover hasn't yet been called
>>> + */
>>> +int qcom_q6v5_unprepare(struct qcom_q6v5 *q6v5)
>>> +{
>>> +    disable_irq(q6v5->handover_irq);
>>> +
>>> +    return !q6v5->handover_issued;
>>> +}
>>> +
>>> +static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
>>> +{
>>> +    struct qcom_q6v5 *q6v5 = data;
>>> +    size_t len;
>>> +    char *msg;
>>> +
>>> +    /* Sometimes the stop triggers a watchdog rather than a stop-ack */
>>> +    if (!q6v5->running) {
>>> +        complete(&q6v5->stop_done);
>>> +        return IRQ_HANDLED;
>>> +    }
>>> +
>>
>>     Does this change the behavior for adsp pil, which was unconditionally
>>     doing a rproc_report_crash before, but now checks for the running flag
>>     or probably this is the correct sequence ?
>>
>>> +    msg = qcom_smem_get(QCOM_SMEM_HOST_ANY, q6v5->crash_reason, &len);
>>> +    if (!IS_ERR(msg) && len > 0 && msg[0])
>>> +        dev_err(q6v5->dev, "watchdog received: %s\n", msg);
>>> +    else
>>> +        dev_err(q6v5->dev, "watchdog without message\n");
>>> +
>>> +    rproc_report_crash(q6v5->rproc, RPROC_FATAL_ERROR);
>>> +
>>
>>     Should be rproc_report_crash(q6v5->rproc, RPROC_WATCHDOG);
>>
>>> +    return IRQ_HANDLED;
>>> +}
>>> +
>>> +static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
>>> +{
>>> +    struct qcom_q6v5 *q6v5 = data;
>>> +    size_t len;
>>> +    char *msg;
>>> +
>>> +    msg = qcom_smem_get(QCOM_SMEM_HOST_ANY, q6v5->crash_reason, &len);
>>> +    if (!IS_ERR(msg) && len > 0 && msg[0])
>>> +        dev_err(q6v5->dev, "fatal error received: %s\n", msg);
>>> +    else
>>> +        dev_err(q6v5->dev, "fatal error without message\n");
>>> +
>>> +    rproc_report_crash(q6v5->rproc, RPROC_FATAL_ERROR);
>>> +
>>> +    return IRQ_HANDLED;
>>> +}
>>> +
>>> +static irqreturn_t q6v5_ready_interrupt(int irq, void *data)
>>> +{
>>> +    struct qcom_q6v5 *q6v5 = data;
>>> +
>>> +    complete(&q6v5->start_done);
>>> +
>>> +    return IRQ_HANDLED;
>>> +}
>>
>>    For adsp, previously start_done completion was done as a part of
>>    handover interrupt, now its done in ready. Does it mean that the
>>    entries in DT should be changed etc ?
> 
> ready interrupt has always been a part dt entry however a corresponding
> interrupt handler was never registered. The trigger condition for
> the handover interrupt in the remote processor seem to vary across SoCs
> but we can always rely on the ready interrupt to declare the rproc
> device is running.
> 

 All right. My doubt was more because start_done completion  being
 moved to ready. I guess Rohit has already verified the functionality
 with the patch. So should be fine.

Regards,
 Sricharan
 
>>> +
>>> +/**
>>> + * qcom_q6v5_wait_for_start() - wait for remote processor start signal
>>> + * @q6v5:    reference to qcom_q6v5 context
>>> + * @timeout:    timeout to wait for the event, in jiffies
>>> + *
>>> + * qcom_q6v5_unprepare() should not be called when this function fails.
>>> + *
>>> + * Return: 0 on success, -ETIMEDOUT on timeout
>>> + */
>>> +int qcom_q6v5_wait_for_start(struct qcom_q6v5 *q6v5, int timeout)
>>> +{
>>> +    int ret;
>>> +
>>> +    ret = wait_for_completion_timeout(&q6v5->start_done, timeout);
>>> +    if (!ret)
>>> +        disable_irq(q6v5->handover_irq);
>>> +
>>> +    return !ret ? -ETIMEDOUT : 0;
>>> +}
>>> +
>>> +static irqreturn_t q6v5_handover_interrupt(int irq, void *data)
>>> +{
>>> +    struct qcom_q6v5 *q6v5 = data;
>>> +
>>> +    if (q6v5->handover)
>>> +        q6v5->handover(q6v5);
>>> +
>>> +    q6v5->handover_issued = true;
>>> +
>>> +    return IRQ_HANDLED;
>>> +}
>>> +
>>> +static irqreturn_t q6v5_stop_interrupt(int irq, void *data)
>>> +{
>>> +    struct qcom_q6v5 *q6v5 = data;
>>> +
>>> +    complete(&q6v5->stop_done);
>>> +
>>> +    return IRQ_HANDLED;
>>> +}
>>> +
>>> +/**
>>> + * qcom_q6v5_request_stop() - request the remote processor to stop
>>> + * @q6v5:    reference to qcom_q6v5 context
>>> + *
>>> + * Return: 0 on success, negative errno on failure
>>> + */
>>> +int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5)
>>> +{
>>> +    int ret;
>>> +
>>> +    q6v5->running = false;
>>> +
>>> +    qcom_smem_state_update_bits(q6v5->state,
>>> +                    BIT(q6v5->stop_bit), BIT(q6v5->stop_bit));
>>> +
>>> +    ret = wait_for_completion_timeout(&q6v5->stop_done, 5 * HZ);
>>> +
>>> +    qcom_smem_state_update_bits(q6v5->state, BIT(q6v5->stop_bit), 0);
>>> +
>>> +    return ret == 0 ? -ETIMEDOUT : 0;
>>> +}
>>> +
>>> +/**
>>> + * qcom_q6v5_init() - initializer of the q6v5 common struct
>>> + * @q6v5:    handle to be initialized
>>> + * @pdev:    platform_device reference for acquiring resources
>>> + * @rproc:    associated remoteproc instance
>>> + * @crash_reason: SMEM id for crash reason string, or 0 if none
>>> + * @handover:    function to be called when proxy resources should be released
>>> + *
>>> + * Return: 0 on success, negative errno on failure
>>> + */
>>> +int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
>>> +           struct rproc *rproc, int crash_reason,
>>> +           void (*handover)(struct qcom_q6v5 *q6v5))
>>> +{
>>> +    int ret;
>>> +
>>> +    q6v5->rproc = rproc;
>>> +    q6v5->dev = &pdev->dev;
>>> +    q6v5->crash_reason = crash_reason;
>>> +    q6v5->handover = handover;
>>> +
>>> +    init_completion(&q6v5->start_done);
>>> +    init_completion(&q6v5->stop_done);
>>> +
>>> +    q6v5->wdog_irq = platform_get_irq_byname(pdev, "wdog");
>>> +    ret = devm_request_threaded_irq(&pdev->dev, q6v5->wdog_irq,
>>> +                    NULL, q6v5_wdog_interrupt,
>>> +                    IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>>> +                    "q6v5 wdog", q6v5);
>>> +    if (ret) {
>>> +        dev_err(&pdev->dev, "failed to acquire wdog IRQ\n");
>>> +        return ret;
>>> +    }
>>> +
>>> +    q6v5->fatal_irq = platform_get_irq_byname(pdev, "fatal");
>>> +    ret = devm_request_threaded_irq(&pdev->dev, q6v5->fatal_irq,
>>> +                    NULL, q6v5_fatal_interrupt,
>>> +                    IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>>> +                    "q6v5 fatal", q6v5);
>>> +    if (ret) {
>>> +        dev_err(&pdev->dev, "failed to acquire fatal IRQ\n");
>>> +        return ret;
>>> +    }
>>> +
>>> +    q6v5->ready_irq = platform_get_irq_byname(pdev, "ready");
>>> +    ret = devm_request_threaded_irq(&pdev->dev, q6v5->ready_irq,
>>> +                    NULL, q6v5_ready_interrupt,
>>> +                    IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>>> +                    "q6v5 ready", q6v5);
>>> +    if (ret) {
>>> +        dev_err(&pdev->dev, "failed to acquire ready IRQ\n");
>>> +        return ret;
>>> +    }
>>> +
>>> +    q6v5->handover_irq = platform_get_irq_byname(pdev, "handover");
>>> +    ret = devm_request_threaded_irq(&pdev->dev, q6v5->handover_irq,
>>> +                    NULL, q6v5_handover_interrupt,
>>> +                    IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>>> +                    "q6v5 handover", q6v5);
>>> +    if (ret) {
>>> +        dev_err(&pdev->dev, "failed to acquire handover IRQ\n");
>>> +        return ret;
>>> +    }
>>> +    disable_irq(q6v5->handover_irq);
>>> +
>>> +    q6v5->stop_irq = platform_get_irq_byname(pdev, "stop-ack");
>>> +    ret = devm_request_threaded_irq(&pdev->dev, q6v5->stop_irq,
>>> +                    NULL, q6v5_stop_interrupt,
>>> +                    IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>>> +                    "q6v5 stop", q6v5);
>>> +    if (ret) {
>>> +        dev_err(&pdev->dev, "failed to acquire stop-ack IRQ\n");
>>> +        return ret;
>>> +    }
>>> +
>>> +    q6v5->state = qcom_smem_state_get(&pdev->dev, "stop", &q6v5->stop_bit);
>>> +    if (IS_ERR(q6v5->state)) {
>>> +        dev_err(&pdev->dev, "failed to acquire stop state\n");
>>> +        return PTR_ERR(q6v5->state);
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> diff --git a/drivers/remoteproc/qcom_q6v5.h b/drivers/remoteproc/qcom_q6v5.h
>>> new file mode 100644
>>> index 000000000000..7ac92c1e0f49
>>> --- /dev/null
>>> +++ b/drivers/remoteproc/qcom_q6v5.h
>>> @@ -0,0 +1,46 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +
>>> +#ifndef __QCOM_Q6V5_H__
>>> +#define __QCOM_Q6V5_H__
>>> +
>>> +#include <linux/kernel.h>
>>> +#include <linux/completion.h>
>>> +
>>> +struct rproc;
>>> +struct qcom_smem_state;
>>> +
>>> +struct qcom_q6v5 {
>>> +    struct device *dev;
>>> +    struct rproc *rproc;
>>> +
>>> +    struct qcom_smem_state *state;
>>> +    unsigned stop_bit;
>>> +
>>> +    int wdog_irq;
>>> +    int fatal_irq;
>>> +    int ready_irq;
>>> +    int handover_irq;
>>> +    int stop_irq;
>>> +
>>> +    bool handover_issued;
>>> +
>>> +    struct completion start_done;
>>> +    struct completion stop_done;
>>> +
>>> +    int crash_reason;
>>> +
>>> +    bool running;
>>> +
>>> +    void (*handover)(struct qcom_q6v5 *q6v5);
>>> +};
>>> +
>>> +int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
>>> +           struct rproc *rproc, int crash_reason,
>>> +           void (*handover)(struct qcom_q6v5 *q6v5));
>>> +
>>> +int qcom_q6v5_prepare(struct qcom_q6v5 *q6v5);
>>> +int qcom_q6v5_unprepare(struct qcom_q6v5 *q6v5);
>>> +int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5);
>>> +int qcom_q6v5_wait_for_start(struct qcom_q6v5 *q6v5, int timeout);
>>> +
>>> +#endif
>>>
>>
>> Regards,
>>   Sricharan
>>
> 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
