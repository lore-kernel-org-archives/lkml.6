Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeCTDQv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 23:16:51 -0400
Received: from akagi.fsij.org ([217.70.189.144]:38112 "EHLO akagi.fsij.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750968AbeCTDQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 23:16:50 -0400
From: NIIBE Yutaka <gniibe@fsij.org>
To: linux-kernel@vger.kernel.org
Cc: gniibe@fsij.org
Subject: [PATCH 4/4] signal/x86: Move restore_saved_sigmask().
Date: Tue, 20 Mar 2018 11:38:57 +0900
Message-Id: <20180320023857.1885-5-gniibe@fsij.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180320023857.1885-1-gniibe@fsij.org>
References: <20180320023857.1885-1-gniibe@fsij.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call to restore_saved_sigmask is only needed when it is from a system
call.  It is only unblocked system call which uses saved_sigmask.
Specifically, they are pselect, ppoll, and epoll_pwait.

Signed-off-by: NIIBE Yutaka <gniibe@fsij.org>
---
 arch/x86/kernel/signal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 57576988a01f..c3928718a33a 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -834,13 +834,13 @@ void nosig_restart_syscall(struct pt_regs *regs)
 			regs->ip -= 2;
 			break;
 		}
-	}
 
-	/*
-	 * If there's no signal to deliver, we just put the saved sigmask
-	 * back.
-	 */
-	restore_saved_sigmask();
+		/*
+		 * If there's no signal to deliver, we just put the
+		 * saved sigmask back.
+		 */
+		restore_saved_sigmask();
+	}
 }
 
 void signal_fault(struct pt_regs *regs, void __user *frame, char *where)
-- 
2.11.0
