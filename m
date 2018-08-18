Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533A3C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04774208D4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ge4ofGp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04774208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeHRQcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 12:32:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32958 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeHRQcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 12:32:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id x5-v6so5983377edr.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 06:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7wNQuEOW6DSm3DDPaI4dqIJbyGqUkfXPQ1MvlL0WjNs=;
        b=ge4ofGp6gzIM0NU+6XKOb7JNs6aK92vVTPoSHKJ2t7DolZcaip6+K1FwUw4hrqww+/
         gdS++Eg8BUuZuBdvmyc5wXd13tq337yWU7c2BjBRqutMfLkYoZP2N9rFMe8X1RcMgEtW
         IUn9A6PkbQZUxpA33nlMHzcDLdQtH3qndokjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7wNQuEOW6DSm3DDPaI4dqIJbyGqUkfXPQ1MvlL0WjNs=;
        b=Cksfer1dGEQyeZa9n85eIGZpWQ8eeGngE0MzxWI99bswLAZmeJgXnZQvbGqCkQLV1V
         yjuvtRrFGywGfRGQ97NMtGLtLTQTMyhof88xzxshCFmkGJjNMkKdnYfvBwRfKlgSYCDO
         yRMssH2/wTGzDE84dzSR/ij9bjWN5VG7nVpjRJrCa3GkBlmcU4s1pM2InZHvvIaqrfzn
         75z1DMhSILmDFqckiqG1bSf4wQ0z/nkSi6AZi/wrXU/+cn+sKg9DBdvHWGiNNNe+2MHa
         T7izAQj7ccDNhvx5n7qUW8/6fV7XE/WijuYtGgXKJFK8jd6KOoLb9Elw1/Todeg594lq
         3MBA==
X-Gm-Message-State: AOUpUlEaYNNK8GloUwOml70HC1aQHsBxsLlVK+adBnhKFePLo14tIZiE
        Na8f5KFCbHCPv+b/JmnnpwgPvw==
X-Google-Smtp-Source: AA+uWPxEiVYiygFltQBs/RMVWpl8ZpZlZOI2v8hcDdjEK2v/FDDmuICqC8Pw/dNGhjxGNflj+50mGQ==
X-Received: by 2002:a50:9493:: with SMTP id s19-v6mr46731159eda.285.1534598688597;
        Sat, 18 Aug 2018 06:24:48 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-212.cgn.ip.fibianet.dk. [5.186.114.212])
        by smtp.gmail.com with ESMTPSA id a11-v6sm2739032edn.95.2018.08.18.06.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Aug 2018 06:24:48 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     cluster-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 6/8] dlm: use seq_open_data in table_openN functions
Date:   Sat, 18 Aug 2018 15:24:32 +0200
Message-Id: <20180818132434.9515-6-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180818132434.9515-1-linux@rasmusvillemoes.dk>
References: <20180818132434.9515-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the seq_open_data helper simplifies these to oneliners.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Depends on 1/8 introducing seq_open_data.

fs/dlm/debug_fs.c | 44 ++++----------------------------------------
 1 file changed, 4 insertions(+), 40 deletions(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index fa08448e35dd..02892bca05b4 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -608,58 +608,22 @@ static const struct file_operations format4_fops;
 
 static int table_open1(struct inode *inode, struct file *file)
 {
-	struct seq_file *seq;
-	int ret;
-
-	ret = seq_open(file, &format1_seq_ops);
-	if (ret)
-		return ret;
-
-	seq = file->private_data;
-	seq->private = inode->i_private; /* the dlm_ls */
-	return 0;
+	return seq_open_data(file, &format1_seq_ops, inode->i_private);
 }
 
 static int table_open2(struct inode *inode, struct file *file)
 {
-	struct seq_file *seq;
-	int ret;
-
-	ret = seq_open(file, &format2_seq_ops);
-	if (ret)
-		return ret;
-
-	seq = file->private_data;
-	seq->private = inode->i_private; /* the dlm_ls */
-	return 0;
+	return seq_open_data(file, &format2_seq_ops, inode->i_private);
 }
 
 static int table_open3(struct inode *inode, struct file *file)
 {
-	struct seq_file *seq;
-	int ret;
-
-	ret = seq_open(file, &format3_seq_ops);
-	if (ret)
-		return ret;
-
-	seq = file->private_data;
-	seq->private = inode->i_private; /* the dlm_ls */
-	return 0;
+	return seq_open_data(file, &format3_seq_ops, inode->i_private);
 }
 
 static int table_open4(struct inode *inode, struct file *file)
 {
-	struct seq_file *seq;
-	int ret;
-
-	ret = seq_open(file, &format4_seq_ops);
-	if (ret)
-		return ret;
-
-	seq = file->private_data;
-	seq->private = inode->i_private; /* the dlm_ls */
-	return 0;
+	return seq_open_data(file, &format4_seq_ops, inode->i_private);
 }
 
 static const struct file_operations format1_fops = {
-- 
2.16.4

