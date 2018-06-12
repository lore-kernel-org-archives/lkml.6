Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C9DFFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763022089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FZcSw0p7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763022089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933684AbeFLMoa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:44:30 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58535 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932976AbeFLMo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:44:28 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180612124426euoutp01872149b6578012d3930be4107703b77e~3akp5T4Gt0630506305euoutp01i
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 12:44:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180612124426euoutp01872149b6578012d3930be4107703b77e~3akp5T4Gt0630506305euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1528807466;
        bh=5Cp+z7KyqdDLvd22Gzq1AMdd4Scj7rZQp7+rtXMJA3s=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FZcSw0p7hLOvH2tghZ1Ct3LXiN9pQDUOh103EzFfO/+a4yH1IQg4J9xdLe++h5C5z
         eYmht82fhPOfHKbmQkSna9sbXslMXt2F5qY1nbJVwxt/NLoJBC3lq0mG/BqDIZ+mE+
         JJsgv/nh3C0wHQ1Ht4z1hWde83IltFpPBul9qqHc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180612124425eucas1p24f09df067254c32e75b322c4142e3aad~3akpL5cxA2650026500eucas1p2e;
        Tue, 12 Jun 2018 12:44:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 93.B1.17380.920CF1B5; Tue, 12
        Jun 2018 13:44:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180612124424eucas1p101e61369a42132234d103ce52918b08e~3akoRUwbQ3138731387eucas1p17;
        Tue, 12 Jun 2018 12:44:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180612124424eusmtrp17f58fb2d892458ebcc6cfef147fd9be3~3akoAVFFn0306903069eusmtrp1-;
        Tue, 12 Jun 2018 12:44:24 +0000 (GMT)
X-AuditID: cbfec7f4-713ff700000043e4-7c-5b1fc029f95c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CA.AC.04183.820CF1B5; Tue, 12
        Jun 2018 13:44:24 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180612124424eusmtip23e848e823f0be27f20b33e8e01db75e7~3aknoFPS01131011310eusmtip2P;
        Tue, 12 Jun 2018 12:44:24 +0000 (GMT)
Subject: Re: [PATCH] PM / core: Fix supplier device runtime PM usage counter
 imbalance
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lukas Wunner <lukas@wunner.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jon Hunter <jonathanh@nvidia.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Tue, 12 Jun 2018 14:44:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <10125310.W3e2TP0641@aspire.rjw.lan>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djP87qaB+SjDT6vkrXYOGM9q0Xz4vVs
        Fi2zFrFYXN41h83ic+8RRosXz6Utzpy+xGpxfG24A4fHnWt72Dz2z13D7tHb/I7NY8vVdhaP
        vi2rGD0+b5LzmNG+jTWAPYrLJiU1J7MstUjfLoErY8LaSewFM+QqDr3pYWlgnCbRxcjBISFg
        InH6qUIXIxeHkMAKRokHhyYwQjhfGCWWnf/HAuF8ZpSY1bSarYuRE6xjXcNcJhBbSGA5o8TG
        9iiIoveMEju3rGIGSQgLREg0fHrDCGKLCARJrJ07iw2kiFngL6PEv9YzYAk2AUOJrrddbCB3
        sAioSvx55QgSFhWIkdh2+QELiM0rIChxcuYTMJsTqPzjlOesIDazgLzE9rdzmCFscYlbT+Yz
        gcyXEDjELjFrwXSo5jKJi78nMkNc7SJxueEiO4QtLPHq+BYoW0bi9OQeFojmZkaJ9hmz2CGc
        HkaJrXN2QP1sLXH4+EVWkEuZBTQl1u/Shwg7SjxbO50dEpB8EjfeCkIcxCcxadt0Zogwr0RH
        mxBEtZrErOPr4NYevHCJeQKj0iwkb85C8tosJK/NQti7gJFlFaN4amlxbnpqsVFearlecWJu
        cWleul5yfu4mRmByOv3v+JcdjLv+JB1iFOBgVOLhjaiUixZiTSwrrsw9xCjBwawkwhu4VT5a
        iDclsbIqtSg/vqg0J7X4EKM0B4uSOG+cRl2UkEB6YklqdmpqQWoRTJaJg1OqgXH1FP1nN5/U
        b197Ljzi3cNXnVwpNu9OX6hU+t5zfQVDSMXGuCqvU7ff7dae2GttaHKMS2Tf2zli7TrbYt0n
        du7uXZp6XHdpwqe7tbOOH5faG1V1X9FV92LXQ/aYzzcmyzmf9wvcszTXVnmPoP/GpQ7xIf8Z
        VeefcPTkUp3jyHxHjSH7qb79nGlKLMUZiYZazEXFiQCf+/5JSgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xe7oaB+SjDd7dV7TYOGM9q0Xz4vVs
        Fi2zFrFYXN41h83ic+8RRosXz6Utzpy+xGpxfG24A4fHnWt72Dz2z13D7tHb/I7NY8vVdhaP
        vi2rGD0+b5LzmNG+jTWAPUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
        JiU1J7MstUjfLkEvY8LaSewFM+QqDr3pYWlgnCbRxcjJISFgIrGuYS5TFyMXh5DAUkaJK9ca
        2SASMhInpzWwQtjCEn+udYHFhQTeMkq8eO4LYgsLREg0fHrDCGKLCARJ3J/3hwXEZhb4zyhx
        YWcKxNAWRolfM7+DDWITMJToegsxiFfATmL7ulNANgcHi4CqxJ9XjiBhUYEYidUbL7NDlAhK
        nJz5BGwmJ1DrxynPWSHmm0nM2/yQGcKWl9j+dg6ULS5x68l8pgmMQrOQtM9C0jILScssJC0L
        GFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBEbjtmM/t+xg7HoXfIhRgINRiYd3Q7VctBBr
        YllxZe4hRgkOZiUR3sCt8tFCvCmJlVWpRfnxRaU5qcWHGE2BfpvILCWanA9MFHkl8YamhuYW
        lobmxubGZhZK4rznDSqjhATSE0tSs1NTC1KLYPqYODilGhgPy6h9eay5xGBi7FqFq/qaC3Zm
        mr1/9k4gTsTlRvSKu8YHp6Yem3LU9HGRe9beY++tru05t4h3X76F3Qnpj/utr+l9fr+vRTXd
        9YdsG/vH7FLptu2xF5YX7eaLnxSW+OjrZkd9OZ6WwI+pB0K94/i2zrjl+2rn7PyyAPmAvCf+
        Btxf5kwzYvmuxFKckWioxVxUnAgA3BPfodwCAAA=
