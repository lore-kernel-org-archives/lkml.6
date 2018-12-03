Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD39C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0967020881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0967020881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbeLCDRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:17:50 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:51908 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbeLCDRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 22:17:50 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9719872CA65;
        Mon,  3 Dec 2018 06:17:47 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 8C6367CCEA3; Mon,  3 Dec 2018 06:17:47 +0300 (MSK)
Date:   Mon, 3 Dec 2018 06:17:47 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Ley Foon Tan <lftan@altera.com>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        nios2-dev@lists.rocketboards.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nios2: fix syscall_get_error()
Message-ID: <20181203031747.GC11573@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to documentation in include/asm-generic/syscall.h,
syscall_get_error() should return -ERRORCODE if the system call failed.

This change fixes syscall_get_error() implementation on nios2 to match
its own syscall_set_return_value(), the documentation, and other
architectures where syscall_get_error() returns a non-positive value.

Fixes: 1000197d80132 ("nios2: System calls handling")
Cc: stable@vger.kernel.org # v3.19+
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/nios2/include/asm/syscall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nios2/include/asm/syscall.h b/arch/nios2/include/asm/syscall.h
index 9de220854c4a..abf54addb804 100644
--- a/arch/nios2/include/asm/syscall.h
+++ b/arch/nios2/include/asm/syscall.h
@@ -35,7 +35,7 @@ static inline void syscall_rollback(struct task_struct *task,
 static inline long syscall_get_error(struct task_struct *task,
 				struct pt_regs *regs)
 {
-	return regs->r7 ? regs->r2 : 0;
+	return regs->r7 ? -regs->r2 : 0;
 }
 
 static inline long syscall_get_return_value(struct task_struct *task,
-- 
ldv
