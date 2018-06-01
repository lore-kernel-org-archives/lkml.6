Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeFALY5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:24:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50272 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751836AbeFALYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:24:52 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com
Cc: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCHv2 01/19] arm64: consistently use unsigned long for thread flags
Date: Fri,  1 Jun 2018 12:24:23 +0100
Message-Id: <20180601112441.37810-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180601112441.37810-1-mark.rutland@arm.com>
References: <20180601112441.37810-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In do_notify_resume, we manipulate thread_flags as a 32-bit unsigned
int, whereas thread_info::flags is a 64-bit unsigned long, and elsewhere
(e.g. in the entry assembly) we manipulate the flags as a 64-bit
quantity.

For consistency, and to avoid problems if we end up with more than 32
flags, let's make do_notify_resume take the flags as a 64-bit unsigned
long.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 154b7d30145d..8e624fec4707 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -896,7 +896,7 @@ static void do_signal(struct pt_regs *regs)
 }
 
 asmlinkage void do_notify_resume(struct pt_regs *regs,
-				 unsigned int thread_flags)
+				 unsigned long thread_flags)
 {
 	/*
 	 * The assembly code enters us with IRQs off, but it hasn't
-- 
2.11.0
