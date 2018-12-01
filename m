Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F9BC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8477020867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEfhJNWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8477020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeLBBGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 20:06:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45478 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbeLBBGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 20:06:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so3728354pgc.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 05:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6oDL80I1M15Z0yu2uqdDVUXucNvaCq5vy3zskrfxhCM=;
        b=qEfhJNWLe1DCf9z6JvsJBW+3OQS4ddTvIg/jT5UyZGEuYHOmGWIYRTKmv4+CoW+l22
         guHd2SelozgpNJQjbIFsBDaOyEX+rnipEYc52x1QPINhx7/nfKQmFMAiXzrFHk0AYiru
         cHOs/IVtwkMMgZD57Q4ZXLeAdV+QLhi1Q83JWHipCUpEcGZCJB83HP7R9rFLL03rtm7D
         3y6TyESsm9S59cGywO8glk6A1LgkZZpybM9D76jMnyyCmyXhPc/IrlxLTvT79YiGHwcR
         sW34dCkd2XwpUCyChnxhHbxUvhv15lgNHYksbgsn8pwQShMintHFh5MXwue7KLVf6yq7
         gDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6oDL80I1M15Z0yu2uqdDVUXucNvaCq5vy3zskrfxhCM=;
        b=tdNsxHZ9F46s0/1Pd6zfx6dGpMuAuiL/zbuD/8tttd3/FamcG7xD6WFEfLos6ntU0z
         LYtdFI7Eorl5w0j4OcwiigePjR2/aKFgW4O23docpIwVmpOLXZY2R5IhPfsd5m5XRA6D
         IdCuSptkHcV+9MrPELZeyHMnf/FtJLD89YLtZsFn+jhBupGzX6piLnEcHz3GnQpdyAtN
         CrPZQ0iiz4kQJii5Rhrty38vxHrlX9ZG1o/4I0+Z5lP775zucazU5UG1CcvG8uXCBBrU
         fE4UG8qTxINU5qLVyZRjrYzkKhBGyCjgLTEFeBsaplbCLLNJLYVFMhEJRkpFyjY0HbdG
         h7pg==
X-Gm-Message-State: AA+aEWbmiGxerZUGf0hhvheWwzQoqkhKHxiPkFUpEo4mxKuNlqabJJxq
        g7l5e+Zre6tlRqT5IWHxJDU=
X-Google-Smtp-Source: AFSGD/Vk9TwsfKZ5AJxzv2K7ik6Wu4AD0YT4Anu7N/GMylUljLhR0r0QiYj/gZz5PZ3LUs2op31E0w==
X-Received: by 2002:aa7:810c:: with SMTP id b12mr9297993pfi.44.1543672447946;
        Sat, 01 Dec 2018 05:54:07 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id t2sm14754847pfm.32.2018.12.01.05.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 05:54:07 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     ebiederm@xmission.com
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] RAS/CEC: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat,  1 Dec 2018 08:54:04 -0500
Message-Id: <20181201135404.7470-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/ras/cec.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 2d9ec378a8bc..05301ef4820e 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -400,7 +400,7 @@ static int count_threshold_set(void *data, u64 val)
 }
 DEFINE_DEBUGFS_ATTRIBUTE(count_threshold_ops, u64_get, count_threshold_set, "%lld\n");
 
-static int array_dump(struct seq_file *m, void *v)
+static int array_show(struct seq_file *m, void *v)
 {
 	struct ce_array *ca = &ce_arr;
 	u64 prev = 0;
@@ -436,18 +436,7 @@ static int array_dump(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int array_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, array_dump, NULL);
-}
-
-static const struct file_operations array_ops = {
-	.owner	 = THIS_MODULE,
-	.open	 = array_open,
-	.read	 = seq_read,
-	.llseek	 = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(array);
 
 static int __init create_debugfs_nodes(void)
 {
@@ -459,13 +448,15 @@ static int __init create_debugfs_nodes(void)
 		return -1;
 	}
 
-	pfn = debugfs_create_file("pfn", S_IRUSR | S_IWUSR, d, &dfs_pfn, &pfn_ops);
+	pfn = debugfs_create_file("pfn", S_IRUSR | S_IWUSR, d,
+				    &dfs_pfn, &pfn_ops);
 	if (!pfn) {
 		pr_warn("Error creating pfn debugfs node!\n");
 		goto err;
 	}
 
-	array = debugfs_create_file("array", S_IRUSR, d, NULL, &array_ops);
+	array = debugfs_create_file("array", S_IRUSR, d, NULL,
+				    &array_fops);
 	if (!array) {
 		pr_warn("Error creating array debugfs node!\n");
 		goto err;
-- 
2.17.0

