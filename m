Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABD9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC87213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWiSV6n7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC87213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbeKTJLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:11:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730419AbeKTJLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:11:34 -0500
Received: from localhost (c-71-205-112-160.hsd1.co.comcast.net [71.205.112.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FD6220870;
        Mon, 19 Nov 2018 22:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542667541;
        bh=ScGIehJBD70GgCfuEbZJwE1EEeXaS9dgpxdLr56YU64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=HWiSV6n7p9ktL8Avz/pYR10awKl98WEtYqjwuslinFL30HVGLa7s5kUfkSjgfKk/E
         kgyeutKhcNV+2w0tavGpshai+k9P9YzNUauPWkn8GX4BeDjWByagw5T6mJDc8c26Fa
         /EDcuA4qmX5blJnF7y4HQj2SfKyKHkB8dnQDvXNM=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 01/13] x86/fault: Check user_mode(regs) when avoiding an mmap_sem deadlock
Date:   Mon, 19 Nov 2018 14:45:25 -0800
Message-Id: <4b89b542e8ceba9bd6abde2f386afed6d99244a9.1542667307.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1542667307.git.luto@kernel.org>
References: <cover.1542667307.git.luto@kernel.org>
In-Reply-To: <cover.1542667307.git.luto@kernel.org>
References: <cover.1542667307.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fault-handling code that takes mmap_sem needs to avoid a
deadlock that could occur if the kernel took a bad (OOPS-worthy)
page fault on a user address while holding mmap_sem.  This can only
happen if the faulting instruction was in the kernel
(i.e. user_mode(regs)).  Rather than checking the sw_error_code
(which will have the USER bit set if the fault was a USER-permission
access *or* if user_mode(regs)), just check user_mode(regs)
directly.

The old code would have malfunctioned if the kernel executed a bogus
WRUSS instruction while holding mmap_sem.  Fortunately, that is
extremely unlikely in current kernels, which don't use WRUSS.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 71d4b9d4d43f..91d4d2722f2e 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1344,13 +1344,10 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * Only do the expensive exception table search when we might be at
 	 * risk of a deadlock.  This happens if we
 	 * 1. Failed to acquire mmap_sem, and
-	 * 2. The access did not originate in userspace.  Note: either the
-	 *    hardware or earlier page fault code may set X86_PF_USER
-	 *    in sw_error_code.
+	 * 2. The access did not originate in userspace.
 	 */
 	if (unlikely(!down_read_trylock(&mm->mmap_sem))) {
-		if (!(sw_error_code & X86_PF_USER) &&
-		    !search_exception_tables(regs->ip)) {
+		if (!user_mode(regs) && !search_exception_tables(regs->ip)) {
 			/*
 			 * Fault from code in kernel from
 			 * which we do not expect faults.
-- 
2.17.2

