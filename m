Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F637C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F06B21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170903;
	bh=rdQqRvE6bRp8PqN9mm0dC6LLrunUx2tWmydq03JT1EA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=lzadnX5qzb4OKG4/XF8cU172eKXTTMxCjexQZ6+ov82L7VR01kAtSS0cQMwaKGAzo
	 8vZEzIa+HxuvgjBEQw7uP7L4axLvKU3m4LJqneWv1PdmgxX4B44ClTFjswXO6d91Kz
	 cJVEDAKM9iGx8g1pRPuu7zrYaxronKgJpdkblp3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbfAVPWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:22:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729496AbfAVPWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:22:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E05B9217D4;
        Tue, 22 Jan 2019 15:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170531;
        bh=rdQqRvE6bRp8PqN9mm0dC6LLrunUx2tWmydq03JT1EA=;
        h=From:To:Cc:Subject:Date:From;
        b=RRLG7bewpKJ03na93ToeZeKB+ZA4TOW64COQunfps4NwaUJTWpcgYyw7UHcLY6nqa
         3EvVaZcl728K1hzrIPzG3RQ8vKXtSL4jYV2ha0cYtqfsOAn567qzav0s+k1D3M3haK
         tbJRlEdRhqgE6btV7xSGfxOwXSq/G4GJCcV+Ldoo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org
Subject: [PATCH] mm: kmemleak: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:12 +0100
Message-Id: <20190122152151.16139-13-gregkh@linuxfoundation.org>
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

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/kmemleak.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index f9d9dc250428..d45bc65db5fb 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -2124,14 +2124,9 @@ void __init kmemleak_init(void)
  */
 static int __init kmemleak_late_init(void)
 {
-	struct dentry *dentry;
-
 	kmemleak_initialized = 1;
 
-	dentry = debugfs_create_file("kmemleak", 0644, NULL, NULL,
-				     &kmemleak_fops);
-	if (!dentry)
-		pr_warn("Failed to create the debugfs kmemleak file\n");
+	debugfs_create_file("kmemleak", 0644, NULL, NULL, &kmemleak_fops);
 
 	if (kmemleak_error) {
 		/*
-- 
2.20.1

