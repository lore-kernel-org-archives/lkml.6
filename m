Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E011C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CA121726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548168091;
	bh=+rMan51RaYrsGd1clsL6raIWizTKaNVX/cWyBz3I4IQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CDklnS0sNXJKWmnBHWEPIA7lJUmSI0Je6uHwllWsGAlN8GtNfzlAdH44TGuLg+JkU
	 nKzyirQ8GWTJ52LkRRgApPoQaxhKpYcYnRDie/7r4ECohjopfYQ/I0QzyXS/HMEOlT
	 GMWzUJNA+Y/nisTK1e72idfRpv4GFGFipul3vFxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfAVOl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:41:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:53302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728318AbfAVOl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:41:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 799EB20855;
        Tue, 22 Jan 2019 14:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548168088;
        bh=+rMan51RaYrsGd1clsL6raIWizTKaNVX/cWyBz3I4IQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bRhhNgsRJ4bBuopJ2XMvhNcv1Yv8fMrIb2/iM+yLQE76etYZrzqQj1/2dO0lNYcQd
         Z0fXSeWxf2dPklZ7x3HJPAqDBiG4mNLWzFDFLdt1u1jenTxzrlQxfPIXqHBafwNOOW
         ZENY9Q1Z6bAuUYFN6UVkb0/HGcG+F6GkD2vU2iRc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH 1/4] arm64: dump: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 15:41:11 +0100
Message-Id: <20190122144114.9816-2-gregkh@linuxfoundation.org>
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

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Peng Donglin <dolinux.peng@gmail.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/ptdump.h | 9 +++------
 arch/arm64/mm/dump.c            | 4 ++--
 arch/arm64/mm/ptdump_debugfs.c  | 7 ++-----
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 6afd8476c60c..9e948a93d26c 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -34,13 +34,10 @@ struct ptdump_info {
 
 void ptdump_walk_pgd(struct seq_file *s, struct ptdump_info *info);
 #ifdef CONFIG_ARM64_PTDUMP_DEBUGFS
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
 #endif
 void ptdump_check_wx(void);
 #endif /* CONFIG_ARM64_PTDUMP_CORE */
diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index fcb1f2a6d7c6..08c250350b8a 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -407,7 +407,7 @@ void ptdump_check_wx(void)
 static int ptdump_init(void)
 {
 	ptdump_initialize();
-	return ptdump_debugfs_register(&kernel_ptdump_info,
-					"kernel_page_tables");
+	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
+	return 0;
 }
 device_initcall(ptdump_init);
diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
index 24d786fc3a4c..064163f25592 100644
--- a/arch/arm64/mm/ptdump_debugfs.c
+++ b/arch/arm64/mm/ptdump_debugfs.c
@@ -12,10 +12,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(ptdump);
 
-int ptdump_debugfs_register(struct ptdump_info *info, const char *name)
+void ptdump_debugfs_register(struct ptdump_info *info, const char *name)
 {
-	struct dentry *pe;
-	pe = debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
-	return pe ? 0 : -ENOMEM;
-
+	debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
 }
-- 
2.20.1

