Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2193BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B8D20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B8D20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbeKLFsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49896 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730066AbeKLFsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:13 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0000l4-7v; Sun, 11 Nov 2018 19:58:43 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsW-0001jS-LL; Sun, 11 Nov 2018 19:58:40 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Eric Biggers" <ebiggers@google.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        syzbot+b890b3335a4d8c608963@syzkaller.appspotmail.com
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.28148511@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 256/366] reiserfs: fix buffer overflow with long
 warning messages
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit fe10e398e860955bac4d28ec031b701d358465e4 upstream.

ReiserFS prepares log messages into a 1024-byte buffer with no bounds
checks.  Long messages, such as the "unknown mount option" warning when
userspace passes a crafted mount options string, overflow this buffer.
This causes KASAN to report a global-out-of-bounds write.

Fix it by truncating messages to the buffer size.

Link: http://lkml.kernel.org/r/20180707203621.30922-1-ebiggers3@gmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+b890b3335a4d8c608963@syzkaller.appspotmail.com
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/reiserfs/prints.c | 141 +++++++++++++++++++++++++------------------
 1 file changed, 81 insertions(+), 60 deletions(-)

--- a/fs/reiserfs/prints.c
+++ b/fs/reiserfs/prints.c
@@ -76,85 +76,101 @@ static char *le_type(struct reiserfs_key
 }
 
 /* %k */
-static void sprintf_le_key(char *buf, struct reiserfs_key *key)
+static int scnprintf_le_key(char *buf, size_t size, struct reiserfs_key *key)
 {
 	if (key)
-		sprintf(buf, "[%d %d %s %s]", le32_to_cpu(key->k_dir_id),
-			le32_to_cpu(key->k_objectid), le_offset(key),
-			le_type(key));
+		return scnprintf(buf, size, "[%d %d %s %s]",
+				 le32_to_cpu(key->k_dir_id),
+				 le32_to_cpu(key->k_objectid), le_offset(key),
+				 le_type(key));
 	else
-		sprintf(buf, "[NULL]");
+		return scnprintf(buf, size, "[NULL]");
 }
 
 /* %K */
-static void sprintf_cpu_key(char *buf, struct cpu_key *key)
+static int scnprintf_cpu_key(char *buf, size_t size, struct cpu_key *key)
 {
 	if (key)
-		sprintf(buf, "[%d %d %s %s]", key->on_disk_key.k_dir_id,
-			key->on_disk_key.k_objectid, reiserfs_cpu_offset(key),
-			cpu_type(key));
+		return scnprintf(buf, size, "[%d %d %s %s]",
+				 key->on_disk_key.k_dir_id,
+				 key->on_disk_key.k_objectid,
+				 reiserfs_cpu_offset(key), cpu_type(key));
 	else
-		sprintf(buf, "[NULL]");
+		return scnprintf(buf, size, "[NULL]");
 }
 
-static void sprintf_de_head(char *buf, struct reiserfs_de_head *deh)
+static int scnprintf_de_head(char *buf, size_t size,
+			     struct reiserfs_de_head *deh)
 {
 	if (deh)
-		sprintf(buf,
-			"[offset=%d dir_id=%d objectid=%d location=%d state=%04x]",
-			deh_offset(deh), deh_dir_id(deh), deh_objectid(deh),
-			deh_location(deh), deh_state(deh));
+		return scnprintf(buf, size,
+				 "[offset=%d dir_id=%d objectid=%d location=%d state=%04x]",
+				 deh_offset(deh), deh_dir_id(deh),
+				 deh_objectid(deh), deh_location(deh),
+				 deh_state(deh));
 	else
-		sprintf(buf, "[NULL]");
+		return scnprintf(buf, size, "[NULL]");
 
 }
 
-static void sprintf_item_head(char *buf, struct item_head *ih)
+static int scnprintf_item_head(char *buf, size_t size, struct item_head *ih)
 {
 	if (ih) {
-		strcpy(buf,
-		       (ih_version(ih) == KEY_FORMAT_3_6) ? "*3.6* " : "*3.5*");
-		sprintf_le_key(buf + strlen(buf), &(ih->ih_key));
-		sprintf(buf + strlen(buf), ", item_len %d, item_location %d, "
-			"free_space(entry_count) %d",
-			ih_item_len(ih), ih_location(ih), ih_free_space(ih));
+		char *p = buf;
+		char * const end = buf + size;
+
+		p += scnprintf(p, end - p, "%s",
+			       (ih_version(ih) == KEY_FORMAT_3_6) ?
+			       "*3.6* " : "*3.5*");
+
+		p += scnprintf_le_key(p, end - p, &ih->ih_key);
+
+		p += scnprintf(p, end - p,
+			       ", item_len %d, item_location %d, free_space(entry_count) %d",
+			       ih_item_len(ih), ih_location(ih),
+			       ih_free_space(ih));
+		return p - buf;
 	} else
-		sprintf(buf, "[NULL]");
+		return scnprintf(buf, size, "[NULL]");
 }
 
-static void sprintf_direntry(char *buf, struct reiserfs_dir_entry *de)
+static int scnprintf_direntry(char *buf, size_t size,
+			      struct reiserfs_dir_entry *de)
 {
 	char name[20];
 
 	memcpy(name, de->de_name, de->de_namelen > 19 ? 19 : de->de_namelen);
 	name[de->de_namelen > 19 ? 19 : de->de_namelen] = 0;
-	sprintf(buf, "\"%s\"==>[%d %d]", name, de->de_dir_id, de->de_objectid);
+	return scnprintf(buf, size, "\"%s\"==>[%d %d]",
+			 name, de->de_dir_id, de->de_objectid);
 }
 
