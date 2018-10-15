Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98393C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4D82089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4D82089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJOUWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:22:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:52286 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726499AbeJOUWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:22:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2CA44AE19;
        Mon, 15 Oct 2018 12:37:27 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v13 02/12] livepatch: Helper macros to define livepatch structures
Date:   Mon, 15 Oct 2018 14:37:03 +0200
Message-Id: <20181015123713.25868-3-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20181015123713.25868-1-pmladek@suse.com>
References: <20181015123713.25868-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definition of struct klp_func might be a bit confusing.
The original function is defined by name as a string.
The new function is defined by name as a function pointer
casted to unsigned long.

This patch adds helper macros that hide the different types.
The functions are defined just by the name. For example:

static struct klp_func funcs[] = {
	{
		.old_name = "function_A",
		.new_addr = (unsigned long)livepatch_function_A,
	}, {
		.old_name = "function_B",
		.new_addr = (unsigned long)livepatch_function_B,
	}, { }
};

can be defined as:

static struct klp_func funcs[] = {
	KLP_FUNC(function_A,
		 livepatch_function_A),
	KLP_FUNC(function_B,
		 livepatch_function_B),
	KLP_FUNC_END
};

Just for completeness, this patch adds similar macros to define
struct klp_object. For example,

static struct klp_object objs[] = {
	{
		/* name being NULL means vmlinux */
		.funcs = funcs_vmlinux,
	}, {
		.name = "module_A",
		.funcs = funcs_module_A,
	}, {
		.name = "module_B",
		.funcs = funcs_module_B,
	}, { }
};

can be defined as:

static struct klp_object objs[] = {
	KLP_VMLINUX(funcs_vmlinux),
	KLP_OBJECT(module_A,
		   funcs_module_A),
	KLP_OBJECT(module_B,
		   funcs_module_B),
	KLP_OBJECT_END
};

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/livepatch.h                    | 40 ++++++++++++++++++++
 samples/livepatch/livepatch-callbacks-demo.c | 55 +++++++++++-----------------
 samples/livepatch/livepatch-sample.c         | 13 +++----
 samples/livepatch/livepatch-shadow-fix1.c    | 20 ++++------
 samples/livepatch/livepatch-shadow-fix2.c    | 20 ++++------
 5 files changed, 83 insertions(+), 65 deletions(-)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 817a737b49e8..1163742b27c0 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -152,6 +152,46 @@ struct klp_patch {
 	struct completion finish;
 };
 
+#define KLP_FUNC(_old_func, _new_func) {			\
+		.old_name = #_old_func,				\
+		.new_addr = (unsigned long)(_new_func),		\
+	}
+#define KLP_FUNC_POS(_old_func, _new_func, _sympos) {		\
+		.old_name = #_old_func,				\
+		.new_addr = (unsigned long)_new_func,		\
+		.sympos = _sympos,				\
+	}
+#define KLP_FUNC_END { }
+
+#define KLP_OBJECT(_obj, _funcs) {				\
+		.name = #_obj,					\
+		.funcs = _funcs,				\
+	}
+#define KLP_OBJECT_CALLBACKS(_obj, _funcs,			\
+			     _pre_patch, _post_patch,		\
+			     _pre_unpatch, _post_unpatch) {	\
+		.name = #_obj,					\
+		.funcs = _funcs,				\
+		.callbacks.pre_patch = _pre_patch,		\
+		.callbacks.post_patch = _post_patch,		\
+		.callbacks.pre_unpatch = _pre_unpatch,		\
+		.callbacks.post_unpatch = _post_unpatch,	\
+	}
+/* name being NULL means vmlinux */
+#define KLP_VMLINUX(_funcs) {					\
+		.funcs = _funcs,				\
+	}
+#define KLP_VMLINUX_CALLBACKS(_funcs,				\
+			     _pre_patch, _post_patch,		\
+			     _pre_unpatch, _post_unpatch) {	\
+		.funcs = _funcs,				\
+		.callbacks.pre_patch = _pre_patch,		\
+		.callbacks.post_patch = _post_patch,		\
+		.callbacks.pre_unpatch = _pre_unpatch,		\
+		.callbacks.post_unpatch = _post_unpatch,	\
+	}
+#define KLP_OBJECT_END { }
+
 #define klp_for_each_object(patch, obj) \
 	for (obj = patch->objs; obj->funcs || obj->name; obj++)
 
diff --git a/samples/livepatch/livepatch-callbacks-demo.c b/samples/livepatch/livepatch-callbacks-demo.c
index 4b1aec474bb7..001a0c672251 100644
--- a/samples/livepatch/livepatch-callbacks-demo.c
+++ b/samples/livepatch/livepatch-callbacks-demo.c
@@ -147,45 +147,34 @@ static void patched_work_func(struct work_struct *work)
 }
 
 static struct klp_func no_funcs[] = {
-	{ }
+	KLP_FUNC_END
 };
 
 static struct klp_func busymod_funcs[] = {
-	{
-		.old_name = "busymod_work_func",
-		.new_addr = (unsigned long)patched_work_func,
-	}, { }
+	KLP_FUNC(busymod_work_func,
+		 patched_work_func),
+	KLP_FUNC_END
 };
 
 static struct klp_object objs[] = {
-	{
-		.name = NULL,	/* vmlinux */
-		.funcs = no_funcs,
-		.callbacks = {
-			.pre_patch = pre_patch_callback,
-			.post_patch = post_patch_callback,
-			.pre_unpatch = pre_unpatch_callback,
-			.post_unpatch = post_unpatch_callback,
-		},
-	},	{
-		.name = "livepatch_callbacks_mod",
-		.funcs = no_funcs,
-		.callbacks = {
-			.pre_patch = pre_patch_callback,
-			.post_patch = post_patch_callback,
-			.pre_unpatch = pre_unpatch_callback,
-			.post_unpatch = post_unpatch_callback,
-		},
-	},	{
-		.name = "livepatch_callbacks_busymod",
-		.funcs = busymod_funcs,
-		.callbacks = {
-			.pre_patch = pre_patch_callback,
-			.post_patch = post_patch_callback,
-			.pre_unpatch = pre_unpatch_callback,
-			.post_unpatch = post_unpatch_callback,
-		},
-	}, { }
+	KLP_VMLINUX_CALLBACKS(no_funcs,
+			      pre_patch_callback,
+			      post_patch_callback,
+			      pre_unpatch_callback,
+			      post_unpatch_callback),
+	KLP_OBJECT_CALLBACKS(livepatch_callbacks_mod,
+			     no_funcs,
+			     pre_patch_callback,
+			     post_patch_callback,
+			     pre_unpatch_callback,
+			     post_unpatch_callback),
+	KLP_OBJECT_CALLBACKS(livepatch_callbacks_busymod,
+			     busymod_funcs,
+			     pre_patch_callback,
+			     post_patch_callback,
+			     pre_unpatch_callback,
+			     post_unpatch_callback),
+	KLP_OBJECT_END
 };
 
 static struct klp_patch patch = {
diff --git a/samples/livepatch/livepatch-sample.c b/samples/livepatch/livepatch-sample.c
index e470a052fb77..de30d1ba4791 100644
--- a/samples/livepatch/livepatch-sample.c
+++ b/samples/livepatch/livepatch-sample.c
@@ -49,17 +49,14 @@ static int livepatch_cmdline_proc_show(struct seq_file *m, void *v)
 }
 
 static struct klp_func funcs[] = {
-	{
-		.old_name = "cmdline_proc_show",
-		.new_addr = (unsigned long)livepatch_cmdline_proc_show,
-	}, { }
+	KLP_FUNC(cmdline_proc_show,
+		 livepatch_cmdline_proc_show),
+	KLP_FUNC_END
 };
 
 static struct klp_object objs[] = {
-	{
-		/* name being NULL means vmlinux */
-		.funcs = funcs,
-	}, { }
+	KLP_VMLINUX(funcs),
+	KLP_OBJECT_END
 };
 
 static struct klp_patch patch = {
diff --git a/samples/livepatch/livepatch-shadow-fix1.c b/samples/livepatch/livepatch-shadow-fix1.c
index ede0de7abe40..8f337b4a9108 100644
--- a/samples/livepatch/livepatch-shadow-fix1.c
+++ b/samples/livepatch/livepatch-shadow-fix1.c
@@ -128,21 +128,17 @@ void livepatch_fix1_dummy_free(struct dummy *d)
 }
 
 static struct klp_func funcs[] = {
-	{
-		.old_name = "dummy_alloc",
-		.new_addr = (unsigned long)livepatch_fix1_dummy_alloc,
-	},
-	{
-		.old_name = "dummy_free",
-		.new_addr = (unsigned long)livepatch_fix1_dummy_free,
-	}, { }
+	KLP_FUNC(dummy_alloc,
+		 livepatch_fix1_dummy_alloc),
+	KLP_FUNC(dummy_free,
+		 livepatch_fix1_dummy_free),
+	KLP_FUNC_END
 };
 
 static struct klp_object objs[] = {
-	{
-		.name = "livepatch_shadow_mod",
-		.funcs = funcs,
-	}, { }
+	KLP_OBJECT(livepatch_shadow_mod,
+		   funcs),
+	KLP_OBJECT_END
 };
 
 static struct klp_patch patch = {
diff --git a/samples/livepatch/livepatch-shadow-fix2.c b/samples/livepatch/livepatch-shadow-fix2.c
index 035ee0ef387f..e8c0c0467bc0 100644
--- a/samples/livepatch/livepatch-shadow-fix2.c
+++ b/samples/livepatch/livepatch-shadow-fix2.c
@@ -105,21 +105,17 @@ void livepatch_fix2_dummy_free(struct dummy *d)
 }
 
 static struct klp_func funcs[] = {
-	{
-		.old_name = "dummy_check",
-		.new_addr = (unsigned long)livepatch_fix2_dummy_check,
-	},
-	{
-		.old_name = "dummy_free",
-		.new_addr = (unsigned long)livepatch_fix2_dummy_free,
-	}, { }
+	KLP_FUNC(dummy_check,
+		 livepatch_fix2_dummy_check),
+	KLP_FUNC(dummy_free,
+		 livepatch_fix2_dummy_free),
+	KLP_FUNC_END
 };
 
 static struct klp_object objs[] = {
-	{
-		.name = "livepatch_shadow_mod",
-		.funcs = funcs,
-	}, { }
+	KLP_OBJECT(livepatch_shadow_mod,
+		   funcs),
+	KLP_OBJECT_END
 };
 
 static struct klp_patch patch = {
-- 
2.13.7

