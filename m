Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeBBWxi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 17:53:38 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50774 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeBBWxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 17:53:30 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 804C860112
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Fri, 2 Feb 2018 22:53:27 +0000
From: Lina Iyer <ilina@codeaurora.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sboyd@codeaurora.org, rnayak@codeaurora.org, asathyak@codeaurora.org
Subject: Re: [PATCH RFC v2 3/3] drivers: irqchip: pdc: log PDC info in FTRACE
Message-ID: <20180202225327.GA15464@codeaurora.org>
References: <20180202142200.6229-1-ilina@codeaurora.org>
 <20180202142200.6229-4-ilina@codeaurora.org>
 <20180202113227.23716bc9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180202113227.23716bc9@gandalf.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02 2018 at 16:32 +0000, Steven Rostedt wrote:
>On Fri,  2 Feb 2018 07:22:00 -0700
>Lina Iyer <ilina@codeaurora.org> wrote:
>
>Hi Lina,
>
>This looks really good. I have one nit below.
>
>
>> From: Archana Sathyakumar <asathyak@codeaurora.org>
>>
>> Log key PDC pin configuration in FTRACE.
>>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Signed-off-by: Archana Sathyakumar <asathyak@codeaurora.org>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>  drivers/irqchip/qcom-pdc.c |  7 ++++++
>>  include/trace/events/pdc.h | 55 ++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 62 insertions(+)
>>  create mode 100644 include/trace/events/pdc.h
>>
>> diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
>> index a392380eada6..7f177ad88713 100644
>> --- a/drivers/irqchip/qcom-pdc.c
>> +++ b/drivers/irqchip/qcom-pdc.c
>> @@ -26,6 +26,8 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/slab.h>
>>  #include <linux/types.h>
>> +#define CREATE_TRACE_POINTS
>> +#include "trace/events/pdc.h"
>>
>>  #define PDC_MAX_IRQS		126
>>
>> @@ -68,6 +70,8 @@ static inline void pdc_enable_intr(struct irq_data *d, bool on)
>>  	enable = on ? ENABLE_INTR(enable, mask) : CLEAR_INTR(enable, mask);
>>  	pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
>>  	spin_unlock_irqrestore(&pdc_lock, flags);
>> +
>> +	trace_irq_pin_config(PDC_ENTRY, pin_out, (u64)d->chip_data, 0, on);
>>  }
>>
>>  static void qcom_pdc_gic_mask(struct irq_data *d)
>> @@ -149,6 +153,9 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
>>
>>  	pdc_reg_write(IRQ_i_CFG, pin_out, pdc_type);
>>
>> +	trace_irq_pin_config(PDC_TYPE_CONFIG, pin_out, (u64)d->chip_data,
>> +				pdc_type, 0);
>
>I wonder if it makes more sense to just pass 'd' into the trace events,
>and then do the dereference there. The reason is to try to get as much
>code out of the calling path as possible. Even though trace events use
>jump labels and have no conditional branches, the code to call the
>function is still within the code using the trace events. By passing in
>'d' and doing the redirect in the trace event code, we remove the
>setting up of the redirect from the caller, and save some cache lines
>in the process.
Makes sense. Will fix it.

Thanks Steve.

-- Lina
