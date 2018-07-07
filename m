Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9302CC3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F76224DC
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Buko4B2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F76224DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932984AbeGGBoh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 21:44:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932164AbeGGBog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 21:44:36 -0400
Received: from [192.168.0.101] (unknown [49.77.239.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25FF92249E;
        Sat,  7 Jul 2018 01:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530927876;
        bh=cEpUeUC/eAWeS5gubi3IoBr/aOHyCnm1nunL4uG5WAU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Buko4B2jigmEy+mV7ThIL+dhEuVS+fjJOAPch2zOJPDS2ioAhjr6qsT3QFcDkNxs0
         t2lhbhmhwzL9Zjsh0ToA0K7fg2rvY3AXBnLrBYASemtZT2KG6FugBgiZBVuoI8VEUy
         em6Cid8M1w5+Mi6Eti4HRTKJyJ/sSrDaV1Ju3Fv0=
Subject: Re: [PATCH] f2fs: enable real-time discard by default
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20180705062411.3757-1-yuchao0@huawei.com>
 <20180707011348.GB3904@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <50f73892-fc50-f6c5-02ec-cd41f6bdb6fc@kernel.org>
Date:   Sat, 7 Jul 2018 09:44:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180707011348.GB3904@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/7 9:13, Jaegeuk Kim wrote:
> On 07/05, Chao Yu wrote:
>> f2fs is focused on flash based storage, so let's enable real-time
>> discard by default, if user don't want to enable it, 'nodiscard'
>> mount option should be used on mount.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/super.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 848badda50ad..980edeb0b650 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1366,12 +1366,11 @@ static void default_options(struct f2fs_sb_info *sbi)
>>  	set_opt(sbi, NOHEAP);
>>  	sbi->sb->s_flags |= SB_LAZYTIME;
>>  	set_opt(sbi, FLUSH_MERGE);
>> -	if (f2fs_sb_has_blkzoned(sbi->sb)) {
> 
> I added this.
> 
> 	if (blk_queue_discard(bdev_get_queue(sbi->sb->s_bdev)))

That's correct. Thank you! :)

Thanks,

> 
>> +	set_opt(sbi, DISCARD);
>> +	if (f2fs_sb_has_blkzoned(sbi->sb))
>>  		set_opt_mode(sbi, F2FS_MOUNT_LFS);
>> -		set_opt(sbi, DISCARD);
>> -	} else {
>> +	else
>>  		set_opt_mode(sbi, F2FS_MOUNT_ADAPTIVE);
>> -	}
>>  
>>  #ifdef CONFIG_F2FS_FS_XATTR
>>  	set_opt(sbi, XATTR_USER);
>> -- 
>> 2.18.0.rc1
