Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D94C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D3A21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170871;
	bh=quRMAXt4hjMDtnBNH2qSNVlvrM8PCp2mVMmaQNS11h4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=fSgKRsDwVF4OVwQKgxIK/H91TLs1zu+kkEbxmOlFG7C66VKvPhq06L5DjQeVZCIkH
	 r7cxUvrX1KElJg1KPF1TWic3f6OB7jHBOGHMyVLzx0oWnRjyOghBwRZP63EICwptJZ
	 34rjoPulsKKlGl7hPQDjdBIyrQwfaQzS7LfGxv9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfAVP1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:27:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729619AbfAVPWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:22:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE71E217D4;
        Tue, 22 Jan 2019 15:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170554;
        bh=quRMAXt4hjMDtnBNH2qSNVlvrM8PCp2mVMmaQNS11h4=;
        h=From:To:Cc:Subject:Date:From;
        b=fPHBuwWnku70MXZERYQvmR/hgOe3S5XmaLJf90ckv5iDokIGOVnyDjn4ShBgaEFiG
         6LmWdui/FHiHaOs8U5GW2z3KZc+3BMD6HKyHGqa6F4p/r41Hm66lFw4j02x2c8z0bW
         Jbuio0AiGpDiqIYCX/bgnUMvQ1YfVlR4AtZNotzQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH] s390: kernel: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:02 +0100
Message-Id: <20190122152151.16139-3-gregkh@linuxfoundation.org>
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

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/debug.c    | 6 ------
 arch/s390/kernel/kdebugfs.c | 2 --
 arch/s390/kernel/sysinfo.c  | 2 --
 3 files changed, 10 deletions(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index d374f9b218b4..0ebf08c3b35e 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -1056,12 +1056,6 @@ int debug_register_view(debug_info_t *id, struct debug_view *view)
 		mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
 	pde = debugfs_create_file(view->name, mode, id->debugfs_root_entry,
 				  id, &debug_file_ops);
-	if (!pde) {
-		pr_err("Registering view %s/%s failed due to out of "
-		       "memory\n", id->name, view->name);
-		rc = -1;
-		goto out;
-	}
 	spin_lock_irqsave(&id->lock, flags);
 	for (i = 0; i < DEBUG_MAX_VIEWS; i++) {
 		if (!id->views[i])
diff --git a/arch/s390/kernel/kdebugfs.c b/arch/s390/kernel/kdebugfs.c
index 2c46bd6c6fd2..33130c7daf55 100644
--- a/arch/s390/kernel/kdebugfs.c
+++ b/arch/s390/kernel/kdebugfs.c
@@ -9,8 +9,6 @@ EXPORT_SYMBOL(arch_debugfs_dir);
 static int __init arch_kdebugfs_init(void)
 {
 	arch_debugfs_dir = debugfs_create_dir("s390", NULL);
-	if (IS_ERR(arch_debugfs_dir))
-		arch_debugfs_dir = NULL;
 	return 0;
 }
 postcore_initcall(arch_kdebugfs_init);
diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
index 12f80d1f0415..2ac3c9b56a13 100644
--- a/arch/s390/kernel/sysinfo.c
+++ b/arch/s390/kernel/sysinfo.c
@@ -545,8 +545,6 @@ static __init int stsi_init_debugfs(void)
 	int lvl, i;
 
 	stsi_root = debugfs_create_dir("stsi", arch_debugfs_dir);
-	if (IS_ERR_OR_NULL(stsi_root))
-		return 0;
 	lvl = stsi(NULL, 0, 0, 0);
 	if (lvl > 0)
 		stsi_0_0_0 = lvl;
-- 
2.20.1

