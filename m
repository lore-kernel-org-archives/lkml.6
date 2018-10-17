Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E14C5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C9C2148D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C9C2148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJQLX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 07:23:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52768 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727111AbeJQLX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 07:23:56 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3C841CBA5D457;
        Wed, 17 Oct 2018 11:30:18 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.399.0; Wed, 17 Oct 2018
 11:30:08 +0800
Subject: Re: [PATCH v11] f2fs: guarantee journalled quota data by checkpoint
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, Weichao Guo <guoweichao@huawei.com>
References: <20180920120500.21026-1-chao@kernel.org>
 <20181001000618.GC17407@jaegeuk-macbookpro.roam.corp.google.com>
 <cd4d60b9-3f24-d408-610a-af57e0cb0165@kernel.org>
 <20181001012911.GF17407@jaegeuk-macbookpro.roam.corp.google.com>
 <73df627f-5b12-71cd-9a52-41f187d5516d@kernel.org>
 <20181001014915.GG17407@jaegeuk-macbookpro.roam.corp.google.com>
 <143b572f-8044-eae2-d321-79040beba4f4@kernel.org>
 <20181002164514.GA93409@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <9a3f0b96-8d29-121a-b31b-1eeb7c2e92c2@huawei.com>
Date:   Wed, 17 Oct 2018 11:30:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002164514.GA93409@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jaegeuk,

Sorry for the long delay, I'm busy on other thing.

I'm trying your fixing code on both fsck and kernel with 'run.sh
por_fsstress' case.

And got below output, is that normal in updated fsck? I didn't have time to
look into this.

Info: checkpoint state = 8c6 :  quota_need_fsck nat_bits crc
compacted_summary orphan_inodes sudden-power-off
[fsck_chk_quota_files:1755] Fixing Quota file ([  0] ino [0x4])
[ERROR] quotaio_tree.c:83:write_blk:: Cannot write block (1320):
Inappropriate ioctl for device
[ERROR] quotaio_tree.c:110:get_free_dqblk:: Cannot allocate new quota block
(out of disk space).
[ERROR] quotaio_tree.c:315:dq_insert_tree:: Cannot write quota (id
67368348): Inappropriate ioctl for device
[fsck_chk_quota_files:1755] Fixing Quota file ([  1] ino [0x5])
[ERROR] quotaio_tree.c:83:write_blk:: Cannot write block (1332):
Inappropriate ioctl for device
[ERROR] quotaio_tree.c:110:get_free_dqblk:: Cannot allocate new quota block
(out of disk space).
[ERROR] quotaio_tree.c:315:dq_insert_tree:: Cannot write quota (id
73435216): Inappropriate ioctl for device

Thanks,


