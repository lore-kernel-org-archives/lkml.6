Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbeFCM3X (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:29:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751963AbeFCM25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:28:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Laight <David.Laight@ACULAB.COM>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        damian <damian.tometzki@icloud.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 25/29] objtool: Fix "noreturn" detection for recursive sibling calls
Date: Sun,  3 Jun 2018 14:26:48 +0200
Message-Id: <20180603122652.17453-26-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180603122652.17453-1-gregkh@linuxfoundation.org>
References: <20180603122652.17453-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit 0afd0d9e0e7879d666c1df2fa1bea4d8716909fe upstream.

Objtool has some crude logic for detecting static "noreturn" functions
(aka "dead ends").  This is necessary for being able to correctly follow
GCC code flow when such functions are called.

It's remotely possible for two functions to call each other via sibling
calls.  If they don't have RET instructions, objtool's noreturn
detection logic goes into a recursive loop:

  drivers/char/ipmi/ipmi_ssif.o: warning: objtool: return_hosed_msg()+0x0: infinite recursion (objtool bug!)
  drivers/char/ipmi/ipmi_ssif.o: warning: objtool: deliver_recv_msg()+0x0: infinite recursion (objtool bug!)

Instead of reporting an error in this case, consider the functions to be
non-dead-ends.

Reported-and-tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: damian <damian.tometzki@icloud.com>
Link: http://lkml.kernel.org/r/7cc156408c5781a1f62085d352ced1fe39fe2f91.1525923412.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/objtool/check.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2299eae155ac..e128d1c71c30 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -207,9 +207,13 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 
 				/* local sibling call */
 				if (recursion == 5) {
-					WARN_FUNC("infinite recursion (objtool bug!)",
-						  dest->sec, dest->offset);
-					return -1;
+					/*
+					 * Infinite recursion: two functions
+					 * have sibling calls to each other.
+					 * This is a very rare case.  It means
+					 * they aren't dead ends.
+					 */
+					return 0;
 				}
 
 				return __dead_end_function(file, dest->func,
-- 
2.17.1
