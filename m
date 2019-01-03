Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953F3C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 04:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677852070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 04:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbfACEsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 23:48:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729358AbfACEsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 23:48:39 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E49F8804F6;
        Thu,  3 Jan 2019 04:48:38 +0000 (UTC)
Received: from [10.72.12.82] (ovpn-12-82.pek2.redhat.com [10.72.12.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C5195D9C5;
        Thu,  3 Jan 2019 04:48:37 +0000 (UTC)
Subject: Re: [PATCH v3] driver: uio: fix possible memory leak in uio_open
To:     liujian <liujian56@huawei.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <1546525702-11264-1-git-send-email-liujian56@huawei.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <eed703d7-094f-4e6a-2948-e3ff82fad93d@redhat.com>
Date:   Thu, 3 Jan 2019 12:48:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1546525702-11264-1-git-send-email-liujian56@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 03 Jan 2019 04:48:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/3 22:28, liujian wrote:
> Fixes: 57c5f4df0a5a ("uio: fix crash after the device is unregistered")
> Signed-off-by: liujian <liujian56@huawei.com>
> ---
> v1->v2:
> rename the "err_infoopen" to "err_idev_info"
> v2->3:
> put the extra info after the "--"

Looks good to me.

Thanks.
BRs


>   drivers/uio/uio.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> index 5c10fc7..aab3520 100644
> --- a/drivers/uio/uio.c
> +++ b/drivers/uio/uio.c
> @@ -496,18 +496,19 @@ static int uio_open(struct inode *inode, struct file *filep)
>   	if (!idev->info) {
>   		mutex_unlock(&idev->info_lock);
>   		ret = -EINVAL;
> -		goto err_alloc_listener;
> +		goto err_idev_info;
>   	}
>   
>   	if (idev->info && idev->info->open)
>   		ret = idev->info->open(idev->info, inode);
>   	mutex_unlock(&idev->info_lock);
>   	if (ret)
> -		goto err_infoopen;
> +		goto err_idev_info;
>   
>   	return 0;
>   
> -err_infoopen:
> +err_idev_info:
> +	filep->private_data = NULL;
>   	kfree(listener);
>   
>   err_alloc_listener:


