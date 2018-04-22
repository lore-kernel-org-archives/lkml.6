Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+ebupAGGwX0LIP+S4dj7nvXLCvCqZNMJx2U59QzhXozhskiX2wtckfz7L5dRuQJbBSuKQg
ARC-Seal: i=1; a=rsa-sha256; t=1524406640; cv=none;
        d=google.com; s=arc-20160816;
        b=GUYyTQkk3Y8yUtqqyP4H+rv9SruccnPgqbY6uj0WoJb5vDDnuv5euqpj/mwaK9EQOL
         rE8BXY0fUdD38YwT+gDSz2UxAW7eidRNs8d864MkS1VPsmRK2oHMCofreFZi1UEaZQSC
         Q3DY2jbaiY1FGkoQ6jcLADiEe246pHzdbPJIWwPL+khb+4zQT5XNfGVeaa150raQxFWQ
         syEV+cMCcQ+/2hws9EVbGavvMJ1XQhVU2y6qpvx+l8ZvjdQJiwW3tb95kyQOv8H9Jv33
         zECoE+tiX+qDi8HQVegk4pgqjWhOq66Sh05DzTKqlcRjfkuxJT3qWogosMWGURg8FBzc
         MQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=w/tf157b0gTpuqhfAolz4S0P5YusbdCyg+S4CUc5uVM=;
        b=ojjNd2GYXiBYGVs5RCfskjpTVNmFe8uaiiaDoYC25CMOZc4YHoG826F/6+3Eypzt/e
         cqqMKlYUZhG/YUlLMKGkwBVcwNEEm660IWPjenRJnyZTLWLgbEP/ieKVFN3L6GcCew6g
         1cJZEUHaz8yWeO3L1CgwU9IcBT1gnmUGgjQOyNnexCnhSt3bKMeJRj+0NhgE/YBGFgij
         p+Om9ogUH9BkUQL5wnGTz3gAKZZ9+CuSWJe1w4ZW6Cw8p6cZWSCZTbmOzCKqJIT+ZmVp
         7unpb0+fi5LFSlHAoMhYFcFF5JNI0UJQDdXio5EU4VddfvUjjJ3C//aXm7cVLKwzVeCy
         8jIg==
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
Subject: [PATCH 4.4 50/97] ext4: add validity checks for bitmap block numbers
Date: Sun, 22 Apr 2018 15:53:28 +0200
Message-Id: <20180422135308.084667867@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455024318699724?=
X-GMAIL-MSGID: =?utf-8?q?1598456217188700974?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -337,20 +337,25 @@ static ext4_fsblk_t ext4_valid_block_bit
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
@@ -416,6 +421,7 @@ struct buffer_head *
 ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group)
 {
 	struct ext4_group_desc *desc;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct buffer_head *bh;
 	ext4_fsblk_t bitmap_blk;
 	int err;
@@ -424,6 +430,12 @@ ext4_read_block_bitmap_nowait(struct sup
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
@@ -119,6 +119,7 @@ static struct buffer_head *
 ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
 {
 	struct ext4_group_desc *desc;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct buffer_head *bh = NULL;
 	ext4_fsblk_t bitmap_blk;
 	int err;
@@ -128,6 +129,12 @@ ext4_read_inode_bitmap(struct super_bloc
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
