Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3470C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FB320821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfBFSF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:05:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57835 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfBFSF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:05:26 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x16I4Dxv1387757
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 6 Feb 2019 10:04:13 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x16I4BnF1387753;
        Wed, 6 Feb 2019 10:04:11 -0800
Date:   Wed, 6 Feb 2019 10:04:11 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-45b13b424faafb81c8c44541f093a682fdabdefc@git.kernel.org>
Cc:     kyle.d.pelton@intel.com, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, bp@suse.de,
        wei@redhat.com, mingo@kernel.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com
Reply-To: kyle.d.pelton@intel.com, x86@kernel.org, hpa@zytor.com,
          mingo@redhat.com, linux-kernel@vger.kernel.org, bp@suse.de,
          wei@redhat.com, mingo@kernel.org, tglx@linutronix.de,
          kirill.shutemov@linux.intel.com
In-Reply-To: <20190206115253.1907-1-kirill.shutemov@linux.intel.com>
References: <20190206115253.1907-1-kirill.shutemov@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/boot/compressed/64: Do not corrupt EDX on
 EFER.LME=1 setting
Git-Commit-ID: 45b13b424faafb81c8c44541f093a682fdabdefc
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  45b13b424faafb81c8c44541f093a682fdabdefc
Gitweb:     https://git.kernel.org/tip/45b13b424faafb81c8c44541f093a682fdabdefc
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Wed, 6 Feb 2019 14:52:53 +0300
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 6 Feb 2019 18:56:18 +0100

x86/boot/compressed/64: Do not corrupt EDX on EFER.LME=1 setting

RDMSR in the trampoline code overwrites EDX but that register is used
to indicate whether 5-level paging has to be enabled and if clobbered,
leads to failure to boot on a 5-level paging machine.

Preserve EDX on the stack while we are dealing with EFER.

Fixes: b677dfae5aa1 ("x86/boot/compressed/64: Set EFER.LME=1 in 32-bit trampoline before returning to long mode")
Reported-by: Kyle D Pelton <kyle.d.pelton@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: dave.hansen@linux.intel.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Huang <wei@redhat.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190206115253.1907-1-kirill.shutemov@linux.intel.com
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
