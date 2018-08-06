Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A09BC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5250D21A6C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OAcU0W8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5250D21A6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbeHFSy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:54:29 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:37058 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730503AbeHFSy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:54:29 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id E078A24E0513;
        Mon,  6 Aug 2018 09:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1533573874; bh=xusQBT7Tx5DnvNgWHCuXP4/Vag/vTHQUvbeKwVs2aCM=;
        h=From:To:Cc:Subject:Date:From;
        b=OAcU0W8FY45Tfe1jYcYp/uhGbSXEnub739xcxRjC4h1kGh0yo6HTZ9Igu7muUnx4D
         qTQBSdKSMmfzgB0hC0OEC1neXDJVKLunL11Bc38smUeYsBwYopf+3fZDTegFXl/ojn
         EJdeOyLzPyCjNnpD/O2vSF3tJ5Wj4lwRbHnGfGMTOtJjHKJoCvOzsxVQt4p9R26Cbj
         7LFrnksRjObyAzwr9AlwJvhQy9nLdBo35p1EfNYwlE21w2Jwrl4q4m1efeNRlJIl7o
         C3b+ucEvi2yZpz9EqIgn0s8ZfefV4Xww42VKiEqHtBgMNyKZwFUDjxt/8CfmIh++r5
         rVqiphymqCXyw==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.86])
        by mailhost.synopsys.com (Postfix) with ESMTP id DF0325155;
        Mon,  6 Aug 2018 09:44:31 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 1/2] ARC: show_faulting_vma: remove unused variables
Date:   Mon,  6 Aug 2018 19:44:23 +0300
Message-Id: <20180806164424.32439-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get 'inode', 'dev', and 'ino' in show_faulting_vma()
but never use them. So get rid of this variables and corresponding
code.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/kernel/troubleshoot.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoot.c
index 783b20354f8b..f7330a3a1c4d 100644
--- a/arch/arc/kernel/troubleshoot.c
+++ b/arch/arc/kernel/troubleshoot.c
@@ -83,9 +83,6 @@ static void print_task_path_n_nm(struct task_struct *tsk, char *buf)
 static void show_faulting_vma(unsigned long address, char *buf)
 {
 	struct vm_area_struct *vma;
-	struct inode *inode;
-	unsigned long ino = 0;
-	dev_t dev = 0;
 	char *nm = buf;
 	struct mm_struct *active_mm = current->active_mm;
 
@@ -99,12 +96,8 @@ static void show_faulting_vma(unsigned long address, char *buf)
 	 * if the container VMA is not found
 	 */
 	if (vma && (vma->vm_start <= address)) {
-		struct file *file = vma->vm_file;
-		if (file) {
-			nm = file_path(file, buf, PAGE_SIZE - 1);
-			inode = file_inode(vma->vm_file);
-			dev = inode->i_sb->s_dev;
-			ino = inode->i_ino;
+		if (vma->vm_file) {
+			nm = file_path(vma->vm_file, buf, PAGE_SIZE - 1);
 		}
 		pr_info("    @off 0x%lx in [%s]\n"
 			"    VMA: 0x%08lx to 0x%08lx\n",
-- 
2.14.4

