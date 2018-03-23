Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753714AbeCWMBa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:01:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:39649 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753565AbeCWMBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:01:03 -0400
From: Petr Mladek <pmladek@suse.com>
To: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc: Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 7/8] livepatch: Allow to replace even disabled patches
Date: Fri, 23 Mar 2018 13:00:27 +0100
Message-Id: <20180323120028.31451-8-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180323120028.31451-1-pmladek@suse.com>
References: <20180323120028.31451-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches without the replace flag might depend on each other. It makes
sense to enforce the order in which they are enabled and disabled.

The situation is different when the patch replaces all existing ones.
These patches should make the life easier for both: patch producers
and users. Such a patch should be ready to replace basically any
older patch. It should work well even in situations when the previous
patches were not installed or when they were disabled from some reasons.

The code is almost ready for this. There are needed two changes:

  + Disable only enabled patches in klp_discard_replaced_patches().

  + Stop enforcing the stack order for the patches with the replace flag.
    Instead, we need to make sure that they are still usable (not
    replaced). This check is already there.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/livepatch/core.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 0b3be6e14b80..c64371ffc063 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -355,11 +355,13 @@ void klp_discard_replaced_patches(struct klp_patch *new_patch, bool keep_module)
 		if (old_patch == new_patch)
 			return;
 
-		klp_unpatch_objects(old_patch);
-		old_patch->enabled = false;
+		if (old_patch->enabled) {
+			klp_unpatch_objects(old_patch);
+			old_patch->enabled = false;
 
-		if (!keep_module)
-			module_put(old_patch->mod);
+			if (!keep_module)
+				module_put(old_patch->mod);
+		}
 
 		/*
 		 * Replaced patches could not get re-enabled to keep
@@ -453,8 +455,13 @@ static int __klp_enable_patch(struct klp_patch *patch)
 	if (!klp_is_patch_on_stack(patch))
 		return -EINVAL;
 
-	/* Only the first disabled patch can be enabled. */
-	if (patch->list.prev != &klp_patches &&
+	/*
+	 * Only the first disabled patch can be enabled. This is not required
+	 * for patches with the replace flags. They override even disabled
+	 * patches that were registered earlier.
+	 */
+	if (!patch->replace &&
+	    patch->list.prev != &klp_patches &&
 	    !list_prev_entry(patch, list)->enabled)
 		return -EBUSY;
 
-- 
2.13.6
