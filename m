Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDACC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A618820853
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L2VJiDIz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L2VJiDIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A618820853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeJOPYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:24:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33388 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeJOPYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 11:24:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A5FEA612EE; Mon, 15 Oct 2018 07:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539589228;
        bh=MxqOKQIJXhqnwFeNXvwCIfN3fc4PCTE4h8yxLXJMZBk=;
        h=From:To:Cc:Subject:Date:From;
        b=L2VJiDIzOISUSrIhWm4naoaPgDlibGnfH6vnmt9HMoNJJOOfcXWWN0AY6mtX5ol+H
         u53i6gCGD94/Ls7nGI5frPqnvIDAfvcfqZietL1TqOm/6g8YMUrsvVRH5VFpHnpXbV
         WxYPGh7seipAuG3ZVJeg36AAdGBZ4NG8/0gZcwP4=
Received: from smasetty-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: smasetty@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 364BC60C4B;
        Mon, 15 Oct 2018 07:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539589228;
        bh=MxqOKQIJXhqnwFeNXvwCIfN3fc4PCTE4h8yxLXJMZBk=;
        h=From:To:Cc:Subject:Date:From;
        b=L2VJiDIzOISUSrIhWm4naoaPgDlibGnfH6vnmt9HMoNJJOOfcXWWN0AY6mtX5ol+H
         u53i6gCGD94/Ls7nGI5frPqnvIDAfvcfqZietL1TqOm/6g8YMUrsvVRH5VFpHnpXbV
         WxYPGh7seipAuG3ZVJeg36AAdGBZ4NG8/0gZcwP4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 364BC60C4B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=smasetty@codeaurora.org
From:   Sharat Masetty <smasetty@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        Sharat Masetty <smasetty@codeaurora.org>
Subject: [PATCH] lib/string: Pass the input gfp flags to kmalloc
Date:   Mon, 15 Oct 2018 13:10:15 +0530
Message-Id: <1539589215-6461-1-git-send-email-smasetty@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the user sent gfp flags to kmalloc() calls. This helps calling the
functions in user desired contexts.

Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
---
 lib/string_helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 29c490e..60f9015 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -576,7 +576,7 @@ char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp)
 	char *buffer, *quoted;
 	int i, res;
 
-	buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	buffer = kmalloc(PAGE_SIZE, gfp);
 	if (!buffer)
 		return NULL;
 
@@ -612,7 +612,7 @@ char *kstrdup_quotable_file(struct file *file, gfp_t gfp)
 		return kstrdup("<unknown>", gfp);
 
 	/* We add 11 spaces for ' (deleted)' to be appended */
-	temp = kmalloc(PATH_MAX + 11, GFP_KERNEL);
+	temp = kmalloc(PATH_MAX + 11, gfp);
 	if (!temp)
 		return kstrdup("<no_memory>", gfp);
 
-- 
1.9.1

