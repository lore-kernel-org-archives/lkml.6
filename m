Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DD4C6787E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DBC2088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="Z5jT+vMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DBC2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbeJHGhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 02:37:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45609 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbeJHGhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:37:11 -0400
Received: by mail-qt1-f195.google.com with SMTP id e10-v6so8179201qtq.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 16:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WyJDUInPj/ncKWy6ColCfgvGT7HOPVuvI6ekHZb86EA=;
        b=Z5jT+vMcRWJCj5GW1xs9JafGh/yQjOjVp3oCaYX2pbKPAQvcV0tddqf4kIl2VotjwI
         I4qDehDSbaUaoWs13ErFkIjO/vSCcb+EnEccmR66cYZNqkBP1kZQYMd568e2t12mrZFU
         XgKpKxxjrkY5A/TjqKVFOQVWEwFfBR5s8OPYhTQzCGx+VsCd5aBQIxcigJdfOFqNYt98
         OPgZB6FztjMSxWVSVEen9fUNB4czRmkR+3LqWYcjhcc2ioaZ73pd3KkCShh4Fto3qw1Z
         Z3B1FTQXSHbSetKtNDBHRg8zZkUOmppiPS2PIATKZhjSt9SwuCLWciwZVuuw2FBaGaWK
         VWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WyJDUInPj/ncKWy6ColCfgvGT7HOPVuvI6ekHZb86EA=;
        b=P1WsYMsbgDpA1A1PkZkSR/rAM5wYQEw/taK6lmysRfADn3CX096ULnlmjgrjwJeUkP
         r6sDTa1k9mnQyyiF9Pf2p5HFBKscw/l6xxhdTAsk0N4TQBSzY0A1lbdSLIxj5qZVt0Lk
         UvZfuPkaFo8A6QQYpKwymFURfys6ntohklvB9NAeJ/nKYzPEuTPS2WwaNbPGFGQXBQtf
         sdaEUEn7SeOF5DwtSIdEUqKMegpyal3UDo4ATrvCMXcXBD94MT6QU7YPYErGLIQ2kONa
         bLbI5XYvB990rYq8mkK4pHT0+v8CdQcoCtIPbQBhMC38ehpZ4ack187nVpTVzwx3NaPd
         orkA==
X-Gm-Message-State: ABuFfoj6T/Sz8P+zXdNUkbdsARR+QRVYFevQOGyjJGSwMr9IOvzFrNaz
        ta74axZ1u54uSRd5FeSCmhduelF5PH01BA==
X-Google-Smtp-Source: ACcGV63en9A/JNVnSWG7eEwtrkimGfeROAfGDFPDsw9+KKINXggacAsTC7EqoeDGTxQE48t7Rbiycw==
X-Received: by 2002:ac8:5487:: with SMTP id h7-v6mr17576097qtq.150.1538954897673;
        Sun, 07 Oct 2018 16:28:17 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-35-153-175-159.compute-1.amazonaws.com. [35.153.175.159])
        by smtp.gmail.com with ESMTPSA id x38-v6sm6793915qtc.39.2018.10.07.16.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 16:28:16 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hubcap@omnibond.com
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 17/19] orangefs: implement writepages
Date:   Sun,  7 Oct 2018 23:27:34 +0000
Message-Id: <20181007232736.3780-18-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007232736.3780-1-martin@omnibond.com>
References: <20181007232736.3780-1-martin@omnibond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Go through pages and look for a consecutive writable region.  After
finding 128 consecutive writable pages or when finding a non-consecutive
region, do the write.

Signed-off-by: Martin Brandenburg <martin@omnibond.com>
---
 fs/orangefs/file.c            |   1 +
 fs/orangefs/inode.c           | 144 +++++++++++++++++++++++++++++++++-
 fs/orangefs/orangefs-kernel.h |   1 +
 fs/orangefs/super.c           |   1 +
 4 files changed, 145 insertions(+), 2 deletions(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index d5ecfea3288a..0d9cef37404f 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -491,6 +491,7 @@ static int orangefs_file_release(struct inode *inode, struct file *file)
 			gossip_debug(GOSSIP_INODE_DEBUG,
 			    "flush_racache finished\n");
 		}
+
 	}
 	return 0;
 }
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index f53d768acdd9..9a41b7d2ce54 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -15,6 +15,8 @@
 #include "orangefs-kernel.h"
 #include "orangefs-bufmap.h"
 
+#define ORANGEFS_WRITEPAGES_COUNT 128
+
 static int orangefs_writepage_locked(struct page *page,
     struct writeback_control *wbc)
 {
@@ -44,10 +46,10 @@ static int orangefs_writepage_locked(struct page *page,
 			len = i_size_read(inode);
 		}
 	} else {
-/*		BUG();*/
+		end_page_writeback(page);
 		/* It's not private so there's nothing to write, right? */
 		printk("writepage not private!\n");
-		end_page_writeback(page);
+		BUG();
 		return 0;
 
 	}
@@ -230,6 +232,143 @@ static int orangefs_readpage(struct file *file, struct page *page)
 	return ret;
 }
 
