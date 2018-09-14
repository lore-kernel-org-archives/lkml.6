Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A77ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D92C20881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D92C20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbeINPOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:14:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:39670 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726868AbeINPOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:14:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C22F2AE66;
        Fri, 14 Sep 2018 10:00:37 +0000 (UTC)
Subject: Re: [PATCH] add label interface for cache device in sysfs
To:     Dongbo Cao <cdbdyx@163.com>
Cc:     kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180914095120.2699-1-cdbdyx@163.com>
From:   Coly Li <colyli@suse.de>
Message-ID: <eb59aaba-809b-579e-23c0-da802bd66e84@suse.de>
Date:   Fri, 14 Sep 2018 18:00:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180914095120.2699-1-cdbdyx@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/14/18 5:51 PM, Dongbo Cao wrote:
> label interface will be called by bcache tools in user space.
>
> Signed-off-by: Dongbo Cao <cdbdyx@163.com>

Hi Dongbo,


In your change I see you set superblock label to cache set. What is the 
use case for doing this ?

Thanks.


Coly Li


> ---
>   drivers/md/bcache/sysfs.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
> index 225b15aa..e64c718f 100644
> --- a/drivers/md/bcache/sysfs.c
> +++ b/drivers/md/bcache/sysfs.c
> @@ -950,6 +950,13 @@ SHOW(__bch_cache)
>   		return ret;
>   	}
>   
> +	if (attr == &sysfs_label) {
> +		memcpy(buf, ca->sb.label, SB_LABEL_SIZE);
> +		buf[SB_LABEL_SIZE + 1] = '\0';
> +		strcat(buf, "\n");
> +		return strlen(buf);
> +	}
> +
>   	return 0;
>   }
>   SHOW_LOCKED(bch_cache)
> @@ -993,6 +1000,17 @@ STORE(__bch_cache)
>   		atomic_set(&ca->io_errors, 0);
>   	}
>   
> +	if (attr == &sysfs_label) {
> +		if (size > SB_LABEL_SIZE)
> +			return -EINVAL;
> +		memcpy(ca->sb.label, buf, size);
> +		if (size < SB_LABEL_SIZE)
> +			ca->sb.label[size] = '\0';
> +		if (size && ca->sb.label[size - 1] == '\n')
> +			ca->sb.label[size - 1] = '\0';
> +		bcache_write_super(ca->set);
> +	}
> +
>   	return size;
>   }
>   STORE_LOCKED(bch_cache)
> @@ -1009,6 +1027,7 @@ static struct attribute *bch_cache_files[] = {
>   	&sysfs_io_errors,
>   	&sysfs_clear_stats,
>   	&sysfs_cache_replacement_policy,
> +	&sysfs_label,
>   	NULL
>   };
>   KTYPE(bch_cache);
