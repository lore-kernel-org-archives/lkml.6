Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4868FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0407208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="loems+9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0407208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387520AbeHAUpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732210AbeHAUpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:45:23 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16E8E20844;
        Wed,  1 Aug 2018 18:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533149892;
        bh=OvEoAibnceyyuysUdAjHHf2PHj9DQpeUMJ/3VQe0zl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=loems+9GEKHQ7rzXhN6s6BTBptpodCVZCrKpbc89ZJuAN0Wc30Q8NNWXAZKNORk4D
         HHsnsG1cQtUu2HflN060JTofh3eZCB2Gtn0+urX0YmQMvMYFXid8yKHzUlsgyNHkvf
         9dKwlJpggUZM4S9xbb0AU//c+fKF1RyArB48onFs=
Date:   Wed, 1 Aug 2018 11:58:11 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix invalid memory access
Message-ID: <20180801185811.GA57086@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180801151642.2963-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801151642.2963-1-chao@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> syzbot found the following crash on:
> 
> HEAD commit:    d9bd94c0bcaa Add linux-next specific files for 20180801
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1001189c400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cc8964ea4d04518c
> dashboard link: https://syzkaller.appspot.com/bug?extid=c966a82db0b14aa37e81
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c966a82db0b14aa37e81@syzkaller.appspotmail.com
> 
> loop7: rw=12288, want=8200, limit=20
> netlink: 65342 bytes leftover after parsing attributes in process `syz-executor4'.
> openvswitch: netlink: Message has 8 unknown bytes.
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> CPU: 1 PID: 7615 Comm: syz-executor7 Not tainted 4.18.0-rc7-next-20180801+ #29
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
> RIP: 0010:compound_head include/linux/page-flags.h:142 [inline]
> RIP: 0010:PageLocked include/linux/page-flags.h:272 [inline]
> RIP: 0010:f2fs_put_page fs/f2fs/f2fs.h:2011 [inline]
> RIP: 0010:validate_checkpoint+0x66d/0xec0 fs/f2fs/checkpoint.c:835
> Code: e8 58 05 7f fe 4c 8d 6b 80 4d 8d 74 24 08 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 c6 04 02 00 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 f4 06 00 00 4c 89 ea 4d 8b 7c 24 08 48 b8 00 00
> RSP: 0018:ffff8801937cebe8 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffff8801937cef30 RCX: ffffc90006035000
> RDX: 0000000000000000 RSI: ffffffff82fd9658 RDI: 0000000000000005
> RBP: ffff8801937cef58 R08: ffff8801ab254700 R09: fffff94000d9e026
> R10: fffff94000d9e026 R11: ffffea0006cf0137 R12: fffffffffffffffb
> R13: ffff8801937ceeb0 R14: 0000000000000003 R15: ffff880193419b40
> FS:  00007f36a61d5700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fc04ff93000 CR3: 00000001d0562000 CR4: 00000000001426e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  f2fs_get_valid_checkpoint+0x436/0x1ec0 fs/f2fs/checkpoint.c:860
>  f2fs_fill_super+0x2d42/0x8110 fs/f2fs/super.c:2883
>  mount_bdev+0x314/0x3e0 fs/super.c:1344
>  f2fs_mount+0x3c/0x50 fs/f2fs/super.c:3133
>  legacy_get_tree+0x131/0x460 fs/fs_context.c:729
>  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1743
>  do_new_mount fs/namespace.c:2603 [inline]
>  do_mount+0x6f2/0x1e20 fs/namespace.c:2927
>  ksys_mount+0x12d/0x140 fs/namespace.c:3143
>  __do_sys_mount fs/namespace.c:3157 [inline]
>  __se_sys_mount fs/namespace.c:3154 [inline]
>  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3154
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x45943a
> Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 bd 8a fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 9a 8a fb ff c3 66 0f 1f 84 00 00 00 00 00
> RSP: 002b:00007f36a61d4a88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007f36a61d4b30 RCX: 000000000045943a
> RDX: 00007f36a61d4ad0 RSI: 0000000020000100 RDI: 00007f36a61d4af0
> RBP: 0000000020000100 R08: 00007f36a61d4b30 R09: 00007f36a61d4ad0
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000013
> R13: 0000000000000000 R14: 00000000004c8ea0 R15: 0000000000000000
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end trace bd8550c129352286 ]---
> RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
> RIP: 0010:compound_head include/linux/page-flags.h:142 [inline]
> RIP: 0010:PageLocked include/linux/page-flags.h:272 [inline]
> RIP: 0010:f2fs_put_page fs/f2fs/f2fs.h:2011 [inline]
> RIP: 0010:validate_checkpoint+0x66d/0xec0 fs/f2fs/checkpoint.c:835
> Code: e8 58 05 7f fe 4c 8d 6b 80 4d 8d 74 24 08 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 c6 04 02 00 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 f4 06 00 00 4c 89 ea 4d 8b 7c 24 08 48 b8 00 00
> RSP: 0018:ffff8801937cebe8 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffff8801937cef30 RCX: ffffc90006035000
> RDX: 0000000000000000 RSI: ffffffff82fd9658 RDI: 0000000000000005
> netlink: 65342 bytes leftover after parsing attributes in process `syz-executor4'.
> RBP: ffff8801937cef58 R08: ffff8801ab254700 R09: fffff94000d9e026
> openvswitch: netlink: Message has 8 unknown bytes.
> R10: fffff94000d9e026 R11: ffffea0006cf0137 R12: fffffffffffffffb
> R13: ffff8801937ceeb0 R14: 0000000000000003 R15: ffff880193419b40
> FS:  00007f36a61d5700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fc04ff93000 CR3: 00000001d0562000 CR4: 00000000001426e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> In validate_checkpoint(), if we failed to call get_checkpoint_version(), we
> will pass returned invalid page pointer into f2fs_put_page, cause accessing
> invalid memory, this patch tries to handle error path correctly to fix this
> issue.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/checkpoint.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 2cffc37e6c5b..861e61e08aa6 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -780,6 +780,7 @@ static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
>  
>  	crc_offset = le32_to_cpu((*cp_block)->checksum_offset);
>  	if (crc_offset > (blk_size - sizeof(__le32))) {
> +		f2fs_put_page(*cp_page, 1);
>  		f2fs_msg(sbi->sb, KERN_WARNING,
>  			"invalid crc_offset: %zu", crc_offset);
>  		return -EINVAL;
> @@ -787,6 +788,7 @@ static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
>  
>  	crc = cur_cp_crc(*cp_block);
>  	if (!f2fs_crc_valid(sbi, crc, *cp_block, crc_offset)) {
> +		f2fs_put_page(*cp_page, 1);
>  		f2fs_msg(sbi->sb, KERN_WARNING, "invalid crc value");
>  		return -EINVAL;
>  	}
> @@ -806,14 +808,14 @@ static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
>  	err = get_checkpoint_version(sbi, cp_addr, &cp_block,
>  					&cp_page_1, version);
>  	if (err)
> -		goto invalid_cp1;
> +		return NULL;
>  
>  	if (le32_to_cpu(cp_block->cp_pack_total_block_count) >
>  					sbi->log_blocks_per_seg) {
>  		f2fs_msg(sbi->sb, KERN_WARNING,
>  			"invalid cp_pack_total_block_count:%u",
>  			le32_to_cpu(cp_block->cp_pack_total_block_count));
> -		goto invalid_cp1;
> +		goto invalid_cp;
>  	}
>  	pre_version = *version;
>  
> @@ -821,7 +823,7 @@ static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
>  	err = get_checkpoint_version(sbi, cp_addr, &cp_block,
>  					&cp_page_2, version);
>  	if (err)
> -		goto invalid_cp2;
> +		goto invalid_cp;
>  	cur_version = *version;
>  
>  	if (cur_version == pre_version) {
> @@ -829,9 +831,7 @@ static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
>  		f2fs_put_page(cp_page_2, 1);
>  		return cp_page_1;
>  	}
> -invalid_cp2:
> -	f2fs_put_page(cp_page_2, 1);

	we need to put cp_page_2 above.

> -invalid_cp1:
> +invalid_cp:
>  	f2fs_put_page(cp_page_1, 1);
>  	return NULL;
>  }
> -- 
> 2.18.0
