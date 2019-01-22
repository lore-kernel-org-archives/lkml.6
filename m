Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34D8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBA0217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548167800;
	bh=rBEt2r9mzWrR/uvjIPxqYL3nG9xM3niqdNj63RlvBR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zbJ6lbUweP4LtOBnd7uiPlVDkxWr4MncIijYNWvZ4mt9B4W2nVfe6gUQYvnvwk5od
	 CLFpMdve/buxOjBAxSEMw/GQpgWfZeoIe2d4+Sc/TtzIKQVbnhPxyZxY6i7d3goRlb
	 mZ6f6MoSmC2xRHuQqKX7dCCCd8EAkrEW6yyFPBg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfAVOgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:36:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:50112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbfAVOgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:36:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1D3E21721;
        Tue, 22 Jan 2019 14:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548167794;
        bh=rBEt2r9mzWrR/uvjIPxqYL3nG9xM3niqdNj63RlvBR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eaygyKMSzI8vss5/OXXE82mNF7QunolxdXHBIHUkO16bmzUHhBYnFy0Swj5GfkOwp
         u1CgqeQEgCbv8szeaCQnry/EDYOSxkaqy6LxnhsUFcdL3/LA7s4qmC/5DWeeuEQdLE
         8W5Ez9x8wjfrvE2efVm2LI0QyGQDhxPwbh1FdHZo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/6] x86: kdebugfs: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 15:35:38 +0100
Message-Id: <20190122143542.8816-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122143542.8816-1-gregkh@linuxfoundation.org>
References: <20190122143542.8816-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/kdebugfs.c | 60 +++++++-------------------------------
 1 file changed, 11 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kernel/kdebugfs.c b/arch/x86/kernel/kdebugfs.c
index fd6f8fbbe6f2..0758e7ca8977 100644
--- a/arch/x86/kernel/kdebugfs.c
+++ b/arch/x86/kernel/kdebugfs.c
@@ -68,33 +68,18 @@ static const struct file_operations fops_setup_data = {
 	.llseek		= default_llseek,
 };
 
-static int __init
+static void __init
 create_setup_data_node(struct dentry *parent, int no,
 		       struct setup_data_node *node)
 {
-	struct dentry *d, *type, *data;
+	struct dentry *d;
 	char buf[16];
 
 	sprintf(buf, "%d", no);
 	d = debugfs_create_dir(buf, parent);
-	if (!d)
-		return -ENOMEM;
-
-	type = debugfs_create_x32("type", S_IRUGO, d, &node->type);
-	if (!type)
-		goto err_dir;
-
-	data = debugfs_create_file("data", S_IRUGO, d, node, &fops_setup_data);
-	if (!data)
-		goto err_type;
 
-	return 0;
-
-err_type:
-	debugfs_remove(type);
-err_dir:
-	debugfs_remove(d);
-	return -ENOMEM;
+	debugfs_create_x32("type", S_IRUGO, d, &node->type);
+	debugfs_create_file("data", S_IRUGO, d, node, &fops_setup_data);
 }
 
 static int __init create_setup_data_nodes(struct dentry *parent)
@@ -107,8 +92,6 @@ static int __init create_setup_data_nodes(struct dentry *parent)
 	int no = 0;
 
 	d = debugfs_create_dir("setup_data", parent);
-	if (!d)
-		return -ENOMEM;
 
 	pa_data = boot_params.hdr.setup_data;
 
@@ -129,19 +112,17 @@ static int __init create_setup_data_nodes(struct dentry *parent)
 		node->paddr = pa_data;
 		node->type = data->type;
 		node->len = data->len;
-		error = create_setup_data_node(d, no, node);
+		create_setup_data_node(d, no, node);
 		pa_data = data->next;
 
 		memunmap(data);
-		if (error)
-			goto err_dir;
 		no++;
 	}
 
 	return 0;
 
 err_dir:
-	debugfs_remove(d);
+	debugfs_remove_recursive(d);
 	return error;
 }
 
@@ -152,35 +133,18 @@ static struct debugfs_blob_wrapper boot_params_blob = {
 
 static int __init boot_params_kdebugfs_init(void)
 {
-	struct dentry *dbp, *version, *data;
-	int error = -ENOMEM;
+	struct dentry *dbp;
+	int error;
 
 	dbp = debugfs_create_dir("boot_params", arch_debugfs_dir);
-	if (!dbp)
-		return -ENOMEM;
-
-	version = debugfs_create_x16("version", S_IRUGO, dbp,
-				     &boot_params.hdr.version);
-	if (!version)
-		goto err_dir;
 
-	data = debugfs_create_blob("data", S_IRUGO, dbp,
-				   &boot_params_blob);
-	if (!data)
-		goto err_version;
+	debugfs_create_x16("version", S_IRUGO, dbp, &boot_params.hdr.version);
+	debugfs_create_blob("data", S_IRUGO, dbp, &boot_params_blob);
 
 	error = create_setup_data_nodes(dbp);
 	if (error)
-		goto err_data;
+		debugfs_remove_recursive(dbp);
 
-	return 0;
-
-err_data:
-	debugfs_remove(data);
-err_version:
-	debugfs_remove(version);
-err_dir:
-	debugfs_remove(dbp);
 	return error;
 }
 #endif /* CONFIG_DEBUG_BOOT_PARAMS */
@@ -190,8 +154,6 @@ static int __init arch_kdebugfs_init(void)
 	int error = 0;
 
 	arch_debugfs_dir = debugfs_create_dir("x86", NULL);
-	if (!arch_debugfs_dir)
-		return -ENOMEM;
 
 #ifdef CONFIG_DEBUG_BOOT_PARAMS
 	error = boot_params_kdebugfs_init();
-- 
2.20.1

