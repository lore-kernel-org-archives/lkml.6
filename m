Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4BCC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F6C20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ijB5IzZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F6C20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbeGYM0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 08:26:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44791 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbeGYM0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 08:26:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so6988336wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 04:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ogZwxMNJoOlUsO2e0DELcRB3aG8kC7LBxHuzJDg0wT4=;
        b=ijB5IzZhcxFAkYruC310QWF/ioQcWrRYH5iyzNB1K0tB57OfX9k9yrVkERAz7uAfn9
         QaXThbPbs+3e+rDdwhBeh/GWIUqdlcX63Y90cZ2EG/zKeWAHqgMXkJWG/ouoMM4tjUt/
         /2HqBrHEtMGAfu2HO4lIOxot5BTXflQVe4xV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ogZwxMNJoOlUsO2e0DELcRB3aG8kC7LBxHuzJDg0wT4=;
        b=fs/kKArSqTxCI0bSfWfPySSYqvKUrTFcwXaxmFuG91npgUSz0Xir8QXWT1AM11ey09
         D0iSYN6Na72+QoUC8SVIyhaMnmWOxvXXrxafXTkZvY5c+yy7JjLIN0md2Kv7wAN1qr2a
         dahWQOmMPGAaUzwGuruoU+VuCId7wWUhaMXDG6jKgSHnaNnOfs1syuWdzoBycwncfLsf
         KIdfy3Ay4vH5vggJNfKx8Te615b+/y40oCy6FVhqGZYuqZn0xLAlUizBaTJgPVM1ESSO
         Xy6RZbKUTYkGT6UXJzUryC1V0oWvQks/1PNK+jpAp91+y0sRe6y0A9SH3HZB2WsWSHQy
         fPbA==
X-Gm-Message-State: AOUpUlHVx/Z/7oVo+t3EjZ6gQ9LPnOwbB8KnVYVFGENGIctf1jV+xs8Z
        /2XoD2kW3LY0Mnx3PdmWtIhHpg==
X-Google-Smtp-Source: AAOMgpflfCO4o3yoZyn18ugajuqgJ6zTVm1hXmNCDSm5fQAvjLDrDz0ooWI2xPP/uxe8klG8dqheWw==
X-Received: by 2002:a5d:6401:: with SMTP id z1-v6mr14103346wru.64.1532517293079;
        Wed, 25 Jul 2018 04:14:53 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id n8-v6sm11375181wrt.56.2018.07.25.04.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 04:14:51 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] venus: firmware: add routine to reset ARM9
To:     Vikash Garodia <vgarodia@codeaurora.org>,
        stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, acourbot@chromium.org
References: <1530731212-30474-1-git-send-email-vgarodia@codeaurora.org>
 <1530731212-30474-2-git-send-email-vgarodia@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <a9e7aee2-7320-affa-4887-c090b3ce289d@linaro.org>
Date:   Wed, 25 Jul 2018 14:14:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1530731212-30474-2-git-send-email-vgarodia@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/04/2018 10:06 PM, Vikash Garodia wrote:
> Add routine to reset the ARM9 and brings it out of reset. Also
> abstract the Venus CPU state handling with a new function. This
> is in preparation to add PIL functionality in venus driver.
> 
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/core.h         |  1 +
>  drivers/media/platform/qcom/venus/firmware.c     | 36 ++++++++++++++++++++++++
>  drivers/media/platform/qcom/venus/firmware.h     |  1 +
>  drivers/media/platform/qcom/venus/hfi_venus.c    | 13 +++------
>  drivers/media/platform/qcom/venus/hfi_venus_io.h |  5 ++++
>  5 files changed, 47 insertions(+), 9 deletions(-)
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
> index 521d4b3..3968553d 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -22,11 +22,47 @@
>  #include <linux/sizes.h>
>  #include <linux/soc/qcom/mdt_loader.h>
>  
> +#include "core.h"
>  #include "firmware.h"
> +#include "hfi_venus_io.h"
>  
>  #define VENUS_PAS_ID			9
>  #define VENUS_FW_MEM_SIZE		(6 * SZ_1M)
>  
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
> +	/* Make sure all register writes are committed. */
> +	mb();
> +
> +	/* Bring ARM9 out of reset */
> +	writel_relaxed(0, base + WRAPPER_A9SS_SW_RESET);
> +}
> +
> +int venus_set_hw_state(struct venus_core *core, bool resume)
> +{
> +	void __iomem *base = core->base;
> +
> +	if (!core->no_tz)
> +		return qcom_scm_set_remote_state(resume, 0);
> +
> +	if (resume)
> +		venus_reset_cpu(core);
> +	else
> +		writel(1, base + WRAPPER_A9SS_SW_RESET);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(venus_set_hw_state);

This export_symbol shouldn't be needed

-- 
regards,
Stan
