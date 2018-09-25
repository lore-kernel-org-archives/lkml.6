Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45A4C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C46214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O3Fm6WXR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O3Fm6WXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C46214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbeIYM4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 08:56:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34952 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIYM4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 08:56:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 805D06074D; Tue, 25 Sep 2018 06:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537858200;
        bh=D+nhW8KTMJQyNB8JiMapSrZ6VRFivBuAQQ5Sc0iYAVc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O3Fm6WXR29aN9l/4ahf0p4JauJ04A1H2UkPnwURezLMyTJPZzBr8wxYBELZmqGp3k
         ARLbgtx2BHtBhEH2XyWXOn9Rc32DB2gY+U8f3AyPaFrVO+24M/tyUACnd0gbyYNdsk
         YMI7Bj/rlpyhippcsHb7IZJLP1yY1T9GkDScAJaI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1F57660116;
        Tue, 25 Sep 2018 06:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537858200;
        bh=D+nhW8KTMJQyNB8JiMapSrZ6VRFivBuAQQ5Sc0iYAVc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O3Fm6WXR29aN9l/4ahf0p4JauJ04A1H2UkPnwURezLMyTJPZzBr8wxYBELZmqGp3k
         ARLbgtx2BHtBhEH2XyWXOn9Rc32DB2gY+U8f3AyPaFrVO+24M/tyUACnd0gbyYNdsk
         YMI7Bj/rlpyhippcsHb7IZJLP1yY1T9GkDScAJaI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 Sep 2018 12:20:00 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        stable@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: q6v5: Propagate EPROBE_DEFER
In-Reply-To: <20180920015151.15957-1-bjorn.andersson@linaro.org>
References: <20180920015151.15957-1-bjorn.andersson@linaro.org>
Message-ID: <a1fdf85cb2e23b173243ba3b43b818bb@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-20 07:21, Bjorn Andersson wrote:
> In the case that the interrupts fail to result because of the
> interrupt-controller not yet being registered the
> platform_get_irq_byname() call will fail with -EPROBE_DEFER, but 
> passing
> this into devm_request_threaded_irq() will result in -EINVAL being
> returned, the driver is therefor not reprobed later.
> 

The patch looks fine.
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

> Fixes: 3b415c8fb263 ("remoteproc: q6v5: Extract common resource 
> handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/remoteproc/qcom_q6v5.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5.c 
> b/drivers/remoteproc/qcom_q6v5.c
> index 61a760ee4aac..e9ab90c19304 100644
> --- a/drivers/remoteproc/qcom_q6v5.c
> +++ b/drivers/remoteproc/qcom_q6v5.c
> @@ -198,6 +198,9 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct
> platform_device *pdev,
>  	}
> 
>  	q6v5->fatal_irq = platform_get_irq_byname(pdev, "fatal");
> +	if (q6v5->fatal_irq == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
>  	ret = devm_request_threaded_irq(&pdev->dev, q6v5->fatal_irq,
>  					NULL, q6v5_fatal_interrupt,
>  					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> @@ -208,6 +211,9 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct
> platform_device *pdev,
>  	}
> 
>  	q6v5->ready_irq = platform_get_irq_byname(pdev, "ready");
> +	if (q6v5->ready_irq == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
>  	ret = devm_request_threaded_irq(&pdev->dev, q6v5->ready_irq,
>  					NULL, q6v5_ready_interrupt,
>  					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> @@ -218,6 +224,9 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct
> platform_device *pdev,
>  	}
> 
>  	q6v5->handover_irq = platform_get_irq_byname(pdev, "handover");
> +	if (q6v5->handover_irq == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
>  	ret = devm_request_threaded_irq(&pdev->dev, q6v5->handover_irq,
>  					NULL, q6v5_handover_interrupt,
>  					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> @@ -229,6 +238,9 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct
> platform_device *pdev,
>  	disable_irq(q6v5->handover_irq);
> 
>  	q6v5->stop_irq = platform_get_irq_byname(pdev, "stop-ack");
> +	if (q6v5->stop_irq == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
>  	ret = devm_request_threaded_irq(&pdev->dev, q6v5->stop_irq,
>  					NULL, q6v5_stop_interrupt,
>  					IRQF_TRIGGER_RISING | IRQF_ONESHOT,

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
