Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48001C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EA9208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1EA9208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbeG0Njw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:39:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10144 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729431AbeG0Njw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:39:52 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B30ABE4A0974;
        Fri, 27 Jul 2018 20:18:08 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.382.0; Fri, 27 Jul 2018
 20:18:07 +0800
Subject: Re: linux-next: build failure after merge of the net-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
References: <20180727203259.4ec64ff9@canb.auug.org.au>
CC:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <f8be91dd-aafc-c1a4-6e76-efaf3caea4d0@huawei.com>
Date:   Fri, 27 Jul 2018 20:18:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180727203259.4ec64ff9@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/27 18:32, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the net-next tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> hns_roce_hw_v1.c:(.text.hns_roce_v1_reset+0x8c): undefined reference to `.hns_dsaf_roce_reset'
> hns_roce_hw_v1.c:(.text.hns_roce_v1_reset+0xdc): undefined reference to `.hns_dsaf_roce_reset'
> 
> Caused by commit
> 
>   336a443bd9dd ("net: hns: Make many functions static")

Sorry,I forgot do a allyesconfig. And I have post a fix patch, Dvaid applied it:

[PATCH net-next] net: hns: make hns_dsaf_roce_reset non static

https://lkml.org/lkml/2018/7/26/939

> 
> I have applied the following patch for today.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 27 Jul 2018 20:23:20 +1000
> Subject: [PATCH] net: hns: make hns_dsaf_roce_reset() not static
> 
> This function is declared in a header file and used in a different
> source file.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
> index 7afc67510569..619e6ce465c2 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
> @@ -2836,7 +2836,7 @@ module_platform_driver(g_dsaf_driver);
>   * @enable: false - request reset , true - drop reset
>   * retuen 0 - success , negative -fail
>   */
> -static int hns_dsaf_roce_reset(struct fwnode_handle *dsaf_fwnode, bool dereset)
> +int hns_dsaf_roce_reset(struct fwnode_handle *dsaf_fwnode, bool dereset)
>  {
>  	struct dsaf_device *dsaf_dev;
>  	struct platform_device *pdev;
> 

