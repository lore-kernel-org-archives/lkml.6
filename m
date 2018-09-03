Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FFEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D0E20869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NWGdPIzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D0E20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbeIDAWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:22:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40160 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbeIDAWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:22:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id s17-v6so560450plp.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ok+yVNaCms/X/ip/EN92qU/7hhxmaX4GAkt6zQR8ogE=;
        b=NWGdPIzRTYuFLOTp0tegKMQlPzRTr1ksXke/LH219+sLqgpjU25ovuPNTkrrFo1MmP
         gSns16CcpPJnjWy6npKeeRLyaxJRTagXKJXePdp6bz0Or1/GFF9pwdK3Bv+I/05xnf+e
         6tUHXH5+5DoK+MuFsx2yZn/3Al78dqtJtlhDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ok+yVNaCms/X/ip/EN92qU/7hhxmaX4GAkt6zQR8ogE=;
        b=XDgL8JoDhHqbTzWS+ydAQwAibfcUhS+BskDaONx4r69YB58Mw4Lne/z6Klab50WoKy
         qA4hTzfq8tJ6qtIbgujpuDcrYg+DHLbiqPmcRKIy+GQpU035JUtZQJCDMNjan/tXgJdj
         M0UrwOFuFWns9UpGd4K1ITKZK+0z1e9E5Ic0x4e1G2hN7b2IrmhMTbVUaH3503vj5Bvb
         E1dAtbxC5dghx79OOLq1d8NrUVK2+hDOLMQHXGvoteSv24rDXtEdUwWOfz7aSH1g6940
         xsLaMGsjaLIGHY+UZb8BZPHUCvZOCcWJCjTgxKOKWDKebosxrU5NhSr83urJc+enEJKm
         o5Og==
X-Gm-Message-State: APzg51BcgyprE9sA8X+3Zqvsu2szrr9fnr7xYUYET5itSjJIMu6+CUip
        YXZf21T12Pbh3SL5VyC94k7Gxg==
X-Google-Smtp-Source: ANB0VdaIQujRm0SHKV1JBGApJw9BaS6IQXXrmSYbd/raxM5Qku9XZ9v5BnmOsR2wFpUIJUXMLYjwKw==
X-Received: by 2002:a17:902:6909:: with SMTP id j9-v6mr29807185plk.196.1536004839961;
        Mon, 03 Sep 2018 13:00:39 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 16-v6sm31491237pfo.164.2018.09.03.13.00.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 13:00:39 -0700 (PDT)
Date:   Mon, 3 Sep 2018 13:04:33 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 04/11] thermal: tsens: Add SPDX license identifiers
Message-ID: <20180903200433.GO3456@tuxbook-pro>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
 <ed1481a7c4b2c557a7825bf1f92506323ddaa328.1535462942.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed1481a7c4b2c557a7825bf1f92506323ddaa328.1535462942.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 Aug 06:38 PDT 2018, Amit Kucheria wrote:

> The TSENS drivers use a GPL-2.0 license. Replace with equivalent SPDX
> tags and delete the full license text.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/thermal/qcom/tsens-8916.c   | 11 +----------
>  drivers/thermal/qcom/tsens-8960.c   | 11 +----------
>  drivers/thermal/qcom/tsens-8974.c   | 11 +----------
>  drivers/thermal/qcom/tsens-common.c | 11 +----------
>  drivers/thermal/qcom/tsens.c        | 11 +----------
>  drivers/thermal/qcom/tsens.h        | 11 ++---------
>  6 files changed, 7 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-8916.c b/drivers/thermal/qcom/tsens-8916.c
> index fdf561b8b81d..c4955c85e922 100644
> --- a/drivers/thermal/qcom/tsens-8916.c
> +++ b/drivers/thermal/qcom/tsens-8916.c
> @@ -1,15 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 and
> - * only version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
>   */
>  
>  #include <linux/platform_device.h>
> diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
> index 0451277d3a8f..4af76de7dc2e 100644
> --- a/drivers/thermal/qcom/tsens-8960.c
> +++ b/drivers/thermal/qcom/tsens-8960.c
> @@ -1,15 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 and
> - * only version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
>   */
>  
>  #include <linux/platform_device.h>
> diff --git a/drivers/thermal/qcom/tsens-8974.c b/drivers/thermal/qcom/tsens-8974.c
> index 9baf77e8cbe3..7e149edbfeb6 100644
> --- a/drivers/thermal/qcom/tsens-8974.c
> +++ b/drivers/thermal/qcom/tsens-8974.c
> @@ -1,15 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 and
> - * only version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
>   */
>  
>  #include <linux/platform_device.h>
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 478739543bbc..303e3fdaca98 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -1,15 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 and
> - * only version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
>   */
>  
>  #include <linux/err.h>
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index a2c9bfae3d86..90bb431cf740 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -1,15 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 and
> - * only version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
>   */
>  
>  #include <linux/err.h>
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 14331eb45a86..8207610f326a 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -1,15 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
> +
>  #ifndef __QCOM_TSENS_H__
>  #define __QCOM_TSENS_H__
>  
> -- 
> 2.17.1
> 
