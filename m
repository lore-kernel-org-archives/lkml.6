Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932677AbeCIVdb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 16:33:31 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41048 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932327AbeCIVd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 16:33:29 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB332602A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Fri, 9 Mar 2018 14:33:27 -0700
From: Lina Iyer <ilina@codeaurora.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] drivers: qcom: rpmh-rsc: add RPMH controller
 for QCOM SoCs
Message-ID: <20180309213327.GA2806@codeaurora.org>
References: <20180302164317.10554-1-ilina@codeaurora.org>
 <20180302164317.10554-2-ilina@codeaurora.org>
 <152036550693.218381.11708415467260101936@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <152036550693.218381.11708415467260101936@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

I will address all the comments in the next spin of the patch. Here are
some responses to the questions.

On Tue, Mar 06 2018 at 12:45 -0700, Stephen Boyd wrote:
>Quoting Lina Iyer (2018-03-02 08:43:08)
[...]
> +#include <linux/module.h>
>
>If the driver doesn't become tristate, this should become export.h
>instead of module.h
>
MODULE_DEVICE_TABLE seems to need this.

[...]
>> +
>> +static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int m, int n,
>> +                             u32 data)
>> +{
>> +       write_tcs_reg(drv, reg, m, n, data);
>> +       for (;;) {
>> +               if (data == read_tcs_reg(drv, reg, m, n))
>> +                       break;
>> +               udelay(1);
>
>Hopefully this never gets stuck. Add a timeout?
>
No, it wont. The read is to make sure that the write went through before
we exit this call.

[...]
>> +               list_del(&resp->list);
>> +               spin_unlock_irqrestore(&drv->drv_lock, flags);
>> +               free_response(resp);
>
>But all this function does is free the structure? Will it do more later?
>
Hopefully, I would like to use a pre-allocateed pool instead of alloc
and free.

> +               for_each_set_bit(j, &curr_enabled, MAX_CMDS_PER_TCS) {
>> +                       addr = read_tcs_reg(drv, RSC_DRV_CMD_ADDR, m, j);
>> +                       for (k = 0; k < msg->num_payload; k++) {
>> +                               if (addr == msg->payload[k].addr)
>> +                                       return -EBUSY;
>> +                       }
>> +               }
>> +       }
>
>There isn't any way to do this in software only? Hopefully this isn't
>costly to read the TCS to see if something matches.
>
It is, but not too expensive. The alternatives involves more locking..

Thanks,
Lina
