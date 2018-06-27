Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC282C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D50268F1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="arcnDB1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D50268F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753175AbeF0Fp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 01:45:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751316AbeF0Fpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 01:45:55 -0400
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE91E267FF;
        Wed, 27 Jun 2018 05:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530078354;
        bh=V6ohwXtyx/0JJfI970j3QZNpDE24Mvnj4xYCGvl5A9M=;
        h=From:To:Cc:Subject:Date:From;
        b=arcnDB1a7+Bm0NOfye1Cmq5zmFU1c9AI/rDrenBurFCAo+dT2Jnh4Pv4r1h7zQ/j5
         fVxoziAr2ebuBjkHsxy4IFlDdfawYEKXWmYt93unPWRV66LvVzEPDsoa1avjr+zK0N
         rzmKiCvcMMBDUZacMVAPSgwW5WXRJg6ztNEL9oKQ=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, zhijianx.li@intel.com,
        Andy Lutomirski <luto@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] x86/entry/64/compat: Fix "x86/entry/64/compat: Preserve r8-r11 in int $0x80"
Date:   Tue, 26 Jun 2018 22:45:52 -0700
Message-Id: <6012b922485401bc42676e804171ded262fc2ef2.1530078306.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8bb2610bc496 ("x86/entry/64/compat: Preserve r8-r11 in int
$0x80") was busted.  My original patch had a minor conflict with
some of the nospec changes.  git apply is very clever and silently
accepted the patch by making the same changes to a different
function in the same file.  There was obviously a huge offset, but
git apply for some reason doesn't feel any need to say so.

Move the changes to the correct function.  Now the
test_syscall_vdso_32 selftests passes.

If anyone cares to observe the original problem, try applying the
patch at
https://lore.kernel.org/lkml/d4c4d9985fbe64f8c9e19291886453914b48caee.1523975710.git.luto@kernel.org/raw
to the kernel at 316d097c4cd4e7f2ef50c40cff2db266593c4ec4.  git am and
git apply accept the patch without any complaints at all.  patch -p1
at least prints out a message about the huge offset.

Reported-by: zhijianx.li@intel.com
Fixes: 8bb2610bc496 ("x86/entry/64/compat: Preserve r8-r11 in int $0x80")
Cc: stable@vger.kernel.org
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/entry_64_compat.S | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 9de7f1e1dede..7d0df78db727 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -84,13 +84,13 @@ ENTRY(entry_SYSENTER_compat)
 	pushq	%rdx			/* pt_regs->dx */
 	pushq	%rcx			/* pt_regs->cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
-	pushq   %r8			/* pt_regs->r8 */
+	pushq   $0			/* pt_regs->r8  = 0 */
 	xorl	%r8d, %r8d		/* nospec   r8 */
-	pushq   %r9			/* pt_regs->r9 */
+	pushq   $0			/* pt_regs->r9  = 0 */
 	xorl	%r9d, %r9d		/* nospec   r9 */
-	pushq   %r10			/* pt_regs->r10 */
+	pushq   $0			/* pt_regs->r10 = 0 */
 	xorl	%r10d, %r10d		/* nospec   r10 */
-	pushq   %r11			/* pt_regs->r11 */
+	pushq   $0			/* pt_regs->r11 = 0 */
 	xorl	%r11d, %r11d		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
 	xorl	%ebx, %ebx		/* nospec   rbx */
@@ -374,13 +374,13 @@ ENTRY(entry_INT80_compat)
 	pushq	%rcx			/* pt_regs->cx */
 	xorl	%ecx, %ecx		/* nospec   cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
-	pushq   $0			/* pt_regs->r8  = 0 */
+	pushq   %r8			/* pt_regs->r8 */
 	xorl	%r8d, %r8d		/* nospec   r8 */
-	pushq   $0			/* pt_regs->r9  = 0 */
+	pushq   %r9			/* pt_regs->r9 */
 	xorl	%r9d, %r9d		/* nospec   r9 */
-	pushq   $0			/* pt_regs->r10 = 0 */
+	pushq   %r10			/* pt_regs->r10*/
 	xorl	%r10d, %r10d		/* nospec   r10 */
-	pushq   $0			/* pt_regs->r11 = 0 */
+	pushq   %r11			/* pt_regs->r11 */
 	xorl	%r11d, %r11d		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
 	xorl	%ebx, %ebx		/* nospec   rbx */
-- 
2.17.1

