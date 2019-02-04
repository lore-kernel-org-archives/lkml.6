Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26849C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34D22082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbfBDN5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 08:57:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:35818 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729991AbfBDN5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 08:57:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E0581ADE6;
        Mon,  4 Feb 2019 13:57:08 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 4/4] livepatch: Module coming and going callbacks can proceed with all listed patches
Date:   Mon,  4 Feb 2019 14:56:53 +0100
Message-Id: <20190204135653.31406-5-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190204135653.31406-1-pmladek@suse.com>
References: <20190204135653.31406-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Livepatches can no longer get enabled and disabled repeatedly.
The list klp_patches contains only enabled patches and eventually
the patch in transition.

The module coming and going callbacks do no longer need to check
for these state. They have to proceed with all listed patches.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
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

