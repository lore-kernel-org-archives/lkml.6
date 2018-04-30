Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrrx5dLuWpKNTgau3YtXLcBJK09EHt5lkdxKD1zSBe+N/WlSkHBopYylUCpO56RSjlWi9+n
ARC-Seal: i=1; a=rsa-sha256; t=1525116237; cv=none;
        d=google.com; s=arc-20160816;
        b=OpFLtBWsu3y8vk/SBBe4ZYnaAxAY1wRtQeHusRqgBb77p7fV53VLsj+OXWaaJXY6u1
         tL2WsIb6cyKKrfkp6uHkv66+dbY+tdsFigxdfn5pFV6hgSgoExd76Jnc0kWuAEAjMc/0
         /5kf4uuY3ldt/fAjru8hdVoiji9IxMVMjR0+07gW1mNuVShxSFVvrGkB82199YIOwpoY
         N1mhmxqHrhdubrPi32lSEh2RKm6XExOmW1htVGflWMqQCy0cTptM3fSsKMF1F1uMQTmq
         7RRAzJWNC7fxYVKNKV/O0fnzgn7UrczrGP7WBaMNoj0IHbJ6Ohb4xgXiYz0uls7QQKJR
         NCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=/KZuBvmDa72KQ5ID4N6xtMKGD2pfqQvS7FaBMWKWLhE=;
        b=sTvubuhKPU+q+bxEEDpVvj9O9MvqTns5Pwx3iptM2ChFl2HOYgknoxi2lgN+XKiCCw
         l5aBMWshPIfWx9ykxQ1UfUP88+FtrO6TKoDQxokNmkoDnZ44fHg2Fz2HjyhBthtSd/SS
         iwwe1vP9jFkUL3gx62xGgRJ/jgVA5D7Nrn2/+yoBNNMF4WxNSSvWR/SAJoATutmV9u1k
         bD4Z7ut0UylItU+Qy5dmLpM0hfEJBAbNa7jRNxWUZ98RGB39IDyPxaFb6xPu5rkf+1Nq
         oR9U8VlgyTKeZB/A7KmiisYy2xSdy2WA74J5hhyRucrlYLO6JGFVCGFIhonIV/FqPGze
         yDAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9DC22DA3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wen Xu <wen.xu@gatech.edu>,
	Theodore Tso <tytso@mit.edu>,
	Harsh Shandilya <harsh@prjkt.io>
Subject: [PATCH 3.18 02/25] ext4: add validity checks for bitmap block numbers
Date: Mon, 30 Apr 2018 12:23:09 -0700
Message-Id: <20180430183910.898507174@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183910.801976983@linuxfoundation.org>
References: <20180430183910.801976983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200284172323398?=
X-GMAIL-MSGID: =?utf-8?q?1599200284172323398?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 7dac4a1726a9c64a517d595c40e95e2d0d135f6f upstream.

An privileged attacker can cause a crash by mounting a crafted ext4
image which triggers a out-of-bounds read in the function
ext4_valid_block_bitmap() in fs/ext4/balloc.c.

This issue has been assigned CVE-2018-1093.

Backport notes:
3.18.y is missing commit 6a797d273783 ("ext4: call out CRC and corruption errors with specific error codes")
so the EFSCORRUPTED label doesn't exist. Replaced
all instances of EFSCORRUPTED with EUCLEAN since that's
what 6a797d273783 defined it as.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=199181
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1560782
Reported-by: Wen Xu <wen.xu@gatech.edu>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
[harsh@prjkt.io: s/EFSCORRUPTED/EUCLEAN/ fs/ext4/balloc.c]
Signed-off-by: Harsh Shandilya <harsh@prjkt.io>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/balloc.c |   16 ++++++++++++++--
 fs/ext4/ialloc.c |    8 +++++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -338,20 +338,25 @@ static ext4_fsblk_t ext4_valid_block_bit
 	/* check whether block bitmap block number is set */
 	blk = ext4_block_bitmap(sb, desc);
 	offset = blk - group_first_block;
-	if (!ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
+	if (offset < 0 || EXT4_B2C(sbi, offset) >= sb->s_blocksize ||
+	    !ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
 		/* bad block bitmap */
 		return blk;
 
 	/* check whether the inode bitmap block number is set */
 	blk = ext4_inode_bitmap(sb, desc);
 	offset = blk - group_first_block;
-	if (!ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
+	if (offset < 0 || EXT4_B2C(sbi, offset) >= sb->s_blocksize ||
+	    !ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
 		/* bad block bitmap */
 		return blk;
 
 	/* check whether the inode table block number is set */
 	blk = ext4_inode_table(sb, desc);
 	offset = blk - group_first_block;
+	if (offset < 0 || EXT4_B2C(sbi, offset) >= sb->s_blocksize ||
+	    EXT4_B2C(sbi, offset + sbi->s_itb_per_group) >= sb->s_blocksize)
+		return blk;
 	next_zero_bit = ext4_find_next_zero_bit(bh->b_data,
 			EXT4_B2C(sbi, offset + EXT4_SB(sb)->s_itb_per_group),
 			EXT4_B2C(sbi, offset));
@@ -414,6 +419,7 @@ struct buffer_head *
 ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group)
 {
 	struct ext4_group_desc *desc;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct buffer_head *bh;
 	ext4_fsblk_t bitmap_blk;
 
@@ -421,6 +427,12 @@ ext4_read_block_bitmap_nowait(struct sup
 	if (!desc)
 		return NULL;
 	bitmap_blk = ext4_block_bitmap(sb, desc);
+	if ((bitmap_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
+	    (bitmap_blk >= ext4_blocks_count(sbi->s_es))) {
+		ext4_error(sb, "Invalid block bitmap block %llu in "
+			   "block_group %u", bitmap_blk, block_group);
+		return ERR_PTR(-EUCLEAN);
+	}
 	bh = sb_getblk(sb, bitmap_blk);
 	if (unlikely(!bh)) {
 		ext4_error(sb, "Cannot get buffer for block bitmap - "
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -84,16 +84,22 @@ static struct buffer_head *
 ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
 {
 	struct ext4_group_desc *desc;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct buffer_head *bh = NULL;
 	ext4_fsblk_t bitmap_blk;
 	struct ext4_group_info *grp;
-	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
 	desc = ext4_get_group_desc(sb, block_group, NULL);
 	if (!desc)
 		return NULL;
 
 	bitmap_blk = ext4_inode_bitmap(sb, desc);
+	if ((bitmap_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
+	    (bitmap_blk >= ext4_blocks_count(sbi->s_es))) {
+		ext4_error(sb, "Invalid inode bitmap blk %llu in "
+			   "block_group %u", bitmap_blk, block_group);
+		return ERR_PTR(-EUCLEAN);
+	}
 	bh = sb_getblk(sb, bitmap_blk);
 	if (unlikely(!bh)) {
 		ext4_error(sb, "Cannot read inode bitmap - "
