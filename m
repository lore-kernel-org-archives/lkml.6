Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32519C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2032081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PKOq2TG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED2032081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbeKHQRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:17:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46115 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKHQRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:17:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id c13-v6so9060406plz.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 22:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ImWfqAgLxY3HQ/tm7TK4IQzGtz5NhygKjUEhDAWLQz0=;
        b=PKOq2TG99CkefDfL7G1e3sJ0lcAlGPzcoNMFgHTG35fzhR49IRonBFSrj+bhBzQrQc
         5FEnhBgNIbgDAUSYSx/LFfZKxRrwTs36KuI4Hs1dfKXU3Y1rFl10qNtEQD/53U2WVueZ
         93gSJQ4t8LLFOkPD6hjvIhRljUYcBqRe22mjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ImWfqAgLxY3HQ/tm7TK4IQzGtz5NhygKjUEhDAWLQz0=;
        b=RhIb8zHnrSAksVAPbHak4JpPpgomj6/zY3tMuU3ScAiv8C04HsOx9OsjQDhMydGs53
         Q6TuLnz7LmYJAQk6T1eKLMJnDT1q7BNDzt2CPjVHdjrqWAUvXxSpNu740COKxUZYvU69
         w7Z1FU2f1v+/d6Fze+4garCR/x7Yhd1B6Xx3+6FIuBy+FRsABw2pGUh6yY6kGUXE5Kol
         f25TMz/JfgiL+QjvWkN9CujS0fmDSUfPUKAYGVr8GB1pHvyKQskmEkqWGrNHTZguqBP6
         3vm4AjzBPi0x5Vu9/Kd/nc6vmZsH8B734lYSH1we92YVlnzHIIB7LrggYbEXHdTyHAz7
         /KFg==
X-Gm-Message-State: AGRZ1gJXfbS4yg/DvcqtrE6NYndG1Wq0EHDwWt8b3QkXd+X3DoVC5bKp
        7IE+oh3DZqlKShxB47g+Vu83/Q==
X-Google-Smtp-Source: AJdET5fUZ59AxKvNhcaJTxBN3y0BgAjGiPL2oi7uLTzZIwz+DSAUlNJ07HUx+Hm+IY0HsIOgpAVyHQ==
X-Received: by 2002:a17:902:22cc:: with SMTP id o12-v6mr3420993plg.108.1541659431146;
        Wed, 07 Nov 2018 22:43:51 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x14-v6sm2909421pfe.178.2018.11.07.22.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 22:43:50 -0800 (PST)
Date:   Wed, 7 Nov 2018 22:47:35 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     ohad@wizery.com, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 2/5] hwspinlock: add STM32 hwspinlock device
Message-ID: <20181108064735.GB12063@builder>
References: <20181031093032.20386-1-benjamin.gaignard@st.com>
 <20181031093032.20386-3-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031093032.20386-3-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31 Oct 02:30 PDT 2018, Benjamin Gaignard wrote:
> diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
> index e895d29500ee..e1a20b460590 100644
> --- a/drivers/hwspinlock/Kconfig
> +++ b/drivers/hwspinlock/Kconfig
> @@ -59,3 +59,12 @@ config HSEM_U8500
>  	  SoC.
>  
>  	  If unsure, say N.
> +
> +config HWSPINLOCK_STM32

Please keep these alphabetically sorted.

> +	tristate "STM32 Hardware Spinlock device"
> +	depends on MACH_STM32MP157
> +	depends on HWSPINLOCK
> +	help
> +	  Say y here to support the STM32 Hardware Spinlock device.
> +
> +	  If unsure, say N.
> diff --git a/drivers/hwspinlock/Makefile b/drivers/hwspinlock/Makefile
> index b87c01a506a4..c0a9505b4dcf 100644
> --- a/drivers/hwspinlock/Makefile
> +++ b/drivers/hwspinlock/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_HWSPINLOCK_QCOM)		+= qcom_hwspinlock.o
>  obj-$(CONFIG_HWSPINLOCK_SIRF)		+= sirf_hwspinlock.o
>  obj-$(CONFIG_HWSPINLOCK_SPRD)		+= sprd_hwspinlock.o
>  obj-$(CONFIG_HSEM_U8500)		+= u8500_hsem.o
> +obj-$(CONFIG_HWSPINLOCK_STM32)		+= stm32_hwspinlock.o

Ditto.

> diff --git a/drivers/hwspinlock/stm32_hwspinlock.c b/drivers/hwspinlock/stm32_hwspinlock.c
> new file mode 100644
> index 000000000000..6a0fafac7389
> --- /dev/null
> +++ b/drivers/hwspinlock/stm32_hwspinlock.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) STMicroelectronics SA 2018
> + * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
> + * License terms:  GNU General Public License (GPL), version 2

Didn't you already state your license terms with the SPDX header above?

> + */
[..]
> +static int stm32_hwspinlock_remove(struct platform_device *pdev)
> +{
> +	struct stm32_hwspinlock *hw = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret = hwspin_lock_unregister(&hw->bank);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s failed: %d\n", __func__, ret);
> +		return ret;

The return value of platform_device is ignored, so printing an error
message is fine, but don't "abort".

> +	}
> +
> +	pm_runtime_disable(&pdev->dev);
> +
> +	return 0;
> +}

Regards,
Bjorn
