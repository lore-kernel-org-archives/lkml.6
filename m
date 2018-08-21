Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E6BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19B921473
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E5RVPopC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19B921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeHUP3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 11:29:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38125 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbeHUP3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 11:29:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so2618744wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 05:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QQx1Lrk72OzEwnF8r0pcJxTAl3sqHG9R54J6B9zmWZg=;
        b=E5RVPopC6+R/iHfYfBJa0gbEM20maZTXg7rMPKb6GYW21Q2cBU8JLKsvFtGsaJ9g10
         zr2mJVJyGS8vUxUnKLMF3gwbvkQOOWzUgnMDdX5bBehY/vXrrCgorpCNi72/UvXF3EEy
         tXKjHAstcD+tZhQUnd+EMvYblCZi5OPAwGMS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QQx1Lrk72OzEwnF8r0pcJxTAl3sqHG9R54J6B9zmWZg=;
        b=XaBTP3lzA9xCq2x15qQKesqIkWWXRwlvBr6Ev+IUzpDcbq5nPKw/mL5frtN7uIHCbZ
         70KYDyETeh5LnMu3qie9XXdzToMfW0oC4qYyFI+39Lqog54WTJ4hCmfumchm8YmrTq2s
         SQZOwi0Kua8xGQRlNoKpRb597IdyMzIMEISOcJ4eJ6ThjS52gFqGUkXuIVe6BBkKyeSI
         h3WDGw8C9TpIPtY/5sTkDz5rGwJAyArqdHjJ5QTPxUouG/M+XjwGjGV6S0n93esJgHWR
         K+lrI8oea782/yFnZyJDnQoDtIE8RW2aycW0uQdUQbJvEPf7Q1UnCj99N/mNe37ucQf7
         /dgg==
X-Gm-Message-State: APzg51AGimLLTSrRIV87RQJvq9cHpk2r7OiIwVg6YMrjO6HDSxHGg1Ae
        56CCxUEHgoiFftNYM3tYD2EPMw==
X-Google-Smtp-Source: ANB0VdaqmnH5sRX6jjuXupZRodHHEwH8e/6vuaxAPXhybWG8/AFYrfERh3Q0uzLffd/2Ra0tKBIBfA==
X-Received: by 2002:a1c:cc1a:: with SMTP id h26-v6mr2085558wmb.112.1534853363065;
        Tue, 21 Aug 2018 05:09:23 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id a6-v6sm2357562wmf.22.2018.08.21.05.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 05:09:22 -0700 (PDT)
Subject: Re: [PATCH v4 1/4] venus: firmware: add routine to reset ARM9
To:     Vikash Garodia <vgarodia@codeaurora.org>, hverkuil@xs4all.nl,
        mchehab@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, acourbot@chromium.org
References: <1533562085-8773-1-git-send-email-vgarodia@codeaurora.org>
 <1533562085-8773-2-git-send-email-vgarodia@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <16018b76-ac65-828c-9fe3-e87b41f9bbe1@linaro.org>
Date:   Tue, 21 Aug 2018 15:09:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533562085-8773-2-git-send-email-vgarodia@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

On 08/06/2018 04:28 PM, Vikash Garodia wrote:
> Add routine to reset the ARM9 and brings it out of reset. Also
> abstract the Venus CPU state handling with a new function. This
> is in preparation to add PIL functionality in venus driver.
> 
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/core.h         |  1 +
>  drivers/media/platform/qcom/venus/firmware.c     | 31 ++++++++++++++++++++++++
>  drivers/media/platform/qcom/venus/firmware.h     | 11 +++++++++
>  drivers/media/platform/qcom/venus/hfi_venus.c    | 13 +++-------
>  drivers/media/platform/qcom/venus/hfi_venus_io.h |  5 ++++
>  5 files changed, 52 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 2f02365..eb5ee66 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -129,6 +129,7 @@ struct venus_core {
>  	struct device *dev;
>  	struct device *dev_dec;
>  	struct device *dev_enc;
> +	bool no_tz;
>  	struct mutex lock;
>  	struct list_head instances;
>  	atomic_t insts_count;
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index c4a5778..3aa6b37 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -22,10 +22,41 @@
>  #include <linux/sizes.h>
>  #include <linux/soc/qcom/mdt_loader.h>
>  
> +#include "core.h"
>  #include "firmware.h"
> +#include "hfi_venus_io.h"
>  
>  #define VENUS_PAS_ID			9
>  #define VENUS_FW_MEM_SIZE		(6 * SZ_1M)
> +#define VENUS_FW_START_ADDR		0x0
> +
> +static void venus_reset_cpu(struct venus_core *core)
> +{
> +	void __iomem *base = core->base;
> +
> +	writel(0, base + WRAPPER_FW_START_ADDR);
> +	writel(VENUS_FW_MEM_SIZE, base + WRAPPER_FW_END_ADDR);
> +	writel(0, base + WRAPPER_CPA_START_ADDR);
> +	writel(VENUS_FW_MEM_SIZE, base + WRAPPER_CPA_END_ADDR);
> +	writel(0x0, base + WRAPPER_CPU_CGC_DIS);
> +	writel(0x0, base + WRAPPER_CPU_CLOCK_CONFIG);
> +
> +	/* Bring ARM9 out of reset */
> +	writel(0, base + WRAPPER_A9SS_SW_RESET);
> +}
> +
> +int venus_set_hw_state(struct venus_core *core, bool resume)
> +{
> +	if (!core->no_tz)
> +		return qcom_scm_set_remote_state(resume, 0);
> +
> +	if (resume)
> +		venus_reset_cpu(core);
> +	else
> +		writel(1, core->base + WRAPPER_A9SS_SW_RESET);
> +
> +	return 0;
> +}
>  
>  int venus_boot(struct device *dev, const char *fwname)
>  {
> diff --git a/drivers/media/platform/qcom/venus/firmware.h b/drivers/media/platform/qcom/venus/firmware.h
> index 428efb5..efa449a 100644
> --- a/drivers/media/platform/qcom/venus/firmware.h
> +++ b/drivers/media/platform/qcom/venus/firmware.h
> @@ -18,5 +18,16 @@
>  
>  int venus_boot(struct device *dev, const char *fwname);
>  int venus_shutdown(struct device *dev);
> +int venus_set_hw_state(struct venus_core *core, bool suspend);
> +
> +static inline int venus_set_hw_state_suspend(struct venus_core *core)
> +{
> +	return venus_set_hw_state(core, 0);

venus_set_hw_state(core, false);

> +}
> +
> +static inline int venus_set_hw_state_resume(struct venus_core *core)
> +{
> +	return venus_set_hw_state(core, 1);

venus_set_hw_state(core, true);

<snip>

-- 
regards,
Stan
