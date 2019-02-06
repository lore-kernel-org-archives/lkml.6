Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA44C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA56420823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfBFIhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 03:37:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:60054 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726721AbfBFIhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 03:37:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9A79B685;
        Wed,  6 Feb 2019 08:37:40 +0000 (UTC)
Subject: Re: [PATCH] bcache: use kmemdup_nul for CACHED_LABEL buffer
To:     Geliang Tang <geliangtang@gmail.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
References: <04ff7c6d5cdd8b389d471989704c2f9dc3def554.1548840161.git.geliangtang@gmail.com>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <04ebd070-3c9c-0cd4-f2d8-d7b078ea2582@suse.de>
Date:   Wed, 6 Feb 2019 16:37:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <04ff7c6d5cdd8b389d471989704c2f9dc3def554.1548840161.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/30 5:29 下午, Geliang Tang wrote:
> This patch uses kmemdup_nul to create a NUL-terminated string from
> dc->sb.label. This is better than open coding it.
> 
> With this, we can move env[2] initialization into env[] array to make
> code more elegant.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Hi Geliang,

In general I am OK with your idea. But I feel there might be some
regression with your change. I comment your patch in line, correct me if
I am wrong.


> ---
>  drivers/md/bcache/super.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 4dee119c3664..84ab241c8516 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -906,21 +906,18 @@ static int cached_dev_status_update(void *arg)
>  void bch_cached_dev_run(struct cached_dev *dc)
>  {
>  	struct bcache_device *d = &dc->disk;
> -	char buf[SB_LABEL_SIZE + 1];
> +	char *buf = kmemdup_nul(dc->sb.label, SB_LABEL_SIZE, GFP_KERNEL);

If kdumdup_null() is failed, buf will be NULL.

>  	char *env[] = {
>  		"DRIVER=bcache",
>  		kasprintf(GFP_KERNEL, "CACHED_UUID=%pU", dc->sb.uuid),
> -		NULL,
> +		kasprintf(GFP_KERNEL, "CACHED_LABEL=%s", buf ? : ""),

If buf is NULL, env[2] here is pointed to "" which is allocated in
read-only data segment, and not a dynamic memory.

>  		NULL,
>  	};
>  
> -	memcpy(buf, dc->sb.label, SB_LABEL_SIZE);
> -	buf[SB_LABEL_SIZE] = '\0';
> -	env[2] = kasprintf(GFP_KERNEL, "CACHED_LABEL=%s", buf);
> -
>  	if (atomic_xchg(&dc->running, 1)) {
>  		kfree(env[1]);
>  		kfree(env[2]);

Then kfree() here will try to release a read-only memory segment. I
guess this is problematic.

> +		kfree(buf);
>  		return;
>  	}
>  
> @@ -944,6 +941,7 @@ void bch_cached_dev_run(struct cached_dev *dc)
>  	kobject_uevent_env(&disk_to_dev(d->disk)->kobj, KOBJ_CHANGE, env);
>  	kfree(env[1]);
>  	kfree(env[2]);

Same problem might happen here for env[2].

> +	kfree(buf);
>  
>  	if (sysfs_create_link(&d->kobj, &disk_to_dev(d->disk)->kobj, "dev") ||
>  	    sysfs_create_link(&disk_to_dev(d->disk)->kobj, &d->kobj, "bcache"))
> 


-- 

Coly Li
