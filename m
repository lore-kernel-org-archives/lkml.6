Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeCTQQt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:16:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34978 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeCTQQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:16:45 -0400
X-Google-Smtp-Source: AG47ELufGiC/AOXok2cRb0TFqXOCbZhaChV7TELPjfXDJrZ7kDyEFuCvBFS/Rjhe01Dvp52g8qdQ7w==
Subject: Re: [PATCH -next] drm/meson: Fix potential NULL dereference in
 meson_drv_bind_master()
From: Neil Armstrong <narmstrong@baylibre.com>
To: Wei Yongjun <weiyongjun1@huawei.com>, David Airlie <airlied@linux.ie>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1521555630-29284-1-git-send-email-weiyongjun1@huawei.com>
 <4cad8099-dbb8-d12c-9ce8-b64688222bd7@baylibre.com>
Organization: Baylibre
Message-ID: <1772626e-c521-a072-76e4-64e3b4883f2e@baylibre.com>
Date: Tue, 20 Mar 2018 17:16:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4cad8099-dbb8-d12c-9ce8-b64688222bd7@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2018 16:04, Neil Armstrong wrote:
> On 20/03/2018 15:20, Wei Yongjun wrote:
>> platform_get_resource_byname() may fail and return NULL, so we should
>> better check it's return value to avoid a NULL pointer dereference
>> a bit later in the code.
>>
>> This is detected by Coccinelle semantic patch.
>>
>> @@
>> expression pdev, res, n, t, e, e1, e2;
>> @@
>>
>> res = platform_get_resource_byname(pdev, t, n);
>> + if (!res)
>> +   return -EINVAL;
>> ... when != res == NULL
>> e = devm_ioremap(e1, res->start, e2);
>>
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>> ---
>>  drivers/gpu/drm/meson/meson_drv.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
>> index 3baceb7..32b1a6c 100644
>> --- a/drivers/gpu/drm/meson/meson_drv.c
>> +++ b/drivers/gpu/drm/meson/meson_drv.c
>> @@ -197,6 +197,8 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>>  	priv->io_base = regs;
>>  
>>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hhi");
>> +	if (!res)
>> +		return -EINVAL;
>>  	/* Simply ioremap since it may be a shared register zone */
>>  	regs = devm_ioremap(dev, res->start, resource_size(res));
>>  	if (!regs) {
>> @@ -213,6 +215,8 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>>  	}
>>  
>>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmc");
>> +	if (!res)
>> +		return -EINVAL;
>>  	/* Simply ioremap since it may be a shared register zone */
>>  	regs = devm_ioremap(dev, res->start, resource_size(res));
>>  	if (!regs) {
>>
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
>>
> Thanks,
> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> 

Applied to drm-misc-next
