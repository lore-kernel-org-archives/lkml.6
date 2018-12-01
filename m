Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5417BC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107F520867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRBx96VP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107F520867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeLANRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 08:17:47 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46516 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeLANRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 08:17:47 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so3647651pfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 18:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SSA5TnzfDQsfAfea8WFOyZtPpiN8FlBMkhpgzpWewPw=;
        b=jRBx96VPYRDFWjZMTIGQUSOeVpmEkfuplfySTaB7XRzNDVwbUxfGelfjqSJiYyhJar
         a0aYs99SZA1ZV/Eut590ah8rjGcEi9ZdL7DZ8re3UhjqWwyDBeMNLK9yG6PNcw1Q14v5
         7Q+lsyAX5CJepIb3O55aLVhnDyxWjs8x3Vm6IOzL0DmNIJgGYjEFTtbmkqSAToUD9ymz
         wBSzCh4kub8fR9YKpnINTHDvx4YRwqman5SKh4EU4L+fA2fQ3gzkek+KmLCzh7bpHjqR
         qhbuZF6Nns/hzzL80mkJNB6ldIqVgMl3FudmEVKuyJWwK+NPD8t8FYJCyO9urF4X/m34
         S+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SSA5TnzfDQsfAfea8WFOyZtPpiN8FlBMkhpgzpWewPw=;
        b=rRqE9M5RM3vdocoHsURFjIExPH9KsPyds0FCwPa0f2ehrh+gyOJWsLHTqj3zqPSvJ+
         HjosITnh2sXyYTeeER3rLWcJ4PqMNMqMf0RBHyeLfr0GNE9lx1RlN1xTBNVnTAF/wLGq
         Os6ONtLHJT0u5UPRtuQ9KqWne72myO2B/sxPvYTEay3XTXU5PowL9LM72kZLh5vwgDpA
         Jt83pvYwr9hAjEIlsHoAwRWtUuuC8YrvWOFbBdhPMwmpXpHOCuqAANHMDN8JNOswA1M2
         /Do94edHpVCCOthrr9YTyDRlD+4lER/ROsWQb0a5ChT6g5EJaX4BmFXhSlIe7B5NXmhA
         wuUw==
X-Gm-Message-State: AA+aEWYeWgw2Hr0IcLom1BdBk72cDJd1IO64U+WOCN+FiK02RYG3g9cd
        LB2GYc4m88l3gliZIB/WGKU=
X-Google-Smtp-Source: AFSGD/W/t6RWQD9I8vPkgU+1YiePophuwdLtxwavhO7tqEOji2Q6+wsIumU6+jWvXa3SJQHbS4FXzA==
X-Received: by 2002:a63:4456:: with SMTP id t22mr6892140pgk.0.1543629986855;
        Fri, 30 Nov 2018 18:06:26 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 184sm8799304pfe.106.2018.11.30.18.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 18:06:26 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rubini@gnudd.com
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] drivers/fmc: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Fri, 30 Nov 2018 21:06:24 -0500
Message-Id: <20181201020624.4854-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/fmc/fmc-debug.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/fmc/fmc-debug.c b/drivers/fmc/fmc-debug.c
index 32930722770c..c923d076c807 100644
--- a/drivers/fmc/fmc-debug.c
+++ b/drivers/fmc/fmc-debug.c
@@ -114,7 +114,7 @@ static void fmc_sdb_dump_recursive(struct fmc_device *fmc, struct seq_file *s,
 	}
 }
 
-static int fmc_sdb_dump(struct seq_file *s, void *offset)
+static int fmc_sdb_dump_show(struct seq_file *s, void *offset)
 {
 	struct fmc_device *fmc = s->private;
 
@@ -131,22 +131,7 @@ static int fmc_sdb_dump(struct seq_file *s, void *offset)
 	return 0;
 }
 
-
-static int fmc_sdb_dump_open(struct inode *inode, struct file *file)
-{
-	struct fmc_device *fmc = inode->i_private;
-
-	return single_open(file, fmc_sdb_dump, fmc);
-}
-
-
-const struct file_operations fmc_dbgfs_sdb_dump = {
-	.owner = THIS_MODULE,
-	.open  = fmc_sdb_dump_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(fmc_sdb_dump);
 
 int fmc_debug_init(struct fmc_device *fmc)
 {
@@ -158,7 +143,7 @@ int fmc_debug_init(struct fmc_device *fmc)
 
 	fmc->dbg_sdb_dump = debugfs_create_file(FMC_DBG_SDB_DUMP, 0444,
 						fmc->dbg_dir, fmc,
-						&fmc_dbgfs_sdb_dump);
+						&fmc_sdb_dump_fops);
 	if (IS_ERR_OR_NULL(fmc->dbg_sdb_dump))
 		pr_err("FMC: Cannot create debugfs file %s\n",
 		       FMC_DBG_SDB_DUMP);
-- 
2.17.0

