Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D501DC71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C53E20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C53E20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeJOUWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:22:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:52264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726400AbeJOUWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:22:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0A91AAE15;
        Mon, 15 Oct 2018 12:37:25 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v13 01/12] livepatch: Change void *new_func -> unsigned long new_addr in struct klp_func
Date:   Mon, 15 Oct 2018 14:37:02 +0200
Message-Id: <20181015123713.25868-2-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20181015123713.25868-1-pmladek@suse.com>
References: <20181015123713.25868-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The address of the to be patched function and new function is stored
in struct klp_func as:

	void *new_func;
	unsigned long old_addr;

The different naming scheme and type is derived from the way how
the addresses are set. @old_addr is assigned at runtime using
kallsyms-based search. @new_func is statically initialized,
for example:

  static struct klp_func funcs[] = {
	{
		.old_name = "cmdline_proc_show",
		.new_func = livepatch_cmdline_proc_show,
	}, { }
  };

This patch changes void *new_func -> unsigned long new_addr. It removes
some confusion when these address are later used in the code. It is
motivated by a followup patch that adds special NOP struct klp_func
where we want to assign func->new_func = func->old_addr respectively
func->new_addr = func->old_addr.

This patch does not modify the existing behavior.

IMPORTANT: This patch modifies ABI. The patches will need to use,
for example:

  static struct klp_func funcs[] = {
	{
		.old_name = "cmdline_proc_show",
		.new_addr = (unsigned long)livepatch_cmdline_proc_show,
	}, { }
  };

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/livepatch.h                    | 6 +++---
 kernel/livepatch/core.c                      | 4 ++--
 kernel/livepatch/patch.c                     | 2 +-
 kernel/livepatch/transition.c                | 4 ++--
 samples/livepatch/livepatch-callbacks-demo.c | 2 +-
 samples/livepatch/livepatch-sample.c         | 2 +-
 samples/livepatch/livepatch-shadow-fix1.c    | 4 ++--
 samples/livepatch/livepatch-shadow-fix2.c    | 4 ++--
 8 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index aec44b1d9582..817a737b49e8 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -37,7 +37,7 @@
 /**
  * struct klp_func - function structure for live patching
  * @old_name:	name of the function to be patched
- * @new_func:	pointer to the patched function code
+ * @new_addr:	address of the new function (function pointer)
  * @old_sympos: a hint indicating which symbol position the old function
  *		can be found (optional)
  * @old_addr:	the address of the function being patched
@@ -66,7 +66,7 @@
 struct klp_func {
 	/* external */
 	const char *old_name;
-	void *new_func;
+	unsigned long new_addr;
 	/*
 	 * The old_sympos field is optional and can be used to resolve
 	 * duplicate symbol names in livepatch objects. If this field is zero,
@@ -157,7 +157,7 @@ struct klp_patch {
 
 #define klp_for_each_func(obj, func) \
 	for (func = obj->funcs; \
-	     func->old_name || func->new_func || func->old_sympos; \
+	     func->old_name || func->new_addr || func->old_sympos; \
 	     func++)
 
 int klp_register_patch(struct klp_patch *);
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 5b77a7314e01..577ebeb43024 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -675,7 +675,7 @@ static void klp_free_patch(struct klp_patch *patch)
 
 static int klp_init_func(struct klp_object *obj, struct klp_func *func)
 {
-	if (!func->old_name || !func->new_func)
+	if (!func->old_name || !func->new_addr)
 		return -EINVAL;
 
 	if (strlen(func->old_name) >= KSYM_NAME_LEN)
@@ -733,7 +733,7 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 			return -ENOENT;
 		}
 
-		ret = kallsyms_lookup_size_offset((unsigned long)func->new_func,
+		ret = kallsyms_lookup_size_offset(func->new_addr,
 						  &func->new_size, NULL);
 		if (!ret) {
 			pr_err("kallsyms size lookup failed for '%s' replacement\n",
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index 82d584225dc6..82927f59d3ff 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -118,7 +118,7 @@ static void notrace klp_ftrace_handler(unsigned long ip,
 		}
 	}
 
-	klp_arch_set_pc(regs, (unsigned long)func->new_func);
+	klp_arch_set_pc(regs, func->new_addr);
 unlock:
 	preempt_enable_notrace();
 }
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 5bc349805e03..982a2e4c6120 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -217,7 +217,7 @@ static int klp_check_stack_func(struct klp_func *func,
 			  * Check for the to-be-unpatched function
 			  * (the func itself).
 			  */
