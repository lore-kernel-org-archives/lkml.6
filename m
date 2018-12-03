Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E0AC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E622B20881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E622B20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbeLCDSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:18:08 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:52362 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbeLCDSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 22:18:07 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id CBA6172CA65;
        Mon,  3 Dec 2018 06:18:04 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id B8A277CCEA3; Mon,  3 Dec 2018 06:18:04 +0300 (MSK)
Date:   Mon, 3 Dec 2018 06:18:04 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sh: fix syscall_set_return_value()
Message-ID: <20181203031804.GD11573@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to documentation in include/asm-generic/syscall.h,
if error argument of syscall_set_return_value() is nonzero,
it is a negated errno.

This change fixes syscall_set_return_value() implementation on sh
to match its own syscall_get_error(), the documentation, and other
architectures where error argument of syscall_set_return_value()
is non-positive.

Fixes: fb4f87a2f048b ("sh: Provide the asm/syscall.h interface, needed by tracehook.")
Fixes: 94e2fb3d3e1f4 ("sh: Provide asm/syscall.h for SH-5.")
Cc: stable@vger.kernel.org # v2.6.28+
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/sh/include/asm/syscall_32.h | 5 +----
 arch/sh/include/asm/syscall_64.h | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/sh/include/asm/syscall_32.h b/arch/sh/include/asm/syscall_32.h
index 6e118799831c..5d636a3593d1 100644
--- a/arch/sh/include/asm/syscall_32.h
+++ b/arch/sh/include/asm/syscall_32.h
@@ -40,10 +40,7 @@ static inline void syscall_set_return_value(struct task_struct *task,
 					    struct pt_regs *regs,
 					    int error, long val)
 {
-	if (error)
-		regs->regs[0] = -error;
-	else
-		regs->regs[0] = val;
+	regs->regs[0] = error ?: val;
 }
 
 static inline void syscall_get_arguments(struct task_struct *task,
diff --git a/arch/sh/include/asm/syscall_64.h b/arch/sh/include/asm/syscall_64.h
index 43882580c7f9..799fe72316e2 100644
--- a/arch/sh/include/asm/syscall_64.h
+++ b/arch/sh/include/asm/syscall_64.h
@@ -39,10 +39,7 @@ static inline void syscall_set_return_value(struct task_struct *task,
 					    struct pt_regs *regs,
 					    int error, long val)
 {
-	if (error)
-		regs->regs[9] = -error;
-	else
-		regs->regs[9] = val;
+	regs->regs[9] = error ?: val;
 }
 
 static inline void syscall_get_arguments(struct task_struct *task,
-- 
ldv
