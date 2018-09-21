Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB865ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856D62147D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856D62147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390009AbeIUUFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:05:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12673 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389022AbeIUUFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:05:50 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 331374A3CDD9D;
        Fri, 21 Sep 2018 22:16:42 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 22:16:43 +0800
Message-ID: <5BA4FD4A.2030804@huawei.com>
Date:   Fri, 21 Sep 2018 22:16:42 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <martin.petersen@oracle.com>
CC:     <don.brace@microsemi.com>, <jejb@linux.vnet.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RESEND PATCH v2] scsi: Use vmemdup_user to replace the open
 code
References: <1537286081-63081-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1537286081-63081-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  martin

Can you pick up the patch?  Thanks,

Sincerely,
zhong jiang

On 2018/9/18 23:54, zhong jiang wrote:
> vmemdup_user is better than duplicating its implementation, So just
> replace the open code.
>
> The issue is detected with the help of Coccinelle.
>
> Tested-by: Don Brace <don.brace@microsemi.com>
> Acked-by: Don Brace <don.brace@microsemi.com>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/scsi/hpsa.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
> index 58bb70b..666ba09e5 100644
> --- a/drivers/scsi/hpsa.c
> +++ b/drivers/scsi/hpsa.c
> @@ -6381,13 +6381,9 @@ static int hpsa_big_passthru_ioctl(struct ctlr_info *h, void __user *argp)
>  		return -EINVAL;
>  	if (!capable(CAP_SYS_RAWIO))
>  		return -EPERM;
> -	ioc = kmalloc(sizeof(*ioc), GFP_KERNEL);
> -	if (!ioc) {
> -		status = -ENOMEM;
> -		goto cleanup1;
> -	}
> -	if (copy_from_user(ioc, argp, sizeof(*ioc))) {
> -		status = -EFAULT;
> +	ioc = vmemdup_user(argp, sizeof(*ioc));
> +	if (IS_ERR(ioc)) {
> +		status = PTR_ERR(ioc);
>  		goto cleanup1;
>  	}
>  	if ((ioc->buf_size < 1) &&
> @@ -6505,7 +6501,7 @@ static int hpsa_big_passthru_ioctl(struct ctlr_info *h, void __user *argp)
>  		kfree(buff);
>  	}
>  	kfree(buff_size);
> -	kfree(ioc);
> +	kvfree(ioc);
>  	return status;
>  }
>  


