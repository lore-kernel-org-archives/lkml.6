Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B07C46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 03:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D523321476
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 03:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D523321476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbeHOGCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 02:02:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52254 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726003AbeHOGCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 02:02:10 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 52912929A10E5;
        Wed, 15 Aug 2018 11:11:55 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Wed, 15 Aug 2018
 11:11:56 +0800
Subject: Re: [PATCH] Revert "f2fs: use printk_ratelimited for f2fs_msg"
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20180813062845.25394-1-yuchao0@huawei.com>
 <20180814170956.GA56510@jaegeuk-macbookpro.roam.corp.google.com>
 <51fabc55-ba93-1845-da39-0ee203fe2098@huawei.com>
 <20180815030114.GD84720@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8f5fb053-6244-45a6-7393-cbab2c239930@huawei.com>
Date:   Wed, 15 Aug 2018 11:11:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180815030114.GD84720@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/15 11:01, Jaegeuk Kim wrote:
> On 08/15, Chao Yu wrote:
>> On 2018/8/15 1:09, Jaegeuk Kim wrote:
>>> On 08/13, Chao Yu wrote:
>>>> Don't limit printing log, so that we will not miss any key messages.
>>>
>>> For example, this can avoid lots of messages during roll-forward recovery.
>>
>> That's really important evidence that can prove filesystem didn't lose last
>> fsynced data, when file/data is missing after SPO, otherwise, filesystem will
>> still be treated as suspect... :(
> 
> It's too bad that we need to rely on kernel messages for that purpose. Anyway,

Yes, it's very hard to make sure the problem is not caused by filesystem's bug
when trouble shooting, unless there is explicit kernel message.

Also, without message, trouble shooting becomes harder.

> if so, we may need to use printk() for essential messages only.

Now, during our debugging, we have to change to use printk to avoid potential
message missing...

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> This reverts commit a36c106dffb616250117efb1cab271c19a8f94ff.
>>>>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>  fs/f2fs/super.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>> index bf4c919fe418..3d89d94191e7 100644
>>>> --- a/fs/f2fs/super.c
>>>> +++ b/fs/f2fs/super.c
>>>> @@ -209,7 +209,7 @@ void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...)
>>>>  	va_start(args, fmt);
>>>>  	vaf.fmt = fmt;
>>>>  	vaf.va = &args;
>>>> -	printk_ratelimited("%sF2FS-fs (%s): %pV\n", level, sb->s_id, &vaf);
>>>> +	printk("%sF2FS-fs (%s): %pV\n", level, sb->s_id, &vaf);
>>>>  	va_end(args);
>>>>  }
>>>>  
>>>> -- 
>>>> 2.18.0.rc1
>>>
>>> .
>>>
> 
> .
> 

