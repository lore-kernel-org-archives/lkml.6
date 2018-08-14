Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB2BC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E46E21747
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E46E21747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbeHNJyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 05:54:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11104 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727670AbeHNJyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 05:54:20 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 61372DAA5771C;
        Tue, 14 Aug 2018 15:08:23 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Tue, 14 Aug 2018
 15:08:21 +0800
Subject: Re: [PATCH 1/2] f2fs: set 4KB discard granularity by default
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20180810100806.9298-1-yuchao0@huawei.com>
 <20180814041329.GB52730@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8dd153c2-5611-728b-e4a9-0c59486f53a4@huawei.com>
Date:   Tue, 14 Aug 2018 15:08:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814041329.GB52730@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/14 12:13, Jaegeuk Kim wrote:
> On 08/10, Chao Yu wrote:
>> Small granularity (size < 64K) fragmentation will cause f2fs suspending
>> all pending discards, result in performance regression, so let's set
>> 4KB discard granularity by default.
>>
>> So that without fstrim, we also have the ability to avoid any performance
>> regression caused by non-alignment mapping between fs and flash device.
> 
> This is why we added a sysfs entry. Why do we need to change the default
> value every time?

Of course, I didn't forget it. But, mostly, our user didn't know very well about
our filesystem including each configuration's meaning, mechanism, or usage
scenario, most of the time, they will choose to test f2fs with all default
option, and then make the conclusion.

Currently, with default 64k granularity, if we simulate fragmentation scenario
of filesystem, like by a)writing 4k file and b)deleting even indexing file, then
all 4k discards won't be issued, result in exhaustion of free space of flash
storage, and performance degradation.

So I think we'd better to consider and set default value of configuration more
elaborately to avoid obvious weakness.

Thoughts?

Thanks,

> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/f2fs.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 58431b9bfd8f..273ffdaf4891 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -248,7 +248,7 @@ struct discard_entry {
>>  };
>>  
>>  /* default discard granularity of inner discard thread, unit: block count */
>> -#define DEFAULT_DISCARD_GRANULARITY		16
>> +#define DEFAULT_DISCARD_GRANULARITY		1
>>  
>>  /* max discard pend list number */
>>  #define MAX_PLIST_NUM		512
>> -- 
>> 2.18.0.rc1
> 
> .
> 

