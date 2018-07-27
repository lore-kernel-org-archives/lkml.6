Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B71C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F44B208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVjG7cd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F44B208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbeG0NGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:06:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729492AbeG0NGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:06:32 -0400
Received: from [192.168.0.101] (unknown [180.111.102.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D180120877;
        Fri, 27 Jul 2018 11:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532691899;
        bh=NK7HDwCcSlqTmVF5hBP81riVQkzHa2pqttRN48mWVVg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oVjG7cd82GpqRe/IEb1+4QACG+LHvF7JHHlqpccOn92L2OyPobmf7PTbnV7wRv0cj
         z9HfXBTcg6XPhxzpxlccpORXBhD/S+zlx1GY/IRgboBfB82R4C3I/bRZ9131SIkpIN
         7VnVfi/qXlAnQ94Rptutnpi7zyLkcZ5FYK4Qo98M=
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: turn off atomic writes when deteting
 abnormal behaviors
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20180715011112.11475-1-jaegeuk@kernel.org>
 <29151284-ef34-2eb2-1060-7e214fe8834a@huawei.com>
 <20180723130346.GD19644@jaegeuk-macbookpro.roam.corp.google.com>
 <d7fe5243-b0cd-a685-fe24-7ce833a07015@kernel.org>
 <20180727091721.GA16155@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <65fc88dc-5d38-6323-9ba0-8776bcd6165f@kernel.org>
Date:   Fri, 27 Jul 2018 19:44:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180727091721.GA16155@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/27 17:17, Jaegeuk Kim wrote:
> On 07/23, Chao Yu wrote:
>> On 2018/7/23 21:03, Jaegeuk Kim wrote:
>>> On 07/16, Chao Yu wrote:
>>>> On 2018/7/15 9:11, Jaegeuk Kim wrote:
>>>>> In order to prevent abusing atomic writes by abnormal users, we've added a
>>>>> threshold, 20% over memory footprint, which disallows further atomic writes.
>>>>> Previously, however, SQLite doesn't know the files became normal, so that
>>>>> it could write stale data and commit on revoked normal database file.
>>>>>
>>>>> Once f2fs detects such the abnormal behavior, this patch simply disables
>>>>> all the atomic operations such as:
>>>>> - write_begin() gives EINVAL to avoid stale data writes, and SQLite will call
>>>>>   F2FS_IOC_ABORT_VOLATILE_WRITE to notify aborting the transaction,
>>>>> - F2FS_IOC_START_ATOMIC_WRITE gives EINVAL for SQLite to fall back normal
>>>>>   journal_mode,
>>>>> - F2FS_IOC_COMMIT_ATOMIC_WRITE gives EINVAL, if the file was revoked, so that
>>>>>   Framework retries to submit the transaction given propagated SQLite error.
>>>>>
>>>>> Note that, this patch also turns off atomic operations, if foreground GC tries
>>>>> to move atomic files too frequently.
>>>>
>>>> Well, how about just keeping original implementation: shutdown atomic write for
>>>> those files which are really affect fggc? Since intention of the original
>>>> behavior is targeting to abnormal atomic write usage, e.g. open atomic_write
>>>> file for very long time, then fggc will be blocked each time when moving its
>>>> block. So shutdown it, fggc will recover.
>>>
>>> The point here is stopping sqlite to keep going wrong data writes even after
>>> we already revoked blocks.
>>
>> Yes, that's correct, what I mean is that if we can do that with smaller
>> granularity like just revoke blocks for file which is blocking fggc, it will
>> affect system/sqlite flow much less than forcing closing all atomic_write.
> 
> How about this?

Yes, it looks good to me. :)

> 
> From 64d2becb82a496c2e2c04abeed42efa3b401ee20 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Fri, 27 Jul 2018 18:15:11 +0900
> Subject: [PATCH] f2fs: don't allow any writes on aborted atomic writes
> 
> In order to prevent abusing atomic writes by abnormal users, we've added a
> threshold, 20% over memory footprint, which disallows further atomic writes.
> Previously, however, SQLite doesn't know the files became normal, so that
> it could write stale data and commit on revoked normal database file.
> 
> Once f2fs detects such the abnormal behavior, this patch tries to avoid further
> writes in write_begin().
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/data.c | 3 ++-
>  fs/f2fs/file.c | 7 ++++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 22dd00c6e241..02ec2603725f 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2295,7 +2295,8 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
>  	trace_f2fs_write_begin(inode, pos, len, flags);
>  
>  	if (f2fs_is_atomic_file(inode) &&
> -			!f2fs_available_free_memory(sbi, INMEM_PAGES)) {
> +			(is_inode_flag_set(inode, FI_ATOMIC_REVOKE_REQUEST) ||
> +			!f2fs_available_free_memory(sbi, INMEM_PAGES))) {
>  		err = -ENOMEM;
>  		drop_atomic = true;
>  		goto fail;
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index ff2cb8fb6934..c2c47f3248c4 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1708,8 +1708,11 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>  
>  	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  
> -	if (f2fs_is_atomic_file(inode))
> +	if (f2fs_is_atomic_file(inode)) {
> +		if (is_inode_flag_set(inode, FI_ATOMIC_REVOKE_REQUEST))
> +			ret = -EINVAL;
>  		goto out;
> +	}
>  
>  	ret = f2fs_convert_inline_inode(inode);
>  	if (ret)
> @@ -1871,6 +1874,8 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
>  		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
>  	}
>  
> +	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
> +
>  	inode_unlock(inode);
>  
>  	mnt_drop_write_file(filp);
> 
