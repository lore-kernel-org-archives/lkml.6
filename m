Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751602AbeDGBVo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 21:21:44 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46044 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbeDGBVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 21:21:42 -0400
X-Google-Smtp-Source: AIpwx4+93jSFe8VzH/Ys0ioXXWtH605DO5NPuBJOklgXh+e4LV6oMANbwZeq0r1dXSn538pvbgbixA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Lina Iyer <ilina@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180405161834.3850-5-ilina@codeaurora.org>
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
References: <20180405161834.3850-1-ilina@codeaurora.org>
 <20180405161834.3850-5-ilina@codeaurora.org>
Message-ID: <152306410070.94378.2738189478665128271@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 04/10] drivers: qcom: rpmh: add RPMH helper functions
Date: Fri, 06 Apr 2018 18:21:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w371LnHo015670

Quoting Lina Iyer (2018-04-05 09:18:28)
> diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
> new file mode 100644
> index 000000000000..95334d4c1ede
> --- /dev/null
> +++ b/include/soc/qcom/rpmh.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef __SOC_QCOM_RPMH_H__
> +#define __SOC_QCOM_RPMH_H__
> +
> +#include <soc/qcom/tcs.h>
> +#include <linux/platform_device.h>
> +
> +struct rpmh_client;
> +
> +#if IS_ENABLED(CONFIG_QCOM_RPMH)
> +int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
> +              const struct tcs_cmd *cmd, u32 n);
> +
> +struct rpmh_client *rpmh_get_client(struct platform_device *pdev);
> +
> +void rpmh_release(struct rpmh_client *rc);

Please get rid of this 'client' layer and fold it into the rpmh driver.
Everything that uses the rpmh_client is a child device of the rpmh
device so they should be able to just pass in their device pointer as
their 'handle' and have the rpmh driver take that, get the parent device
pointer, and pull an rpmh_drv structure out of there. The 'common' code
can go into the base rpmh driver and get used from there and then we
don't have to hop between two files to see how rpmh is used by the
consumers. Code complexity goes down this way.
