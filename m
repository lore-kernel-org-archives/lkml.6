Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F203C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 02:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE970208FA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 02:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE970208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeHQF1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 01:27:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46427 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725833AbeHQF1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 01:27:19 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 33EA8D559E5E8;
        Fri, 17 Aug 2018 10:25:48 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Fri, 17 Aug 2018
 10:25:44 +0800
Message-ID: <5B763226.1040609@huawei.com>
Date:   Fri, 17 Aug 2018 10:25:42 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     <ezequiel@collabora.com>, <rui.zhang@intel.com>,
        <edubezval@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/thermal/tegra: fix a doule free devce node
References: <1533822056-33930-1-git-send-email-zhongjiang@huawei.com> <d2987e9f-5cbf-9622-c6b9-b8bc66b3a5a2@linaro.org>
In-Reply-To: <d2987e9f-5cbf-9622-c6b9-b8bc66b3a5a2@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/14 14:39, Daniel Lezcano wrote:
> On 09/08/2018 15:40, zhong jiang wrote:
>> Device node iterators will get the return node. Meawhile, It is
>> also put the previous device node. An explicit put will cause
>> a double put.
> What about:
>
> Subject: drivers/thermal/tegra: Fix a double free on the device node
>
> "The function 'for_each_child_of_node' iterates over the node list by
> dropping the of_node reference of the previous node.
>
> Calling of_node_put() on the iterator is pointless and leads to an
> inconsistent refcounting in addition to a double free. Remove it."
 Hi, Daniel

 Have you picked up the patch or should I repost the patch with above commit
 message that you have suggested?

 Thanks,
 zhong jiang
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/thermal/tegra/soctherm.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
>> index ed28110..3aa55c9 100644
>> --- a/drivers/thermal/tegra/soctherm.c
>> +++ b/drivers/thermal/tegra/soctherm.c
>> @@ -980,7 +980,6 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
>>  		tcd = thermal_of_cooling_device_register(np_stcc,
>>  							 (char *)name, ts,
>>  							 &throt_cooling_ops);
>> -		of_node_put(np_stcc);
>>  		if (IS_ERR_OR_NULL(tcd)) {
>>  			dev_err(dev,
>>  				"throttle-cfg: %s: failed to register cooling device\n",
>>
>


