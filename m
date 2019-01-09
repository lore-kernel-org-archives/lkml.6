Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7E8C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF9B206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547052303;
	bh=dVNlzxR9FWgvgQ8Ubw8O9XzlHawwmox4jWa1UgGb1QM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mVQdTvLSPmcIw9hHCTOmzrA3MenV5gyD/NgeYdtThcSRqqc0BiV35ZixRQf/Ve7wW
	 yadtoDsIFftyV31IVuSGXDTj9WYDjB6xvNYcOb05+it7XS3HXDzvxB3ni8bqgpa/dZ
	 c9isZqma79F2l38EBy4IuDvTup6CaqJs37VrFd68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfAIQpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:45:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:47586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfAIQo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:44:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31430206BB;
        Wed,  9 Jan 2019 16:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547052298;
        bh=dVNlzxR9FWgvgQ8Ubw8O9XzlHawwmox4jWa1UgGb1QM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zpdu0335Drk6tintVlNXmlbUxylHZRMQivqMwTNj9Rd65R8R9bn8wrRuRz9UlwqVZ
         Bj3zPNyxPtg4VwFYZQUpjuRps3jJcedPljK1spVn5Lsr8QhEEWovczyburQd8SdRmL
         FQRNEzvU4H3Ep3NzjwYulDily+ZW/c4UN+acSIzg=
Date:   Wed, 9 Jan 2019 17:44:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: Re: [PATCH 4.20 079/145] ext4: check for shutdown and r/o file
 system in ext4_write_inode()
Message-ID: <20190109164455.GA3486@kroah.com>
References: <20190107104437.308206189@linuxfoundation.org>
 <20190107104447.599996662@linuxfoundation.org>
 <20190107215606.GH166797@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107215606.GH166797@sasha-vm>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 04:56:06PM -0500, Sasha Levin wrote:
