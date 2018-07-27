Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC88C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEF12089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BEF12089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389476AbeG0LdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:33:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40810 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729547AbeG0LdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:33:09 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8FE19E9E35D0D;
        Fri, 27 Jul 2018 18:11:53 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.382.0; Fri, 27 Jul 2018
 18:11:54 +0800
Subject: Re: [PATCH] f2fs: fix to restrict mount condition when without
 CONFIG_QUOTA
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20180724165546.12924-1-chao@kernel.org>
 <20180727100855.GF16155@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <103b0302-acd0-28e9-6053-60c6663fad33@huawei.com>
Date:   Fri, 27 Jul 2018 18:12:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180727100855.GF16155@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/27 18:08, Jaegeuk Kim wrote:
> On 07/25, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> Like quota_ino feature, we need to reject mounting RDWR with image
>> which enables project_quota feature when there is no CONFIG_QUOTA
>> be set in kernel.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/super.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index dbc1cb53581f..bb40f08d2861 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -775,6 +775,12 @@ static int parse_options(struct super_block *sb, char *options)
>>  			 "without CONFIG_QUOTA");
>>  		return -EINVAL;
>>  	}
>> +	if (f2fs_sb_has_project_quota(sbi->sb) && !f2fs_readonly(sbi->sb)) {
>> +		ext4_msg(sb, KERN_ERR,
> 
> What is this?

Sorry, I just porting ext4's code here, but forget to change the function,
strangely, it pass my module compiling... :(, I have resend one patch.

Thanks,

> 
>> +			"Filesystem with project quota feature cannot be "
>> +			"mounted RDWR without CONFIG_QUOTA");
>> +		return -EINVAL;
>> +	}
>>  #endif
>>  
>>  	if (F2FS_IO_SIZE_BITS(sbi) && !test_opt(sbi, LFS)) {
>> -- 
>> 2.16.2.17.g38e79b1fd
> 
> .
> 

