Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9A5C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854E82089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLVoAz1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854E82089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933287AbeGIPE6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:04:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932903AbeGIPE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:04:57 -0400
Received: from [192.168.0.101] (unknown [49.77.238.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF7E720863;
        Mon,  9 Jul 2018 15:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531148696;
        bh=iBuFvf4D7QWhNIHsX2TrMNq9/sfr+UhWI+hm7I8Zir4=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=qLVoAz1WPAIOfMCmLy1+VBYTDHmuDCWpu6gL+6LKAvleMGSM58QsHMUouTvacjuVC
         DQ4hkcUzqwidwErxtlz+diCpgW1bTtyqA3wbBRrbB1PgvZwnUmrn9jNkJ1VKDu9Vq0
         9PJBRiwoboUHeXyG6ZYaj1oxL3ty+oNZZyH1QpCk=
Subject: Re: [f2fs-dev] [PATCH] f2fs: do checkpoint in kill_sb
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20180707012020.4708-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <0cb1e0fd-1fb4-ba69-6c70-e05e991a243a@kernel.org>
Date:   Mon, 9 Jul 2018 23:04:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180707012020.4708-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/7 9:20, Jaegeuk Kim wrote:
> When unmounting f2fs in force mode, we can get it stuck by io_schedule()

force mode means force shutdown?

> by some pending IOs in meta_inode.
> 
> io_schedule+0xd/0x30
> wait_on_page_bit_common+0xc6/0x130

Looks like a deadlock here? Does this mean we forget to submit cached bio in
somewhere?

Thanks,

> __filemap_fdatawait_range+0xbd/0x100
> filemap_fdatawait_keep_errors+0x15/0x40
> sync_inodes_sb+0x1cf/0x240
> sync_filesystem+0x52/0x90
> generic_shutdown_super+0x1d/0x110
> ceph_kill_sb+0x28/0x80 [ceph]
> deactivate_locked_super+0x35/0x60
> cleanup_mnt+0x36/0x70
> task_work_run+0x79/0xa0
> exit_to_usermode_loop+0x62/0x70
> do_syscall_64+0xdb/0xf0
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 0xffffffffffffffff
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/super.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 3995e926ba3a..1dc6809fac38 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3089,9 +3089,19 @@ static struct dentry *f2fs_mount(struct file_system_type *fs_type, int flags,
>  static void kill_f2fs_super(struct super_block *sb)
>  {
>  	if (sb->s_root) {
> -		set_sbi_flag(F2FS_SB(sb), SBI_IS_CLOSE);
> -		f2fs_stop_gc_thread(F2FS_SB(sb));
> -		f2fs_stop_discard_thread(F2FS_SB(sb));
> +		struct f2fs_sb_info *sbi = F2FS_SB(sb);
> +
> +		set_sbi_flag(sbi, SBI_IS_CLOSE);
> +		f2fs_stop_gc_thread(sbi);
> +		f2fs_stop_discard_thread(sbi);
> +
> +		if (is_sbi_flag_set(sbi, SBI_IS_DIRTY) ||
> +				!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
> +			struct cp_control cpc = {
> +				.reason = CP_UMOUNT,
> +			};
> +			f2fs_write_checkpoint(sbi, &cpc);
> +		}
>  	}
>  	kill_block_super(sb);
>  }
> 
