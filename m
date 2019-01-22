Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BA5C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F91217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548169119;
	bh=JssKERfluoLL++cBKjL1JZ7jtOSY5IhfmHDS3c2NyJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j6SaRUf+DKBy2X0Hcbw4Gj88gUWTzEjBuuxVcrrJrP63LLENK8cNJzw1vMWsGAmly
	 e1XKzoCH4XlBF8y/T3N6QDookwvC3SdKZGsv3yIbhGTsZrh2+vGwvu1eUR+5pDbvQV
	 bLWyP/v32F40diCV3l9d1M2DQdtViO7+wXQnwFXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfAVO6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:58:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728947AbfAVO6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:58:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 829AE20870;
        Tue, 22 Jan 2019 14:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548169115;
        bh=JssKERfluoLL++cBKjL1JZ7jtOSY5IhfmHDS3c2NyJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F88YiGUbuIDkcV5OMBNeMrExBnB6xxQzwEbEVgLUSXe27xiuUa6i9qRmyk7zEshEQ
         oSz+r4vROOd1cws4EZY3RdEXmxQ66h+0X8vdVAOXvXrnYms6X+WSglgttShKnY0V94
         LUhrWQequzXQV78riAMIuTTxfGJbXj8uhZBHAYp4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mathieu Malaterre <malat@debian.org>,
        Huacai Chen <chenhc@lemote.com>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Yasha Cherikovsky <yasha.che3@gmail.com>
Subject: [PATCH 5/5] mips: kernel: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 15:57:42 +0100
Message-Id: <20190122145742.11292-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122145742.11292-1-gregkh@linuxfoundation.org>
References: <20190122145742.11292-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Yangtao Li <tiny.windzz@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Mathieu Malaterre <malat@debian.org>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Marcin Nowakowski <marcin.nowakowski@mips.com>
Cc: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: linux-mips@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kernel/mips-r2-to-r6-emul.c | 21 ++++-----------------
 arch/mips/kernel/segment.c            | 15 +++------------
 arch/mips/kernel/setup.c              |  7 +------
 arch/mips/kernel/spinlock_test.c      | 21 ++++-----------------
 arch/mips/kernel/unaligned.c          | 16 ++++------------
 5 files changed, 16 insertions(+), 64 deletions(-)

diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
index c50c89a978f1..b4d210bfcdae 100644
--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -2351,23 +2351,10 @@ DEFINE_SHOW_ATTRIBUTE(mipsr2_clear);
 
 static int __init mipsr2_init_debugfs(void)
 {
-	struct dentry		*mipsr2_emul;
-
-	if (!mips_debugfs_dir)
-		return -ENODEV;
-
-	mipsr2_emul = debugfs_create_file("r2_emul_stats", S_IRUGO,
-					  mips_debugfs_dir, NULL,
-					  &mipsr2_emul_fops);
-	if (!mipsr2_emul)
-		return -ENOMEM;
-
-	mipsr2_emul = debugfs_create_file("r2_emul_stats_clear", S_IRUGO,
-					  mips_debugfs_dir, NULL,
-					  &mipsr2_clear_fops);
-	if (!mipsr2_emul)
-		return -ENOMEM;
-
+	debugfs_create_file("r2_emul_stats", S_IRUGO, mips_debugfs_dir, NULL,
+			    &mipsr2_emul_fops);
+	debugfs_create_file("r2_emul_stats_clear", S_IRUGO, mips_debugfs_dir,
+			    NULL, &mipsr2_clear_fops);
 	return 0;
 }
 
diff --git a/arch/mips/kernel/segment.c b/arch/mips/kernel/segment.c
index 2703f218202e..0a9bd7b0983b 100644
--- a/arch/mips/kernel/segment.c
+++ b/arch/mips/kernel/segment.c
@@ -95,18 +95,9 @@ static const struct file_operations segments_fops = {
 
 static int __init segments_info(void)
 {
-	struct dentry *segments;
-
-	if (cpu_has_segments) {
-		if (!mips_debugfs_dir)
-			return -ENODEV;
-
-		segments = debugfs_create_file("segments", S_IRUGO,
-					       mips_debugfs_dir, NULL,
-					       &segments_fops);
-		if (!segments)
-			return -ENOMEM;
-	}
+	if (cpu_has_segments)
+		debugfs_create_file("segments", S_IRUGO, mips_debugfs_dir, NULL,
+				    &segments_fops);
 	return 0;
 }
 
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 8c6c48ed786a..44434e50a355 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -1010,12 +1010,7 @@ unsigned long fw_passed_dtb;
 struct dentry *mips_debugfs_dir;
 static int __init debugfs_mips(void)
 {
-	struct dentry *d;
-
-	d = debugfs_create_dir("mips", NULL);
-	if (!d)
-		return -ENOMEM;
-	mips_debugfs_dir = d;
+	mips_debugfs_dir = debugfs_create_dir("mips", NULL);
 	return 0;
 }
 arch_initcall(debugfs_mips);
diff --git a/arch/mips/kernel/spinlock_test.c b/arch/mips/kernel/spinlock_test.c
index eaed550e79a2..ab4e3e1b138d 100644
--- a/arch/mips/kernel/spinlock_test.c
+++ b/arch/mips/kernel/spinlock_test.c
@@ -118,23 +118,10 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_multi, multi_get, NULL, "%llu\n");
 
 static int __init spinlock_test(void)
 {
-	struct dentry *d;
-
-	if (!mips_debugfs_dir)
-		return -ENODEV;
-
-	d = debugfs_create_file("spin_single", S_IRUGO,
-				mips_debugfs_dir, NULL,
-				&fops_ss);
-	if (!d)
-		return -ENOMEM;
-
-	d = debugfs_create_file("spin_multi", S_IRUGO,
-				mips_debugfs_dir, NULL,
-				&fops_multi);
-	if (!d)
-		return -ENOMEM;
-
+	debugfs_create_file("spin_single", S_IRUGO, mips_debugfs_dir, NULL,
+			    &fops_ss);
+	debugfs_create_file("spin_multi", S_IRUGO, mips_debugfs_dir, NULL,
+			    &fops_multi);
 	return 0;
 }
 device_initcall(spinlock_test);
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 595ca9c85111..0ed20a64b285 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -2374,18 +2374,10 @@ asmlinkage void do_ade(struct pt_regs *regs)
 #ifdef CONFIG_DEBUG_FS
 static int __init debugfs_unaligned(void)
 {
-	struct dentry *d;
-
-	if (!mips_debugfs_dir)
-		return -ENODEV;
-	d = debugfs_create_u32("unaligned_instructions", S_IRUGO,
-			       mips_debugfs_dir, &unaligned_instructions);
-	if (!d)
-		return -ENOMEM;
-	d = debugfs_create_u32("unaligned_action", S_IRUGO | S_IWUSR,
-			       mips_debugfs_dir, &unaligned_action);
-	if (!d)
-		return -ENOMEM;
+	debugfs_create_u32("unaligned_instructions", S_IRUGO, mips_debugfs_dir,
+			   &unaligned_instructions);
+	debugfs_create_u32("unaligned_action", S_IRUGO | S_IWUSR,
+			   mips_debugfs_dir, &unaligned_action);
 	return 0;
 }
 arch_initcall(debugfs_unaligned);
-- 
2.20.1

