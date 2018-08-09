Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F13C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0465121EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GkQJ33Hh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0465121EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeHIVqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 17:46:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45000 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbeHIVqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 17:46:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so3284757pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 12:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cb2YeYILFwuH85VGiPyGh+Gde3K8DDl5wAijcqjnC5s=;
        b=GkQJ33HhadRrOKTWTm7MKFdzbDhkVa3Ch08b98YWJ8F4DZejI+3ZfyKj4by17ZJjjI
         6VCp6GBJiSYRqkGviPYZrIOJjzFMpIuhZwkk2IHoRikUPD3mbktE26JeNFl2vGhZgumn
         XySXXGpFlVF56n7nI/5JNJ+vFta9S4yNV3ZXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cb2YeYILFwuH85VGiPyGh+Gde3K8DDl5wAijcqjnC5s=;
        b=ZZ3t1fxWvwBZyuU4zj4U884yBJ3hRWZ2Z8LJkeTJj5x+9tWhplfMtEoA5LhiT6WG7B
         4pw+zva5PiJ7g9NydHL8uirMrhZ/BWDtubwxOgWMKlxscLVb3vxiri0VlUF95tIJl7Vt
         VN4URNvl/2WcGkEj0J547NodKlI8hKATQE1V2iyDJh0dlqp2E8qlHVr0IRRinWyXgvKQ
         Xyn6yBB1XPYf5hJjT70FBhi9cmYl+sIgFanw3yEepvJCdIY3xUhPr6HJBoMZlpkP2C/0
         m3wUzevEOSjN/z6FlM4zQz1jwxphpt41l/tJ/zb7LZfawkj+ZmluI0KKjmeTURUYGyWR
         nbUg==
X-Gm-Message-State: AOUpUlFxuTwITHCTBAeQw1g8+ibUZ9XR1Oodyqgn/7+2R9Z27rCa0VCk
        Vt/VowCzcoXqoekhwoLFXsSkOQ==
X-Google-Smtp-Source: AA+uWPx2COqqByjjfsjFZIBfD30qJBltsll2kGdkTLH91XdKgNaj4STlbf6Hlkq4GpQslOLLHzSInw==
X-Received: by 2002:a65:658d:: with SMTP id u13-v6mr3409876pgv.20.1533842393982;
        Thu, 09 Aug 2018 12:19:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id l27-v6sm17342117pfi.180.2018.08.09.12.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 12:19:53 -0700 (PDT)
Date:   Thu, 9 Aug 2018 12:19:52 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 03/10] thermal: tsens: Add SPDX license identifiers
Message-ID: <20180809191952.GK160295@google.com>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <e9f81dd5358244d44b0d74e3fb11189b514dd976.1533815718.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e9f81dd5358244d44b0d74e3fb11189b514dd976.1533815718.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 06:02:35PM +0530, Amit Kucheria wrote:
> The TSENS drivers use a GPL-2.0 license. Replace with equivalent SPDX
> tags and delete the full license text.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
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

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
