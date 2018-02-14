Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032789AbeBNQlS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:41:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032773AbeBNQlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:41:16 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 1/3] jump_label: Warn on failed jump_label patch
Date: Wed, 14 Feb 2018 10:40:41 -0600
Message-Id: <b8f1b55f17c346fba39d3f59a01251185e09e151.1518626149.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1518626149.git.jpoimboe@redhat.com>
References: <cover.1518626149.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the jump label code encounters an address which isn't recognized by
kernel_text_address(), it just silently fails.

This can be dangerous because jump labels are used in a variety of
places, and are generally expected to work.  Convert the silent failure
to a warning.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 kernel/jump_label.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index b4517095db6a..c71fb7cdfc41 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -370,8 +370,12 @@ static void __jump_label_update(struct static_key *key,
 		 * kernel_text_address() verifies we are not in core kernel
 		 * init code, see jump_label_invalidate_module_init().
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
