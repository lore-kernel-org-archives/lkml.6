Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9AFECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF4B2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="lm5/UU5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF4B2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387615AbeGLXUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 19:20:20 -0400
Received: from imap.thunk.org ([74.207.234.97]:36784 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733209AbeGLXUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 19:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=yOIL+9IsP/4zAVFUwwD0UX/lBiOJQN0rRGB2wSH3kKY=; b=lm5/UU5V5lSA5hn/fbFW0+fezh
        54lVWe95bfALvUacxU9YUdbKaOnFQBTr3HZf5LOhN22rc3EVaK3HgNAf77oiQhoRAU1nYNzcGe6e6
        u/yOl97zZ+M9u+ZVu4zNexyWjmp9XE6yM2x8k3FxiV085TZP2mFCPz1hfysylMKDmBGM=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fdkhI-0006Fz-A1; Thu, 12 Jul 2018 23:08:28 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 002327A55D2; Thu, 12 Jul 2018 19:08:26 -0400 (EDT)
Date:   Thu, 12 Jul 2018 19:08:26 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ike Panhc <ike.pan@canonical.com>
Cc:     dann frazier <dann.frazier@canonical.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanaijie@huawei.com, colin.king@canonical.com,
        kamal.mostafa@canonical.com
Subject: Re: [Bisect] ext4_validate_inode_bitmap:98: comm stress-ng: Corrupt
 inode bitmap
Message-ID: <20180712230826.GB28610@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ike Panhc <ike.pan@canonical.com>,
        dann frazier <dann.frazier@canonical.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanaijie@huawei.com, colin.king@canonical.com,
        kamal.mostafa@canonical.com
References: <20180706174324.GA3049@xps13.dannf>
 <20180707041018.GB3546@thunk.org>
 <20180710165143.GA20459@xps13.dannf>
 <20180710204329.GB20459@xps13.dannf>
 <b39169ad-2237-0a4f-e3d1-afc51ac10fa5@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b39169ad-2237-0a4f-e3d1-afc51ac10fa5@canonical.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Review console log and on each run I have filesystem rebuild. The problem
> is that mke2fs I am using is 1.44.3-rc2. I am now reseting the environment
> and re-test.
>

Could it be that you saw the error in ext4_validate_block_bitmap()?
The patch which I sent Dann only fixed the problem for inode bitmaps;
I noticed today that we need to fix it for block allocation bitmaps as
well.

						- Ted

commit 8d5a803c6a6ce4ec258e31f76059ea5153ba46ef
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Thu Jul 12 19:08:05 2018 -0400

    ext4: check for allocation block validity with block group locked
    
    With commit 044e6e3d74a3: "ext4: don't update checksum of new
    initialized bitmaps" the buffer valid bit will get set without
    actually setting up the checksum for the allocation bitmap, since the
    checksum will get calculated once we actually allocate an inode or
    block.
    
    If we are doing this, then we need to (re-)check the verified bit
    after we take the block group lock.  Otherwise, we could race with
    another process reading and verifying the bitmap, which would then
    complain about the checksum being invalid.
    
    https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1780137
    
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>
    Cc: stable@kernel.org

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index e68cefe08261..aa52d87985aa 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -368,6 +368,8 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
 		return -EFSCORRUPTED;
 
 	ext4_lock_group(sb, block_group);
+	if (buffer_verified(bh))
+		goto verified;
 	if (unlikely(!ext4_block_bitmap_csum_verify(sb, block_group,
 			desc, bh))) {
 		ext4_unlock_group(sb, block_group);
@@ -386,6 +388,7 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
 		return -EFSCORRUPTED;
 	}
 	set_buffer_verified(bh);
+verified:
 	ext4_unlock_group(sb, block_group);
 	return 0;
 }
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index fb83750c1a14..e9d8e2667ab5 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -90,6 +90,8 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
 		return -EFSCORRUPTED;
 
 	ext4_lock_group(sb, block_group);
+	if (buffer_verified(bh))
+		goto verified;
 	blk = ext4_inode_bitmap(sb, desc);
 	if (!ext4_inode_bitmap_csum_verify(sb, block_group, desc, bh,
 					   EXT4_INODES_PER_GROUP(sb) / 8)) {
@@ -101,6 +103,7 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
 		return -EFSBADCRC;
 	}
 	set_buffer_verified(bh);
+verified:
 	ext4_unlock_group(sb, block_group);
 	return 0;
 }
