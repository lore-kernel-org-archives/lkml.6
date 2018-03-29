Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752608AbeC2UqS convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 16:46:18 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:50506 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751194AbeC2UqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 16:46:17 -0400
From: Richard Weinberger <richard@nod.at>
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, richard@nod.at, jdike@addtoit.com
Subject: [PATCH] um: Fix return value of start_idle_thread
Date: Thu, 29 Mar 2018 22:45:59 +0200
Message-Id: <20180329204559.14113-1-richard@nod.at>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the function will never returns, gcc will warns.
Add a return statement to make gcc happy.
Before f44f1e7da7c8 we never noticed because gcc knows that longjmp does
not return.

arch/um/os-Linux/skas/process.c: In function ‘start_idle_thread’:
arch/um/os-Linux/skas/process.c:613:1: warning: control reaches end of non-void function [-Wreturn-type]

Fixes: f44f1e7da7c8 ("um: Avoid longjmp/setjmp symbol clashes with libpthread.a")
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/os-Linux/skas/process.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index c94c3bd70ccd..d41fdf686a5f 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -610,6 +610,10 @@ int start_idle_thread(void *stack, jmp_buf *switch_buf)
 		fatal_sigsegv();
 	}
 	longjmp(*switch_buf, 1);
+
+	/* unreachable */
+	fatal_sigsegv();
+	return 0;
 }
 
 void initial_thread_cb_skas(void (*proc)(void *), void *arg)
-- 
2.13.6
