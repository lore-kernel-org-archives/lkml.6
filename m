Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38845C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36D320867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QW0W3/jl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36D320867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeLADUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:20:53 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36274 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeLADUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:20:53 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so3036442plo.3;
        Fri, 30 Nov 2018 08:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Rr/Hq9KzXdJ4IDycJi5BYWufMJuCHtFtIvdftRharWQ=;
        b=QW0W3/jljDoxeuScOaaD9QtxwGr1qzPVmLGEML1xjDvRIOf8JCk8HwjwSLZ/iLjlL7
         K6VrTG381QoeyJA0v+S7SWAgQx0bBtKJlrYxG8MB4G2iPfN0f7wLtYSmk2rfCwEeb9tu
         QOYZ/KBYC3A3wYF8+WKIdfvh/gcR+Jr9Owi22Ykvv7qdBval1wwUdPkLtSNEjQWPzUnV
         GC0qhF3bsuX2N9jVGX053GxdPY2z8wq5Lx3kAiPOXwxFWxbDq8DNqWyh6UaeJHnRWqjS
         n+kKbzfPln6zovKf1VihkrgbLtC+GxBRgvJ+PREhbnmN+nPQL+hWOAfbly6fZFjeMqra
         ZB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rr/Hq9KzXdJ4IDycJi5BYWufMJuCHtFtIvdftRharWQ=;
        b=RIH6GfFaLDG2WWPjXZiKTFJbK9Kql5tdjFoF/XAR01vhVBaFWONJ7jHD7L7DlcqFvf
         pCoG4H7hWq65jxUbZOomWUg9cgKiBvr6f6yPbNV7okYu74BCavsIoP6JF5d4CDwlieAV
         kNkVyqEjhp5897rgaqiojNakYmF2LUdTHMDjGXNSC/L/CAG9UHuJOVqC7ZNN7Z8VQa8q
         NjSFzhShQjpdBWCRfWcX5UqHSi5xJdM7ezo6khanpub/6yanm316CB35LPDBUXqxCQKS
         j5bEo2YCzZSZT8bB554QfzCf5hpTMFdqjRBJBISnx/RVZrhT2ybn8b7Tmo8v8xRBmQ2N
         CbTw==
X-Gm-Message-State: AA+aEWZa7ByKrDB3VMbj+NdmT1g/1LcRmIhSM1MlFnpM2ZQQgu78XJuQ
        euJ17iupgByQAC1UolbMehM=
X-Google-Smtp-Source: AFSGD/W7VoxPLKHy3//JHb4UjAowC6/6RiiGZj+63b65PXp4dn4bXhNLFV8WDV3apFSguDtdDrgVBw==
X-Received: by 2002:a17:902:31a4:: with SMTP id x33mr6124336plb.41.1543594264531;
        Fri, 30 Nov 2018 08:11:04 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id z62sm8365223pfl.33.2018.11.30.08.11.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 08:11:03 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     sumit.semwal@linaro.org, gustavo@padovan.org
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] dma-buf: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Fri, 30 Nov 2018 11:11:01 -0500
Message-Id: <20181130161101.3413-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/dma-buf/dma-buf.c    | 12 +-----------
 drivers/dma-buf/sync_debug.c | 16 +++-------------
 2 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 02f7f9a89979..7c858020d14b 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1093,17 +1093,7 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int dma_buf_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, dma_buf_debug_show, NULL);
-}
-
-static const struct file_operations dma_buf_debug_fops = {
-	.open           = dma_buf_debug_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(dma_buf_debug);
 
 static struct dentry *dma_buf_debugfs_dir;
 
diff --git a/drivers/dma-buf/sync_debug.c b/drivers/dma-buf/sync_debug.c
index c4c8ecb24aa9..c0abf37df88b 100644
--- a/drivers/dma-buf/sync_debug.c
+++ b/drivers/dma-buf/sync_debug.c
@@ -147,7 +147,7 @@ static void sync_print_sync_file(struct seq_file *s,
 	}
 }
 
-static int sync_debugfs_show(struct seq_file *s, void *unused)
+static int sync_info_debugfs_show(struct seq_file *s, void *unused)
 {
 	struct list_head *pos;
 
@@ -178,17 +178,7 @@ static int sync_debugfs_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int sync_info_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, sync_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations sync_info_debugfs_fops = {
-	.open           = sync_info_debugfs_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(sync_info_debugfs);
 
 static __init int sync_debugfs_init(void)
 {
@@ -218,7 +208,7 @@ void sync_dump(void)
 	};
 	int i;
 
-	sync_debugfs_show(&s, NULL);
+	sync_info_debugfs_show(&s, NULL);
 
 	for (i = 0; i < s.count; i += DUMP_CHUNK) {
 		if ((s.count - i) > DUMP_CHUNK) {
-- 
2.17.0

