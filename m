Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754041AbeDAWeg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 18:34:36 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46030 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753977AbeDAWed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 18:34:33 -0400
X-Google-Smtp-Source: AIpwx4/th1LOqNwHtTGmO07AcuWwzt+40p2pnLOPW+F4VZudJOZS8meTrww3kxvXlpBdZQn+wnE9PQ==
Date: Sun, 1 Apr 2018 15:34:56 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Ilia Lin <ilialin@codeaurora.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, andy.gross@linaro.org,
        david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rnayak@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: Re: [PATCH v4 01/14] soc: qcom: Separate kryo l2 accessors from PMU
 driver
Message-ID: <20180401223456.GG510@tuxbook-pro>
References: <1522358807-10413-1-git-send-email-ilialin@codeaurora.org>
 <1522358807-10413-2-git-send-email-ilialin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522358807-10413-2-git-send-email-ilialin@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 29 Mar 14:26 PDT 2018, Ilia Lin wrote:

> diff --git a/drivers/soc/qcom/kryo-l2-accessors.c b/drivers/soc/qcom/kryo-l2-accessors.c
> new file mode 100644
> index 0000000..b0356c2
> --- /dev/null
> +++ b/drivers/soc/qcom/kryo-l2-accessors.c
> @@ -0,0 +1,66 @@
> +/*
> + * Copyright (c) 2014-2015, 2018, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * SPDX-License-Identifier: GPL-2.0
> + */

The copyright header in the C file should be:

// SPDX-License-Identifier: GPL-2.0
/*
 * Copyright (c) 2014-2015, 2018, The Linux Foundation. All rights reserved.
 */

> +
> +#include <linux/spinlock.h>
> +#include <asm/sysreg.h>
> +#include <soc/qcom/kryo-l2-accessors.h>
> +
> +#define L2CPUSRSELR_EL1         sys_reg(3, 3, 15, 0, 6)
> +#define L2CPUSRDR_EL1           sys_reg(3, 3, 15, 0, 7)
> +
> +static DEFINE_RAW_SPINLOCK(l2_access_lock);
> +
> +/**
> + * set_l2_indirect_reg: write value to an L2 register

* set_l2_indirect_reg() - write value to an L2 register

> + * @reg: Address of L2 register.
> + * @value: Value to be written to register.
> + *
> + * Use architecturally required barriers for ordering between system register
> + * accesses, and system registers with respect to device memory
> + */
> +void set_l2_indirect_reg(u64 reg, u64 val)

As these are now kernel-global functions I recommend that you give them
a slightly more specific name; e.g. kryo_l2_set_indirect_reg() and
kryo_l2_get_indirect_reg().

[..]
> diff --git a/include/soc/qcom/kryo-l2-accessors.h b/include/soc/qcom/kryo-l2-accessors.h
> new file mode 100644
> index 0000000..3c796cf
> --- /dev/null
> +++ b/include/soc/qcom/kryo-l2-accessors.h
> @@ -0,0 +1,20 @@
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

And in the header file it should be:

/* SPDX-License-Identifier: GPL-2.0 */
/*
 * Copyright (c) 2014-2015, 2018, The Linux Foundation. All rights reserved.
 */

> +
> +#ifndef __SOC_ARCH_QCOM_KRYO_L2_ACCESSORS_H
> +#define __SOC_ARCH_QCOM_KRYO_L2_ACCESSORS_H
> +
> +void set_l2_indirect_reg(u64 reg_addr, u64 val);
> +u64 get_l2_indirect_reg(u64 reg_addr);

Rename "reg_addr" to "reg" to match the implementation.

Regards,
Bjorn
