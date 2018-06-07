Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id M7kSMb76GFtKeAAAmS7hNA
	; Thu, 07 Jun 2018 09:30:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 401BC607DC; Thu,  7 Jun 2018 09:30:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A33E7605A2;
	Thu,  7 Jun 2018 09:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A33E7605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932206AbeFGJad (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:30:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:54615 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753001AbeFGJ3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:29:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 571C0AEF5;
        Thu,  7 Jun 2018 09:29:52 +0000 (UTC)
From: Miroslav Benes <mbenes@suse.cz>
To: jikos@kernel.org, jpoimboe@redhat.com, jeyu@kernel.org
Cc: pmladek@suse.com, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 2/3] livepatch: Deny the patched modules to be removed
Date: Thu,  7 Jun 2018 11:29:48 +0200
Message-Id: <20180607092949.1706-3-mbenes@suse.cz>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180607092949.1706-1-mbenes@suse.cz>
References: <20180607092949.1706-1-mbenes@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh reported a bug:

  When the object to be patched is a module, and that module is
  rmmod'ed and reloaded, it fails to load with:

  module: x86/modules: Skipping invalid relocation target, existing value is nonzero for type 2, loc 00000000ba0302e9, val ffffffffa03e293c
  livepatch: failed to initialize patch 'livepatch_nfsd' for module 'nfsd' (-8)
  livepatch: patch 'livepatch_nfsd' failed for module 'nfsd', refusing to load module 'nfsd'

  The livepatch module has a relocation which references a symbol
  in the _previous_ loading of nfsd. When apply_relocate_add()
  tries to replace the old relocation with a new one, it sees that
  the previous one is nonzero and it errors out.

  On ppc64le, we have a similar issue:

  module_64: livepatch_nfsd: Expected nop after call, got e8410018 at e_show+0x60/0x548 [livepatch_nfsd]
  livepatch: failed to initialize patch 'livepatch_nfsd' for module 'nfsd' (-8)
  livepatch: patch 'livepatch_nfsd' failed for module 'nfsd', refusing to load module 'nfsd'

He also proposed three different solutions. We could remove the error
check in apply_relocate_add() introduced by commit eda9cec4c9a1
("x86/module: Detect and skip invalid relocations"). However the check
is useful for detecting corrupted modules.

We could also reverse the relocation patching (clear all relocation
targets on x86_64, or return back nops on powerpc) in
klp_unpatch_object(). The solution is not universal and is too much
arch-specific.

We decided to deny the patched modules to be removed. If it proves to be
a major drawback for users, we can still implement a different approach.

The reference of a patched module has to be taken regardless of a
patch's state. Thus it is not taken and dropped in enable/disable paths,
but in register/unregister paths.

The new behaviour should not collide with mod->klp_alive variable.

Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 kernel/livepatch/core.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 36eb5cf38766..2fa9eaee7bb5 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -645,6 +645,10 @@ static void klp_free_object_loaded(struct klp_object *obj)
 {
 	struct klp_func *func;
 
+	/*
+	 * Drop the reference from klp_init_object_loaded()
+	 */
+	module_put(obj->mod);
 	obj->mod = NULL;
 
 	klp_for_each_func(obj, func)
@@ -663,6 +667,9 @@ static void klp_free_objects_limited(struct klp_patch *patch,
 	for (obj = patch->objs; obj->funcs && obj != limit; obj++) {
 		klp_free_funcs_limited(obj, NULL);
 		kobject_put(&obj->kobj);
+
+		if (klp_is_module(obj) && klp_is_object_loaded(obj))
+			module_put(obj->mod);
 	}
 }
 
@@ -739,6 +746,14 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 		}
 	}
 
+	/*
+	 * Do not allow patched modules to be removed.
+	 *
+	 * All callers of klp_init_object_loaded() set obj->mod.
+	 */
+	if (klp_is_module(obj) && !try_module_get(obj->mod))
+		return -ENODEV;
+
 	return 0;
 }
 
@@ -984,7 +999,7 @@ int klp_module_coming(struct module *mod)
 			if (ret) {
 				pr_warn("pre-patch callback failed for object '%s'\n",
 					obj->name);
-				goto err;
+				goto err_after_init;
 			}
 
 			ret = klp_patch_object(obj);
@@ -993,7 +1008,7 @@ int klp_module_coming(struct module *mod)
 					patch->mod->name, obj->mod->name, ret);
 
 				klp_post_unpatch_callback(obj);
-				goto err;
+				goto err_after_init;
 			}
 
 			if (patch != klp_transition_patch)
@@ -1007,6 +1022,11 @@ int klp_module_coming(struct module *mod)
 
 	return 0;
 
+err_after_init:
+	/*
+	 * Drop the reference from klp_init_object_loaded().
+	 */
+	module_put(obj->mod);
 err:
 	/*
 	 * If a patch is unsuccessfully applied, return
-- 
2.17.0
