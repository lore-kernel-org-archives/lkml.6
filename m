Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE86C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6CD20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y80spTcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6CD20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbeGYKqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:46:51 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37883 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbeGYKqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:46:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so5286000wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 02:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=806iHYh3bmw03kK6hn1fb7nl1ZtzrIEssj6Cc2wmOJM=;
        b=Y80spTcuX2S3BV5bGDT5wHn/5PjnJDsawIODnCadAlkVBm2GxUUHgorIflxKPQdEOT
         rq8Tf0D5IGZ/O2rtvt7csAJDVMNPjCqgtWkXd/QtAq19LCpSJe1kZ2+zbrAD/yGNBLNU
         EeYNVOEFjLIrfz7xdaVQzlcWk/aHA8vX42Bp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=806iHYh3bmw03kK6hn1fb7nl1ZtzrIEssj6Cc2wmOJM=;
        b=kP96furI41X70gScyoQgbxaNuuVzYtMYZHB/WBproIwcDNq2QJyBZ/4zAnnYFaZ+FQ
         vT18WtbZDWipPbmhO6x+fU5HqdbXQdVqRiL0WMBICxrLAxrSdDdHWyazXs0yceCy5l5c
         JPuSxX8pLZtBD8+ULTGF2CIjqIG6COjeilN+EdDxelnXAsstKDDuiROIVyj76yg576lH
         os0upu0epA9h2AHBNRXNqi5kw/mjCPnrTWYhQXPrcRXefANOmZ8fg9k/HIaQoFgyP+wu
         JXXP3dC8/toY2JG+K3x68m012dYqc+ERtmR3a4QfLiTIPtvqCsArvegQxYufJvhYnIZY
         eA6Q==
X-Gm-Message-State: AOUpUlH/BI43xoEgEaCvx+RoMssRB/lshY7RcqKmA8aAoWERPf9Asn4b
        7NdyRmbbHpn0foMaYuSQ7uDzRA==
X-Google-Smtp-Source: AAOMgpeN5lcA0I9KejKfSTT0vtxx6K50ptOO0fncI1kK1e6nY422sPrMp3p8aEUHfd9NKWGQh33KlA==
X-Received: by 2002:a1c:3a8f:: with SMTP id h137-v6mr4270411wma.72.1532511358587;
        Wed, 25 Jul 2018 02:35:58 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id i205-v6sm6502457wmf.30.2018.07.25.02.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 02:35:58 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] venus: firmware: move load firmware in a separate
 function
To:     Vikash Garodia <vgarodia@codeaurora.org>, hverkuil@xs4all.nl,
        mchehab@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, acourbot@chromium.org
References: <1530731212-30474-1-git-send-email-vgarodia@codeaurora.org>
 <1530731212-30474-3-git-send-email-vgarodia@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <b5ecaa26-2f3b-9a2e-d496-7f9b35e3f761@linaro.org>
Date:   Wed, 25 Jul 2018 12:35:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1530731212-30474-3-git-send-email-vgarodia@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

On 07/04/2018 10:06 PM, Vikash Garodia wrote:
> Separate firmware loading part into a new function.

I cannot apply this patch in order to test the series.

> 
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/core.c     |  4 +-
>  drivers/media/platform/qcom/venus/firmware.c | 58 +++++++++++++++++-----------
>  drivers/media/platform/qcom/venus/firmware.h |  2 +-
>  3 files changed, 39 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index bb6add9..75b9785 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -84,7 +84,7 @@ static void venus_sys_error_handler(struct work_struct *work)
>  
>  	pm_runtime_get_sync(core->dev);
>  
> -	ret |= venus_boot(core->dev, core->res->fwname);
> +	ret |= venus_boot(core);
>  
>  	ret |= hfi_core_resume(core, true);
>  
> @@ -284,7 +284,7 @@ static int venus_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto err_runtime_disable;
>  
> -	ret = venus_boot(dev, core->res->fwname);
> +	ret = venus_boot(core);
>  	if (ret)
>  		goto err_runtime_disable;
>  
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 3968553d..6d6cca4 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -63,40 +63,37 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
>  }
>  EXPORT_SYMBOL_GPL(venus_set_hw_state);
>  
> -int venus_boot(struct device *dev, const char *fwname)
> +static int venus_load_fw(struct venus_core *core, const char *fwname,
> +		phys_addr_t *mem_phys, size_t *mem_size)