> On Mon, Jan 07, 2019 at 01:31:56PM +0100, Greg Kroah-Hartman wrote:
> > 4.20-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Theodore Ts'o <tytso@mit.edu>
> > 
> > commit 18f2c4fcebf2582f96cbd5f2238f4f354a0e4847 upstream.
> > 
> > If the file system has been shut down or is read-only, then
> > ext4_write_inode() needs to bail out early.
> > 
> > Also use jbd2_complete_transaction() instead of ext4_force_commit() so
> > we only force a commit if it is needed.
> > 
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > Cc: stable@kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > ---
> > fs/ext4/inode.c |    9 +++++++--
> > 1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -5400,9 +5400,13 @@ int ext4_write_inode(struct inode *inode
> > {
> > 	int err;
> > 
> > -	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC))
> > +	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC) ||
> > +	    sb_rdonly(inode->i_sb))
> > 		return 0;
> > 
> > +	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
> > +		return -EIO;
> > +
> > 	if (EXT4_SB(inode->i_sb)->s_journal) {
> > 		if (ext4_journal_current_handle()) {
> > 			jbd_debug(1, "called recursively, non-PF_MEMALLOC!\n");
> > @@ -5418,7 +5422,8 @@ int ext4_write_inode(struct inode *inode
> > 		if (wbc->sync_mode != WB_SYNC_ALL || wbc->for_sync)
> > 			return 0;
> > 
> > -		err = ext4_force_commit(inode->i_sb);
> > +		err = jbd2_complete_transaction(EXT4_SB(inode->i_sb)->s_journal,
> > +						EXT4_I(inode)->i_sync_tid);
> > 	} else {
> > 		struct ext4_iloc iloc;
> 
> Hi Ted,
> 
> I'm not sure if this patch is the culprit or no, but testing with
> xfstests on 4.20.1-rc1 started failing generic/390 with:
> 
> [ 3405.656893] run fstests generic/390 at 2019-01-07 20:26:55
> [ 3406.524380] EXT4-fs (nvme0n1p2): mounted filesystem without journal. Opts: acl,user_xattr
> [ 3406.731410] WARNING: CPU: 0 PID: 93128 at fs/ext4/ext4_jbd2.c:53 ext4_journal_check_start+0x121/0x190
> [ 3406.731418] CPU: 0 PID: 93128 Comm: fsstress Tainted: G    B   W         4.20.1-rc1+ #1
> [ 3406.731420] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090007  05/18/2018
> [ 3406.731425] RIP: 0010:ext4_journal_check_start+0x121/0x190
> [ 3406.731430] Code: 4d 85 e4 74 1e 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 4f 41 f6 04 24 02 75 0b 31 c0 5b 41 5c 5d c3 <0f> 0b eb ab 48 c7 c1 60 b4 f9 a4 ba 3d 00 00 00 48 c7 c6 a0 b8 f9
> [ 3406.731432] RSP: 0018:ffff888f30317648 EFLAGS: 00010246
> [ 3406.731437] RAX: 0000000000000000 RBX: ffff888ee6ce12c8 RCX: 000000000000000c
> [ 3406.731440] RDX: 1ffff111dcd9c2a0 RSI: 0000000000000b33 RDI: ffff888ee6ce1500
> [ 3406.731442] RBP: ffff888f30317658 R08: 0000000000000000 R09: ffffed11db5f01a7
> [ 3406.731444] R10: 0000000000000001 R11: ffffed11db5f01a6 R12: ffff888ee6ce2ee8
> [ 3406.731447] R13: dffffc0000000000 R14: 0000000000000000 R15: ffff888f303178e0
> [ 3406.731450] FS:  00007fc015d5cb80(0000) GS:ffff888f6b800000(0000) knlGS:0000000000000000
> [ 3406.731452] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3406.731455] CR2: 0000557f34651000 CR3: 0000000f2c722000 CR4: 00000000003406f0
> [ 3406.731459] Call Trace:
> [ 3406.731465]  __ext4_journal_start_sb+0x95/0x380
> [ 3406.731479]  ext4_writepages+0x10e1/0x3170
> [ 3406.731567]  do_writepages+0xc7/0x120
> [ 3406.731577]  __filemap_fdatawrite_range+0x313/0x470
> [ 3406.731594]  file_write_and_wait_range+0x7c/0xd0
> [ 3406.731598]  __generic_file_fsync+0x6c/0x180
> [ 3406.731601]  ext4_sync_file+0x60b/0xf90
> [ 3406.731626]  vfs_fsync_range+0xf5/0x210
> [ 3406.731630]  do_fsync+0x3d/0x70
> [ 3406.731634]  __x64_sys_fdatasync+0x36/0x50
> [ 3406.731638]  do_syscall_64+0x153/0x460
> [ 3406.731666]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 3406.731669] RIP: 0033:0x7fc0152412c4
> [ 3406.731673] Code: 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8d 05 41 96 2d 00 8b 00 85 c0 75 13 b8 4b 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 3c f3 c3 66 90 53 89 fb 48 83 ec 10 e8 04 94
> [ 3406.731675] RSP: 002b:00007ffc445f72f8 EFLAGS: 00000246 ORIG_RAX: 000000000000004b
> [ 3406.731679] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fc0152412c4
> [ 3406.731681] RDX: 00007ffc445f7250 RSI: 00007ffc445f7250 RDI: 0000000000000003
> [ 3406.731683] RBP: 0000000000000034 R08: 00007fc015515c40 R09: 0000000000000000
> [ 3406.731685] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000001f4
> [ 3406.731687] R13: 0000000051eb851f R14: 00007ffc445f73f6 R15: 0000557f33ad1930
> [ 3406.731690] ---[ end trace 698eba2a0467d312 ]---
> 
> I'm also slightly confused here because this test is for ext4 without
> journal (see even "EXT4-fs (nvme0n1p2): mounted filesystem without
> journal") but for some reason it seems that this still goes to the
> journal?
> 

Does this also fail on 4.19?  The same patch is here and in 4.14 as
well.

thanks,

greg k-h
