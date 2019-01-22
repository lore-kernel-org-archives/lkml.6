Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3DBC282C5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EEA4217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170530;
	bh=nR1J8d5LtNfO/mqoIHCKhucG3tVtxmXGKdRWuUFm+yk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bP20anU7IoQU6OkOJhYFJQ5Qh9AC7qSDpMIn/PMLrGmLCeySN2GC+wcEqSLRYi/6G
	 yEpsbK+7FSXajwz8ciPF+f4is/LeOUevLW7fWseybPY8B54HdbENxR9wmN7rZUbg+C
	 04euHQxk2B3A1YGZt4g8y0xKVEZchipvO1bwaHqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbfAVPWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:22:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:33958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728836AbfAVPWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:22:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E7C9217D4;
        Tue, 22 Jan 2019 15:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170525;
        bh=nR1J8d5LtNfO/mqoIHCKhucG3tVtxmXGKdRWuUFm+yk=;
        h=From:To:Cc:Subject:Date:From;
        b=CaWmaZnsDgZzY7IvRRAVYw3uqaqOl8RPjW+JbSy3FFfAnxXTxh7xfnGx6m9v6aUH0
         XdWfo3e8zH1Y/JY7fhHM7F+jHn7xfX/9SGv+Z73VpWIhXoR05UAuQYdRmGTVli9Ob6
         i9CzYkhceLnUN3MFyNi7VxE/wLInctXTNFH87e6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-mm@kvack.org
Subject: [PATCH] hwpoison-inject: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:10 +0100
Message-Id: <20190122152151.16139-11-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: linux-mm@kvack.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/hwpoison-inject.c | 67 +++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 45 deletions(-)

diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index b6ac70616c32..36662d0097d5 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -76,63 +76,40 @@ static void pfn_inject_exit(void)
 
 static int pfn_inject_init(void)
 {
-	struct dentry *dentry;
-
 	hwpoison_dir = debugfs_create_dir("hwpoison", NULL);
-	if (hwpoison_dir == NULL)
-		return -ENOMEM;
 
 	/*
 	 * Note that the below poison/unpoison interfaces do not involve
 	 * hardware status change, hence do not require hardware support.
 	 * They are mainly for testing hwpoison in software level.
 	 */
-	dentry = debugfs_create_file("corrupt-pfn", 0200, hwpoison_dir,
-					  NULL, &hwpoison_fops);
-	if (!dentry)
-		goto fail;
-
-	dentry = debugfs_create_file("unpoison-pfn", 0200, hwpoison_dir,
-				     NULL, &unpoison_fops);
-	if (!dentry)
-		goto fail;
-
-	dentry = debugfs_create_u32("corrupt-filter-enable", 0600,
-				    hwpoison_dir, &hwpoison_filter_enable);
-	if (!dentry)
-		goto fail;
-
-	dentry = debugfs_create_u32("corrupt-filter-dev-major", 0600,
-				    hwpoison_dir, &hwpoison_filter_dev_major);
-	if (!dentry)
-		goto fail;
-
-	dentry = debugfs_create_u32("corrupt-filter-dev-minor", 0600,
-				    hwpoison_dir, &hwpoison_filter_dev_minor);
-	if (!dentry)
-		goto fail;
-
-	dentry = debugfs_create_u64("corrupt-filter-flags-mask", 0600,
-				    hwpoison_dir, &hwpoison_filter_flags_mask);
-	if (!dentry)
-		goto fail;
-
-	dentry = debugfs_create_u64("corrupt-filter-flags-value", 0600,
-				    hwpoison_dir, &hwpoison_filter_flags_value);
-	if (!dentry)
-		goto fail;
+	debugfs_create_file("corrupt-pfn", 0200, hwpoison_dir, NULL,
+			    &hwpoison_fops);
+
+	debugfs_create_file("unpoison-pfn", 0200, hwpoison_dir, NULL,
+			    &unpoison_fops);
+
+	debugfs_create_u32("corrupt-filter-enable", 0600, hwpoison_dir,
+			   &hwpoison_filter_enable);
+
+	debugfs_create_u32("corrupt-filter-dev-major", 0600, hwpoison_dir,
+			   &hwpoison_filter_dev_major);
+
+	debugfs_create_u32("corrupt-filter-dev-minor", 0600, hwpoison_dir,
+			   &hwpoison_filter_dev_minor);
+
+	debugfs_create_u64("corrupt-filter-flags-mask", 0600, hwpoison_dir,
+			   &hwpoison_filter_flags_mask);
+
+	debugfs_create_u64("corrupt-filter-flags-value", 0600, hwpoison_dir,
+			   &hwpoison_filter_flags_value);
 
 #ifdef CONFIG_MEMCG
-	dentry = debugfs_create_u64("corrupt-filter-memcg", 0600,
-				    hwpoison_dir, &hwpoison_filter_memcg);
-	if (!dentry)
-		goto fail;
+	debugfs_create_u64("corrupt-filter-memcg", 0600, hwpoison_dir,
+			   &hwpoison_filter_memcg);
 #endif
 
 	return 0;
-fail:
-	pfn_inject_exit();
-	return -ENOMEM;
 }
 
 module_init(pfn_inject_init);
-- 
2.20.1

