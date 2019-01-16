Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C61C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C4920675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405239AbfAPQRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:17:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:38666 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729517AbfAPQRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:17:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 73911AE3C;
        Wed, 16 Jan 2019 16:17:45 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 1/4] livepatch: Introduce klp_for_each_patch macro
Date:   Wed, 16 Jan 2019 17:17:17 +0100
Message-Id: <20190116161720.796-2-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190116161720.796-1-pmladek@suse.com>
References: <20190116161720.796-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are already macros to iterate over struct klp_func and klp_object.

Add also klp_for_each_patch(). But make it internal because also
klp_patches list is internal.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/livepatch/core.c       | 8 ++++----
 kernel/livepatch/core.h       | 6 ++++++
 kernel/livepatch/transition.c | 2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index adca5cf07f7e..b716a6289204 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -554,7 +554,7 @@ static int klp_add_nops(struct klp_patch *patch)
 	struct klp_patch *old_patch;
 	struct klp_object *old_obj;
 
-	list_for_each_entry(old_patch, &klp_patches, list) {
+	klp_for_each_patch(old_patch) {
 		klp_for_each_object(old_patch, old_obj) {
 			int err;
 
@@ -1089,7 +1089,7 @@ void klp_discard_replaced_patches(struct klp_patch *new_patch)
 {
 	struct klp_patch *old_patch, *tmp_patch;
 
-	list_for_each_entry_safe(old_patch, tmp_patch, &klp_patches, list) {
+	klp_for_each_patch_safe(old_patch, tmp_patch) {
 		if (old_patch == new_patch)
 			return;
 
@@ -1133,7 +1133,7 @@ static void klp_cleanup_module_patches_limited(struct module *mod,
 	struct klp_patch *patch;
 	struct klp_object *obj;
 
-	list_for_each_entry(patch, &klp_patches, list) {
+	klp_for_each_patch(patch) {
 		if (patch == limit)
 			break;
 
@@ -1180,7 +1180,7 @@ int klp_module_coming(struct module *mod)
 	 */
 	mod->klp_alive = true;
 
-	list_for_each_entry(patch, &klp_patches, list) {
+	klp_for_each_patch(patch) {
 		klp_for_each_object(patch, obj) {
 			if (!klp_is_module(obj) || strcmp(obj->name, mod->name))
 				continue;
diff --git a/kernel/livepatch/core.h b/kernel/livepatch/core.h
index e6200f38701f..ec43a40b853f 100644
--- a/kernel/livepatch/core.h
+++ b/kernel/livepatch/core.h
@@ -7,6 +7,12 @@
 extern struct mutex klp_mutex;
 extern struct list_head klp_patches;
 
+#define klp_for_each_patch_safe(patch, tmp_patch)		\
+	list_for_each_entry_safe(patch, tmp_patch, &klp_patches, list)
+
+#define klp_for_each_patch(patch)	\
+	list_for_each_entry(patch, &klp_patches, list)
+
 void klp_free_patch_start(struct klp_patch *patch);
 void klp_discard_replaced_patches(struct klp_patch *new_patch);
 void klp_discard_nops(struct klp_patch *new_patch);
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 300273819674..a3a6f32c6fd0 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -642,6 +642,6 @@ void klp_force_transition(void)
 	for_each_possible_cpu(cpu)
 		klp_update_patch_state(idle_task(cpu));
 
-	list_for_each_entry(patch, &klp_patches, list)
+	klp_for_each_patch(patch)
 		patch->forced = true;
 }
-- 
2.13.7

