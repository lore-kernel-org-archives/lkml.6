Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D67C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D7420873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D7420873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbeLMGaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:30:18 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15686 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726542AbeLMGaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:30:17 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A17887EA5AD87;
        Thu, 13 Dec 2018 14:30:13 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Thu, 13 Dec 2018
 14:30:11 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: add an ioctl() to explicitly trigger
 fsck later
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20181129015257.95036-1-jaegeuk@kernel.org>
 <16b92898-0d8b-8edf-17f4-36b112b25add@huawei.com>
 <20181130203611.GC71781@jaegeuk-macbookpro.roam.corp.google.com>
 <a50a7612-7429-4cc7-c9bb-56a054826a03@huawei.com>
 <20181213035631.GB33959@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <4dbbef1b-037c-0129-8485-a9f908835ec2@huawei.com>
Date:   Thu, 13 Dec 2018 14:30:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181213035631.GB33959@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/13 11:56, Jaegeuk Kim wrote:
> On 12/07, Chao Yu wrote:
>> On 2018/12/1 4:36, Jaegeuk Kim wrote:
>>> On 11/30, Chao Yu wrote:
>>>> On 2018/11/29 9:52, Jaegeuk Kim wrote:
>>>>> This adds an option in ioctl(F2FS_IOC_SHUTDOWN) in order to trigger fsck by
>>>>> setting a NEED_FSCK flag.
>>>>>
>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>> ---
>>>>>  fs/f2fs/f2fs.h | 1 +
>>>>>  fs/f2fs/file.c | 7 +++++++
>>>>>  2 files changed, 8 insertions(+)
>>>>>
>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>> index aa500239baf2..7cec897146a3 100644
>>>>> --- a/fs/f2fs/f2fs.h
>>>>> +++ b/fs/f2fs/f2fs.h
>>>>> @@ -417,6 +417,7 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
>>>>>  #define F2FS_GOING_DOWN_METASYNC	0x1	/* going down with metadata */
>>>>>  #define F2FS_GOING_DOWN_NOSYNC		0x2	/* going down */
>>>>>  #define F2FS_GOING_DOWN_METAFLUSH	0x3	/* going down with meta flush */
>>>>> +#define F2FS_GOING_DOWN_NEED_FSCK	0x4	/* going down to trigger fsck */
>>>>
>>>> Why not add a new ioctl interface for this? F2FS_GOING_DOWN_ prefix implies
>>>> filesystem will shutdown, IMO, we'd better to keep all sub-interfaces being
>>>> consistent in f2fs_ioc_shutdown().
>>>
>>> I'm thinking to use this for QA as device shutdown tests.
>>>
>>>>
>>>>>  
>>>>>  #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
>>>>>  /*
>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>> index ff82350a2c55..ca9bdbb8651b 100644
>>>>> --- a/fs/f2fs/file.c
>>>>> +++ b/fs/f2fs/file.c
>>>>> @@ -1966,6 +1966,13 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>>>>>  		f2fs_stop_checkpoint(sbi, false);
>>>>>  		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>>>>>  		break;
>>>>> +	case F2FS_GOING_DOWN_NEED_FSCK:
>>>>> +		set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>>> +		/* do checkpoint only */
>>>>> +		ret = f2fs_sync_fs(sb, 1);
>>>>> +		if (ret)
>>>>> +			goto out;
>>>>
>>>> In large-sized image, it may take long time to trigger full scan during
>>>> boot, so I'd like to ask how often we set this flag?
>>>
>>> Based on the use of shutdown ioctl, I'll use this for testing purpose, so it
>>> won't be used for regular cases.
>>
>> How about adding some commit messages or comments on
>> F2FS_GOING_DOWN_NEED_FSCK marco definition to give a bit hint for f2fs
>> developers to know the usage of the interface?
> 
> Done. :P
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev

Looks good to me now. ;)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>>> +		break;
>>>>>  	default:
>>>>>  		ret = -EINVAL;
>>>>>  		goto out;
>>>>>
>>>
>>> .
>>>
> 
> .
> 

