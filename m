Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583A6C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCB620852
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CCB620852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbeGZDH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:07:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10123 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728352AbeGZDH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:07:58 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6C780CAF0EC0C;
        Thu, 26 Jul 2018 09:53:29 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.382.0; Thu, 26 Jul 2018
 09:53:21 +0800
Subject: Re: [f2fs-dev] [PATCH RESEND] f2fs: fix to restrict mount condition
 when without CONFIG_QUOTA
To:     Sheng Yong <shengyong1@huawei.com>, Chao Yu <chao@kernel.org>,
        <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180725231948.18075-1-chao@kernel.org>
 <4b46f8b3-2858-a528-de53-c2de333c3314@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0b69dfb2-098d-c986-9cdf-f6eac08cba76@huawei.com>
Date:   Thu, 26 Jul 2018 09:53:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4b46f8b3-2858-a528-de53-c2de333c3314@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/26 9:41, Sheng Yong wrote:
> Hi, Chao
> 
> On 2018/7/26 7:19, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> Like quota_ino feature, we need to reject mounting RDWR with image
>> which enables project_quota feature when there is no CONFIG_QUOTA
>> be set in kernel.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>   fs/f2fs/super.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index dbc1cb53581f..bc7c14a055bb 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -775,6 +775,12 @@ static int parse_options(struct super_block *sb, char *options)
>>   			 "without CONFIG_QUOTA");
>>   		return -EINVAL;
>>   	}
> 
> I think the following should be checked within !CONFIG_QUOTA, like patch "f2fs: quota: do
> not mount as RDWR without QUOTA if quota feature enabled" :)

I wrote this patch based on yours, so I think the code actually locates in the
right place. Please check serials on below link:

https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=f2fs-dev

> 
> thanks
> 
>> +	if (f2fs_sb_has_project_quota(sbi->sb) && !f2fs_readonly(sbi->sb)) {
>> +		f2fs_msg(sb, KERN_ERR,
>> +			"Filesystem with project quota feature cannot be "
>> +			"mounted RDWR without CONFIG_QUOTA");
>> +		return -EINVAL;
>> +	}
>>   #endif
>>   
>>   	if (F2FS_IO_SIZE_BITS(sbi) && !test_opt(sbi, LFS)) {
>>
> 
> 
> .
> 

