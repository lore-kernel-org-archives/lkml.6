Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A588C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DAB208A1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVTIZ5rk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DAB208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbeG0Lqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:46:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730244AbeG0Lqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:46:35 -0400
Received: from localhost (unknown [119.197.233.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9D02208A0;
        Fri, 27 Jul 2018 10:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532687119;
        bh=xP7A9oU9KgH/BlG11dVIYx94e6UlX9x9h2sKX2tdxZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jVTIZ5rkb3/VsQv/PmD3b7gebOBYaEEcUOF9rlac6nVoZmGNPff9OCRNzt++FacQf
         EimouO7DDmNbTtB35MvUHYS6pUV1yHUK0iVnVS578Xun3aFFTIep3zlwfpEQsGY1IM
         cpTMOMaNIvvRvtCT2Ar/D03A6C0Pp13pUyRn3rsc=
Date:   Fri, 27 Jul 2018 19:25:16 +0900
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: relocate f2fs_sanity_check_ckpt() and make it
 static
Message-ID: <20180727102516.GH16155@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180726105411.115343-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726105411.115343-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

I don't see any reason to do this at all.

Thanks,

On 07/26, Chao Yu wrote:
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/checkpoint.c | 93 +++++++++++++++++++++++++++++++++++++++++++-
>  fs/f2fs/f2fs.h       |  1 -
>  fs/f2fs/super.c      | 91 -------------------------------------------
>  3 files changed, 92 insertions(+), 93 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index e010fecce097..7d16cb36be47 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -833,6 +833,97 @@ static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
>  	return NULL;
>  }
>  
> +static int sanity_check_ckpt(struct f2fs_sb_info *sbi)
> +{
> +	unsigned int total, fsmeta;
> +	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
> +	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
> +	unsigned int ovp_segments, reserved_segments;
> +	unsigned int main_segs, blocks_per_seg;
> +	unsigned int sit_segs, nat_segs;
> +	unsigned int sit_bitmap_size, nat_bitmap_size;
> +	unsigned int log_blocks_per_seg;
> +	unsigned int user_block_count;
> +	unsigned int segment_count_main;
> +	unsigned int cp_pack_start_sum, cp_blkaddr, cp_payload;
> +	int i;
> +
> +	total = le32_to_cpu(raw_super->segment_count);
> +	fsmeta = le32_to_cpu(raw_super->segment_count_ckpt);
> +	sit_segs = le32_to_cpu(raw_super->segment_count_sit);
> +	fsmeta += sit_segs;
> +	nat_segs = le32_to_cpu(raw_super->segment_count_nat);
> +	fsmeta += nat_segs;
> +	fsmeta += le32_to_cpu(ckpt->rsvd_segment_count);
> +	fsmeta += le32_to_cpu(raw_super->segment_count_ssa);
> +
> +	if (unlikely(fsmeta >= total))
> +		return 1;
> +
> +	ovp_segments = le32_to_cpu(ckpt->overprov_segment_count);
> +	reserved_segments = le32_to_cpu(ckpt->rsvd_segment_count);
> +
> +	if (unlikely(fsmeta < F2FS_MIN_SEGMENTS ||
> +			ovp_segments == 0 || reserved_segments == 0)) {
> +		f2fs_msg(sbi->sb, KERN_ERR,
> +			"Wrong layout: check mkfs.f2fs version");
> +		return 1;
> +	}
> +
> +	user_block_count = le32_to_cpu(ckpt->user_block_count);
> +	segment_count_main = le32_to_cpu(raw_super->segment_count_main);
> +	log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
> +	if (!user_block_count || user_block_count >=
> +			segment_count_main << log_blocks_per_seg) {
> +		f2fs_msg(sbi->sb, KERN_ERR,
> +			"Wrong user_block_count: %u", user_block_count);
> +		return 1;
> +	}
> +
> +	main_segs = le32_to_cpu(raw_super->segment_count_main);
> +	blocks_per_seg = sbi->blocks_per_seg;
> +
> +	for (i = 0; i < NR_CURSEG_NODE_TYPE; i++) {
> +		if (le32_to_cpu(ckpt->cur_node_segno[i]) >= main_segs ||
> +			le16_to_cpu(ckpt->cur_node_blkoff[i]) >= blocks_per_seg)
> +			return 1;
> +	}
> +	for (i = 0; i < NR_CURSEG_DATA_TYPE; i++) {
> +		if (le32_to_cpu(ckpt->cur_data_segno[i]) >= main_segs ||
> +			le16_to_cpu(ckpt->cur_data_blkoff[i]) >= blocks_per_seg)
> +			return 1;
> +	}
> +
> +	sit_bitmap_size = le32_to_cpu(ckpt->sit_ver_bitmap_bytesize);
> +	nat_bitmap_size = le32_to_cpu(ckpt->nat_ver_bitmap_bytesize);
> +
> +	if (sit_bitmap_size != ((sit_segs / 2) << log_blocks_per_seg) / 8 ||
> +		nat_bitmap_size != ((nat_segs / 2) << log_blocks_per_seg) / 8) {
> +		f2fs_msg(sbi->sb, KERN_ERR,
> +			"Wrong bitmap size: sit: %u, nat:%u",
> +			sit_bitmap_size, nat_bitmap_size);
> +		return 1;
> +	}
> +
> +	cp_pack_start_sum = __start_sum_addr(sbi);
> +	cp_blkaddr = __start_cp_addr(sbi);
> +	cp_payload = __cp_payload(sbi);
> +	if (cp_pack_start_sum < cp_payload + 1 ||
> +		cp_pack_start_sum > blocks_per_seg - 1 -
> +			NR_CURSEG_TYPE) {
> +		f2fs_msg(sbi->sb, KERN_ERR,
> +			"Wrong cp_pack_start_sum: %u",
> +			cp_pack_start_sum);
> +		return 1;
> +	}
> +
> +	if (unlikely(f2fs_cp_error(sbi))) {
> +		f2fs_msg(sbi->sb, KERN_ERR, "A bug case: need to run fsck");
> +		return 1;
> +	}
> +	return 0;
> +}
> +
>  int f2fs_get_valid_checkpoint(struct f2fs_sb_info *sbi)
>  {
>  	struct f2fs_checkpoint *cp_block;
> @@ -883,7 +974,7 @@ int f2fs_get_valid_checkpoint(struct f2fs_sb_info *sbi)
>  		sbi->cur_cp_pack = 2;
>  
>  	/* Sanity checking of checkpoint */
> -	if (f2fs_sanity_check_ckpt(sbi))
> +	if (sanity_check_ckpt(sbi))
>  		goto free_fail_no_cp;
>  
>  	if (cp_blks <= 1)
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index adee43288593..fa5d0ebf8998 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2817,7 +2817,6 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
>  int f2fs_sync_fs(struct super_block *sb, int sync);
>  extern __printf(3, 4)
>  void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...);
> -int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi);
>  
>  /*
>   * hash.c
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 622acaab46b2..0eb5c9b659f7 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2295,97 +2295,6 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>  	return 0;
>  }
>  
> -int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
> -{
> -	unsigned int total, fsmeta;
> -	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
> -	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
> -	unsigned int ovp_segments, reserved_segments;
> -	unsigned int main_segs, blocks_per_seg;
> -	unsigned int sit_segs, nat_segs;
> -	unsigned int sit_bitmap_size, nat_bitmap_size;
> -	unsigned int log_blocks_per_seg;
> -	unsigned int user_block_count;
> -	unsigned int segment_count_main;
> -	unsigned int cp_pack_start_sum, cp_blkaddr, cp_payload;
> -	int i;
> -
> -	total = le32_to_cpu(raw_super->segment_count);
> -	fsmeta = le32_to_cpu(raw_super->segment_count_ckpt);
> -	sit_segs = le32_to_cpu(raw_super->segment_count_sit);
> -	fsmeta += sit_segs;
> -	nat_segs = le32_to_cpu(raw_super->segment_count_nat);
> -	fsmeta += nat_segs;
> -	fsmeta += le32_to_cpu(ckpt->rsvd_segment_count);
> -	fsmeta += le32_to_cpu(raw_super->segment_count_ssa);
> -
> -	if (unlikely(fsmeta >= total))
> -		return 1;
> -
> -	ovp_segments = le32_to_cpu(ckpt->overprov_segment_count);
> -	reserved_segments = le32_to_cpu(ckpt->rsvd_segment_count);
> -
> -	if (unlikely(fsmeta < F2FS_MIN_SEGMENTS ||
> -			ovp_segments == 0 || reserved_segments == 0)) {
> -		f2fs_msg(sbi->sb, KERN_ERR,
> -			"Wrong layout: check mkfs.f2fs version");
> -		return 1;
> -	}
> -
> -	user_block_count = le32_to_cpu(ckpt->user_block_count);
> -	segment_count_main = le32_to_cpu(raw_super->segment_count_main);
> -	log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
> -	if (!user_block_count || user_block_count >=
> -			segment_count_main << log_blocks_per_seg) {
> -		f2fs_msg(sbi->sb, KERN_ERR,
> -			"Wrong user_block_count: %u", user_block_count);
> -		return 1;
> -	}
> -
> -	main_segs = le32_to_cpu(raw_super->segment_count_main);
> -	blocks_per_seg = sbi->blocks_per_seg;
> -
> -	for (i = 0; i < NR_CURSEG_NODE_TYPE; i++) {
> -		if (le32_to_cpu(ckpt->cur_node_segno[i]) >= main_segs ||
> -			le16_to_cpu(ckpt->cur_node_blkoff[i]) >= blocks_per_seg)
> -			return 1;
> -	}
> -	for (i = 0; i < NR_CURSEG_DATA_TYPE; i++) {
> -		if (le32_to_cpu(ckpt->cur_data_segno[i]) >= main_segs ||
> -			le16_to_cpu(ckpt->cur_data_blkoff[i]) >= blocks_per_seg)
> -			return 1;
> -	}
> -
> -	sit_bitmap_size = le32_to_cpu(ckpt->sit_ver_bitmap_bytesize);
> -	nat_bitmap_size = le32_to_cpu(ckpt->nat_ver_bitmap_bytesize);
> -
> -	if (sit_bitmap_size != ((sit_segs / 2) << log_blocks_per_seg) / 8 ||
> -		nat_bitmap_size != ((nat_segs / 2) << log_blocks_per_seg) / 8) {
> -		f2fs_msg(sbi->sb, KERN_ERR,
> -			"Wrong bitmap size: sit: %u, nat:%u",
> -			sit_bitmap_size, nat_bitmap_size);
> -		return 1;
> -	}
> -
> -	cp_pack_start_sum = __start_sum_addr(sbi);
> -	cp_blkaddr = __start_cp_addr(sbi);
> -	cp_payload = __cp_payload(sbi);
> -	if (cp_pack_start_sum < cp_payload + 1 ||
> -		cp_pack_start_sum > blocks_per_seg - 1 -
> -			NR_CURSEG_TYPE) {
> -		f2fs_msg(sbi->sb, KERN_ERR,
> -			"Wrong cp_pack_start_sum: %u",
> -			cp_pack_start_sum);
> -		return 1;
> -	}
> -
> -	if (unlikely(f2fs_cp_error(sbi))) {
> -		f2fs_msg(sbi->sb, KERN_ERR, "A bug case: need to run fsck");
> -		return 1;
> -	}
> -	return 0;
> -}
> -
>  static void init_sb_info(struct f2fs_sb_info *sbi)
>  {
>  	struct f2fs_super_block *raw_super = sbi->raw_super;
> -- 
> 2.18.0.rc1
