Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB578C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 09:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A25B2064E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 09:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A25B2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeJNQ6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 12:58:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58941 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbeJNQ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 12:58:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9E9HCdn3117062
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 14 Oct 2018 02:17:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9E9HAmH3117059;
        Sun, 14 Oct 2018 02:17:10 -0700
Date:   Sun, 14 Oct 2018 02:17:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-16561f27f94e6193ee8f5b9b74801e1668c86efc@git.kernel.org>
Cc:     bp@alien8.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        luto@kernel.org, dave.hansen@linux.intel.com, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: hpa@zytor.com, dave.hansen@linux.intel.com, mingo@kernel.org,
          luto@kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org,
          tglx@linutronix.de
In-Reply-To: <20181012232118.3EAAE77B@viggo.jf.intel.com>
References: <20181012232118.3EAAE77B@viggo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/entry: Add some paranoid entry/exit CR3
 handling comments
Git-Commit-ID: 16561f27f94e6193ee8f5b9b74801e1668c86efc
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

Commit-ID:  16561f27f94e6193ee8f5b9b74801e1668c86efc
Gitweb:     https://git.kernel.org/tip/16561f27f94e6193ee8f5b9b74801e1668c86efc
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 12 Oct 2018 16:21:18 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 14 Oct 2018 11:11:22 +0200

x86/entry: Add some paranoid entry/exit CR3 handling comments

Andi Kleen was just asking me about the NMI CR3 handling and why
we restore it unconditionally.  I was *sure* we had documented it
well.  We did not.

Add some documentation.  We have common entry code where the CR3
value is stashed, but three places in two big code paths where we
restore it.  I put bulk of the comments in this common path and
then refer to it from the other spots.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: luto@kernel.org
Cc: bp@alien8.de
Cc: "H. Peter Anvin" <hpa@zytor.come
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lkml.kernel.org/r/20181012232118.3EAAE77B@viggo.jf.intel.com

---
 arch/x86/entry/entry_64.S | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 957dfb693ecc..1d9b4a300c8c 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1187,6 +1187,18 @@ ENTRY(paranoid_entry)
 	xorl	%ebx, %ebx
 
 1:
+	/*
+	 * Always stash CR3 in %r14.  This value will be restored,
+	 * verbatim, at exit.  Needed if kernel is interrupted
+	 * after switching to the user CR3 value but before
+	 * returning to userspace.
+	 *
+	 * This is also why CS (stashed in the "iret frame" by the
+	 * hardware at entry) can not be used: this may be a return
+	 * to kernel code, but with a user CR3 value.  The %ebx flag
+	 * for SWAPGS is also unusable for CR3 because there is a
+	 * window with a user GS and a kernel CR3.
+	 */
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
 	ret
@@ -1211,11 +1223,13 @@ ENTRY(paranoid_exit)
 	testl	%ebx, %ebx			/* swapgs needed? */
 	jnz	.Lparanoid_exit_no_swapgs
 	TRACE_IRQS_IRETQ
+	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
 	SWAPGS_UNSAFE_STACK
 	jmp	.Lparanoid_exit_restore
 .Lparanoid_exit_no_swapgs:
 	TRACE_IRQS_IRETQ_DEBUG
+	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
 .Lparanoid_exit_restore:
 	jmp restore_regs_and_return_to_kernel
@@ -1626,6 +1640,7 @@ end_repeat_nmi:
 	movq	$-1, %rsi
 	call	do_nmi
 
+	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
 
 	testl	%ebx, %ebx			/* swapgs needed? */
