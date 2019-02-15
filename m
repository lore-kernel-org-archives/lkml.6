Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A72C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF96C21900
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405931AbfBOKwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:52:32 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:36024 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405807AbfBOKwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:52:31 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 669E47E9D13BCB0BA87B;
        Fri, 15 Feb 2019 18:52:29 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Fri, 15 Feb 2019
 18:52:18 +0800
Subject: Re: [PATCH] net: hns: Fix object reference leaks in
 hns_dsaf_roce_reset()
To:     Huang Zijiang <huang.zijiang@zte.com.cn>, <yisen.zhuang@huawei.com>
References: <1550126505-28394-1-git-send-email-huang.zijiang@zte.com.cn>
CC:     <salil.mehta@huawei.com>, <davem@davemloft.net>,
        <lipeng321@huawei.com>, <liuyonglong@huawei.com>,
        <yuehaibing@huawei.com>, <keescook@chromium.org>,
        <wangxi11@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wang.yi59@zte.com.cn>,
        Linuxarm <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b20d235c-779c-77bd-e69f-2d63ffd79ec1@huawei.com>
Date:   Fri, 15 Feb 2019 10:52:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1550126505-28394-1-git-send-email-huang.zijiang@zte.com.cn>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2019 06:41, Huang Zijiang wrote:
> The of_find_device_by_node() takes a reference to the underlying device
> structure, we should release that reference.

of_find_device_by_node() is not called for every path, so is this change 
proper:

	/* find the platform device corresponding to fwnode */
	if (is_of_node(dsaf_fwnode)) {
		pdev = of_find_device_by_node(to_of_node(dsaf_fwnode));
	} else if (is_acpi_device_node(dsaf_fwnode)) {
		pdev = hns_dsaf_find_platform_device(dsaf_fwnode);
	} else {
		pr_err("fwnode is neither OF or ACPI type\n");
		return -EINVAL;
	}

	/* check if we were a success in fetching pdev */
	if (!pdev) {
		pr_err("couldn't find platform device for node\n");
		return -ENODEV;
	}

	/* retrieve the dsaf_device from the driver data */
	dsaf_dev = dev_get_drvdata(&pdev->dev);
	if (!dsaf_dev) {
		dev_err(&pdev->dev, "dsaf_dev is NULL\n");
		return -ENODEV;
	}

John

>
> Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
> ---
>  drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
> index 14d7ec7..697d929 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
> @@ -3081,6 +3081,7 @@ int hns_dsaf_roce_reset(struct fwnode_handle *dsaf_fwnode, bool dereset)
>  	dsaf_dev = dev_get_drvdata(&pdev->dev);
>  	if (!dsaf_dev) {
>  		dev_err(&pdev->dev, "dsaf_dev is NULL\n");
> +		put_device(&pdev->dev);
>  		return -ENODEV;
>  	}
>
> @@ -3088,6 +3089,7 @@ int hns_dsaf_roce_reset(struct fwnode_handle *dsaf_fwnode, bool dereset)
>  	if (AE_IS_VER1(dsaf_dev->dsaf_ver)) {
>  		dev_err(dsaf_dev->dev, "%s v1 chip doesn't support RoCE!\n",
>  			dsaf_dev->ae_dev.name);
> +		put_device(&pdev->dev);
>  		return -ENODEV;
>  	}
>
>


