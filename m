Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE05ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB168214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="f7LrNgfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB168214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbeIRBkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:40:23 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38341 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728732AbeIRBkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:40:21 -0400
Received: by mail-qt0-f195.google.com with SMTP id x7-v6so16535493qtk.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 13:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FSJsX7wSy7vnODIzotdDKYUc3pGSuPPc1OVM6kMR1uc=;
        b=f7LrNgflb9w3dZkadyMrmc7c3TxQlK0tvhOLyBZwRUGjlpoEFnNaqXnignwyaQTErA
         7OltRH2+tG3NojLIUOjeSG8e15DuZWGMgIvjOP0ERKbDrWlPVOTN/qrC1L0BkOzQhKuU
         sK7zgvQF0HGlqQY1EDTPBf9rqFgVoBNvN3zlq+Qd4xV6K71xFcAtGgjcqSXadtcYtXxV
         S5GP/RzvRLriAysO894PbPiLpp7s5/pQqWXwWlzuKd5FmIidX1rRkYKoalvqNSCZ5zua
         vlLxaZGsCTPyVbCVeXu/uACDvch4OsMM983g310x4wgdmsQIQKWXXJxMigdAH+Q1/Jcc
         pJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FSJsX7wSy7vnODIzotdDKYUc3pGSuPPc1OVM6kMR1uc=;
        b=pY/rBCcn8TUb+a6mvD3tO3TWjiVHo2ETfaDWt0bKsqtefaLvVWeeKenHA07psgMt4Q
         thd9q7WPQHGJ6vxQ9qARbOXPW50tz0Fsp+WxsglD0+i9vBuJ1XqEpmLFb7D/VFv0zJai
         UuUR518NtRLp340x+T/t2APIDt0t1aUFbtFaEn3HkwPm6b6+iMfufPDFRQZ+ve9asBwz
         l/5MbimYS0aIC4BB2K1YQ1ZLYNTP42TLJgtwTTMjOukQ8Er0D3kBp23zT1kyOy4ebVLy
         Fk8ioh+ZZXspScipdfWbhDbAiaBl2zE2Zbq8Vt8hY0k97ffHDGM1VPuoq9MFJCC6gKYc
         7Zhg==
X-Gm-Message-State: APzg51D2Z7Wm2WoVL7gSon+FWlvDiHzzDBDMe9UxqHpp2ulUXxwgTN+r
        0y//4zd9efUxrNcVOeonbcLGP2wXpe8KBQp3
X-Google-Smtp-Source: ANB0VdbCDzIFci3SZrBoiu67MQg7nyDLaW63S/nhKljvIfB4liF15bePaX9CudU+4g0jvoc7hNBh6w==
X-Received: by 2002:aed:3d05:: with SMTP id g5-v6mr18782592qtf.247.1537215088257;
        Mon, 17 Sep 2018 13:11:28 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-18-215-252-133.compute-1.amazonaws.com. [18.215.252.133])
        by smtp.gmail.com with ESMTPSA id n8-v6sm11053480qtk.38.2018.09.17.13.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 13:11:27 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        devel@lists.orangefs.org
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 17/17] orangefs: implement writepages
Date:   Mon, 17 Sep 2018 20:10:54 +0000
Message-Id: <20180917201054.3530-18-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917201054.3530-1-martin@omnibond.com>
References: <20180917201054.3530-1-martin@omnibond.com>
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
 fs/orangefs/inode.c           | 135 +++++++++++++++++++++++++++++++++-
 fs/orangefs/orangefs-kernel.h |   1 +
 fs/orangefs/super.c           |   1 +
 3 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 178734920e45..34b98d2ed377 100644
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
@@ -230,6 +232,134 @@ static int orangefs_readpage(struct file *file, struct page *page)
 	return ret;
 }
 
+struct orangefs_writepages {
+	loff_t off;
+	size_t len;
+	struct page *pages[ORANGEFS_WRITEPAGES_COUNT];
+	int npages;
+};
+
+static int orangefs_writepages_work(struct orangefs_writepages *ow,
+    struct writeback_control *wbc)
+{
+	struct inode *inode = ow->pages[0]->mapping->host;
+	struct orangefs_write_request *wr;
+	struct iov_iter iter;
+	struct bio_vec *bv;
+	ssize_t ret;
+	loff_t off;
+	int i;
+
+	bv = kcalloc(ORANGEFS_WRITEPAGES_COUNT, sizeof(struct bio_vec),
+	    GFP_KERNEL);
+	if (!bv)
+		return -ENOMEM;
+
+	for (i = 0; i < ow->npages; i++) {
+		set_page_writeback(ow->pages[i]);
+		bv[i].bv_page = ow->pages[i];
+		/* uh except the last one maybe... */
+		if (i == ow->npages - 1 && ow->len % PAGE_SIZE)
+			bv[i].bv_len = ow->len % PAGE_SIZE;
+		else
+			bv[i].bv_len = PAGE_SIZE;
+		bv[i].bv_offset = 0;
+	}
+	iov_iter_bvec(&iter, ITER_BVEC | WRITE, bv, ow->npages, ow->len);
+
+	off = ow->off;
+	ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter, ow->len,
+	    0, NULL);
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
+				wr = (struct orangefs_write_request *)
+				    page_private(ow->pages[i]);
+				ClearPagePrivate(ow->pages[i]);
+				wr_release(wr);
+			}
+			end_page_writeback(ow->pages[i]);
+			unlock_page(ow->pages[i]);
+		}
+	}
+	kfree(bv);
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
+			ow->pages[ow->npages++] = page;
+			ret = 0;
+		}
+		if (ow->off + ow->len == wr->pos) {
+			ow->len += wr->len;
+			ow->pages[ow->npages++] = page;
+			ret = 0;
+		}
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
@@ -325,6 +455,7 @@ static ssize_t orangefs_direct_IO(struct kiocb *iocb,
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

