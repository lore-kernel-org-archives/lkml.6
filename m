Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898A1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D13208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhzgnrTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D13208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390529AbeKVJsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:48:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390489AbeKVJsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:48:04 -0500
Received: from localhost (c-71-205-112-160.hsd1.co.comcast.net [71.205.112.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 824E5214C4;
        Wed, 21 Nov 2018 23:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542841895;
        bh=Gp5ut8Yvjk0UdEW8rghdryCsZib248qHknetthCXLWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=DhzgnrTeTtMYEX22GsCPtI+EWk4ti4TBYYc6/nmpgTSKH82u1WMAFmU6myDyp5iBk
         2sFy0VeDpuNSx8RWgdH0Gt7F5dKcIgDrSxghb+jg18JfhX6S2ID2VZ8f0N2+EOnXlA
         O8gINzizNul4aS5FHEjZCeXb7f7RwPUg+Lx/bMtI=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 5/5] x86/vsyscall/64: Use X86_PF constants in the simulated #PF error code
Date:   Wed, 21 Nov 2018 15:11:26 -0800
Message-Id: <e023f20352b0d05a8b0205629897917262d2ad68.1542841400.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1542841400.git.luto@kernel.org>
References: <cover.1542841400.git.luto@kernel.org>
In-Reply-To: <cover.1542841400.git.luto@kernel.org>
References: <cover.1542841400.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than hardcoding 6 with a comment, use the defined constants.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 85fd85d52ffd..d78bcc03e60e 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -102,7 +102,7 @@ static bool write_ok_or_segv(unsigned long ptr, size_t size)
 	if (!access_ok(VERIFY_WRITE, (void __user *)ptr, size)) {
 		struct thread_struct *thread = &current->thread;
 
-		thread->error_code	= 6;  /* user fault, no page, write */
+		thread->error_code	= X86_PF_USER | X86_PF_WRITE;
 		thread->cr2		= ptr;
 		thread->trap_nr		= X86_TRAP_PF;
 
-- 
2.17.2

