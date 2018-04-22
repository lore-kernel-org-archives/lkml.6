Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx492BMGrEK4YangJCU82XbfF7SRB6ekyF237k2/q52AhCNguvO4O0mmMYifb9+tLs63LeNlO
ARC-Seal: i=1; a=rsa-sha256; t=1524405502; cv=none;
        d=google.com; s=arc-20160816;
        b=K7mJPxQNLcmS6cB5BNVRlLDgBrEMoMF21THcemUaY84IUT3ub/o+8plpTzuAe7AUND
         wwuxTgdYc3rmMvxl6h5cJVa+e7Hjq+3JvkSvjDYW4t8D0mck1LNxPBty67qV3mIMKMP2
         Kxpxyw/mmHpufTI5sKz4jnM6VfmJanEQJHp25VJt4B5QZ2SLnb/2P/PsoDvaf1XvLhGr
         E/27gf2k+ltoK4ucy/QTZVtbk8GprJ/lpY96SLxlyRKNEKy4L4LpaWi9uNYIbmNdO28/
         3S2vNvRephLLvFAG0RyMkb64eZjZp60rqe21zgbaYkm2w60tQd8NchJE3Ab3tgiPHqtE
         mRmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=V2l2lUj1r96wwcj12PPFGyALQZDFuAu4a+R+EwjNiTs=;
        b=scP7D4IIgR5lTjBrJRH+JRMoLS6bw8wcIxPBalNdcXWZe5HLRgWU8AM8UCw2mtyfi7
         GjaN9Pry4yYj/oIwiZFDB99XoOtI04gIGkPyBye+z+gEQZ8IthE0IR/KQnGYv554ojur
         HI7p6wfV1fg9cfbsh/X4869Ukov6b6ywcV8wQbCX7eTa1wIga/8PBx5rIeM++0I5Y9Yh
         Ay26uqift53nP4tUvcF6qoy4CrP4vQHmwOApejyWG700m4R7gqp7+Fh9sPUvKiMxZCOn
         tfCt8wxXhL8tUbpKknmQ7dvMoF5wfNnnsblGMIG1cQJFOWXZVNoCYXqD8AzlK2wcI0mX
         vNTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wen Xu <wen.xu@gatech.edu>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.16 091/196] ext4: add validity checks for bitmap block numbers
Date: Sun, 22 Apr 2018 15:51:51 +0200
Message-Id: <20180422135109.001540448@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455024318699724?=
X-GMAIL-MSGID: =?utf-8?q?1598455024318699724?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 7dac4a1726a9c64a517d595c40e95e2d0d135f6f upstream.

An privileged attacker can cause a crash by mounting a crafted ext4
image which triggers a out-of-bounds read in the function
ext4_valid_block_bitmap() in fs/ext4/balloc.c.

This issue has been assigned CVE-2018-1093.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=199181
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1560782
Reported-by: Wen Xu <wen.xu@gatech.edu>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/balloc.c |   16 ++++++++++++++--
 fs/ext4/ialloc.c |    7 +++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

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
 			EXT4_B2C(sbi, offset + sbi->s_itb_per_group),
 			EXT4_B2C(sbi, offset));
@@ -417,6 +422,7 @@ struct buffer_head *
 ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group)
 {
 	struct ext4_group_desc *desc;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct buffer_head *bh;
 	ext4_fsblk_t bitmap_blk;
 	int err;
@@ -425,6 +431,12 @@ ext4_read_block_bitmap_nowait(struct sup
 	if (!desc)
 		return ERR_PTR(-EFSCORRUPTED);
 	bitmap_blk = ext4_block_bitmap(sb, desc);
+	if ((bitmap_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
+	    (bitmap_blk >= ext4_blocks_count(sbi->s_es))) {
+		ext4_error(sb, "Invalid block bitmap block %llu in "
+			   "block_group %u", bitmap_blk, block_group);
+		return ERR_PTR(-EFSCORRUPTED);
+	}
 	bh = sb_getblk(sb, bitmap_blk);
 	if (unlikely(!bh)) {
 		ext4_error(sb, "Cannot get buffer for block bitmap - "
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -122,6 +122,7 @@ static struct buffer_head *
 ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
 {
 	struct ext4_group_desc *desc;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct buffer_head *bh = NULL;
 	ext4_fsblk_t bitmap_blk;
 	int err;
@@ -131,6 +132,12 @@ ext4_read_inode_bitmap(struct super_bloc
 		return ERR_PTR(-EFSCORRUPTED);
 
 	bitmap_blk = ext4_inode_bitmap(sb, desc);
+	if ((bitmap_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
+	    (bitmap_blk >= ext4_blocks_count(sbi->s_es))) {
+		ext4_error(sb, "Invalid inode bitmap blk %llu in "
+			   "block_group %u", bitmap_blk, block_group);
+		return ERR_PTR(-EFSCORRUPTED);
+	}
 	bh = sb_getblk(sb, bitmap_blk);
 	if (unlikely(!bh)) {
 		ext4_error(sb, "Cannot read inode bitmap - "
