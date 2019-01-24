Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ACFC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2222218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358869;
	bh=B1rSheM2lvVXY9NKVRga1Uk/gGg5fGNd2sihX8GID7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Eqvzn8V1eBDcuK9xXWdfNV8104WqkcScmZL4f9biWwFd94VJ3QyaBd7t7KQf2b00t
	 hteaXXswbYF6/KOpFJteJUJVd251+5A9KD80wOKV1MvqQrUX1DKb7T43R86Xqw5eGj
	 SmkqwBgWorXMajnkVa8YU3jVftlnF7xOePOYPU7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387525AbfAXTlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:41:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:41348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387504AbfAXTlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:41:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B4BC218D0;
        Thu, 24 Jan 2019 19:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358864;
        bh=B1rSheM2lvVXY9NKVRga1Uk/gGg5fGNd2sihX8GID7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=acRneOzx88p1TT6vlI/yh4XRUm/vDDf9NlwFBhuuEM6o1sTdkXyByOAktmU95G0at
         FAzJq4kC55pqH2NV+y8GGipTrbhBgcjEODdAAp/fr34tSHfmSknrWN/td0p9a8oMe5
         eiqmKLkz3OYWBgcw8ZVuPFiQCKrTiHoJt3kQSHdo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 036/127] x86/fault: Dont try to recover from an implicit supervisor access
Date:   Thu, 24 Jan 2019 20:19:42 +0100
Message-Id: <20190124190213.833792830@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



