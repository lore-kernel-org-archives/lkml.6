Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC76C6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAAA24F3C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAAA24F3C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933120AbeGBC5p (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 22:57:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9187 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932468AbeGBC5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 22:57:44 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BECCABAE6383E;
        Mon,  2 Jul 2018 10:57:28 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.382.0; Mon, 2 Jul 2018
 10:57:29 +0800
Subject: Re: [PATCH] f2fs: Replace strncpy with memcpy
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1530478626-15753-1-git-send-email-linux@roeck-us.net>
 <0250de00-adf7-7b43-5f7c-44704119e2f9@huawei.com>
 <367fb12b-3ae0-4a6a-b59e-31d3a360bf05@roeck-us.net>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <ecb4f083-1d61-d882-c85c-53cb33fa793e@huawei.com>
Date:   Mon, 2 Jul 2018 10:57:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <367fb12b-3ae0-4a6a-b59e-31d3a360bf05@roeck-us.net>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/2 10:16, Guenter Roeck wrote:
> On 07/01/2018 06:53 PM, Chao Yu wrote:
>> On 2018/7/2 4:57, Guenter Roeck wrote:
>>> gcc 8.1.0 complains:
>>>
>>> fs/f2fs/namei.c: In function 'f2fs_update_extension_list':
>>> fs/f2fs/namei.c:257:3: warning:
>>> 	'strncpy' output truncated before terminating nul copying
>>> 	as many bytes from a string as its length
>>> fs/f2fs/namei.c:249:3: warning:
>>> 	'strncpy' output truncated before terminating nul copying
>>> 	as many bytes from a string as its length
>>>
>>> Using strncpy() is indeed less than perfect since the length of data to
>>> be copied has already been determined with strlen(). Replace strncpy()
>>> with memcpy() to address the warning and optimize the code a little.
>>>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>>   fs/f2fs/namei.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>>> index 231b7f3ea7d3..e75607544f7c 100644
>>> --- a/fs/f2fs/namei.c
>>> +++ b/fs/f2fs/namei.c
>>> @@ -246,7 +246,7 @@ int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
>>>   		return -EINVAL;
>>>   
>>>   	if (hot) {
>>> -		strncpy(extlist[count], name, strlen(name));
>>> +		memcpy(extlist[count], name, strlen(name));
>>
>> How about replacing with strcpy(extlist[count], name)? Because name length has
>> already been checked before f2fs_update_extension_list, it should be valid, and
>> will not cause overflow during copying.
>>
> 
> Your call; feel free to submit an alternative. Since it is different files, static
> analysis might not know and complain, though. You might want to make sure that this
> doesn't happen, and also add a comment explaining the reason for using strcpy().

Yeah, that could be changed in another patch, but it will be trivial. Anyway, to
fix this gcc complaint, this patch looks good to me, thanks for the patch. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
> Thanks,
> Guenter
> 
> 

