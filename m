Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F43ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE24320652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE24320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbeGTB0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:26:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728018AbeGTB0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:26:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D19ECE1D6;
        Fri, 20 Jul 2018 00:40:55 +0000 (UTC)
Received: from [10.72.12.194] (ovpn-12-194.pek2.redhat.com [10.72.12.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D6AD92026D6B;
        Fri, 20 Jul 2018 00:40:52 +0000 (UTC)
Subject: Re: [PATCH] uio: fix wrong return value from uio_mmap()
To:     Hailong Liu <liu.hailong6@zte.com.cn>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn,
        zhong.weidong@zte.com.cn
References: <1532046716-49792-1-git-send-email-liu.hailong6@zte.com.cn>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <8ff360ff-1b0b-9c29-177d-4a025da58d04@redhat.com>
Date:   Fri, 20 Jul 2018 08:40:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532046716-49792-1-git-send-email-liu.hailong6@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 20 Jul 2018 00:40:55 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 20 Jul 2018 00:40:55 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'xiubli@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/20 8:31, Hailong Liu wrote:
> uio_mmap has multiple fail paths to set return value to nonzero then
> goto out. However, it always returns *0* from the *out* at end, and
> this will mislead callers who check the return value of this function.
>
> Fixes: 57c5f4df0a5a0ee ("uio: fix crash after the device is unregistered")
> CC: Xiubo Li <xiubli@redhat.com>
> Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
> Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
> ---
>   drivers/uio/uio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> index 5d421d7..0ddfda2 100644
> --- a/drivers/uio/uio.c
> +++ b/drivers/uio/uio.c
> @@ -814,7 +814,7 @@ static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
>   
>   out:
>   	mutex_unlock(&idev->info_lock);
> -	return 0;
> +	return ret;
Hi Hailong,

Good catch, Thanks.

BRs


>   }
>   
>   static const struct file_operations uio_fops = {


