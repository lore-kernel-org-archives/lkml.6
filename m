Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbeBURCw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:02:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49001 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932317AbeBURCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:02:50 -0500
Date: Wed, 21 Feb 2018 09:02:08 -0800
From: tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-dc1dd184c2f0016bec35c0d7a48c057e0ad763d3@git.kernel.org>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, jbaron@akamai.com, jpoimboe@redhat.com,
        hpa@zytor.com, mingo@kernel.org, torvalds@linux-foundation.org,
        bp@suse.de
Reply-To: mingo@kernel.org, bp@suse.de, torvalds@linux-foundation.org,
        hpa@zytor.com, jpoimboe@redhat.com, jbaron@akamai.com,
        peterz@infradead.org, tglx@linutronix.de, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <de3a271c93807adb7ed48f4e946b4f9156617680.1519051220.git.jpoimboe@redhat.com>
References: <de3a271c93807adb7ed48f4e946b4f9156617680.1519051220.git.jpoimboe@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] jump_label: Warn on failed jump_label patching
 attempt
Git-Commit-ID: dc1dd184c2f0016bec35c0d7a48c057e0ad763d3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  dc1dd184c2f0016bec35c0d7a48c057e0ad763d3
Gitweb:     https://git.kernel.org/tip/dc1dd184c2f0016bec35c0d7a48c057e0ad763d3
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Tue, 20 Feb 2018 11:37:52 -0600
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 16:54:06 +0100

jump_label: Warn on failed jump_label patching attempt

Currently when the jump label code encounters an address which isn't
recognized by kernel_text_address(), it just silently fails.

This can be dangerous because jump labels are used in a variety of
places, and are generally expected to work.  Convert the silent failure
to a warning.

This won't warn about attempted writes to tracepoints in __init code
after initmem has been freed, as those are already guarded by the
entry->code check.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/de3a271c93807adb7ed48f4e946b4f9156617680.1519051220.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/jump_label.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index b717765..b2f0b47 100644
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
 
