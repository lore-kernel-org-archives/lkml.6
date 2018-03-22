Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754487AbeCVBpc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 21:45:32 -0400
Received: from akagi.fsij.org ([217.70.189.144]:38148 "EHLO akagi.fsij.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754466AbeCVBpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 21:45:30 -0400
From: NIIBE Yutaka <gniibe@fsij.org>
To: linux-kernel@vger.kernel.org
Cc: NIIBE Yutaka <gniibe@fsij.org>
Subject: [PATCH v2 2/4] signal/x86: do_signal: syscall restart should be done only once.
Date: Thu, 22 Mar 2018 10:44:11 +0900
Message-Id: <20180322014413.24099-3-gniibe@fsij.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322014413.24099-1-gniibe@fsij.org>
References: <20180322014413.24099-1-gniibe@fsij.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_signal may be called multiple times from exit_to_usermode_loop.  In
those multiple calls, only the one should handle restarting the system
call.

When actually delivering a signal, make sure the register will not be
examined again as syscall errno by another call of do_signal.

Signed-off-by: NIIBE Yutaka <gniibe@fsij.org>
---
 arch/x86/kernel/signal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index cdfb82031243..e709b54a01b8 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -729,6 +729,7 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 			regs->ip -= 2;
 			break;
 		}
+		regs->orig_ax = -1;
 	}
 
 	/*
-- 
2.11.0