-static void sprintf_block_head(char *buf, struct buffer_head *bh)
+static int scnprintf_block_head(char *buf, size_t size, struct buffer_head *bh)
 {
-	sprintf(buf, "level=%d, nr_items=%d, free_space=%d rdkey ",
-		B_LEVEL(bh), B_NR_ITEMS(bh), B_FREE_SPACE(bh));
+	return scnprintf(buf, size,
+			 "level=%d, nr_items=%d, free_space=%d rdkey ",
+			 B_LEVEL(bh), B_NR_ITEMS(bh), B_FREE_SPACE(bh));
 }
 
-static void sprintf_buffer_head(char *buf, struct buffer_head *bh)
+static int scnprintf_buffer_head(char *buf, size_t size, struct buffer_head *bh)
 {
 	char b[BDEVNAME_SIZE];
 
-	sprintf(buf,
-		"dev %s, size %zd, blocknr %llu, count %d, state 0x%lx, page %p, (%s, %s, %s)",
-		bdevname(bh->b_bdev, b), bh->b_size,
-		(unsigned long long)bh->b_blocknr, atomic_read(&(bh->b_count)),
-		bh->b_state, bh->b_page,
-		buffer_uptodate(bh) ? "UPTODATE" : "!UPTODATE",
-		buffer_dirty(bh) ? "DIRTY" : "CLEAN",
-		buffer_locked(bh) ? "LOCKED" : "UNLOCKED");
+	return scnprintf(buf, size,
+			 "dev %s, size %zd, blocknr %llu, count %d, state 0x%lx, page %p, (%s, %s, %s)",
+			 bdevname(bh->b_bdev, b), bh->b_size,
+			 (unsigned long long)bh->b_blocknr,
+			 atomic_read(&(bh->b_count)),
+			 bh->b_state, bh->b_page,
+			 buffer_uptodate(bh) ? "UPTODATE" : "!UPTODATE",
+			 buffer_dirty(bh) ? "DIRTY" : "CLEAN",
+			 buffer_locked(bh) ? "LOCKED" : "UNLOCKED");
 }
 
-static void sprintf_disk_child(char *buf, struct disk_child *dc)
+static int scnprintf_disk_child(char *buf, size_t size, struct disk_child *dc)
 {
-	sprintf(buf, "[dc_number=%d, dc_size=%u]", dc_block_number(dc),
-		dc_size(dc));
+	return scnprintf(buf, size, "[dc_number=%d, dc_size=%u]",
+			 dc_block_number(dc), dc_size(dc));
 }
 
 static char *is_there_reiserfs_struct(char *fmt, int *what)
@@ -191,55 +207,60 @@ static void prepare_error_buf(const char
 	char *fmt1 = fmt_buf;
 	char *k;
 	char *p = error_buf;
+	char * const end = &error_buf[sizeof(error_buf)];
 	int what;
 
 	spin_lock(&error_lock);
 
-	strcpy(fmt1, fmt);
+	if (WARN_ON(strscpy(fmt_buf, fmt, sizeof(fmt_buf)) < 0)) {
+		strscpy(error_buf, "format string too long", end - error_buf);
+		goto out_unlock;
+	}
 
 	while ((k = is_there_reiserfs_struct(fmt1, &what)) != NULL) {
 		*k = 0;
 
-		p += vsprintf(p, fmt1, args);
+		p += vscnprintf(p, end - p, fmt1, args);
 
 		switch (what) {
 		case 'k':
-			sprintf_le_key(p, va_arg(args, struct reiserfs_key *));
+			p += scnprintf_le_key(p, end - p,
+					      va_arg(args, struct reiserfs_key *));
 			break;
 		case 'K':
-			sprintf_cpu_key(p, va_arg(args, struct cpu_key *));
+			p += scnprintf_cpu_key(p, end - p,
+					       va_arg(args, struct cpu_key *));
 			break;
 		case 'h':
-			sprintf_item_head(p, va_arg(args, struct item_head *));
+			p += scnprintf_item_head(p, end - p,
+						 va_arg(args, struct item_head *));
 			break;
 		case 't':
-			sprintf_direntry(p,
-					 va_arg(args,
-						struct reiserfs_dir_entry *));
+			p += scnprintf_direntry(p, end - p,
+						va_arg(args, struct reiserfs_dir_entry *));
 			break;
 		case 'y':
-			sprintf_disk_child(p,
-					   va_arg(args, struct disk_child *));
+			p += scnprintf_disk_child(p, end - p,
+						  va_arg(args, struct disk_child *));
 			break;
 		case 'z':
-			sprintf_block_head(p,
-					   va_arg(args, struct buffer_head *));
+			p += scnprintf_block_head(p, end - p,
+						  va_arg(args, struct buffer_head *));
 			break;
 		case 'b':
-			sprintf_buffer_head(p,
-					    va_arg(args, struct buffer_head *));
+			p += scnprintf_buffer_head(p, end - p,
+						   va_arg(args, struct buffer_head *));
 			break;
 		case 'a':
-			sprintf_de_head(p,
-					va_arg(args,
-					       struct reiserfs_de_head *));
+			p += scnprintf_de_head(p, end - p,
+					       va_arg(args, struct reiserfs_de_head *));
 			break;
 		}
 
-		p += strlen(p);
 		fmt1 = k + 2;
 	}
-	vsprintf(p, fmt1, args);
+	p += vscnprintf(p, end - p, fmt1, args);
+out_unlock:
 	spin_unlock(&error_lock);
 
 }

