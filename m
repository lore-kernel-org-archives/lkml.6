Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF9BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E02214F1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgfEQ/G9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E02214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbeKTJLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:11:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:45104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731840AbeKTJLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:11:48 -0500
Received: from localhost (c-71-205-112-160.hsd1.co.comcast.net [71.205.112.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9051208E3;
        Mon, 19 Nov 2018 22:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542667555;
        bh=A5a7m/Q1Rkguq0Y6LF8OJibMNs5ERZDtym4XTGjJjmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=MgfEQ/G9fK2xDklLFYnyhKioHMvtgHjSgYD2FytZGdNNBZlro+5xyU+0khF6Yd8UA
         wOwINrBI8rYOEyzmvlOFtfqjLiUAQ8m77TpVvteEvzORF/UlcHo3UxNmSA+JWULKO+
         7mcjVaHmCJrCzpEW9VCXNuG/i/c0SaFx29RGwAuI=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 10/13] x86/fault: Don't try to recover from an implicit supervisor access
Date:   Mon, 19 Nov 2018 14:45:34 -0800
Message-Id: <52a2a4b1187e221074309027c2dac8fa70094770.1542667307.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1542667307.git.luto@kernel.org>
References: <cover.1542667307.git.luto@kernel.org>
In-Reply-To: <cover.1542667307.git.luto@kernel.org>
References: <cover.1542667307.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids a situation in which we attempt to apply various fixups
that are not intended to handle implicit supervisor accesses from
user mode if we screw up in away that causes this type of fault.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 6e18438c367f..092ed6b1df8a 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -653,6 +653,15 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	unsigned long flags;
 	int sig;
 
+	if (user_mode(regs)) {
+		/*
+		 * This is an implicit supervisor-mode access from user
+		 * mode.  Bypass all the kernel-mode recovery code and just
+		 * OOPS.
+		 */
+		goto oops;
+	}
+
 	/* Are we prepared to handle this kernel fault? */
 	if (fixup_exception(regs, X86_TRAP_PF, error_code, address)) {
 		/*
@@ -738,6 +747,7 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	if (IS_ENABLED(CONFIG_EFI))
 		efi_recover_from_page_fault(address);
 
+oops:
 	/*
 	 * Oops. The kernel tried to access some bad page. We'll have to
 	 * terminate things with extreme prejudice:
-- 
2.17.2

