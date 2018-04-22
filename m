Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Ju9Ev9lhD4vx7F/xe6vhV73E4O/4DjTESx1VP2Sww+VLFFh6IJ/gwJLkNyFvTR+PoBW5N
ARC-Seal: i=1; a=rsa-sha256; t=1524406338; cv=none;
        d=google.com; s=arc-20160816;
        b=JBAjBomXkwP5bMG5V5AW9hN/EDe1ulfka+934RhYcUYItNHFG8pGlSiBnePI4bxWNL
         GQdkDBpO/FKGna7CaEjVTY0+Xdo/D9SVRpzp8BRGzPb5NHM2hFk/McBfh5uqzqmjTwMs
         II2glgOyfXIhySkwNk6oivFjDR/t5cYtz2FUWB83+eIPX1nJsZJP09j+YUDtDqOFAu7e
         xL0JnM0PG/JzcDnni7kK+kCOkaXhvIhs2az1tTFYFUkNa/jZfg3VYPYgvdV5H2XUaKyn
         UmVwDE5EQxuAijG5Yi1czy4AX4LrrOEi+L5IL8HSth9J40aTAsQkjfS6RA6UwXjqUo2B
         i6dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ajofFjMnvg+F3MKbnQfeLdkDXZ4E4HI3cAq+u/j4ODw=;
        b=xXN+aXKYfm4VH3wwv668YN9X/M3u3jU5znVSjFtpbvdNSaN6hczaCI2E/whdgRKYv4
         hjPZl3Bohj1RJZrS6bier3TT3bZ3Klg42pypRFxT/2ApeY/e2GkPDc5aIJu4iZOxw4F0
         ywUigv4JbapUqnw5VxJDpu86c58UvZjs3sVEmCzxTwtNmLw6mi3OGb5ERRpp75Uo+eH2
         3FfRA/aXmP38LOUIh/qV+XpESP185rwb3y0e+elpVCOI69ACvdaAYk80TRjpAyLbti5y
         SOu1sSFmGJTvvhDkxlQv2p7WG8usx5Sup074hbIX5OTYpTdBNv8iRiSdJjMHYgLR5M5I
         byng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.9 35/95] ext4: dont update checksum of new initialized bitmaps
Date: Sun, 22 Apr 2018 15:53:04 +0200
Message-Id: <20180422135211.864586360@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455115172049976?=
X-GMAIL-MSGID: =?utf-8?q?1598455900532438020?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 044e6e3d74a3d7103a0c8a9305dfd94d64000660 upstream.

When reading the inode or block allocation bitmap, if the bitmap needs
to be initialized, do not update the checksum in the block group
descriptor.  That's because we're not set up to journal those changes.
Instead, just set the verified bit on the bitmap block, so that it's
not necessary to validate the checksum.

When a block or inode allocation actually happens, at that point the
checksum will be calculated, and update of the bg descriptor block
will be properly journalled.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/balloc.c |    3 +--
 fs/ext4/ialloc.c |   47 +++--------------------------------------------
 2 files changed, 4 insertions(+), 46 deletions(-)

--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -242,8 +242,6 @@ static int ext4_init_block_bitmap(struct
 	 */
 	ext4_mark_bitmap_end(num_clusters_in_group(sb, block_group),
 			     sb->s_blocksize * 8, bh->b_data);
-	ext4_block_bitmap_csum_set(sb, block_group, gdp, bh);
-	ext4_group_desc_csum_set(sb, block_group, gdp);
 	return 0;
 }
 
@@ -447,6 +445,7 @@ ext4_read_block_bitmap_nowait(struct sup
 		err = ext4_init_block_bitmap(sb, bh, block_group, desc);
 		set_bitmap_uptodate(bh);
 		set_buffer_uptodate(bh);
+		set_buffer_verified(bh);
 		ext4_unlock_group(sb, block_group);
 		unlock_buffer(bh);
 		if (err) {
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -63,44 +63,6 @@ void ext4_mark_bitmap_end(int start_bit,
 		memset(bitmap + (i >> 3), 0xff, (end_bit - i) >> 3);
 }
 
-/* Initializes an uninitialized inode bitmap */
-static int ext4_init_inode_bitmap(struct super_block *sb,
-				       struct buffer_head *bh,
-				       ext4_group_t block_group,
-				       struct ext4_group_desc *gdp)
-{
-	struct ext4_group_info *grp;
-	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	J_ASSERT_BH(bh, buffer_locked(bh));
-
-	/* If checksum is bad mark all blocks and inodes use to prevent
-	 * allocation, essentially implementing a per-group read-only flag. */
-	if (!ext4_group_desc_csum_verify(sb, block_group, gdp)) {
-		grp = ext4_get_group_info(sb, block_group);
-		if (!EXT4_MB_GRP_BBITMAP_CORRUPT(grp))
-			percpu_counter_sub(&sbi->s_freeclusters_counter,
-					   grp->bb_free);
-		set_bit(EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT, &grp->bb_state);
-		if (!EXT4_MB_GRP_IBITMAP_CORRUPT(grp)) {
-			int count;
-			count = ext4_free_inodes_count(sb, gdp);
-			percpu_counter_sub(&sbi->s_freeinodes_counter,
-					   count);
-		}
-		set_bit(EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT, &grp->bb_state);
-		return -EFSBADCRC;
-	}
-
-	memset(bh->b_data, 0, (EXT4_INODES_PER_GROUP(sb) + 7) / 8);
-	ext4_mark_bitmap_end(EXT4_INODES_PER_GROUP(sb), sb->s_blocksize * 8,
-			bh->b_data);
-	ext4_inode_bitmap_csum_set(sb, block_group, gdp, bh,
-				   EXT4_INODES_PER_GROUP(sb) / 8);
-	ext4_group_desc_csum_set(sb, block_group, gdp);
-
-	return 0;
-}
-
 void ext4_end_bitmap_read(struct buffer_head *bh, int uptodate)
 {
 	if (uptodate) {
@@ -184,17 +146,14 @@ ext4_read_inode_bitmap(struct super_bloc
 
 	ext4_lock_group(sb, block_group);
 	if (desc->bg_flags & cpu_to_le16(EXT4_BG_INODE_UNINIT)) {
-		err = ext4_init_inode_bitmap(sb, bh, block_group, desc);
+		memset(bh->b_data, 0, (EXT4_INODES_PER_GROUP(sb) + 7) / 8);
+		ext4_mark_bitmap_end(EXT4_INODES_PER_GROUP(sb),
+				     sb->s_blocksize * 8, bh->b_data);
 		set_bitmap_uptodate(bh);
 		set_buffer_uptodate(bh);
 		set_buffer_verified(bh);
 		ext4_unlock_group(sb, block_group);
 		unlock_buffer(bh);
-		if (err) {
-			ext4_error(sb, "Failed to init inode bitmap for group "
-				   "%u: %d", block_group, err);
-			goto out;
-		}
 		return bh;
 	}
 	ext4_unlock_group(sb, block_group);