+struct orangefs_writepages {
+	loff_t off;
+	size_t len;
+	kuid_t uid;
+	kgid_t gid;
+	struct page *pages[ORANGEFS_WRITEPAGES_COUNT];
+	int npages;
+	struct bio_vec bv[ORANGEFS_WRITEPAGES_COUNT];
+};
+
+static int orangefs_writepages_work(struct orangefs_writepages *ow,
+    struct writeback_control *wbc)
+{
+	struct inode *inode = ow->pages[0]->mapping->host;
+	struct orangefs_write_request *wrp, wr;
+	struct iov_iter iter;
+	ssize_t ret;
+	loff_t off;
+	int i;
+
+	for (i = 0; i < ow->npages; i++) {
+		set_page_writeback(ow->pages[i]);
+		ow->bv[i].bv_page = ow->pages[i];
+		/* uh except the last one maybe... */
+		if (i == ow->npages - 1 && ow->len % PAGE_SIZE)
+			ow->bv[i].bv_len = ow->len % PAGE_SIZE;
+		else
+			ow->bv[i].bv_len = PAGE_SIZE;
+		ow->bv[i].bv_offset = 0;
+	}
+	iov_iter_bvec(&iter, ITER_BVEC | WRITE, ow->bv, ow->npages, ow->len);
+
+	off = ow->off;
+	wr.uid = ow->uid;
+	wr.gid = ow->gid;
+	ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter, ow->len,
+	    0, &wr);
+	if (ret < 0) {
+		for (i = 0; i < ow->npages; i++) {
+			SetPageError(ow->pages[i]);
+			mapping_set_error(ow->pages[i]->mapping, ret);
+			end_page_writeback(ow->pages[i]);
+			unlock_page(ow->pages[i]);
+		}
+	} else {
+		for (i = 0; i < ow->npages; i++) {
+			if (PagePrivate(ow->pages[i])) {
+				wrp = (struct orangefs_write_request *)
+				    page_private(ow->pages[i]);
+				ClearPagePrivate(ow->pages[i]);
+				wr_release(wrp);
+			}
+			end_page_writeback(ow->pages[i]);
+			unlock_page(ow->pages[i]);
+		}
+	}
+	return ret;
+}
+
+static int orangefs_writepages_callback(struct page *page,
+    struct writeback_control *wbc, void *data)
+{
+	struct orangefs_writepages *ow = data;
+	struct orangefs_write_request *wr;
+	int ret;
+
+	if (!PagePrivate(page)) {
+		unlock_page(page);
+		/* It's not private so there's nothing to write, right? */
+		printk("writepages_callback not private!\n");
+		BUG();
+		return 0;
+	}
+	wr = (struct orangefs_write_request *)page_private(page);
+
+	if (wr->len != PAGE_SIZE) {
+		ret = orangefs_writepage_locked(page, wbc);
+		mapping_set_error(page->mapping, ret);
+		unlock_page(page);
+	} else {
+		ret = -1;
+		if (ow->npages == 0) {
+			ow->off = wr->pos;
+			ow->len = wr->len;
+			ow->uid = wr->uid;
+			ow->gid = wr->gid;
+			ow->pages[ow->npages++] = page;
+			ret = 0;
+			goto done;
+		}
+		if (!uid_eq(ow->uid, wr->uid) || !gid_eq(ow->gid, wr->gid)) {
+			orangefs_writepages_work(ow, wbc);
+			memset(ow, 0, sizeof *ow);
+			ret = -1;
+			goto done;
+		}
+		if (ow->off + ow->len == wr->pos) {
+			ow->len += wr->len;
+			ow->pages[ow->npages++] = page;
+			ret = 0;
+			goto done;
+		}
+done:
+		if (ret == -1) {
+			ret = orangefs_writepage_locked(page, wbc);
+			mapping_set_error(page->mapping, ret);
+			unlock_page(page);
+		} else {
+			if (ow->npages == ORANGEFS_WRITEPAGES_COUNT) {
+				orangefs_writepages_work(ow, wbc);
+				memset(ow, 0, sizeof *ow);
+			}
+		}
+	}
+	return ret;
+}
+
+static int orangefs_writepages(struct address_space *mapping,
+    struct writeback_control *wbc)
+{
+	struct orangefs_writepages *ow;
+	struct blk_plug plug;
+	int ret;
+	ow = kzalloc(sizeof(struct orangefs_writepages), GFP_KERNEL);
+	if (!ow)
+		return -ENOMEM;
+	mutex_lock(&ORANGEFS_SB(mapping->host->i_sb)->writepages_mutex);
+	blk_start_plug(&plug);
+	ret = write_cache_pages(mapping, wbc, orangefs_writepages_callback, ow);
+	if (ow->npages)
+		ret = orangefs_writepages_work(ow, wbc);
+	blk_finish_plug(&plug);
+	mutex_unlock(&ORANGEFS_SB(mapping->host->i_sb)->writepages_mutex);
+	kfree(ow);
+	return ret;
+}
+
 static int orangefs_write_begin(struct file *file,
     struct address_space *mapping, loff_t pos, unsigned len, unsigned flags,
     struct page **pagep, void **fsdata)
@@ -348,6 +487,7 @@ static int orangefs_launder_page(struct page *page)
 static const struct address_space_operations orangefs_address_operations = {
 	.writepage = orangefs_writepage,
 	.readpage = orangefs_readpage,
+	.writepages = orangefs_writepages,
 	.set_page_dirty = __set_page_dirty_nobuffers,
 	.write_begin = orangefs_write_begin,
 	.write_end = orangefs_write_end,
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index 256851bab7a5..9e23f97fb5cc 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -220,6 +220,7 @@ struct orangefs_sb_info_s {
 	int mount_pending;
 	int no_list;
 	struct list_head list;
+	struct mutex writepages_mutex;
 };
 
 struct orangefs_stats {
diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 83abe5ec2d11..204e1ac7f228 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -467,6 +467,7 @@ static int orangefs_fill_sb(struct super_block *sb,
 
 	sb->s_export_op = &orangefs_export_ops;
 	sb->s_root = root_dentry;
+	mutex_init(&ORANGEFS_SB(sb)->writepages_mutex);
 	return 0;
 }
 
-- 
2.19.0

