Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518710294-2-10884869290546724201
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710293; b=MLtzftRt50FLoK7sfZB3C8wvxJY96G5IM+LKtaxDd8V9jij
    qMmggcx5OTfPWSEHrygZDEZB+icXTTDZdFCatoMGXrnG+TMPkOv90vCwvv5LY6qh
    E9+gm3z4Y77loNqr5vXzP+/9WuyW1P9cbnYNGzIQTGIiziS2TNpkXYVVTqYSLd3I
    ObtQoCUsd4pdv+juURS8bXyll7oOwcEoH0EzFaXuyuH0IOgJ3hnuAySoAlAjtbtH
    BLyZX2Rua5/ExPDfnq5JYS8vc9wHCjQYM9QKnd052Us8DeIY07KEO9mkYjyGWx8E
    IBTQa17J8cXt8+/sHgTFgjaC2MzEnnCkcUyhA2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710293; bh=U04OlZaEH1GUM0UhDNpKdLpIsk
    Hy3sJtUfAUIS1LO04=; b=v3CPfpApfIgpoNQCExbg562re7I9tZ6CRR05eyU7Wq
    6fY6Q+oauT989RMzfHIss+Vx0AgYwZuVGm1PJtj85fV8mIoFrbelV/UL7Ehj3mT+
    JuNx5u8aybouWs7TeTnIw4XoMC0zH0bxtQ8KdXA/hA2gpt7TdZF7VicFDQ794KLN
    IjEnWWIqXfSdqMQF8y6lqLDqp+8gYIqKDKqsaiWQzby7vtF5oRk+j8fwO8PZxjTx
    03zdOGw9yJo6anOWWFdoZzyUiG9lK9ULtkQsOkW8peB21H5lI9LipBaKC9hATnU3
    SyYYPf7ESlgywB99XNR4pDbfGg5sn9RAnHGiwWGCSzsg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424893AbeBOP55 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:57:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36078 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424841AbeBOPrM (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:47:12 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 187/202] objtool: Fix switch-table detection
Date: Thu, 15 Feb 2018 16:18:07 +0100
Message-Id: <20180215151722.578198998@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 99ce7962d52d1948ad6f2785e308d48e76e0a6ef upstream.

Linus reported that GCC-7.3 generated a switch-table construct that
confused objtool. It turns out that, in particular due to KASAN, it is
possible to have unrelated .rodata usage in between the .rodata setup
for the switch-table and the following indirect jump.

The simple linear reverse search from the indirect jump would hit upon
the KASAN .rodata usage first and fail to find a switch_table,
resulting in a spurious 'sibling call with modified stack frame'
warning.

Fix this by creating a 'jump-stack' which we can 'unwind' during
reversal, thereby skipping over much of the in-between code.

This is not fool proof by any means, but is sufficient to make the
known cases work. Future work would be to construct more comprehensive
flow analysis code.

Reported-and-tested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180208130232.GF25235@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/objtool/check.c |   41 +++++++++++++++++++++++++++++++++++++++--
 tools/objtool/check.h |    1 +
 2 files changed, 40 insertions(+), 2 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -851,8 +851,14 @@ static int add_switch_table(struct objto
  *    This is a fairly uncommon pattern which is new for GCC 6.  As of this
  *    writing, there are 11 occurrences of it in the allmodconfig kernel.
  *
+ *    As of GCC 7 there are quite a few more of these and the 'in between' code
+ *    is significant. Esp. with KASAN enabled some of the code between the mov
+ *    and jmpq uses .rodata itself, which can confuse things.
+ *
  *    TODO: Once we have DWARF CFI and smarter instruction decoding logic,
  *    ensure the same register is used in the mov and jump instructions.
+ *
+ *    NOTE: RETPOLINE made it harder still to decode dynamic jumps.
  */
 static struct rela *find_switch_table(struct objtool_file *file,
 				      struct symbol *func,
@@ -874,12 +880,25 @@ static struct rela *find_switch_table(st
 						text_rela->addend + 4);
 		if (!rodata_rela)
 			return NULL;
+
 		file->ignore_unreachables = true;
 		return rodata_rela;
 	}
 
 	/* case 3 */
-	func_for_each_insn_continue_reverse(file, func, insn) {
+	/*
+	 * Backward search using the @first_jump_src links, these help avoid
+	 * much of the 'in between' code. Which avoids us getting confused by
+	 * it.
+	 */
+	for (insn = list_prev_entry(insn, list);
+
+	     &insn->list != &file->insn_list &&
+	     insn->sec == func->sec &&
+	     insn->offset >= func->offset;
+
+	     insn = insn->first_jump_src ?: list_prev_entry(insn, list)) {
+
 		if (insn->type == INSN_JUMP_DYNAMIC)
 			break;
 
@@ -909,14 +928,32 @@ static struct rela *find_switch_table(st
 	return NULL;
 }
 
+
 static int add_func_switch_tables(struct objtool_file *file,
 				  struct symbol *func)
 {
-	struct instruction *insn, *prev_jump = NULL;
+	struct instruction *insn, *last = NULL, *prev_jump = NULL;
 	struct rela *rela, *prev_rela = NULL;
 	int ret;
 
 	func_for_each_insn(file, func, insn) {
+		if (!last)
+			last = insn;
+
+		/*
+		 * Store back-pointers for unconditional forward jumps such
+		 * that find_switch_table() can back-track using those and
+		 * avoid some potentially confusing code.
+		 */
+		if (insn->type == INSN_JUMP_UNCONDITIONAL && insn->jump_dest &&
+		    insn->offset > last->offset &&
+		    insn->jump_dest->offset > insn->offset &&
+		    !insn->jump_dest->first_jump_src) {
+
+			insn->jump_dest->first_jump_src = insn;
+			last = insn->jump_dest;
+		}
+
 		if (insn->type != INSN_JUMP_DYNAMIC)
 			continue;
 
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -47,6 +47,7 @@ struct instruction {
 	bool alt_group, visited, dead_end, ignore, hint, save, restore, ignore_alts;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
+	struct instruction *first_jump_src;
 	struct list_head alts;
 	struct symbol *func;
 	struct stack_op stack_op;
