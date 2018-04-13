Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754119AbeDMNIO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 09:08:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754003AbeDMNIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 09:08:12 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C8A2178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AIpwx48wj3dqcjtDiOX5T+tH8GSlCwkadjPu2k1WajgKWZDFue9jG+YV4UUsTYSOHhMUuDaBEsZbxIZwS3GpD6dE8So=
MIME-Version: 1.0
In-Reply-To: <b70afd25fc48ad4d677e4e53951f2138cd34b85e.1523351100.git.viresh.kumar@linaro.org>
References: <b70afd25fc48ad4d677e4e53951f2138cd34b85e.1523351100.git.viresh.kumar@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 13 Apr 2018 08:07:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJHkwfCM=5+XCtOF+P9HRuhROB2FLKa3Qq1NhYd7_J7_Q@mail.gmail.com>
Message-ID: <CAL_JsqJHkwfCM=5+XCtOF+P9HRuhROB2FLKa3Qq1NhYd7_J7_Q@mail.gmail.com>
Subject: Re: [PATCH] of: Don't create platform device for OPP tables
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Frank Rowand <frowand.list@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 4:05 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The OPP tables are present as separate nodes, whose phandle is used in
> the "operating-points-v2" property of devices. Currently the OF core
> creates a platform device for the OPP table unconditionally, which is
> not used by any kernel code.
>
> Skip creating OPP table platform devices.
>
> Reported-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/of/platform.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index c00d81dfac0b..aaae5d90433d 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -356,6 +356,12 @@ static int of_platform_bus_create(struct device_node *bus,
>                 return 0;
>         }
>
> +       /* OPP tables have separate nodes, but we don't want devices for them */
> +       if (unlikely(of_device_is_compatible(bus, "operating-points-v2"))) {

Can you make this a match table instead. I could imagine we may have
some other cases to add.

> +               pr_debug("%s() - skipping OPP node %pOF\n", __func__, bus);
> +               return 0;
> +       }
> +
>         if (of_node_check_flag(bus, OF_POPULATED_BUS)) {
>                 pr_debug("%s() - skipping %pOF, already populated\n",
>                         __func__, bus);
> --
> 2.15.0.194.g9af6a3dea062
>
