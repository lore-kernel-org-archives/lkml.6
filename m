Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753273AbeDKQeo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 12:34:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45870 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753090AbeDKQem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 12:34:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E4C2602CB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Wed, 11 Apr 2018 10:34:40 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH v5 04/10] drivers: qcom: rpmh: add RPMH helper functions
Message-ID: <20180411163440.GF19682@codeaurora.org>
References: <20180405161834.3850-1-ilina@codeaurora.org>
 <20180405161834.3850-5-ilina@codeaurora.org>
 <152306410070.94378.2738189478665128271@swboyd.mtv.corp.google.com>
 <20180409153631.GB19682@codeaurora.org>
 <152341338838.180276.13886596646409290675@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <152341338838.180276.13886596646409290675@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10 2018 at 20:23 -0600, Stephen Boyd wrote:
>Quoting Lina Iyer (2018-04-09 08:36:31)
>> On Fri, Apr 06 2018 at 19:21 -0600, Stephen Boyd wrote:
>> >Quoting Lina Iyer (2018-04-05 09:18:28)
>> >> diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
>> >> new file mode 100644
>> >> index 000000000000..95334d4c1ede
>> >> --- /dev/null
>> >> +++ b/include/soc/qcom/rpmh.h
>> >> @@ -0,0 +1,34 @@
>> >> +/* SPDX-License-Identifier: GPL-2.0 */
>> >> +/*
>> >> + * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
>> >> + */
>> >> +
>> >> +#ifndef __SOC_QCOM_RPMH_H__
>> >> +#define __SOC_QCOM_RPMH_H__
>> >> +
>> >> +#include <soc/qcom/tcs.h>
>> >> +#include <linux/platform_device.h>
>> >> +
>> >> +struct rpmh_client;
>> >> +
>> >> +#if IS_ENABLED(CONFIG_QCOM_RPMH)
>> >> +int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
>> >> +              const struct tcs_cmd *cmd, u32 n);
>> >> +
>> >> +struct rpmh_client *rpmh_get_client(struct platform_device *pdev);
>> >> +
>> >> +void rpmh_release(struct rpmh_client *rc);
>> >
>> >Please get rid of this 'client' layer and fold it into the rpmh driver.
>> >Everything that uses the rpmh_client is a child device of the rpmh
>> >device so they should be able to just pass in their device pointer as
>> >their 'handle' and have the rpmh driver take that, get the parent device
>> >pointer, and pull an rpmh_drv structure out of there. The 'common' code
>> >can go into the base rpmh driver and get used from there and then we
>> >don't have to hop between two files to see how rpmh is used by the
>> >consumers. Code complexity goes down this way.
>>
>> That would be not be a good idea. This layer is not just providing an
>> API interface. There is resource buffering, handling of memory for
>> requests and downstream quirks and debug going on in this layer. It
>> would be unwise to clobber the hardware centric rpmh-rsc layer. If you
>> look at the series as a whole, you would understand why this is
>> necessary. I plan to build more on top of these patches in the future as
>> we add support for system low power modes. The complexity doesn't go
>> away, it just thrown in to another file, which is already decently
>> sized.
>>
>> I could try to use the device as a handle, and internally work on
>> getting the drv and other information from it, if that helps. But I do
>> not want to clobber these two files together. It doesn't help
>> maintainability.
>
>Using the device as a handle is a good start. Let's see how it looks
>once that part of the code gets replaced. I still fail to see how buffer
>management and requests are any different from poking the hardware, but
>OK. Maybe if this was a TCS "library" on top of the rpmh hardware
>interface?
This is essentially a TCS library.

-- Lina
