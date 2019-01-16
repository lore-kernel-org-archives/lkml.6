Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9B6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5AAF20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405357AbfAPQRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:17:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:38698 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405268AbfAPQRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:17:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3073AED4;
        Wed, 16 Jan 2019 16:17:47 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 3/4] livepatch: Module coming and going callbacks can proceed all listed patches
Date:   Wed, 16 Jan 2019 17:17:19 +0100
Message-Id: <20190116161720.796-4-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190116161720.796-1-pmladek@suse.com>
References: <20190116161720.796-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Livepatches can not longer get enabled and disabled repeatedly.
The list klp_patches contains only enabled patches and eventually
the patch in transition.

The module coming and going callbacks do not longer need to
check for these state. They have to proceed all listed patches.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/livepatch/core.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index b716a6289204..684766d306ad 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -1141,21 +1141,14 @@ static void klp_cleanup_module_patches_limited(struct module *mod,
 			if (!klp_is_module(obj) || strcmp(obj->name, mod->name))
 				continue;
 
-			/*
-			 * Only unpatch the module if the patch is enabled or
-			 * is in transition.
-			 */
-			if (patch->enabled || patch == klp_transition_patch) {
-
-				if (patch != klp_transition_patch)
-					klp_pre_unpatch_callback(obj);
+			if (patch != klp_transition_patch)
+				klp_pre_unpatch_callback(obj);
 
-				pr_notice("reverting patch '%s' on unloading module '%s'\n",
-					  patch->mod->name, obj->mod->name);
-				klp_unpatch_object(obj);
+			pr_notice("reverting patch '%s' on unloading module '%s'\n",
+				  patch->mod->name, obj->mod->name);
+			klp_unpatch_object(obj);
 
-				klp_post_unpatch_callback(obj);
-			}
+			klp_post_unpatch_callback(obj);
 
 			klp_free_object_loaded(obj);
 			break;
@@ -1194,13 +1187,6 @@ int klp_module_coming(struct module *mod)
 				goto err;
 			}
 
-			/*
-			 * Only patch the module if the patch is enabled or is
-			 * in transition.
-			 */
-			if (!patch->enabled && patch != klp_transition_patch)
-				break;
-
 			pr_notice("applying patch '%s' to loading module '%s'\n",
 				  patch->mod->name, obj->mod->name);
 
-- 
2.13.7

