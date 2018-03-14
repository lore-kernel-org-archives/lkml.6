Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbeCNPYx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:24:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751289AbeCNPYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:24:52 -0400
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH] jump_label: Fix sparc64 warning
Date: Wed, 14 Mar 2018 10:24:20 -0500
Message-Id: <c966fed42be6611254a62d46579ec7416548d572.1521041026.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kbuild test robot reported the following warning on sparc64:

  kernel/jump_label.c: In function '__jump_label_update':
  kernel/jump_label.c:376:51: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
       WARN_ONCE(1, "can't patch jump_label at %pS", (void *)entry->code);

On sparc64, the jump_label entry->code field is of type u32, but
pointers are 64-bit.  Silence the warning by casting entry->code to an
unsigned long before casting it to a pointer.  This is also what the
sparc jump label code does.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Fixes: dc1dd184c2f0 ("jump_label: Warn on failed jump_label patching attempt")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 kernel/jump_label.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 52a0a7af8640..e7214093dcd1 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -373,7 +373,8 @@ static void __jump_label_update(struct static_key *key,
 			if (kernel_text_address(entry->code))
 				arch_jump_label_transform(entry, jump_label_type(entry));
 			else
-				WARN_ONCE(1, "can't patch jump_label at %pS", (void *)entry->code);
+				WARN_ONCE(1, "can't patch jump_label at %pS",
+					  (void *)(unsigned long)entry->code);
 		}
 	}
 }
-- 
2.14.3
