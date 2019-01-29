Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE19C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF382148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FXkL8Kcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfA2KvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:51:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35012 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfA2KvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:51:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so21528347wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 02:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=On5srxnIGdGt5FLN1tX10Y0vyhQSunciyKuvGTHXhvc=;
        b=FXkL8KcdzEuwmQJ0l7eDhB/AESddVgTyXHY4Bat7+0yTfUk3/qp3Hoxz8sL69+/CSl
         jhRA/Ymxwlh3ZdqaQowgSMFb+QrynmZzBHeYlFp8i0fbRJwoCXQejyIh1GLEqG+RKyYp
         nRJi/vtf8nfYjOsVE8SKmWphGiXmDMwfDrTFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=On5srxnIGdGt5FLN1tX10Y0vyhQSunciyKuvGTHXhvc=;
        b=uaQCWqVuhi2nysNGaywFwibz9CacAopaQ5kzmEAbOLatNUaIwV8cWHIJP3AHLQzY2H
         GY0fBk89IZkKFYOD0UgFp5NUTqIEqEZ/dx+gG+DNQEPPIMmH/+W09+jCghO/Dc5iOCn8
         Gh4lksLBK+wSugkYWdJCHwCYr6gFHoLSZEPhvnOf+ffE4S2PGojqggrEfYhBHExKuWFD
         FqSwViySDYnx3ZNK0YeClQHt2njxR7kTDeTsTStzMHLtVfJi5ENsN+cls2AMA3pz6VhW
         ArwRaycRbg99Vw+3ou3Uy12QQK0OYFeOziXWsqfpyqNF2mgOcQ8til61P6BPTEXqNRVZ
         I1YA==
X-Gm-Message-State: AJcUukcVk1ACbSKvY8rVEy4LxuA64I6fSr4ozpXTQci4fmiUWg/6cQXe
        WCVDPEcCuiAmFbbrZZZYg/QkQQ==
X-Google-Smtp-Source: ALg8bN7/19qBD0069KQrNBNls7pKAYvKixbIHCemgWUBUf0oLrUq6ZDOoaIzfeCSccL1wEkm32nO+Q==
X-Received: by 2002:adf:80cf:: with SMTP id 73mr25350868wrl.57.1548759080273;
        Tue, 29 Jan 2019 02:51:20 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id 141sm2854089wmb.5.2019.01.29.02.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 02:51:19 -0800 (PST)
Subject: Re: [PATCH] qcom: apr: Make apr callbacks in non-atomic context
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org,
        bjorn.andersson@linaro.org
References: <20181115184904.27223-1-srinivas.kandagatla@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <675fca1e-2202-b4f9-2e45-8f0050886044@linaro.org>
Date:   Tue, 29 Jan 2019 10:51:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181115184904.27223-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Could you queue this up for 5.1 cycle!

We would need this to get the audio working on 820c along with WCD9335 
slimbus codec!

thanks,
srini

