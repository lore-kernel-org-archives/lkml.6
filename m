Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D6CC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B9C216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B9C216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeI0WDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:03:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:60386 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727212AbeI0WDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:03:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56662ACB8;
        Thu, 27 Sep 2018 15:44:21 +0000 (UTC)
Subject: Re: [PATCH] use STORE_LOCKED instead of STORE macro
To:     Dongbo Cao <cdbdyx@163.com>
Cc:     kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180927053142.4529-1-cdbdyx@163.com>
From:   Coly Li <colyli@suse.de>
Message-ID: <4e1bb3e5-82f2-51ff-c95b-fa76da4081da@suse.de>
Date:   Thu, 27 Sep 2018 23:44:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180927053142.4529-1-cdbdyx@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/27/18 1:31 PM, Dongbo Cao wrote:
> merge sysfs_writeback_running attr and sysfs_writeback_percent attr together with other attrs of cached_dev.
>
> Signed-off-by: Dongbo Cao <cdbdyx@163.com>

Could you please to explain more what you want to do, and why you make 
this change?

Thanks.


Coly Li

> ---
>   drivers/md/bcache/sysfs.c | 15 ++-------------
>   1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
> index 26f035a0..14fc9104 100644
> --- a/drivers/md/bcache/sysfs.c
> +++ b/drivers/md/bcache/sysfs.c
> @@ -245,7 +245,7 @@ SHOW(__bch_cached_dev)
>   }
>   SHOW_LOCKED(bch_cached_dev)
>   
> -STORE(__cached_dev)
> +STORE(__bch_cached_dev)
>   {
>   	struct cached_dev *dc = container_of(kobj, struct cached_dev,
>   					     disk.kobj);
> @@ -373,17 +373,6 @@ STORE(__cached_dev)
>   	if (attr == &sysfs_stop)
>   		bcache_device_stop(&dc->disk);
>   
> -	return size;
> -}
> -
> -STORE(bch_cached_dev)
> -{
> -	struct cached_dev *dc = container_of(kobj, struct cached_dev,
> -					     disk.kobj);
> -
> -	mutex_lock(&bch_register_lock);
> -	size = __cached_dev_store(kobj, attr, buf, size);
> -
>   	if (attr == &sysfs_writeback_running)
>   		bch_writeback_queue(dc);
>   
> @@ -392,9 +381,9 @@ STORE(bch_cached_dev)
>   			schedule_delayed_work(&dc->writeback_rate_update,
>   				      dc->writeback_rate_update_seconds * HZ);
>   
> -	mutex_unlock(&bch_register_lock);
>   	return size;
>   }
> +STORE_LOCKED(bch_cached_dev)
>   
>   static struct attribute *bch_cached_dev_files[] = {
>   	&sysfs_attach,