the next function argument on new line should be just below open brace

>  {
>  	const struct firmware *mdt;
>  	struct device_node *node;
> -	phys_addr_t mem_phys;
> +	struct device *dev;
>  	struct resource r;
>  	ssize_t fw_size;
> -	size_t mem_size;
>  	void *mem_va;
>  	int ret;
>  
> -	if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) || !qcom_scm_is_available())
> -		return -EPROBE_DEFER;
> -
> +	dev = core->dev;
>  	node = of_parse_phandle(dev->of_node, "memory-region", 0);
>  	if (!node) {
>  		dev_err(dev, "no memory-region specified\n");
>  		return -EINVAL;
>  	}
> -

please don't delete above blank line

>  	ret = of_address_to_resource(node, 0, &r);
>  	if (ret)
>  		return ret;
>  
> -	mem_phys = r.start;
> -	mem_size = resource_size(&r);
> +	*mem_phys = r.start;
> +	*mem_size = resource_size(&r);
>  
> -	if (mem_size < VENUS_FW_MEM_SIZE)
> +	if (*mem_size < VENUS_FW_MEM_SIZE)
>  		return -EINVAL;
>  
> -	mem_va = memremap(r.start, mem_size, MEMREMAP_WC);
> +	mem_va = memremap(r.start, *mem_size, MEMREMAP_WC);
>  	if (!mem_va) {
>  		dev_err(dev, "unable to map memory region: %pa+%zx\n",
> -			&r.start, mem_size);
> +			&r.start, *mem_size);
>  		return -ENOMEM;
>  	}
>  
> @@ -110,24 +107,41 @@ int venus_boot(struct device *dev, const char *fwname)
>  		release_firmware(mdt);
>  		goto err_unmap;
>  	}
> -
> -	ret = qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID, mem_va, mem_phys,
> -			    mem_size);
> +	if (core->no_tz)
> +		ret = qcom_mdt_load_no_init(dev, mdt, fwname, VENUS_PAS_ID,
> +				mem_va, *mem_phys, *mem_size, NULL);

indentation is wrong see the original code

> +	else
> +		ret = qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID, mem_va,
> +				*mem_phys, *mem_size);

indentation again

>  
>  	release_firmware(mdt);
>  
> -	if (ret)
> -		goto err_unmap;
> -
> -	ret = qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
> -	if (ret)
> -		goto err_unmap;
> -
>  err_unmap:
>  	memunmap(mem_va);
>  	return ret;
>  }
>  
> +int venus_boot(struct venus_core *core)
> +{
> +	phys_addr_t mem_phys;
> +	size_t mem_size;
> +	int ret;
> +	struct device *dev;

please order declarations from longer to shorter.

> +
> +	if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER))
> +		return -EPROBE_DEFER;

the original venus_boot was checking for || !qcom_scm_is_available() why
is that removed? It was done on purpose.

> +
> +	dev = core->dev;

this could be done when dev is declared.

> +
> +	ret = venus_load_fw(core, core->res->fwname, &mem_phys, &mem_size);
> +	if (ret) {
> +		dev_err(dev, "fail to load video firmware\n");
> +		return -EINVAL;
> +	}
> +
> +	return qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
> +}
> +
>  int venus_shutdown(struct device *dev)
>  {
>  	return qcom_scm_pas_shutdown(VENUS_PAS_ID);
> diff --git a/drivers/media/platform/qcom/venus/firmware.h b/drivers/media/platform/qcom/venus/firmware.h
> index ff2e70e..36a5fc2 100644
> --- a/drivers/media/platform/qcom/venus/firmware.h
> +++ b/drivers/media/platform/qcom/venus/firmware.h
> @@ -16,7 +16,7 @@
>  
>  struct device;
>  
> -int venus_boot(struct device *dev, const char *fwname);
> +int venus_boot(struct venus_core *core);
>  int venus_shutdown(struct device *dev);
>  int venus_set_hw_state(struct venus_core *core, bool suspend);
>  
> 

-- 
regards,
Stan
