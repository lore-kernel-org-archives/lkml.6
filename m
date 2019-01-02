Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC10C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C08B21019
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfABGhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 01:37:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbfABGhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 01:37:01 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47644C056807;
        Wed,  2 Jan 2019 06:37:01 +0000 (UTC)
Received: from [10.72.12.82] (ovpn-12-82.pek2.redhat.com [10.72.12.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EF83860C67;
        Wed,  2 Jan 2019 06:36:59 +0000 (UTC)
Subject: Re: [PATCH] driver: uio: fix possible memory leak in uio_open
To:     liujian <liujian56@huawei.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <1546446416-40831-1-git-send-email-liujian56@huawei.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <50ee4818-a154-5ea7-20f8-3c0f0859f4fa@redhat.com>
Date:   Wed, 2 Jan 2019 14:36:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1546446416-40831-1-git-send-email-liujian56@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 02 Jan 2019 06:37:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/3 0:26, liujian wrote:
> Fixes: 57c5f4df0a5a ("uio: fix crash after the device is unregistered")
> Signed-off-by: liujian <liujian56@huawei.com>
> ---
>   drivers/uio/uio.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> index 5c10fc7..bde7d7a 100644
> --- a/drivers/uio/uio.c
> +++ b/drivers/uio/uio.c
> @@ -496,7 +496,7 @@ static int uio_open(struct inode *inode, struct file *filep)
>   	if (!idev->info) {
>   		mutex_unlock(&idev->info_lock);
>   		ret = -EINVAL;
> -		goto err_alloc_listener;
> +		goto err_infoopen;
>   	}
>   
>   	if (idev->info && idev->info->open)
> @@ -508,6 +508,7 @@ static int uio_open(struct inode *inode, struct file *filep)
>   	return 0;
>   
>   err_infoopen:

Maybe we should rename the "err_infoopen" to something like 
"err_idev_info"...

Thanks.

BRs

> +	filep->private_data = NULL;
>   	kfree(listener);
>   
>   err_alloc_listener:


