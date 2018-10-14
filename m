Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3866C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 18:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD612087D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 18:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pe1D2ke2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD612087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeJOCUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 22:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbeJOCUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 22:20:15 -0400
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E95B420835;
        Sun, 14 Oct 2018 18:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539542300;
        bh=tD8qKmyIKAFf3ij+uH9XU1sLc6f7aOc5jWferLVWmmQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Pe1D2ke2Riq1ZvhLaNeSegDms7yrY83Gne1cQ7gWEdsC7ELXJoVAO520vxiAUZleW
         eAgbzUsqALAzrO7AHyd2gJeref2nNqqWqY4V3JXMWtwFlD02yetWtjsJR+WwpwgKAz
         JNBNXAdUt6GQS6XjpHZZKwTuBX/C5bf9cFBgoTIE=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH] x86/entry/64: Further improve paranoid_entry comments
Date:   Sun, 14 Oct 2018 11:38:18 -0700
Message-Id: <c47daa1888dc2298e7e1d3f82bd76b776ea33393.1539542111.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 16561f27f94e ("x86/entry: Add some paranoid entry/exit CR3
handling comments") added some comments.  This improves them a bit:

 - When I first read the new comments, it was unclear to me whether
   they were referring to the case where paranoid_entry interrupted
   other entry code or where paranoid_entry was itself interrupted.
   Clarify it.

 - Remove the EBX comment.  We no longer use EBX as a SWAPGS
   indicator.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.come
Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/entry_64.S | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1d9b4a300c8c..f95dcb209fdf 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1189,15 +1189,13 @@ ENTRY(paranoid_entry)
 1:
 	/*
 	 * Always stash CR3 in %r14.  This value will be restored,
-	 * verbatim, at exit.  Needed if kernel is interrupted
-	 * after switching to the user CR3 value but before
-	 * returning to userspace.
+	 * verbatim, at exit.  Needed if paranoid_entry interrupted
+	 * another entry that already switched to the user CR3 value
+	 * but has not yet returned to userspace.
 	 *
 	 * This is also why CS (stashed in the "iret frame" by the
 	 * hardware at entry) can not be used: this may be a return
-	 * to kernel code, but with a user CR3 value.  The %ebx flag
-	 * for SWAPGS is also unusable for CR3 because there is a
-	 * window with a user GS and a kernel CR3.
+	 * to kernel code, but with a user CR3 value.
 	 */
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
-- 
2.17.1

