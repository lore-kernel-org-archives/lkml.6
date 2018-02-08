Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752310AbeBHUsP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:48:15 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33312 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeBHUsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:48:13 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E722160112
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Thu, 8 Feb 2018 13:48:08 -0700
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        sboyd@codeaurora.org, rnayak@codeaurora.org, msivasub@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drivers: qcom: add command DB driver
Message-ID: <20180208204808.GA9676@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Lina Iyer <ilina@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, sboyd@codeaurora.org,
        rnayak@codeaurora.org, msivasub@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org
References: <20180208195154.3580-1-ilina@codeaurora.org>
 <20180208195154.3580-2-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208195154.3580-2-ilina@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 12:51:53PM -0700, Lina Iyer wrote:
> From: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> 
> Command DB is a simple database in the shared memory of QCOM SoCs, that
> provides information regarding shared resources. Some shared resources
> in the SoC have properties that are probed dynamically at boot by the
> remote processor. The information pertaining to the SoC and the platform
> are made available in the shared memory. Drivers can query this
> information using predefined strings.
> 
> Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---

*snip*

> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> new file mode 100644
> index 000000000000..050a56da76c8
> --- /dev/null
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -0,0 +1,321 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2016-2018, The Linux Foundation. All rights reserved. */
> +
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +
> +#include <soc/qcom/cmd-db.h>
> +
> +#define NUM_PRIORITY		2
> +#define MAX_SLV_ID		8
> +#define CMD_DB_MAGIC		0x0C0330DBUL
> +#define SLAVE_ID_MASK		0x7
> +#define SLAVE_ID_SHIFT		16
> +
> +#define ENTRY_HEADER(hdr)	((void *)cmd_db_header +	\
> +				sizeof(*cmd_db_header) +	\
> +				hdr->header_offset)
> +
> +#define RSC_OFFSET(hdr, ent)	((void *)cmd_db_header +	\
> +				sizeof(*cmd_db_header) +	\
> +				hdr.data_offset + ent.offset)
> +
> +#define MIN(a, b)		(((a) < (b)) ? (a) : (b))

I'm not sure if this was addressed before. Why use a custom macro and not min()
or min_t()?

Jordan
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
