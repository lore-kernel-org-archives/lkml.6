Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE4FC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E686217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548169116;
	bh=HVQq63F+Jt4yklUBPDZYzPWLiSc2sgrhuYQSlsHAx8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QOgjQ6YuG5t+q6wPGSP+AvmWisxpLfOAG0ouAYFofzdyDmbpkkZwBbHYSLYXccP71
	 v2hNjj1j0UXZWkCNqeQbJl7b+Z0lYQhV70uuophbaCwYAZjV9sWRfbCWvEXTbJa9GO
	 OfpZiOrhoiArooj+r5Wuvo3A2xYzJFAdDT4J1Ztc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfAVO6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:58:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729015AbfAVO6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:58:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59112217D4;
        Tue, 22 Jan 2019 14:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548169110;
        bh=HVQq63F+Jt4yklUBPDZYzPWLiSc2sgrhuYQSlsHAx8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQtYIrNA+a0daVHs9FzmxAiTn2omS6jUhL5hYVOywe0GNBkBVAcmgXK5Kb5EilyS9
         gXQFI9J09KnAqx0GmLt/dKicftUZwLbMoyBjjPfOeWOXnWRki8eqbeePyl+AUXp4Qw
         qVelNcVtXUMNJIKjWf3KR9CeiTQxuM6Dz2abLlko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 3/5] mips: mm: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 15:57:40 +0100
Message-Id: <20190122145742.11292-4-gregkh@linuxfoundation.org>
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
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mips@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/mm/sc-debugfs.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/mips/mm/sc-debugfs.c b/arch/mips/mm/sc-debugfs.c
index 2a116084216f..9507421de335 100644
--- a/arch/mips/mm/sc-debugfs.c
+++ b/arch/mips/mm/sc-debugfs.c
@@ -55,20 +55,11 @@ static const struct file_operations sc_prefetch_fops = {
 
 static int __init sc_debugfs_init(void)
 {
-	struct dentry *dir, *file;
-
-	if (!mips_debugfs_dir)
-		return -ENODEV;
+	struct dentry *dir;
 
 	dir = debugfs_create_dir("l2cache", mips_debugfs_dir);
-	if (IS_ERR(dir))
-		return PTR_ERR(dir);
-
-	file = debugfs_create_file("prefetch", S_IRUGO | S_IWUSR, dir,
-				   NULL, &sc_prefetch_fops);
-	if (!file)
-		return -ENOMEM;
-
+	debugfs_create_file("prefetch", S_IRUGO | S_IWUSR, dir, NULL,
+			    &sc_prefetch_fops);
 	return 0;
 }
 late_initcall(sc_debugfs_init);
-- 
2.20.1

