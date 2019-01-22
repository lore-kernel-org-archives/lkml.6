Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC282C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754D821726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548169126;
	bh=jCuAxteeCLcwZWRObsCeZCZ4eTBs5kj/RbwALPOVfCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=drMiMdJOn4axsQPI80aYItZoRpdH2g1MxsnZo7iETzC5nI1hYTHeVKzIU1GbnUzO6
	 C7ULEdc1kYt6rui+yrg2tPX7b2I2Zb3nvkR4WT5PaC3a6iUwudaFSEfVMf6AoIQb5k
	 kwl5shGvJARucyW29JvK1cX8WQxQJkMVLMOMJOGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfAVO6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:58:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:37978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729042AbfAVO6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:58:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1382521726;
        Tue, 22 Jan 2019 14:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548169113;
        bh=jCuAxteeCLcwZWRObsCeZCZ4eTBs5kj/RbwALPOVfCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dBEe1EfedWy8GgMm+wVyTpMFe1BLc7oXgag0iN0zzbBf+u9h7l6F28EaeMRtgHYBL
         mlYVLIYjMLQ/X/0N/vfNbHOjpDAXMHQp4yCftMSvDZ9BsXj6jOfMgQ9g6tGPK4T1f+
         Z2s9RJB6K32Uph8TNdpXYKuy4uN8d7wqt54VFaYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 4/5] mips: math-emu: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 15:57:41 +0100
Message-Id: <20190122145742.11292-5-gregkh@linuxfoundation.org>
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
Cc: linux-mips@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/math-emu/me-debugfs.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/arch/mips/math-emu/me-debugfs.c b/arch/mips/math-emu/me-debugfs.c
index 58798f527356..387724860fa6 100644
--- a/arch/mips/math-emu/me-debugfs.c
+++ b/arch/mips/math-emu/me-debugfs.c
@@ -189,32 +189,21 @@ static int __init debugfs_fpuemu(void)
 {
 	struct dentry *fpuemu_debugfs_base_dir;
 	struct dentry *fpuemu_debugfs_inst_dir;
-	struct dentry *d, *reset_file;
-
-	if (!mips_debugfs_dir)
-		return -ENODEV;
 
 	fpuemu_debugfs_base_dir = debugfs_create_dir("fpuemustats",
 						     mips_debugfs_dir);
-	if (!fpuemu_debugfs_base_dir)
-		return -ENOMEM;
 
-	reset_file = debugfs_create_file("fpuemustats_clear", 0444,
-					 mips_debugfs_dir, NULL,
-					 &fpuemustats_clear_fops);
-	if (!reset_file)
-		return -ENOMEM;
+	debugfs_create_file("fpuemustats_clear", 0444, mips_debugfs_dir, NULL,
+			    &fpuemustats_clear_fops);
 
 #define FPU_EMU_STAT_OFFSET(m)						\
 	offsetof(struct mips_fpu_emulator_stats, m)
 
 #define FPU_STAT_CREATE(m)						\
 do {									\
-	d = debugfs_create_file(#m, 0444, fpuemu_debugfs_base_dir,	\
+	debugfs_create_file(#m, 0444, fpuemu_debugfs_base_dir,		\
 				(void *)FPU_EMU_STAT_OFFSET(m),		\
 				&fops_fpuemu_stat);			\
-	if (!d)								\
-		return -ENOMEM;						\
 } while (0)
 
 	FPU_STAT_CREATE(emulated);
@@ -233,8 +222,6 @@ do {									\
 
 	fpuemu_debugfs_inst_dir = debugfs_create_dir("instructions",
 						     fpuemu_debugfs_base_dir);
-	if (!fpuemu_debugfs_inst_dir)
-		return -ENOMEM;
 
 #define FPU_STAT_CREATE_EX(m)						\
 do {									\
@@ -242,11 +229,9 @@ do {									\
 									\
 	adjust_instruction_counter_name(name, #m);			\
 									\
-	d = debugfs_create_file(name, 0444, fpuemu_debugfs_inst_dir,	\
+	debugfs_create_file(name, 0444, fpuemu_debugfs_inst_dir,	\
 				(void *)FPU_EMU_STAT_OFFSET(m),		\
 				&fops_fpuemu_stat);			\
-	if (!d)								\
-		return -ENOMEM;						\
 } while (0)
 
 	FPU_STAT_CREATE_EX(abs_s);
-- 
2.20.1

