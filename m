Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752567AbeEPGtB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 02:49:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751550AbeEPGtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 02:49:00 -0400
Subject: Re: [PATCH] f2fs: Fix deadlock in shutdown ioctl
To: Sahitya Tummala <stummala@codeaurora.org>
CC: Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1525958444-5579-1-git-send-email-stummala@codeaurora.org>
 <de6f040b-81d3-7f52-2482-135d11200788@huawei.com>
 <20180515075747.GA6293@codeaurora.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <67bd2926-6851-0544-c24a-85dfa72aa70f@huawei.com>
Date: Wed, 16 May 2018 14:48:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180515075747.GA6293@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/5/15 15:57, Sahitya Tummala wrote:
> On Mon, May 14, 2018 at 11:39:42AM +0800, Chao Yu wrote:
>> On 2018/5/10 21:20, Sahitya Tummala wrote:
>>> f2fs_ioc_shutdown() ioctl gets stuck in the below path
>>> when going down with full sync (F2FS_GOING_DOWN_FULLSYNC)
>>> option.
>>>
>>> __switch_to+0x90/0xc4
>>> percpu_down_write+0x8c/0xc0
>>> freeze_super+0xec/0x1e4
>>> freeze_bdev+0xc4/0xcc
>>> f2fs_ioctl+0xc0c/0x1ce0
>>> f2fs_compat_ioctl+0x98/0x1f0
>>>
>>> Fix this by not holding write access during this ioctl.
>>
>> I think we can just remove lock coverage for F2FS_GOING_DOWN_FULLSYNC path, for
>> other path, we need to keep as it is.
>>
> 
> Thanks, I thought about it too but then I checked that XFS shutdown ioctl is
> not taking any lock for this ioctl. Hence, I followed the same in F2FS.
> Do you know why XFS is not taking any lock? 

I don't know. :(

> Is it really needed in shutdown ioctl?

IMO, yes, we should keep freeze and remount be aware of the shutdown operation.

Thanks,

> 
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
> 
> 
