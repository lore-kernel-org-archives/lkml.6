Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3461C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A40F2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+5wp4UH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A40F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeIHDgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 23:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbeIHDgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 23:36:54 -0400
Received: from [192.168.0.101] (unknown [121.237.67.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06E3A20652;
        Fri,  7 Sep 2018 22:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536360822;
        bh=jsG4Wrnox5IAveYdrbWwI0F/N2seuKEjTcvCKpR9tYw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h+5wp4UHwX1mwdWWDxpaLIdSxUGANgZvY0l+7fysV4KhJrVgPO/wLsECtkgkE/sxQ
         +Wo9XDMtWcaZkbBCb2BrIASjzK0slCfM8GuIbVI0kI6HotBAWboS1Xax22I4cBoqoH
         XKfMap/x2IsvWfsS16tjxHGh2/vvdtW8DTSYfdhg=
Subject: Re: [PATCH 2/2] f2fs: fix to avoid quota inode leak in ->put_super
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20180906124436.89193-1-yuchao0@huawei.com>
 <20180906124436.89193-2-yuchao0@huawei.com>
 <20180907223852.GA96592@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <0efd4233-95bf-e4fe-47ca-ae69fd3881e5@kernel.org>
Date:   Sat, 8 Sep 2018 06:53:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907223852.GA96592@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can see it in dev, thanks for merging. ;)

On 2018/9/8 6:38, Jaegeuk Kim wrote:
> I merged as one. Please check dev. :)
> 
> On 09/06, Chao Yu wrote:
>> generic/019 reports below error:
>>
>>  __quota_error: 1160 callbacks suppressed
>>  Quota error (device zram1): write_blk: dquota write failed
>>  Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
>>  Quota error (device zram1): write_blk: dquota write failed
>>  Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
>>  Quota error (device zram1): write_blk: dquota write failed
>>  Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
>>  Quota error (device zram1): write_blk: dquota write failed
>>  Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
>>  Quota error (device zram1): write_blk: dquota write failed
>>  Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
>>  VFS: Busy inodes after unmount of zram1. Self-destruct in 5 seconds.  Have a nice day...
>>
>> If we failed in below path due to fail to write dquot block, we will miss
>> to release quota inode, fix it.
>>
>> - f2fs_put_super
>>  - f2fs_quota_off_umount
>>   - f2fs_quota_off
>>    - f2fs_quota_sync   <-- failed
>>    - dquot_quota_off   <-- missed to call
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/super.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index c026aaccf218..328f58647f4c 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1900,10 +1900,12 @@ void f2fs_quota_off_umount(struct super_block *sb)
>>  	for (type = 0; type < MAXQUOTAS; type++) {
>>  		err = f2fs_quota_off(sb, type);
>>  		if (err) {
>> +			int ret = dquot_quota_off(sb, type);
>> +
>>  			f2fs_msg(sb, KERN_ERR,
>>  				"Fail to turn off disk quota "
>> -				"(type: %d, err: %d), Please "
>> -				"run fsck to fix it.", type, err);
>> +				"(type: %d, err: %d, ret:%d), Please "
>> +				"run fsck to fix it.", type, err, ret);
>>  			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
>>  		}
>>  	}
>> -- 
>> 2.18.0.rc1
