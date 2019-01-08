Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAE3C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4820420827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546978143;
	bh=Sezvcsn5OJPc9yuyhSUxm5paiQLANTXNIs/lAvXm3iU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UiaSP1pH4hNj8P9x0yH7YkmVQnbwXjWMxlCO0m9PND+6PdVmMvpwcsElGz0DYTMa4
	 3GJXRpiqgLV0zjZrYK8YYFCfRXtpSA+p9IaU3632CeuuginpCWx/DXS2u5rY4rsV0o
	 lwM9YWNWVmTqbZRf9BmmjeksBc3Zkfs/YAhnxM8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbfAHUJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:09:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729429AbfAHT1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:27:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B33F020827;
        Tue,  8 Jan 2019 19:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975638;
        bh=Sezvcsn5OJPc9yuyhSUxm5paiQLANTXNIs/lAvXm3iU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HlVgeJD109iXlQCjY0yUSwz59FjZG7IgmL/uIp+0jG6v/qnQ62q3s+nVlqiOsFSy5
         ZRI+6oKpAK0x/M/Fc+U+VZ5F59gZARhYm8tEgZ6DBqI8ffgEZbiv87jXUrTRtxoB98
         JlCwAPEZJKOgivAlvYuS9Va3gz0LWcr5rjcEZAXI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 024/117] x86/fault: Don't try to recover from an implicit supervisor access
Date:   Tue,  8 Jan 2019 14:24:52 -0500
Message-Id: <20190108192628.121270-24-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

[ Upstream commit ebb53e2597e2dc7637ab213df006e99681b6ee25 ]

This avoids a situation in which we attempt to apply various fixups
that are not intended to handle implicit supervisor accesses from
user mode if we screw up in a way that causes this type of fault.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Link: http://lkml.kernel.org/r/9999f151d72ff352265f3274c5ab3a4105090f49.1542841400.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/fault.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 71d4b9d4d43f..26388576a599 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -639,6 +639,15 @@ no_context(struct pt_regs *regs, unsigned long error_code,
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
@@ -726,6 +735,7 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	if (IS_ENABLED(CONFIG_EFI))
 		efi_recover_from_page_fault(address);
 
+oops:
 	/*
 	 * Oops. The kernel tried to access some bad page. We'll have to
 	 * terminate things with extreme prejudice:
-- 
2.19.1