Message-Id: <20180612124424eucas1p101e61369a42132234d103ce52918b08e~3akoRUwbQ3138731387eucas1p17@eucas1p1.samsung.com>
X-CMS-MailID: 20180612124424eucas1p101e61369a42132234d103ce52918b08e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180612110807epcas5p10e076681eac6f50b01840c0052748d12
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180612110807epcas5p10e076681eac6f50b01840c0052748d12
References: <CGME20180612110807epcas5p10e076681eac6f50b01840c0052748d12@epcas5p1.samsung.com>
        <10125310.W3e2TP0641@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 2018-06-12 13:00, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If a device link is added via device_link_add() by the driver of the
> link's consumer device, the supplier's runtime PM usage counter is
> going to be dropped by the pm_runtime_put_suppliers() call in
> driver_probe_device().  However, in that case it is not incremented
> unless the supplier driver is already present and the link is not
> stateless.  That leads to a runtime PM usage counter imbalance for
> the supplier device in a few cases.
>
> To prevent that from happening, bump up the supplier runtime
> PM usage counter in device_link_add() for all links with the
> DL_FLAG_PM_RUNTIME flag set that are added at the consumer probe
> time.  Use pm_runtime_get_noresume() for that as the callers of
> device_link_add() who want the supplier to be resumed by it should
> pass DL_FLAG_RPM_ACTIVE in flags to it anyway.
>
> Fixes: 21d5c57b3726 (PM / runtime: Use device links)
> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> This is a replacement for commit 1e8378619841 (PM / runtime: Fixup
> reference counting of device link suppliers at probe) that is going
> to be reverted.

Thanks Rafael for the patch. I've applied it and now I'm a bit puzzled.
Let's get back to my IOMMU and codec case, mentioned here:
https://marc.info/?l=linux-pm&m=152878741527962&w=2

Now, after applying your patch, when IOMMU creates a link with
DL_FLAG_PM_RUNTIME to the jpeg device (this happens when jpeg device is
being probed), it is not IOMMU is not runtime resumed anymore (that's
because the patch changes pm_runtime_get_sync to pm_runtime_get_noresume).
This means that until jpeg driver enables runtime pm for its device and
finally performs runtime pm suspends/resume cycle, the supplier won't be
resumed. On the other hand, when I add DL_FLAG_RPM_ACTIVE flag to link
creation, the supplier is properly resumed, but then, once the jpeg
device probe finishes, the supplier is still in runtime active state
until a next runtime suspend/resume cycle of jpeg device. If I understand
right, the DL_FLAG_RPM_ACTIVE flag should be there from the beginning,
but that time it runtime pm part of links worked in a bit different way
than now.

Is there any way to keep old behavior?

> ---
>   drivers/base/core.c |   15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
>
> Index: linux-pm/drivers/base/core.c
> ===================================================================
> --- linux-pm.orig/drivers/base/core.c
> +++ linux-pm/drivers/base/core.c
> @@ -216,6 +216,13 @@ struct device_link *device_link_add(stru
>   			link->rpm_active = true;
>   		}
>   		pm_runtime_new_link(consumer);
> +		/*
> +		 * If the link is being added by the consumer driver at probe
> +		 * time, balance the decrementation of the supplier's runtime PM
> +		 * usage counter after consumer probe in driver_probe_device().
> +		 */
> +		if (consumer->links.status == DL_DEV_PROBING)
> +			pm_runtime_get_noresume(supplier);
>   	}
>   	get_device(supplier);
>   	link->supplier = supplier;
> @@ -234,14 +241,6 @@ struct device_link *device_link_add(stru
>   		case DL_DEV_DRIVER_BOUND:
>   			switch (consumer->links.status) {
>   			case DL_DEV_PROBING:
> -				/*
> -				 * Balance the decrementation of the supplier's
> -				 * runtime PM usage counter after consumer probe
> -				 * in driver_probe_device().
> -				 */
> -				if (flags & DL_FLAG_PM_RUNTIME)
> -					pm_runtime_get_sync(supplier);
> -
>   				link->status = DL_STATE_CONSUMER_PROBE;
>   				break;
>   			case DL_DEV_DRIVER_BOUND:
>
>
>
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