-			func_addr = (unsigned long)func->new_func;
+			func_addr = func->new_addr;
 			func_size = func->new_size;
 		} else {
 			/*
@@ -235,7 +235,7 @@ static int klp_check_stack_func(struct klp_func *func,
 				struct klp_func *prev;
 
 				prev = list_next_entry(func, stack_node);
-				func_addr = (unsigned long)prev->new_func;
+				func_addr = prev->new_addr;
 				func_size = prev->new_size;
 			}
 		}
diff --git a/samples/livepatch/livepatch-callbacks-demo.c b/samples/livepatch/livepatch-callbacks-demo.c
index 72f9e6d1387b..4b1aec474bb7 100644
--- a/samples/livepatch/livepatch-callbacks-demo.c
+++ b/samples/livepatch/livepatch-callbacks-demo.c
@@ -153,7 +153,7 @@ static struct klp_func no_funcs[] = {
 static struct klp_func busymod_funcs[] = {
 	{
 		.old_name = "busymod_work_func",
-		.new_func = patched_work_func,
+		.new_addr = (unsigned long)patched_work_func,
 	}, { }
 };
 
diff --git a/samples/livepatch/livepatch-sample.c b/samples/livepatch/livepatch-sample.c
index 2d554dd930e2..e470a052fb77 100644
--- a/samples/livepatch/livepatch-sample.c
+++ b/samples/livepatch/livepatch-sample.c
@@ -51,7 +51,7 @@ static int livepatch_cmdline_proc_show(struct seq_file *m, void *v)
 static struct klp_func funcs[] = {
 	{
 		.old_name = "cmdline_proc_show",
-		.new_func = livepatch_cmdline_proc_show,
+		.new_addr = (unsigned long)livepatch_cmdline_proc_show,
 	}, { }
 };
 
diff --git a/samples/livepatch/livepatch-shadow-fix1.c b/samples/livepatch/livepatch-shadow-fix1.c
index 49b13553eaae..ede0de7abe40 100644
--- a/samples/livepatch/livepatch-shadow-fix1.c
+++ b/samples/livepatch/livepatch-shadow-fix1.c
@@ -130,11 +130,11 @@ void livepatch_fix1_dummy_free(struct dummy *d)
 static struct klp_func funcs[] = {
 	{
 		.old_name = "dummy_alloc",
-		.new_func = livepatch_fix1_dummy_alloc,
+		.new_addr = (unsigned long)livepatch_fix1_dummy_alloc,
 	},
 	{
 		.old_name = "dummy_free",
-		.new_func = livepatch_fix1_dummy_free,
+		.new_addr = (unsigned long)livepatch_fix1_dummy_free,
 	}, { }
 };
 
diff --git a/samples/livepatch/livepatch-shadow-fix2.c b/samples/livepatch/livepatch-shadow-fix2.c
index b34c7bf83356..035ee0ef387f 100644
--- a/samples/livepatch/livepatch-shadow-fix2.c
+++ b/samples/livepatch/livepatch-shadow-fix2.c
@@ -107,11 +107,11 @@ void livepatch_fix2_dummy_free(struct dummy *d)
 static struct klp_func funcs[] = {
 	{
 		.old_name = "dummy_check",
-		.new_func = livepatch_fix2_dummy_check,
+		.new_addr = (unsigned long)livepatch_fix2_dummy_check,
 	},
 	{
 		.old_name = "dummy_free",
-		.new_func = livepatch_fix2_dummy_free,
+		.new_addr = (unsigned long)livepatch_fix2_dummy_free,
 	}, { }
 };
 
-- 
2.13.7

