Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932222AbeCNPlQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:41:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33543 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751517AbeCNPlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:41:14 -0400
Date: Wed, 14 Mar 2018 08:40:01 -0700
From: tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-af1d830bf32b27b387b97c8b29dc09e306a9ff7f@git.kernel.org>
Cc: fengguang.wu@intel.com, jbaron@akamai.com,
        linux-kernel@vger.kernel.org, davem@davemloft.net, bp@suse.de,
        peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        jpoimboe@redhat.com, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, davem@davemloft.net, jbaron@akamai.com,
        fengguang.wu@intel.com, peterz@infradead.org, bp@suse.de,
        tglx@linutronix.de, hpa@zytor.com, jpoimboe@redhat.com,
        mingo@kernel.org
In-Reply-To: <c966fed42be6611254a62d46579ec7416548d572.1521041026.git.jpoimboe@redhat.com>
References: <c966fed42be6611254a62d46579ec7416548d572.1521041026.git.jpoimboe@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] jump_label: Fix sparc64 warning
Git-Commit-ID: af1d830bf32b27b387b97c8b29dc09e306a9ff7f
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

Commit-ID:  af1d830bf32b27b387b97c8b29dc09e306a9ff7f
Gitweb:     https://git.kernel.org/tip/af1d830bf32b27b387b97c8b29dc09e306a9ff7f
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 14 Mar 2018 10:24:20 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 14 Mar 2018 16:35:26 +0100

jump_label: Fix sparc64 warning

The kbuild test robot reported the following warning on sparc64:

  kernel/jump_label.c: In function '__jump_label_update':
  kernel/jump_label.c:376:51: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
       WARN_ONCE(1, "can't patch jump_label at %pS", (void *)entry->code);

On sparc64, the jump_label entry->code field is of type u32, but
pointers are 64-bit.  Silence the warning by casting entry->code to an
unsigned long before casting it to a pointer.  This is also what the
sparc jump label code does.

Fixes: dc1dd184c2f0 ("jump_label: Warn on failed jump_label patching attempt")
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: "David S . Miller" <davem@davemloft.net>
Link: https://lkml.kernel.org/r/c966fed42be6611254a62d46579ec7416548d572.1521041026.git.jpoimboe@redhat.com

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
