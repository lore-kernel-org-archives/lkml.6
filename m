Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbeEGBYV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 21:24:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751864AbeEGBYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 21:24:18 -0400
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] objtool: fix dead end logic for recursive sibling calls
Date: Sun,  6 May 2018 20:24:14 -0500
Message-Id: <b75b33aa241b2ec1b78a72c2414b990a4fa0f659.1525656072.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Objtool has some crude logic for detecting static functions which never
return (aka "dead ends").  This is necessary for being able to correctly
follow GCC code flow when such functions are called.

It's remotely possible for two functions to call each other via sibling
calls.  If they don't have RET instructions, objtool's dead end
detection logic goes into a recursive loop:

  drivers/char/ipmi/ipmi_ssif.o: warning: objtool: return_hosed_msg()+0x0: infinite recursion (objtool bug!)
  drivers/char/ipmi/ipmi_ssif.o: warning: objtool: deliver_recv_msg()+0x0: infinite recursion (objtool bug!)

Instead of reporting an error in this case, consider the functions to be
non-dead-ends.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 92b6a2c21631..dae568fef2c1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -190,9 +190,13 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 					continue;
 
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
 
 				return __dead_end_function(file, dest_func,
-- 
2.14.3