On 2018/10/3 0:45, Jaegeuk Kim wrote:
> On 10/01, Chao Yu wrote:
>> On 2018-10-1 9:49, Jaegeuk Kim wrote:
>>> On 10/01, Chao Yu wrote:
>>>> On 2018-10-1 9:29, Jaegeuk Kim wrote:
>>>>> On 10/01, Chao Yu wrote:
>>>>>> Hi Jaegeuk,
>>>>>>
>>>>>> On 2018-10-1 8:06, Jaegeuk Kim wrote:
>>>>>>> Hi Chao,
>>>>>>>
>>>>>>> This fails on fsstress with godown without fault injection. Could you please
>>>>>>> test a bit? I assumed that this patch should give no fsck failure along with
>>>>>>> valid checkpoint having no flag.
>>>>>>
>>>>>> Okay, let me reproduce with that case.
>>>>>>
>>>>>>>
>>>>>>> BTW, I'm in doubt that f2fs_lock_all covers entire quota modification. What
>>>>>>> about prepare_write_begin() -> f2fs_get_block() ... -> inc_valid_block_count()?
>>>>>>
>>>>>> If quota data changed in above path, we will detect that in below condition:
>>>>>>
>>>>>> block_operation()
>>>>>>
>>>>>> 	down_write(&sbi->node_change);
>>>>>>
>>>>>> 	if (__need_flush_quota(sbi)) {
>>>>>> 		up_write(&sbi->node_change);
>>>>>> 		f2fs_unlock_all(sbi);
>>>>>> 		goto retry_flush_quotas;
>>>>>> 	}
>>>>>>
>>>>>> So there is no problem?
>>>>>
>>>>> We may need to check quota is dirty, since we have no way to detect by
>>>>> f2fs structures?
>>>>
>>>> Below condition can check that.
>>>>
>>>> static bool __need_flush_quota(struct f2fs_sb_info *sbi)
>>>> {
>>>> ...
>>>> 	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_FLUSH))
>>>> 		return true;
>>>> 	if (get_pages(sbi, F2FS_DIRTY_QDATA))
>>>> 		return true;
>>>> ...
>>>> }
>>>>
>>>> static int f2fs_dquot_mark_dquot_dirty(struct dquot *dquot)
>>>> {
>>>> ...
>>>> 	ret = dquot_mark_dquot_dirty(dquot);
>>>>
>>>> 	/* if we are using journalled quota */
>>>> 	if (is_journalled_quota(sbi))
>>>> 		set_sbi_flag(sbi, SBI_QUOTA_NEED_FLUSH);
>>>> ...
>>>> }
>>>
>>> Okay, then, could you please run the above stress test to reproduce this?
>>
>> Sure, let me try this case and fix it.
>>
>> Could you check other patches in mailing list, and test them instead?
> 
> With the below change, the test result is much better for now.
> Let me know, if you have further concern.
> 
> ---
>  fs/f2fs/checkpoint.c | 6 ++++++
>  fs/f2fs/super.c      | 4 +++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index a1facfbfc5c7..b111c6201023 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1111,6 +1111,8 @@ static int block_operations(struct f2fs_sb_info *sbi)
>  
>  retry_flush_quotas:
>  	if (__need_flush_quota(sbi)) {
> +		int locked;
> +
>  		if (++cnt > DEFAULT_RETRY_QUOTA_FLUSH_COUNT) {
>  			set_sbi_flag(sbi, SBI_QUOTA_SKIP_FLUSH);
>  			f2fs_lock_all(sbi);
> @@ -1118,7 +1120,11 @@ static int block_operations(struct f2fs_sb_info *sbi)
>  		}
>  		clear_sbi_flag(sbi, SBI_QUOTA_NEED_FLUSH);
>  
> +		/* only failed during mount/umount/freeze/quotactl */
> +		locked = down_read_trylock(&sbi->sb->s_umount);
>  		f2fs_quota_sync(sbi->sb, -1);
> +		if (locked)
> +			up_read(&sbi->sb->s_umount);
>  	}
>  
>  	f2fs_lock_all(sbi);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index a28c245b1288..b39f60d57120 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1706,6 +1706,7 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
>  				congestion_wait(BLK_RW_ASYNC, HZ/50);
>  				goto repeat;
>  			}
> +			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
>  			return PTR_ERR(page);
>  		}
>  
> @@ -1717,6 +1718,7 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
>  		}
>  		if (unlikely(!PageUptodate(page))) {
>  			f2fs_put_page(page, 1);
> +			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
>  			return -EIO;
>  		}
>  
> @@ -1758,6 +1760,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
>  				congestion_wait(BLK_RW_ASYNC, HZ/50);
>  				goto retry;
>  			}
> +			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
>  			break;
>  		}
>  
> @@ -1794,7 +1797,6 @@ static qsize_t *f2fs_get_reserved_space(struct inode *inode)
>  
>  static int f2fs_quota_on_mount(struct f2fs_sb_info *sbi, int type)
>  {
> -
>  	if (is_set_ckpt_flags(sbi, CP_QUOTA_NEED_FSCK_FLAG)) {
>  		f2fs_msg(sbi->sb, KERN_ERR,
>  			"quota sysfile may be corrupted, skip loading it");
> 