On 15/11/2018 18:49, Srinivas Kandagatla wrote:
> APR communication with DSP is not atomic in nature.
> Its request-response type. Trying to pretend that these are atomic
> and invoking apr client callbacks directly under atomic/irq context has
> endless issues with soundcard. It makes more sense to convert these
> to nonatomic calls. This also coverts all the dais to be nonatomic.
> 
> All the callbacks are now invoked as part of rx work queue.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/soc/qcom/apr.c | 74 +++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 69 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
> index 74f8b9607daa..8cfa825fce81 100644
> --- a/drivers/soc/qcom/apr.c
> +++ b/drivers/soc/qcom/apr.c
> @@ -8,6 +8,7 @@
>   #include <linux/spinlock.h>
>   #include <linux/idr.h>
>   #include <linux/slab.h>
> +#include <linux/workqueue.h>
>   #include <linux/of_device.h>
>   #include <linux/soc/qcom/apr.h>
>   #include <linux/rpmsg.h>
> @@ -17,8 +18,18 @@ struct apr {
>   	struct rpmsg_endpoint *ch;
>   	struct device *dev;
>   	spinlock_t svcs_lock;
> +	spinlock_t rx_lock;
>   	struct idr svcs_idr;
>   	int dest_domain_id;
> +	struct workqueue_struct *rxwq;
> +	struct work_struct rx_work;
> +	struct list_head rx_list;
> +};
> +
> +struct apr_rx_buf {
> +	struct list_head node;
> +	int len;
> +	uint8_t buf[];
>   };
>   
>   /**
> @@ -62,11 +73,7 @@ static int apr_callback(struct rpmsg_device *rpdev, void *buf,
>   				  int len, void *priv, u32 addr)
>   {
>   	struct apr *apr = dev_get_drvdata(&rpdev->dev);
> -	uint16_t hdr_size, msg_type, ver, svc_id;
> -	struct apr_device *svc = NULL;
> -	struct apr_driver *adrv = NULL;
> -	struct apr_resp_pkt resp;
> -	struct apr_hdr *hdr;
> +	struct apr_rx_buf *abuf;
>   	unsigned long flags;
>   
>   	if (len <= APR_HDR_SIZE) {
> @@ -75,6 +82,34 @@ static int apr_callback(struct rpmsg_device *rpdev, void *buf,
>   		return -EINVAL;
>   	}
>   
> +	abuf = kzalloc(sizeof(*abuf) + len, GFP_ATOMIC);
> +	if (!abuf)
> +		return -ENOMEM;
> +
> +	abuf->len = len;
> +	memcpy(abuf->buf, buf, len);
> +
> +	spin_lock_irqsave(&apr->rx_lock, flags);
> +	list_add_tail(&abuf->node, &apr->rx_list);
> +	spin_unlock_irqrestore(&apr->rx_lock, flags);
> +
> +	queue_work(apr->rxwq, &apr->rx_work);
> +
> +	return 0;
> +}
> +
> +
> +static int apr_do_rx_callback(struct apr *apr, struct apr_rx_buf *abuf)
> +{
> +	uint16_t hdr_size, msg_type, ver, svc_id;
> +	struct apr_device *svc = NULL;
> +	struct apr_driver *adrv = NULL;
> +	struct apr_resp_pkt resp;
> +	struct apr_hdr *hdr;
> +	unsigned long flags;
> +	void *buf = abuf->buf;
> +	int len = abuf->len;
> +
>   	hdr = buf;
>   	ver = APR_HDR_FIELD_VER(hdr->hdr_field);
>   	if (ver > APR_PKT_VER + 1)
> @@ -132,6 +167,23 @@ static int apr_callback(struct rpmsg_device *rpdev, void *buf,
>   	return 0;
>   }
>   
> +static void apr_rxwq(struct work_struct *work)
> +{
> +	struct apr *apr = container_of(work, struct apr, rx_work);
> +	struct apr_rx_buf *abuf, *b;
> +	unsigned long flags;
> +
> +	if (!list_empty(&apr->rx_list)) {
> +		list_for_each_entry_safe(abuf, b, &apr->rx_list, node) {
> +			apr_do_rx_callback(apr, abuf);
> +			spin_lock_irqsave(&apr->rx_lock, flags);
> +			list_del(&abuf->node);
> +			spin_unlock_irqrestore(&apr->rx_lock, flags);
> +			kfree(abuf);
> +		}
> +	}
> +}
> +
>   static int apr_device_match(struct device *dev, struct device_driver *drv)
>   {
>   	struct apr_device *adev = to_apr_device(dev);
> @@ -285,6 +337,14 @@ static int apr_probe(struct rpmsg_device *rpdev)
>   	dev_set_drvdata(dev, apr);
>   	apr->ch = rpdev->ept;
>   	apr->dev = dev;
> +	apr->rxwq = create_singlethread_workqueue("qcom_apr_rx");
> +	if (!apr->rxwq) {
> +		dev_err(apr->dev, "Failed to start Rx WQ\n");
> +		return -ENOMEM;
> +	}
> +	INIT_WORK(&apr->rx_work, apr_rxwq);
> +	INIT_LIST_HEAD(&apr->rx_list);
> +	spin_lock_init(&apr->rx_lock);
>   	spin_lock_init(&apr->svcs_lock);
>   	idr_init(&apr->svcs_idr);
>   	of_register_apr_devices(dev);
> @@ -303,6 +363,10 @@ static int apr_remove_device(struct device *dev, void *null)
>   
>   static void apr_remove(struct rpmsg_device *rpdev)
>   {
> +	struct apr *apr = dev_get_drvdata(&rpdev->dev);
> +
> +	flush_workqueue(apr->rxwq);
> +	destroy_workqueue(apr->rxwq);
>   	device_for_each_child(&rpdev->dev, NULL, apr_remove_device);
>   }
>   
> 
