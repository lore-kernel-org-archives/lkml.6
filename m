Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00528C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2D421901
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbfBMD1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:27:19 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3195 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727346AbfBMD1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:27:19 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9AFA828ACBFDD0DE59CF;
        Wed, 13 Feb 2019 11:27:16 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Wed, 13 Feb 2019
 11:27:12 +0800
Subject: Re: [f2fs-dev] [PATCH 6/7] f2fs: flush quota blocks after turnning it
 off
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190128234717.77225-1-jaegeuk@kernel.org>
 <20190128234717.77225-6-jaegeuk@kernel.org>
 <629f4b34-381e-7860-c717-3fe54ee15694@kernel.org>
 <20190204165934.GB15646@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <499c3f3c-3ef4-5412-d4df-8bcfc7a558be@huawei.com>
Date:   Wed, 13 Feb 2019 11:27:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190204165934.GB15646@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/5 0:59, Jaegeuk Kim wrote:
> On 02/02, Chao Yu wrote:
>> On 2019-1-29 7:47, Jaegeuk Kim wrote:
>>> After quota_off, we'll get some dirty blocks. If put_super don't have a chance
>>> to flush them by checkpoint, it causes NULL pointer exception in end_io after
>>> iput(node_inode). (e.g., by checkpoint=disable)
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/super.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index 5e1f8573a17f..7694cb350734 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -2026,6 +2026,12 @@ void f2fs_quota_off_umount(struct super_block *sb)
>>>  			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
>>>  		}
>>>  	}
>>> +	/*
>>> +	 * In case of checkpoint=disable, we must flush quota blocks.
>>
>> checkpoint=disable is one of the cases, right? e.g. IO error can be another case?
>>
>> So here I guess we need to change the comments a bit for that.
> 
> I didn't test other cases, but checkpoint=disable could give real errors through
> some tests. So, basically, I'd like to keep known cases only here.

Alright, not a big deal. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
>>
>> Thanks,
>>
>>> +	 * This can cause NULL exception for node_inode in end_io, since
>>> +	 * put_super already dropped it.
>>> +	 */
>>> +	sync_filesystem(sb);
>>>  }
>>>  
>>>  static void f2fs_truncate_quota_inode_pages(struct super_block *sb)
>>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 

