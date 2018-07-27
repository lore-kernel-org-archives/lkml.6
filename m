Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59ABC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5B0208AC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9pRvE5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5B0208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbeG0NbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:31:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730126AbeG0NbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:31:02 -0400
Received: from [192.168.0.101] (unknown [180.111.102.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8210208A5;
        Fri, 27 Jul 2018 12:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532693364;
        bh=Ur0eiALpQwLpWqj+Kvb4SOqnwY8n7Y2BvTuXFCJcA14=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=F9pRvE5DI/wccsuPH1OMFi52ghQtV/o6//Oj/6dHyo41y0fP30idXqEmZvIXnAVRL
         eeT373yzj9MqxCYJXqzw81++ND9ZGNWwOsCo3vviuEm9bRLEseNtUgH9iE/41SNyE+
         zgrTHPVNlzOrBVdb+gxTrUGHKnLrrLkw7Vau40j8=
Subject: Re: [PATCH] f2fs: relocate f2fs_sanity_check_ckpt() and make it
 static
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20180726105411.115343-1-yuchao0@huawei.com>
 <20180727102516.GH16155@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <3e2587dc-b060-5d95-8fe8-74f7831eba44@kernel.org>
Date:   Fri, 27 Jul 2018 20:08:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180727102516.GH16155@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

On 2018/7/27 18:25, Jaegeuk Kim wrote:
> Hi Chao,
> 
> I don't see any reason to do this at all.

Hmm.. f2fs_sanity_check_ckpt() is not used in super.c and there-in code logic is
not related to super.c too, instead, it is all related to checkpoint.c.

So I just want to unify maintaining checkpoint related functions, it may make
code more clean.

Anyway, it's trivial cleanup, please ignore this patch if you don't want to do
such relocation.

Thanks,

> 
> Thanks,
> 
> On 07/26, Chao Yu wrote:
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/checkpoint.c | 93 +++++++++++++++++++++++++++++++++++++++++++-
>>  fs/f2fs/f2fs.h       |  1 -
>>  fs/f2fs/super.c      | 91 -------------------------------------------
>>  3 files changed, 92 insertions(+), 93 deletions(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index e010fecce097..7d16cb36be47 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -833,6 +833,97 @@ static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
>>  	return NULL;
>>  }
>>  
>> +static int sanity_check_ckpt(struct f2fs_sb_info *sbi)
>> +{
>> +	unsigned int total, fsmeta;
>> +	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
>> +	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
>> +	unsigned int ovp_segments, reserved_segments;
>> +	unsigned int main_segs, blocks_per_seg;
>> +	unsigned int sit_segs, nat_segs;
>> +	unsigned int sit_bitmap_size, nat_bitmap_size;
>> +	unsigned int log_blocks_per_seg;
>> +	unsigned int user_block_count;
>> +	unsigned int segment_count_main;
>> +	unsigned int cp_pack_start_sum, cp_blkaddr, cp_payload;
>> +	int i;
>> +
>> +	total = le32_to_cpu(raw_super->segment_count);
>> +	fsmeta = le32_to_cpu(raw_super->segment_count_ckpt);
>> +	sit_segs = le32_to_cpu(raw_super->segment_count_sit);
>> +	fsmeta += sit_segs;
>> +	nat_segs = le32_to_cpu(raw_super->segment_count_nat);
>> +	fsmeta += nat_segs;
>> +	fsmeta += le32_to_cpu(ckpt->rsvd_segment_count);
>> +	fsmeta += le32_to_cpu(raw_super->segment_count_ssa);
>> +
>> +	if (unlikely(fsmeta >= total))
>> +		return 1;
>> +
>> +	ovp_segments = le32_to_cpu(ckpt->overprov_segment_count);
>> +	reserved_segments = le32_to_cpu(ckpt->rsvd_segment_count);
>> +
>> +	if (unlikely(fsmeta < F2FS_MIN_SEGMENTS ||
>> +			ovp_segments == 0 || reserved_segments == 0)) {
>> +		f2fs_msg(sbi->sb, KERN_ERR,
>> +			"Wrong layout: check mkfs.f2fs version");
>> +		return 1;
>> +	}
>> +
>> +	user_block_count = le32_to_cpu(ckpt->user_block_count);
>> +	segment_count_main = le32_to_cpu(raw_super->segment_count_main);
>> +	log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
>> +	if (!user_block_count || user_block_count >=
>> +			segment_count_main << log_blocks_per_seg) {
>> +		f2fs_msg(sbi->sb, KERN_ERR,
>> +			"Wrong user_block_count: %u", user_block_count);
>> +		return 1;
>> +	}
>> +
>> +	main_segs = le32_to_cpu(raw_super->segment_count_main);
>> +	blocks_per_seg = sbi->blocks_per_seg;
>> +
>> +	for (i = 0; i < NR_CURSEG_NODE_TYPE; i++) {
>> +		if (le32_to_cpu(ckpt->cur_node_segno[i]) >= main_segs ||
>> +			le16_to_cpu(ckpt->cur_node_blkoff[i]) >= blocks_per_seg)
>> +			return 1;
>> +	}
>> +	for (i = 0; i < NR_CURSEG_DATA_TYPE; i++) {
>> +		if (le32_to_cpu(ckpt->cur_data_segno[i]) >= main_segs ||
>> +			le16_to_cpu(ckpt->cur_data_blkoff[i]) >= blocks_per_seg)
>> +			return 1;
>> +	}
>> +
>> +	sit_bitmap_size = le32_to_cpu(ckpt->sit_ver_bitmap_bytesize);
>> +	nat_bitmap_size = le32_to_cpu(ckpt->nat_ver_bitmap_bytesize);
>> +
>> +	if (sit_bitmap_size != ((sit_segs / 2) << log_blocks_per_seg) / 8 ||
>> +		nat_bitmap_size != ((nat_segs / 2) << log_blocks_per_seg) / 8) {
>> +		f2fs_msg(sbi->sb, KERN_ERR,
>> +			"Wrong bitmap size: sit: %u, nat:%u",
>> +			sit_bitmap_size, nat_bitmap_size);
>> +		return 1;
>> +	}
>> +
>> +	cp_pack_start_sum = __start_sum_addr(sbi);
>> +	cp_blkaddr = __start_cp_addr(sbi);
>> +	cp_payload = __cp_payload(sbi);
>> +	if (cp_pack_start_sum < cp_payload + 1 ||
>> +		cp_pack_start_sum > blocks_per_seg - 1 -
>> +			NR_CURSEG_TYPE) {
>> +		f2fs_msg(sbi->sb, KERN_ERR,
>> +			"Wrong cp_pack_start_sum: %u",
>> +			cp_pack_start_sum);
>> +		return 1;
>> +	}
>> +
>> +	if (unlikely(f2fs_cp_error(sbi))) {
>> +		f2fs_msg(sbi->sb, KERN_ERR, "A bug case: need to run fsck");
>> +		return 1;
>> +	}
>> +	return 0;
>> +}
>> +
>>  int f2fs_get_valid_checkpoint(struct f2fs_sb_info *sbi)
>>  {
>>  	struct f2fs_checkpoint *cp_block;
>> @@ -883,7 +974,7 @@ int f2fs_get_valid_checkpoint(struct f2fs_sb_info *sbi)
>>  		sbi->cur_cp_pack = 2;
>>  
>>  	/* Sanity checking of checkpoint */
>> -	if (f2fs_sanity_check_ckpt(sbi))
>> +	if (sanity_check_ckpt(sbi))
>>  		goto free_fail_no_cp;
>>  
>>  	if (cp_blks <= 1)
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index adee43288593..fa5d0ebf8998 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -2817,7 +2817,6 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
>>  int f2fs_sync_fs(struct super_block *sb, int sync);
>>  extern __printf(3, 4)
>>  void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...);
>> -int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi);
>>  
>>  /*
>>   * hash.c
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 622acaab46b2..0eb5c9b659f7 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -2295,97 +2295,6 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>>  	return 0;
>>  }
>>  
>> -int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
>> -{
>> -	unsigned int total, fsmeta;
>> -	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
>> -	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
>> -	unsigned int ovp_segments, reserved_segments;
>> -	unsigned int main_segs, blocks_per_seg;
>> -	unsigned int sit_segs, nat_segs;
>> -	unsigned int sit_bitmap_size, nat_bitmap_size;
>> -	unsigned int log_blocks_per_seg;
>> -	unsigned int user_block_count;
>> -	unsigned int segment_count_main;
>> -	unsigned int cp_pack_start_sum, cp_blkaddr, cp_payload;
>> -	int i;
>> -
>> -	total = le32_to_cpu(raw_super->segment_count);
>> -	fsmeta = le32_to_cpu(raw_super->segment_count_ckpt);
>> -	sit_segs = le32_to_cpu(raw_super->segment_count_sit);
>> -	fsmeta += sit_segs;
>> -	nat_segs = le32_to_cpu(raw_super->segment_count_nat);
>> -	fsmeta += nat_segs;
>> -	fsmeta += le32_to_cpu(ckpt->rsvd_segment_count);
>> -	fsmeta += le32_to_cpu(raw_super->segment_count_ssa);
>> -
>> -	if (unlikely(fsmeta >= total))
>> -		return 1;
>> -
>> -	ovp_segments = le32_to_cpu(ckpt->overprov_segment_count);
>> -	reserved_segments = le32_to_cpu(ckpt->rsvd_segment_count);
>> -
>> -	if (unlikely(fsmeta < F2FS_MIN_SEGMENTS ||
>> -			ovp_segments == 0 || reserved_segments == 0)) {
>> -		f2fs_msg(sbi->sb, KERN_ERR,
>> -			"Wrong layout: check mkfs.f2fs version");
>> -		return 1;
>> -	}
>> -
>> -	user_block_count = le32_to_cpu(ckpt->user_block_count);
>> -	segment_count_main = le32_to_cpu(raw_super->segment_count_main);
>> -	log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
>> -	if (!user_block_count || user_block_count >=
>> -			segment_count_main << log_blocks_per_seg) {
>> -		f2fs_msg(sbi->sb, KERN_ERR,
>> -			"Wrong user_block_count: %u", user_block_count);
>> -		return 1;
>> -	}
>> -
>> -	main_segs = le32_to_cpu(raw_super->segment_count_main);
>> -	blocks_per_seg = sbi->blocks_per_seg;
>> -
>> -	for (i = 0; i < NR_CURSEG_NODE_TYPE; i++) {
>> -		if (le32_to_cpu(ckpt->cur_node_segno[i]) >= main_segs ||
>> -			le16_to_cpu(ckpt->cur_node_blkoff[i]) >= blocks_per_seg)
>> -			return 1;
>> -	}
>> -	for (i = 0; i < NR_CURSEG_DATA_TYPE; i++) {
>> -		if (le32_to_cpu(ckpt->cur_data_segno[i]) >= main_segs ||
>> -			le16_to_cpu(ckpt->cur_data_blkoff[i]) >= blocks_per_seg)
>> -			return 1;
>> -	}
>> -
>> -	sit_bitmap_size = le32_to_cpu(ckpt->sit_ver_bitmap_bytesize);
>> -	nat_bitmap_size = le32_to_cpu(ckpt->nat_ver_bitmap_bytesize);
>> -
>> -	if (sit_bitmap_size != ((sit_segs / 2) << log_blocks_per_seg) / 8 ||
>> -		nat_bitmap_size != ((nat_segs / 2) << log_blocks_per_seg) / 8) {
>> -		f2fs_msg(sbi->sb, KERN_ERR,
>> -			"Wrong bitmap size: sit: %u, nat:%u",
>> -			sit_bitmap_size, nat_bitmap_size);
>> -		return 1;
>> -	}
>> -
>> -	cp_pack_start_sum = __start_sum_addr(sbi);
>> -	cp_blkaddr = __start_cp_addr(sbi);
>> -	cp_payload = __cp_payload(sbi);
>> -	if (cp_pack_start_sum < cp_payload + 1 ||
>> -		cp_pack_start_sum > blocks_per_seg - 1 -
>> -			NR_CURSEG_TYPE) {
>> -		f2fs_msg(sbi->sb, KERN_ERR,
>> -			"Wrong cp_pack_start_sum: %u",
>> -			cp_pack_start_sum);
>> -		return 1;
>> -	}
>> -
>> -	if (unlikely(f2fs_cp_error(sbi))) {
>> -		f2fs_msg(sbi->sb, KERN_ERR, "A bug case: need to run fsck");
>> -		return 1;
>> -	}
>> -	return 0;
>> -}
>> -
>>  static void init_sb_info(struct f2fs_sb_info *sbi)
>>  {
>>  	struct f2fs_super_block *raw_super = sbi->raw_super;
>> -- 
>> 2.18.0.rc1
