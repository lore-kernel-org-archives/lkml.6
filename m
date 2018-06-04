Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753895AbeFDHQF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:16:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753584AbeFDHDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:03:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, David Laight <David.Laight@ACULAB.COM>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        damian <damian.tometzki@icloud.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.16 05/47] objtool: Fix "noreturn" detection for recursive sibling calls
Date: Mon,  4 Jun 2018 08:58:17 +0200
Message-Id: <20180604065549.699801901@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065549.468488465@linuxfoundation.org>
References: <20180604065549.468488465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

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
 tools/objtool/check.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -208,9 +208,13 @@ static int __dead_end_function(struct ob
 
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
