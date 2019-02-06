Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B158DC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F4A218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbfBFLxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:53:05 -0500
Received: from mga14.intel.com ([192.55.52.115]:20958 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727317AbfBFLxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:53:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 03:53:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,339,1544515200"; 
   d="scan'208";a="272911647"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 06 Feb 2019 03:53:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id A0CA6E7; Wed,  6 Feb 2019 13:53:01 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kyle D Pelton <kyle.d.pelton@intel.com>,
        Wei Huang <wei@redhat.com>
Subject: [PATCH] x86/boot/compressed/64: Do not corrupt EDX on EFER.LME=1 setting
Date:   Wed,  6 Feb 2019 14:52:53 +0300
Message-Id: <20190206115253.1907-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RDMSR in the trampoline code overrides EDX, but we use the register to
indicate if 5-level paging has to enabled. It leads to failure to boot
on a 5-level paging machine.

Preserve EDX on the stack while we are dealing with EFER.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: b677dfae5aa1 ("x86/boot/compressed/64: Set EFER.LME=1 in 32-bit trampoline before returning to long mode")
Reported-by: Kyle D Pelton <kyle.d.pelton@intel.com>
Cc: Wei Huang <wei@redhat.com>
---
 arch/x86/boot/compressed/head_64.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index f105ae8651c9..f62e347862cc 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -602,10 +602,12 @@ ENTRY(trampoline_32bit_src)
 3:
 	/* Set EFER.LME=1 as a precaution in case hypervsior pulls the rug */
 	pushl	%ecx
+	pushl	%edx
 	movl	$MSR_EFER, %ecx
 	rdmsr
 	btsl	$_EFER_LME, %eax
 	wrmsr
+	popl	%edx
 	popl	%ecx
 
 	/* Enable PAE and LA57 (if required) paging modes */
-- 
2.20.1

