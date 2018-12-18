Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D46C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EC821850
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeLRMKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:10:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51515 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbeLRMKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:10:00 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIC9r6L2825148
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 04:09:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIC9rNI2825145;
        Tue, 18 Dec 2018 04:09:53 -0800
Date:   Tue, 18 Dec 2018 04:09:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yangtao Li <tipbot@zytor.com>
Message-ID: <tip-6848ac7ca39a226ede5df7af0efcc4ef0611e99c@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tiny.windzz@gmail.com,
        mingo@kernel.org, dave.hansen@linux.intel.com, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: tiny.windzz@gmail.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          dave.hansen@linux.intel.com, hpa@zytor.com
In-Reply-To: <20181119154334.18265-1-tiny.windzz@gmail.com>
References: <20181119154334.18265-1-tiny.windzz@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/dump_pagetables: Use DEFINE_SHOW_ATTRIBUTE()
Git-Commit-ID: 6848ac7ca39a226ede5df7af0efcc4ef0611e99c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6848ac7ca39a226ede5df7af0efcc4ef0611e99c
Gitweb:     https://git.kernel.org/tip/6848ac7ca39a226ede5df7af0efcc4ef0611e99c
Author:     Yangtao Li <tiny.windzz@gmail.com>
AuthorDate: Mon, 19 Nov 2018 10:43:34 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 18 Dec 2018 13:05:54 +0100

x86/mm/dump_pagetables: Use DEFINE_SHOW_ATTRIBUTE()

Use DEFINE_SHOW_ATTRIBUTE() instead of open coding it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: keescook@chromium.org
Cc: luto@kernel.org
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20181119154334.18265-1-tiny.windzz@gmail.com

---
 arch/x86/mm/debug_pagetables.c | 58 +++++-------------------------------------
 1 file changed, 7 insertions(+), 51 deletions(-)

diff --git a/arch/x86/mm/debug_pagetables.c b/arch/x86/mm/debug_pagetables.c
index 225fe2f0bfec..cd84f067e41d 100644
--- a/arch/x86/mm/debug_pagetables.c
+++ b/arch/x86/mm/debug_pagetables.c
@@ -10,20 +10,9 @@ static int ptdump_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int ptdump_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, ptdump_show, NULL);
-}
-
-static const struct file_operations ptdump_fops = {
-	.owner		= THIS_MODULE,
-	.open		= ptdump_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ptdump);
 
-static int ptdump_show_curknl(struct seq_file *m, void *v)
+static int ptdump_curknl_show(struct seq_file *m, void *v)
 {
 	if (current->mm->pgd) {
 		down_read(&current->mm->mmap_sem);
@@ -33,23 +22,12 @@ static int ptdump_show_curknl(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int ptdump_open_curknl(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, ptdump_show_curknl, NULL);
-}
-
-static const struct file_operations ptdump_curknl_fops = {
-	.owner		= THIS_MODULE,
-	.open		= ptdump_open_curknl,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ptdump_curknl);
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 static struct dentry *pe_curusr;
 
-static int ptdump_show_curusr(struct seq_file *m, void *v)
+static int ptdump_curusr_show(struct seq_file *m, void *v)
 {
 	if (current->mm->pgd) {
 		down_read(&current->mm->mmap_sem);
@@ -59,42 +37,20 @@ static int ptdump_show_curusr(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int ptdump_open_curusr(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, ptdump_show_curusr, NULL);
-}
-
-static const struct file_operations ptdump_curusr_fops = {
-	.owner		= THIS_MODULE,
-	.open		= ptdump_open_curusr,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ptdump_curusr);
 #endif
 
 #if defined(CONFIG_EFI) && defined(CONFIG_X86_64)
 static struct dentry *pe_efi;
 
-static int ptdump_show_efi(struct seq_file *m, void *v)
+static int ptdump_efi_show(struct seq_file *m, void *v)
 {
 	if (efi_mm.pgd)
 		ptdump_walk_pgd_level_debugfs(m, efi_mm.pgd, false);
 	return 0;
 }
 
-static int ptdump_open_efi(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, ptdump_show_efi, NULL);
-}
-
-static const struct file_operations ptdump_efi_fops = {
-	.owner		= THIS_MODULE,
-	.open		= ptdump_open_efi,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ptdump_efi);
 #endif
 
 static struct dentry *dir, *pe_knl, *pe_curknl;
