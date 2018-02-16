Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031961AbeBPQb1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:31:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031878AbeBPQbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:31:25 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH v2 2/2] jump_label: Warn on failed jump_label patch
Date: Fri, 16 Feb 2018 10:31:15 -0600
Message-Id: <36f514afcaaeec45cbdd35b201e1de0ec4cf9a7d.1518798288.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1518798288.git.jpoimboe@redhat.com>
References: <cover.1518798288.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the jump label code encounters an address which isn't recognized by
kernel_text_address(), it just silently fails.

This can be dangerous because jump labels are used in a variety of
places, and are generally expected to work.  Convert the silent failure
to a warning.

This won't warn about attempted writes to tracepoints in __init code
after initmem has been freed, as those are already guarded by the
entry->code check.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 kernel/jump_label.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 96274c6d3511..08a02ae54997 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -367,12 +367,15 @@ static void __jump_label_update(struct static_key *key,
 {
 	for (; (entry < stop) && (jump_entry_key(entry) == key); entry++) {
 		/*
-		 * entry->code set to 0 invalidates module init text sections
-		 * kernel_text_address() verifies we are not in core kernel
-		 * init code, see jump_label_invalidate_module_init().
+		 * An entry->code of 0 indicates an entry which has been
+		 * disabled because it was in an init text area.
 		 */
-		if (entry->code && kernel_text_address(entry->code))
-			arch_jump_label_transform(entry, jump_label_type(entry));
+		if (entry->code) {
+			if (kernel_text_address(entry->code))
+				arch_jump_label_transform(entry, jump_label_type(entry));
+			else
+				WARN_ONCE(1, "can't patch jump_label at %pS", (void *)entry->code);
+		}
 	}
 }
 
-- 
2.14.3
