Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933402AbeCGIVO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 03:21:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:50185 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933324AbeCGIVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 03:21:08 -0500
From: Petr Mladek <pmladek@suse.com>
To: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc: Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v10 09/10] livepatch: Allow to replace even disabled patches
Date: Wed,  7 Mar 2018 09:20:38 +0100
Message-Id: <20180307082039.10196-10-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180307082039.10196-1-pmladek@suse.com>
References: <20180307082039.10196-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches without the replace flag might depend on each other. It makes
sense to enforce the order in which they are enabled and disabled.

The situation is different when the patch replaces all existing ones.
It should make the life easier for both: patch producers and users.
Such a patch should be ready to replace basically any older patch.
It should work well even in situations when the previous patches
were not installed or when they were disabled from some reasons.

The code is almost ready for this:

  + klp_add_nops() takes into account even disabled patches. In the worst
    case, we might enable some NOPs that are not really needed.

  + klp_throw_away_replaced_patches() removes all patches down the stack.

We only need to make sure that the livepatch module is put only when
it was gotten (enabled) before.

Also we need to stop enforcing the stack order for the patches
with the replace flag. Instead, we need to make sure that they
are still usable (not replaced).

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/livepatch/core.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 73ce3f93e0bc..b098dc10d4d5 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -376,17 +376,19 @@ void klp_throw_away_replaced_patches(struct klp_patch *new_patch,
 		if (old_patch == new_patch)
 			return;
 
-		klp_unpatch_objects(old_patch, KLP_FUNC_ANY);
-		old_patch->enabled = false;
+		if (old_patch->enabled) {
+			klp_unpatch_objects(old_patch, KLP_FUNC_ANY);
+			old_patch->enabled = false;
+
+			if (!keep_module)
+				module_put(old_patch->mod);
+		}
 
 		/*
 		 * Replaced patches could not get re-enabled to keep
 		 * the code sane.
 		 */
 		list_move(&old_patch->list, &klp_replaced_patches);
-
-		if (!keep_module)
-			module_put(old_patch->mod);
 	}
 }
 
@@ -470,8 +472,16 @@ static int __klp_enable_patch(struct klp_patch *patch)
 	if (WARN_ON(patch->enabled))
 		return -EINVAL;
 
-	/* enforce stacking: only the first disabled patch can be enabled */
-	if (patch->list.prev != &klp_patches &&
+	if (!klp_is_patch_usable(patch))
+		return -EINVAL;
+
+	/*
+	 * Enforce stacking: only the first disabled patch can be enabled.
+	 * This is not required for patches with the replace flags. They
+	 * override even disabled patches that were registered earlier.
+	 */
+	if (!patch->replace &&
+	    patch->list.prev != &klp_patches &&
 	    !list_prev_entry(patch, list)->enabled)
 		return -EBUSY;
 
-- 
2.13.6
