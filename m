Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F367C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0CA20855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548168095;
	bh=8BjUBVZCmrAANyhj3BZe6P8VfjTGGURJDzipiOghw9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=17cgvJU0Lcr6D2XPJoQQyCbeiSo7P64F3LLOLjkNSh+vw1E4F8q98G/LkntUZrPs5
	 tBRxqh3pkbZwg2ej4T6OQNg5+XkDejqjlqtJGzsEScY4/hOFdBnbFnUejo2kY1P44E
	 TX4V1NQnASEn0CB6PreKvdtsoEaDLnUbCFnWFgaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfAVOld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:41:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:53360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728318AbfAVOlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:41:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1438621721;
        Tue, 22 Jan 2019 14:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548168090;
        bh=8BjUBVZCmrAANyhj3BZe6P8VfjTGGURJDzipiOghw9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jjA1JZCXKIIzmIlK9iATEw2pkvtdWfFyrg8yAp+kgKzJvqrN7hM3ca6BwXzTDXHKI
         a3Mn3P2wv99+NRlMTtvqPpUL45tDwysnbj/6W/WW7PHhqKbycILLDk4f22Fs+sLtSc
         bDw4HkWPE4/qKXQrwfeckH4qUKmF68NxAmPC6zbM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jinbum Park <jinb.park7@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>
Subject: [PATCH 2/4] arm: dump: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 15:41:12 +0100
Message-Id: <20190122144114.9816-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122144114.9816-1-gregkh@linuxfoundation.org>
References: <20190122144114.9816-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Jinbum Park <jinb.park7@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <labbott@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/ptdump.h | 9 +++------
 arch/arm/mm/dump.c            | 4 ++--
 arch/arm/mm/ptdump_debugfs.c  | 8 ++------
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/ptdump.h b/arch/arm/include/asm/ptdump.h
index 3ebf9718288d..0c2d3d0d4cc6 100644
--- a/arch/arm/include/asm/ptdump.h
+++ b/arch/arm/include/asm/ptdump.h
@@ -21,13 +21,10 @@ struct ptdump_info {
 
 void ptdump_walk_pgd(struct seq_file *s, struct ptdump_info *info);
 #ifdef CONFIG_ARM_PTDUMP_DEBUGFS
-int ptdump_debugfs_register(struct ptdump_info *info, const char *name);
+void ptdump_debugfs_register(struct ptdump_info *info, const char *name);
 #else
-static inline int ptdump_debugfs_register(struct ptdump_info *info,
-					const char *name)
-{
-	return 0;
-}
+static inline void ptdump_debugfs_register(struct ptdump_info *info,
+					   const char *name) { }
 #endif /* CONFIG_ARM_PTDUMP_DEBUGFS */
 
 void ptdump_check_wx(void);
diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
index 084779c5c893..eb385a500ed0 100644
--- a/arch/arm/mm/dump.c
+++ b/arch/arm/mm/dump.c
@@ -450,7 +450,7 @@ void ptdump_check_wx(void)
 static int ptdump_init(void)
 {
 	ptdump_initialize();
-	return ptdump_debugfs_register(&kernel_ptdump_info,
-					"kernel_page_tables");
+	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
+	return 0;
 }
 __initcall(ptdump_init);
diff --git a/arch/arm/mm/ptdump_debugfs.c b/arch/arm/mm/ptdump_debugfs.c
index be8d87be4b93..598b636615a2 100644
--- a/arch/arm/mm/ptdump_debugfs.c
+++ b/arch/arm/mm/ptdump_debugfs.c
@@ -24,11 +24,7 @@ static const struct file_operations ptdump_fops = {
 	.release	= single_release,
 };
 
-int ptdump_debugfs_register(struct ptdump_info *info, const char *name)
+void ptdump_debugfs_register(struct ptdump_info *info, const char *name)
 {
-	struct dentry *pe;
-
-	pe = debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
-	return pe ? 0 : -ENOMEM;
-
+	debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
 }
-- 
2.20.1

