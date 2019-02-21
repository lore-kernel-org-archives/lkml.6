Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D471FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6F320818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfBUXvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 18:51:25 -0500
Received: from mga14.intel.com ([192.55.52.115]:3176 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbfBUXvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 18:51:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 15:51:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,397,1544515200"; 
   d="scan'208";a="322394963"
Received: from linksys13920.jf.intel.com (HELO rpedgeco-DESK5.jf.intel.com) ([10.54.75.11])
  by fmsmga005.fm.intel.com with ESMTP; 21 Feb 2019 15:51:10 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 19/20] x86/kprobes: Use vmalloc special flag
Date:   Thu, 21 Feb 2019 15:44:50 -0800
Message-Id: <20190221234451.17632-20-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190221234451.17632-1-rick.p.edgecombe@intel.com>
References: <20190221234451.17632-1-rick.p.edgecombe@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new flag VM_FLUSH_RESET_PERMS for handling freeing of special
permissioned memory in vmalloc and remove places where memory was set NX
and RW before freeing which is no longer needed.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/kprobes/core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 98c671e89889..8b56935d7b53 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -434,6 +434,7 @@ void *alloc_insn_page(void)
 	if (!page)
 		return NULL;
 
+	set_vm_flush_reset_perms(page);
 	/*
 	 * First make the page read-only, and only then make it executable to
 	 * prevent it from being W+X in between.
@@ -452,12 +453,6 @@ void *alloc_insn_page(void)
 /* Recover page to RW mode before releasing it */
 void free_insn_page(void *page)
 {
-	/*
-	 * First make the page non-executable, and only then make it writable to
-	 * prevent it from being W+X in between.
-	 */
-	set_memory_nx((unsigned long)page, 1);
-	set_memory_rw((unsigned long)page, 1);
 	module_memfree(page);
 }
 
-- 
2.17.1

