Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A573C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD132087C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD132087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751303AbeGJFzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 01:55:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39061 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751086AbeGJFzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 01:55:00 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5281CBA8C5566;
        Tue, 10 Jul 2018 13:54:56 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.382.0; Tue, 10 Jul 2018
 13:54:56 +0800
Subject: Re: [f2fs-dev] [PATCH 2/4] f2fs: allow wrong configure dio to
 buffered write
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180706210903.77887-1-jaegeuk@kernel.org>
 <20180706210903.77887-2-jaegeuk@kernel.org>
 <af7e2fa5-b9e9-3090-7659-bd76585fd3aa@kernel.org>
 <20180709204125.GC24534@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <5ba170bb-8837-ce0a-87a9-b996b38eb1d8@huawei.com>
Date:   Tue, 10 Jul 2018 13:54:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180709204125.GC24534@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/10 4:41, Jaegeuk Kim wrote:
> On 07/09, Chao Yu wrote:
>> On 2018/7/7 5:09, Jaegeuk Kim wrote:
>>> This fixes to support unaligned dio as buffered writes.
>>
>> Should we return -EINVAL as manual of write said:
>>
>> EINVAL fd is attached to an object which is unsuitable for writing; or the file
>> was opened with the O_DIRECT flag,  and  either  the  address
>> specified in buf, the value specified in count, or the current file offset is
>> not suitably aligned.
> 
> I came from many xfstests failures regarding to direct IO error. It seems other
> filesystems allow buffered writes as well.

But as I see, it allows unaligned DIO write like xfs_io -d -c "pwrite 1 512",
where ext4 returns failure.

I guess, we only need to expand to support DIO write aligns to sector (512
bytes) for these cases?

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/data.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index e66379961804..6e8e78bb64a7 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -2425,7 +2425,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>>>  
>>>  	err = check_direct_IO(inode, iter, offset);
>>>  	if (err)
>>> -		return err;
>>> +		return 0;
>>>  
>>>  	if (f2fs_force_buffered_io(inode, rw))
>>>  		return 0;
>>>
> 
> 

