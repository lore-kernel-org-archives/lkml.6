Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC4DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6C9217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548167789;
	bh=GlOtG8I8bkDK4QMuHaO0T7lRQJHmWjFX3ZSSSxETYAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2P1eGW+L44zbEmo3xnkhJ4YE4mA8U/LCFA3Zij65tsEQlRdvDY6QFqfiTy7/4Z4Rg
	 AR75XTBchlqRjrj/MG1WB9+GZfIKlpBBSDSGNYsJ8kjOlNUiyyYz/8DABBDoCzPrAP
	 gyWZfnlYW4YZhU6rj/pZVdsrK7Ja+Kvs0nclWvbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbfAVOg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:36:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:49874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728671AbfAVOg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:36:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA06421726;
        Tue, 22 Jan 2019 14:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548167785;
        bh=GlOtG8I8bkDK4QMuHaO0T7lRQJHmWjFX3ZSSSxETYAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W5nDwsQstJ0z1aCpv3wHiMkcmZoBfuppY+/GzA4vFWqK9xcYL/n9Ohmi55FVOmnmF
         fgFEqTtKaUXmrNc528KiAsIlJMwyRDKyMURudJbjglhvN9qnb32JZ3y+YGNTrAMvZ+
         L/ilH/jgy/3J1by7PiN1FGlkLrBGHyQ/UOY4mJes=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 4/6] x86: mm: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 15:35:40 +0100
Message-Id: <20190122143542.8816-5-gregkh@linuxfoundation.org>
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

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/debug_pagetables.c | 35 +++++++---------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/arch/x86/mm/debug_pagetables.c b/arch/x86/mm/debug_pagetables.c
index cd84f067e41d..1f23bea5da87 100644
--- a/arch/x86/mm/debug_pagetables.c
+++ b/arch/x86/mm/debug_pagetables.c
@@ -25,8 +25,6 @@ static int ptdump_curknl_show(struct seq_file *m, void *v)
 DEFINE_SHOW_ATTRIBUTE(ptdump_curknl);
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
-static struct dentry *pe_curusr;
-
 static int ptdump_curusr_show(struct seq_file *m, void *v)
 {
 	if (current->mm->pgd) {
@@ -41,8 +39,6 @@ DEFINE_SHOW_ATTRIBUTE(ptdump_curusr);
 #endif
 
 #if defined(CONFIG_EFI) && defined(CONFIG_X86_64)
-static struct dentry *pe_efi;
-
 static int ptdump_efi_show(struct seq_file *m, void *v)
 {
 	if (efi_mm.pgd)
@@ -53,41 +49,24 @@ static int ptdump_efi_show(struct seq_file *m, void *v)
 DEFINE_SHOW_ATTRIBUTE(ptdump_efi);
 #endif
 
-static struct dentry *dir, *pe_knl, *pe_curknl;
+static struct dentry *dir;
 
 static int __init pt_dump_debug_init(void)
 {
 	dir = debugfs_create_dir("page_tables", NULL);
-	if (!dir)
-		return -ENOMEM;
-
-	pe_knl = debugfs_create_file("kernel", 0400, dir, NULL,
-				     &ptdump_fops);
-	if (!pe_knl)
-		goto err;
 
-	pe_curknl = debugfs_create_file("current_kernel", 0400,
-					dir, NULL, &ptdump_curknl_fops);
-	if (!pe_curknl)
-		goto err;
+	debugfs_create_file("kernel", 0400, dir, NULL, &ptdump_fops);
+	debugfs_create_file("current_kernel", 0400, dir, NULL,
+			    &ptdump_curknl_fops);
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
-	pe_curusr = debugfs_create_file("current_user", 0400,
-					dir, NULL, &ptdump_curusr_fops);
-	if (!pe_curusr)
-		goto err;
+	debugfs_create_file("current_user", 0400, dir, NULL,
+			    &ptdump_curusr_fops);
 #endif
-
 #if defined(CONFIG_EFI) && defined(CONFIG_X86_64)
-	pe_efi = debugfs_create_file("efi", 0400, dir, NULL, &ptdump_efi_fops);
-	if (!pe_efi)
-		goto err;
+	debugfs_create_file("efi", 0400, dir, NULL, &ptdump_efi_fops);
 #endif
-
 	return 0;
-err:
-	debugfs_remove_recursive(dir);
-	return -ENOMEM;
 }
 
 static void __exit pt_dump_debug_exit(void)
-- 
2.20.1

