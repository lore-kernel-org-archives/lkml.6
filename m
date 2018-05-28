Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938952AbeE1MiE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:38:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937983AbeE1K6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:58:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 352/496] powerpc/64s: sreset panic if there is no debugger or crash dump handlers
Date: Mon, 28 May 2018 12:02:17 +0200
Message-Id: <20180528100334.640552008@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit d40b6768e45bd9213139b2d91d30c7692b6007b1 ]

system_reset_exception does most of its own crash handling now,
invoking the debugger or crash dumps if they are registered. If not,
then it goes through to die() to print stack traces, and then is
supposed to panic (according to comments).

However after die() prints oopses, it does its own handling which
doesn't allow system_reset_exception to panic (e.g., it may just
kill the current process). This patch causes sreset exceptions to
return from die after it prints messages but before acting.

This also stops die from invoking the debugger on 0x100 crashes.
system_reset_exception similarly calls the debugger. It had been
thought this was harmless (because if the debugger was disabled,
neither call would fire, and if it was enabled the first call
would return). However in some cases like xmon 'X' command, the
debugger returns 0, which currently causes it to be entered
again (first in system_reset_exception, then in die), which is
confusing.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/traps.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -182,6 +182,12 @@ static void oops_end(unsigned long flags
 	}
 	raw_local_irq_restore(flags);
 
+	/*
+	 * system_reset_excption handles debugger, crash dump, panic, for 0x100
+	 */
+	if (TRAP(regs) == 0x100)
+		return;
+
 	crash_fadump(regs, "die oops");
 
 	if (kexec_should_crash(current))
@@ -246,8 +252,13 @@ void die(const char *str, struct pt_regs
 {
 	unsigned long flags;
 
-	if (debugger(regs))
-		return;
+	/*
+	 * system_reset_excption handles debugger, crash dump, panic, for 0x100
+	 */
+	if (TRAP(regs) != 0x100) {
+		if (debugger(regs))
+			return;
+	}
 
 	flags = oops_begin(regs);
 	if (__die(str, regs, err))
