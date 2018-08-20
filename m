Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E822BC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B3021581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+ANkXR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B3021581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeHTPtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:49:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbeHTPtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:49:21 -0400
Received: from [192.168.0.101] (unknown [121.229.162.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27D9F21473;
        Mon, 20 Aug 2018 12:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534768433;
        bh=HZMvElk0U24v1tn1eSIgmhU5tw1qMBN2jwnd1M2TdW4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Z+ANkXR4pLuyIWqt1hLgeyXhbrtnHSCPkAOafedXm8kltVVcBrNEb6/X43rNCo+eo
         D/Q31nZkVZRN+jKTCKINSh9nhiqdZDmCsEIdT0loBOtSS7NxV8DPjUQdYYDoG4UkDr
         btKXcSIwNYKl9Aeg7ASCza/npfef3tJNvu6xQSZc=
Subject: Re: [PATCH 1/2] f2fs: fix to avoid quota inode leak in ->put_super
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20180817091840.50792-1-yuchao0@huawei.com>
 <20180818151600.GA84798@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <b10c4ae6-2a25-fb0b-cbfa-467b5e988b47@kernel.org>
Date:   Mon, 20 Aug 2018 20:33:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180818151600.GA84798@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/18 23:16, Jaegeuk Kim wrote:
> On 08/17, Chao Yu wrote:
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
>> index a5df9fbc6355..9647bbcdfd2b 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1977,10 +1977,12 @@ void f2fs_quota_off_umount(struct super_block *sb)
>>  	for (type = 0; type < MAXQUOTAS; type++) {
>>  		err = f2fs_quota_off(sb, type);
>>  		if (err) {
>> +			int ret = dquot_quota_off(sb, type);
>> +
> 
> Could you check the mainline version?

I guess we missed to apply below patch? Could you check that?

f2fs: report error if quota off error during umount

Thanks,

> 
>>  			f2fs_msg(sb, KERN_ERR,
>>  				"Fail to turn off disk quota "
>> -				"(type: %d, err: %d), Please "
>> -				"run fsck to fix it.", type, err);
>> +				"(type: %d, err: %d, ret:%d), Please "
>> +				"run fsck to fix it.", type, err, ret);
>>  			set_sbi_flag(F2FS_SB(sb), SBI_NEED_FSCK);
>>  		}
>>  	}
>> -- 
>> 2.18.0.rc1
