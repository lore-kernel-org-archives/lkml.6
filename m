Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B060C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A881218AE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfAHKFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:05:16 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:32488 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfAHKFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:05:15 -0500
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x08A4CBY056031;
        Tue, 8 Jan 2019 19:04:12 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Tue, 08 Jan 2019 19:04:12 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x08A47CH056010
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 8 Jan 2019 19:04:12 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in generic_file_write_iter
To:     Jan Kara <jack@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+9933e4476f365f5d5a1b@syzkaller.appspotmail.com>,
        linux-mm@kvack.org, mgorman@techsingularity.net,
        Michal Hocko <mhocko@kernel.org>, ak@linux.intel.com,
        jlayton@redhat.com, linux-kernel@vger.kernel.org,
        mawilcox@microsoft.com, syzkaller-bugs@googlegroups.com,
        tim.c.chen@linux.intel.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <0000000000009ce88d05714242a8@google.com>
 <4b349bff-8ad4-6410-250d-593b13d8d496@I-love.SAKURA.ne.jp>
 <9b9fcdda-c347-53ee-fdbb-8a7d11cf430e@I-love.SAKURA.ne.jp>
 <20180720130602.f3d6dc4c943558875a36cb52@linux-foundation.org>
 <a2df1f24-f649-f5d8-0b2d-66d45b6cb61f@i-love.sakura.ne.jp>
 <20180806100928.x7anab3c3y5q4ssa@quack2.suse.cz>
 <e8a23623-feaf-7730-5492-b329cb0daa21@i-love.sakura.ne.jp>
 <20190102144015.GA23089@quack2.suse.cz>
 <275523c6-f750-44c2-a8a4-f3825eeab788@i-love.sakura.ne.jp>
 <20190102172636.GA29127@quack2.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <bf209c90-3624-68cd-c0db-86a91210f873@i-love.sakura.ne.jp>
Date:   Tue, 8 Jan 2019 19:04:06 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190102172636.GA29127@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/03 2:26, Jan Kara wrote:
> On Thu 03-01-19 01:07:25, Tetsuo Handa wrote:
>> On 2019/01/02 23:40, Jan Kara wrote:
>>> I had a look into this and the only good explanation for this I have is
>>> that sb->s_blocksize is different from (1 << sb->s_bdev->bd_inode->i_blkbits).
>>> If that would happen, we'd get exactly the behavior syzkaller observes
>>> because grow_buffers() would populate different page than
>>> __find_get_block() then looks up.
>>>
>>> However I don't see how that's possible since the filesystem has the block
>>> device open exclusively and blkdev_bszset() makes sure we also have
>>> exclusive access to the block device before changing the block device size.
>>> So changing block device block size after filesystem gets access to the
>>> device should be impossible. 
>>>
>>> Anyway, could you perhaps add to your debug patch a dump of 'size' passed
>>> to __getblk_slow() and bdev->bd_inode->i_blkbits? That should tell us
>>> whether my theory is right or not. Thanks!
>>>

Got two reports. 'size' is 512 while bdev->bd_inode->i_blkbits is 12.

https://syzkaller.appspot.com/text?tag=CrashLog&x=1237c3ab400000

[  385.723941][  T439] kworker/u4:3(439): getblk(): executed=9 bh_count=0 bh_state=0 bdev_super_blocksize=512 size=512 bdev_super_blocksize_bits=9 bdev_inode_blkbits=12
(...snipped...)
[  568.159544][  T439] kworker/u4:3(439): getblk(): executed=9 bh_count=0 bh_state=0 bdev_super_blocksize=512 size=512 bdev_super_blocksize_bits=9 bdev_inode_blkbits=12

https://syzkaller.appspot.com/text?tag=CrashLog&x=143383d7400000

[ 1355.681513][ T6893] syz-executor0(6893): getblk(): executed=9 bh_count=0 bh_state=0 bdev_super_blocksize=512 size=512 bdev_super_blocksize_bits=9 bdev_inode_blkbits=12
[ 1358.274585][T15649] kworker/u4:17(15649): getblk(): executed=9 bh_count=0 bh_state=0 bdev_super_blocksize=512 size=512 bdev_super_blocksize_bits=9 bdev_inode_blkbits=12
(...snipped...)
[ 1455.341572][ T6893] syz-executor0(6893): getblk(): executed=9 bh_count=0 bh_state=0 bdev_super_blocksize=512 size=512 bdev_super_blocksize_bits=9 bdev_inode_blkbits=12
[ 1455.541457][T15649] kworker/u4:17(15649): getblk(): executed=9 bh_count=0 bh_state=0 bdev_super_blocksize=512 size=512 bdev_super_blocksize_bits=9 bdev_inode_blkbits=12

>>
>> OK. Andrew, will you add (or fold into) this change?
>>
>> From e6f334380ad2c87457bfc2a4058316c47f75824a Mon Sep 17 00:00:00 2001
>> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Date: Thu, 3 Jan 2019 01:03:35 +0900
>> Subject: [PATCH] fs/buffer.c: dump more info for __getblk_gfp() stall problem
>>
>> We need to dump more variables on top of
>> "fs/buffer.c: add debug print for __getblk_gfp() stall problem".
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Cc: Jan Kara <jack@suse.cz>
>> ---
>>  fs/buffer.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/buffer.c b/fs/buffer.c
>> index 580fda0..a50acac 100644
>> --- a/fs/buffer.c
>> +++ b/fs/buffer.c
>> @@ -1066,9 +1066,14 @@ static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
>>  #ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
>>  		if (!time_after(jiffies, current->getblk_stamp + 3 * HZ))
>>  			continue;
>> -		printk(KERN_ERR "%s(%u): getblk(): executed=%x bh_count=%d bh_state=%lx\n",
>> +		printk(KERN_ERR "%s(%u): getblk(): executed=%x bh_count=%d bh_state=%lx "
>> +		       "bdev_super_blocksize=%lu size=%u "
>> +		       "bdev_super_blocksize_bits=%u bdev_inode_blkbits=%u\n",
>>  		       current->comm, current->pid, current->getblk_executed,
>> -		       current->getblk_bh_count, current->getblk_bh_state);
>> +		       current->getblk_bh_count, current->getblk_bh_state,
>> +		       bdev->bd_super->s_blocksize, size,
>> +		       bdev->bd_super->s_blocksize_bits,
>> +		       bdev->bd_inode->i_blkbits);
> 
> Well, bd_super may be NULL if there's no filesystem mounted so it would be
> safer to check for this rather than blindly dereferencing it... Otherwise
> the change looks good to me.
> 
> 								Honza
> 

