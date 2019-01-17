Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9DFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE4520855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIZMFkVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbfAQSQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:16:07 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46948 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfAQSQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 13:16:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so5084167ply.13;
        Thu, 17 Jan 2019 10:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C2Z4QWy5wNJw+5XfdnScGboqm8ucQNIbMLIloYyNmGs=;
        b=TIZMFkVVr50pLywqY+9ZmLTAPt1srFAEqLNU42/hQaulTSrqjj0pfJdkcXYADAlW4U
         VF1StksTRnrLRVvo27iasEhRcp+QRIoMn8KtgvYVTPCyI4xv+1R8h4C6Q6KDHOGofdou
         A/sNqGgs/oheekTNdaCg34W9CoAqOzGivZsZLbDflH8BI/8TYKXNvr4YVULYUOoANJBC
         F5lgTrJVlpQ4/mVAUhv8RYuf/e558bNZr3xDaH7zbGQZXm3vQfuzn8JOUbHJ1GfdCaLc
         1y/4qqMSvxbPxXiFGdJGV3aueip1Eg/TfgKuNnEi9eXbR34qPiO0dkHMkRJbEUJloAtT
         YvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=C2Z4QWy5wNJw+5XfdnScGboqm8ucQNIbMLIloYyNmGs=;
        b=D8uzm/cxVCAS7UT7lyPwpvpKtpNmGnLFsDZ03AA/XLB0JsO9PZbThpG9UZ4m/Etj3s
         j2QZMlxsSQFVm2PKC5yBoAq67T1cUK+ni/zlEwgwp04A5ZjDUAFbVXIUvP+HQJUA+I68
         dUQXjvYRk/rI+l4L7aLoHsKMKBF7qKg32QoYcdUEPdYR0lafX8LeOoU1rxnQU7x2QiSE
         n8BDHif1ni7v8Su8ODr4LJODgGOAk8UGOR1u3pr26UTotZeQuHcD9xDXvegszoiSA/Zx
         Lw9l4hr7hul5JQI+LhrcCYmL5UIzV08UxOVV0fe1/w8FcWJnzSg8jptDwCpxqGQu1jco
         KouA==
X-Gm-Message-State: AJcUukfYnueS5wvSL1sjWwSUChOs8iNOPO6yRhxrPw9R6gf0d2CIDLZU
        kCTm0AmgiPLdma+aSwOv9gdoV0lx
X-Google-Smtp-Source: ALg8bN5rtvdvpSZL7vF3ibwgosO2reRsvgoAjNIN0+T/5vvJSnab7IbNYCwaxd0YjXte0uEmGBdhYQ==
X-Received: by 2002:a17:902:2aa8:: with SMTP id j37mr15399309plb.226.1547748966386;
        Thu, 17 Jan 2019 10:16:06 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s190sm3275776pfb.103.2019.01.17.10.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 10:16:05 -0800 (PST)
Date:   Thu, 17 Jan 2019 10:16:03 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCHv2] watchdog: qcom: Add suspend/resume support
Message-ID: <20190117181603.GA14800@roeck-us.net>
References: <20190117151942.6092-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117151942.6092-1-saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 08:49:42PM +0530, Sai Prakash Ranjan wrote:
> This adds the support for qcom watchdog suspend and resume
> when entering and exiting deep sleep states. Otherwise
> having watchdog active after suspend would result in unwanted
> crashes/resets if resume happens after a long time.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> 
> ---
> 
> v2:
>  * Use __maybe_unused instead of #ifdef as suggested by
>    Brian and Guenter
> ---
>  drivers/watchdog/qcom-wdt.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index 780971318810..5dfd604477a4 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -245,6 +245,28 @@ static int qcom_wdt_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int __maybe_unused qcom_wdt_suspend(struct device *dev)
> +{
> +	struct qcom_wdt *wdt = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&wdt->wdd))
> +		qcom_wdt_stop(&wdt->wdd);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused qcom_wdt_resume(struct device *dev)
> +{
> +	struct qcom_wdt *wdt = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&wdt->wdd))
> +		qcom_wdt_start(&wdt->wdd);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(qcom_wdt_pm_ops, qcom_wdt_suspend, qcom_wdt_resume);
> +
>  static const struct of_device_id qcom_wdt_of_table[] = {
>  	{ .compatible = "qcom,kpss-timer", .data = reg_offset_data_apcs_tmr },
>  	{ .compatible = "qcom,scss-timer", .data = reg_offset_data_apcs_tmr },
> @@ -259,6 +281,7 @@ static struct platform_driver qcom_watchdog_driver = {
>  	.driver	= {
>  		.name		= KBUILD_MODNAME,
>  		.of_match_table	= qcom_wdt_of_table,
> +		.pm		= &qcom_wdt_pm_ops,
>  	},
>  };
>  module_platform_driver(qcom_watchdog_driver);
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
