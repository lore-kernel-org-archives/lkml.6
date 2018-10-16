Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4F1C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C5F20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFrYBvv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C5F20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbeJQBNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:13:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbeJQBNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:13:18 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 316E620866;
        Tue, 16 Oct 2018 17:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710513;
        bh=RHFpGlEnersEbAHwb+wnsUj1F5lbNyxDUnQWpoFRDCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jFrYBvv4a/2QNBrPOiMjCzSLYrmWlSudmHWJE9dZkKPBGShJRkkSCDIhllQO1F23r
         lml96P7XhygR07MashbxKw/XU3Lwdr3LDu1FQ6SIvbrVUiOHWywHnWQSJJO4JPBTkS
         DZ0MqOZ9G/5/uLcg+xYSY0etaZz/TkjdRnRWCJVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David A. Long" <dave.long@linaro.org>
Subject: [PATCH 4.14 103/109] ARM: signal: copy registers using __copy_from_user()
Date:   Tue, 16 Oct 2018 19:06:11 +0200
Message-Id: <20181016170530.598255022@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit c32cd419d6650e42b9cdebb83c672ec945e6bd7e upstream.

__get_user_error() is used as a fast accessor to make copying structure
members in the signal handling path as efficient as possible.  However,
with software PAN and the recent Spectre variant 1, the efficiency is
reduced as these are no longer fast accessors.

In the case of software PAN, it has to switch the domain register around
each access, and with Spectre variant 1, it would have to repeat the
access_ok() check for each access.

It becomes much more efficient to use __copy_from_user() instead, so
let's use this for the ARM integer registers.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/kernel/signal.c |   38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -184,6 +184,7 @@ struct rt_sigframe {
 
 static int restore_sigframe(struct pt_regs *regs, struct sigframe __user *sf)
 {
+	struct sigcontext context;
 	char __user *aux;
 	sigset_t set;
 	int err;
@@ -192,23 +193,26 @@ static int restore_sigframe(struct pt_re
 	if (err == 0)
 		set_current_blocked(&set);
 
-	__get_user_error(regs->ARM_r0, &sf->uc.uc_mcontext.arm_r0, err);
-	__get_user_error(regs->ARM_r1, &sf->uc.uc_mcontext.arm_r1, err);
-	__get_user_error(regs->ARM_r2, &sf->uc.uc_mcontext.arm_r2, err);
-	__get_user_error(regs->ARM_r3, &sf->uc.uc_mcontext.arm_r3, err);
-	__get_user_error(regs->ARM_r4, &sf->uc.uc_mcontext.arm_r4, err);
-	__get_user_error(regs->ARM_r5, &sf->uc.uc_mcontext.arm_r5, err);
-	__get_user_error(regs->ARM_r6, &sf->uc.uc_mcontext.arm_r6, err);
-	__get_user_error(regs->ARM_r7, &sf->uc.uc_mcontext.arm_r7, err);
-	__get_user_error(regs->ARM_r8, &sf->uc.uc_mcontext.arm_r8, err);
-	__get_user_error(regs->ARM_r9, &sf->uc.uc_mcontext.arm_r9, err);
-	__get_user_error(regs->ARM_r10, &sf->uc.uc_mcontext.arm_r10, err);
-	__get_user_error(regs->ARM_fp, &sf->uc.uc_mcontext.arm_fp, err);
-	__get_user_error(regs->ARM_ip, &sf->uc.uc_mcontext.arm_ip, err);
-	__get_user_error(regs->ARM_sp, &sf->uc.uc_mcontext.arm_sp, err);
-	__get_user_error(regs->ARM_lr, &sf->uc.uc_mcontext.arm_lr, err);
-	__get_user_error(regs->ARM_pc, &sf->uc.uc_mcontext.arm_pc, err);
-	__get_user_error(regs->ARM_cpsr, &sf->uc.uc_mcontext.arm_cpsr, err);
+	err |= __copy_from_user(&context, &sf->uc.uc_mcontext, sizeof(context));
+	if (err == 0) {
+		regs->ARM_r0 = context.arm_r0;
+		regs->ARM_r1 = context.arm_r1;
+		regs->ARM_r2 = context.arm_r2;
+		regs->ARM_r3 = context.arm_r3;
+		regs->ARM_r4 = context.arm_r4;
+		regs->ARM_r5 = context.arm_r5;
+		regs->ARM_r6 = context.arm_r6;
+		regs->ARM_r7 = context.arm_r7;
+		regs->ARM_r8 = context.arm_r8;
+		regs->ARM_r9 = context.arm_r9;
+		regs->ARM_r10 = context.arm_r10;
+		regs->ARM_fp = context.arm_fp;
+		regs->ARM_ip = context.arm_ip;
+		regs->ARM_sp = context.arm_sp;
+		regs->ARM_lr = context.arm_lr;
+		regs->ARM_pc = context.arm_pc;
+		regs->ARM_cpsr = context.arm_cpsr;
+	}
 
 	err |= !valid_user_regs(regs);
 


