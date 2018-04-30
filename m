Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoiFg1TNftgs34DfXnYgHY8ga2f82PBK3HvzjAVfMTKJaTBNt7aOGq3vxtW1AL4RPZUvSAK
ARC-Seal: i=1; a=rsa-sha256; t=1525116489; cv=none;
        d=google.com; s=arc-20160816;
        b=tt5/ics1ORunN6xUDukNS1d6I0pOQAF1m54LlZCbC+5K0qmmN7Ddd11gqgL0bS/ONn
         YS/QIhHdK+8MJt/6njTj5emzWlGgrASSC/Zu3jXk5l+3Y/q3vfy5yiQL3a4sCQYg0ZZI
         Ctj0Er3msfVBfN39i6+7ICA80IgEh2In0E92jAme/ZPEFaGrtpvLs0+lGDLoh82+tNNc
         q83ZyrG73Umhn52M3C2+9HNGgdMsQa0Lim2NPf3GrP2DBxkvdO5mP+TBrnalKGRFsSPC
         lPMo/qXh0RMLV2XbAfRt7UKLML2JKPx/l2x6Ku1YpYlU2ZEa3fNGUuoNeu60roiXrmMO
         tfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=V2l2lUj1r96wwcj12PPFGyALQZDFuAu4a+R+EwjNiTs=;
        b=ZYDf/WuzMg9HRqLfVUm2LVymoJGO3HlWuocouXmXCvuIppcyLnL0fjD49EI5CsHRmI
         e9umgrEYYnfa3+e1wW+bqDk6n+umou9bT86RgTDCI9Pocf6kupaqtsjDgvrZaSFOqW2Q
         4bdjxikrI4CGYSNMZE8HIb0lPbNoWkKrzrQm00bx02S11ZcKSfCzTd+b7Go1xK8IjsqB
         GpTJV4PbmHUB7YYwJCUxlz3/KLjsxjac/ZyrU7/4rhffjhP79y4B3LQIUuaE6xpvBGXM
         oM9LzyqNoD9fyuC+Ic8WOTtOxmeAO7asVct/tMNIHa9jqkatg4SKIjJWCPURJJnc9pzY
         BlXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305B322DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wen Xu <wen.xu@gatech.edu>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.16 004/113] ext4: add validity checks for bitmap block numbers
Date: Mon, 30 Apr 2018 12:23:35 -0700
Message-Id: <20180430184015.262358165@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200284172323398?=
X-GMAIL-MSGID: =?utf-8?q?1599200548014395502?=
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
