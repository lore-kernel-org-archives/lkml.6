Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08073C64EB4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA4E20881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA4E20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbeLCDRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:17:36 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:51452 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbeLCDRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 22:17:36 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 5525572CC6C;
        Mon,  3 Dec 2018 06:17:33 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 4A72F7CCEA3; Mon,  3 Dec 2018 06:17:33 +0300 (MSK)
Date:   Mon, 3 Dec 2018 06:17:33 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Michal Simek <monstr@monstr.eu>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] microblaze: fix syscall_set_return_value()
Message-ID: <20181203031733.GB11573@altlinux.org>
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

This change fixes syscall_set_return_value() implementation on
microblaze to match its own syscall_get_error(), the documentation,
and other architectures where error argument of
syscall_set_return_value() is non-positive.

Fixes: d5b37092aae1e ("microblaze: Implement include/asm/syscall.h.")
Cc: stable@vger.kernel.org # v2.6.32+
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/microblaze/include/asm/syscall.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/microblaze/include/asm/syscall.h b/arch/microblaze/include/asm/syscall.h
index 220decd605a4..c2489a591d6b 100644
--- a/arch/microblaze/include/asm/syscall.h
+++ b/arch/microblaze/include/asm/syscall.h
@@ -36,10 +36,7 @@ static inline void syscall_set_return_value(struct task_struct *task,
 					    struct pt_regs *regs,
 					    int error, long val)
 {
-	if (error)
-		regs->r3 = -error;
-	else
-		regs->r3 = val;
+	regs->r3 = error ?: val;
 }
 
 static inline microblaze_reg_t microblaze_get_syscall_arg(struct pt_regs *regs,
-- 
ldv
