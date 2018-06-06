Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3UfsXw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1DA71607C7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932283AbeFFGp0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:45:26 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41198 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932164AbeFFGpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:45:24 -0400
X-Google-Smtp-Source: ADUXVKITpxktRTi4asDK4tWFZYmjI2U7YzIfuoYf0YfXTED8QX4lYDMjZlEcVbjSqSBdKYYgm1QZKQ==
Subject: Re: [PATCH 01/20] coresight: Fix memory leak in coresight_register
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-2-git-send-email-suzuki.poulose@arm.com>
Cc: mathieu.poirier@linaro.org, robh@kernel.org,
        frowand.list@gmail.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        arm@kernel.org, linux-kernel@vger.kernel.org, matt.sealey@arm.com,
        john.horley@arm.com, charles.garcia-tobin@arm.com,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        mike.leach@linaro.org
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Message-ID: <b0100f00-c706-3a41-ca55-3c1329c53aa3@gmail.com>
Date: Wed, 6 Jun 2018 12:14:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1528235011-30691-2-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,


On Wednesday 06 June 2018 03:13 AM, Suzuki K Poulose wrote:
> commit 6403587a930c ("coresight: use put_device() instead of kfree()")
> introduced a memory leak where, if we fail to register the device
> for coresight_device, we don't free the "coresight_device" object,
> which was allocated via kzalloc(). Fix this by jumping to the
> appropriate error path.
put_device() will decrement the last reference and then
free the memory by calling dev->release.  Internally
put_device() -> kobject_put() -> kobject_cleanup() which is
responsible to call 'dev -> release' and also free other kobject
resources. If you will see the coresight_device_release. There
we are releasing all allocated memory. Still if you call kfree() again
then it'll be redundancy.

~arvind
>
> Fixes: commit 6403587a930c ("coresight: use put_device() instead of kfree()")
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 4969b32..2893cfe 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -1020,7 +1020,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>   	ret = device_register(&csdev->dev);
>   	if (ret) {
>   		put_device(&csdev->dev);
> -		goto err_kzalloc_csdev;
> +		goto err_kzalloc_refcnts;
>   	}
>   
>   	mutex_lock(&coresight_mutex);
