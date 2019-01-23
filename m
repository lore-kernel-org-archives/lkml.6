Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C47C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFDA21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cnJST061"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfAWLEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:04:46 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35506 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfAWLEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:04:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id z9so1028078pfi.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 03:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2oTiebAzQ5b6qVKjCZS4pAFofSOciry9mA2bg9E9rXs=;
        b=cnJST061ci5OXEjV2JX9Ft1UTAM+A2tN08MzJmbqli+RSpPNcMaRCmDXjsaSCE44IZ
         IKTe9gOS+UUMxQXAQg6oZD2ZuQoudeqxj0hfHiOyNlcz0Ju1KDgiD0yD06yvalFBL61k
         fAwJbo8Ok5tqOSlkxx9W0rjUrq3pcA8Q9v5jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2oTiebAzQ5b6qVKjCZS4pAFofSOciry9mA2bg9E9rXs=;
        b=V+MuNWrYfb1DoLLSsgJICuibnYZuM3RLpi8Zgn66PizFjtLwM42j1TkxmaWpo8x5tb
         YIR1bppfnlD6Q7ynD+s1PE+jSlvuAQ1r3m5sBl5p5qvW7Sp8t5If78iS/i11q/Ye8oz8
         jEs3dTf954r/6wBjvhGNZ1880Jgrh7uYXyoy6T3b5ZMvG1lKTyN1BzSESktFSxi4NbN7
         H4ItVLIINQG+JO8LU8AN0TocH1RXMQDmygdOkzo6BSnw4N169rEW1FM596KofH7CT+xQ
         583G4Tj+G6Tp4X39Lx0Ud6PtZn3B1IRhL3U3vJxQjyGs6rbBJsWyf9KUzOolqNPxm5U0
         V9qQ==
X-Gm-Message-State: AJcUukcUusFUyIczHAa1Bbn50pzpWPaaapx4BRB+lxUlidRzYXM+Zpbx
        gVTTgNhpFGHgG+a9vWxNdtzGdA==
X-Google-Smtp-Source: ALg8bN7KzuIz1gic94LNejFFA7v4wK4lCeYq6wzgHu7pVkAgD50U+IS6a7uMtYrk4PkQfwJqul8B0Q==
X-Received: by 2002:a62:e0d8:: with SMTP id d85mr1609113pfm.214.1548241453780;
        Wed, 23 Jan 2019 03:04:13 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id p64sm3050357pfi.56.2019.01.23.03.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 03:04:12 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Alexander Popov <alex.popov@linux.com>,
        xen-devel@lists.xenproject.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dev@openvswitch.org, linux-kbuild@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH 2/3] gcc-plugins: Introduce stackinit plugin
Date:   Wed, 23 Jan 2019 03:03:48 -0800
Message-Id: <20190123110349.35882-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190123110349.35882-1-keescook@chromium.org>
References: <20190123110349.35882-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This attempts to duplicate the proposed gcc option -finit-local-vars[1]
in an effort to implement the "always initialize local variables" kernel
development goal[2].

Enabling CONFIG_GCC_PLUGIN_STACKINIT should stop all "uninitialized
stack variable" flaws as long as they don't depend on being zero. :)

[1] https://gcc.gnu.org/ml/gcc-patches/2014-06/msg00615.html
[2] https://lkml.kernel.org/r/CA+55aFykZL+cSBJjBBts7ebEFfyGPdMzTmLSxKnT_29=j942dA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/Makefile.gcc-plugins           |  6 ++
 scripts/gcc-plugins/Kconfig            |  9 +++
 scripts/gcc-plugins/gcc-common.h       | 11 +++-
 scripts/gcc-plugins/stackinit_plugin.c | 79 ++++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 3 deletions(-)
 create mode 100644 scripts/gcc-plugins/stackinit_plugin.c

diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 35042d96cf5d..2483121d781c 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -12,6 +12,12 @@ export DISABLE_LATENT_ENTROPY_PLUGIN
 
 gcc-plugin-$(CONFIG_GCC_PLUGIN_SANCOV)		+= sancov_plugin.so
 
+gcc-plugin-$(CONFIG_GCC_PLUGIN_STACKINIT)	+= stackinit_plugin.so
+ifdef CONFIG_GCC_PLUGIN_STACKINIT
+    DISABLE_STACKINIT_PLUGIN += -fplugin-arg-stackinit_plugin-disable
+endif
+export DISABLE_STACKINIT_PLUGIN
+
 gcc-plugin-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)	+= structleak_plugin.so
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE)	\
 		+= -fplugin-arg-structleak_plugin-verbose
diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
index d45f7f36b859..b117fe83f1d3 100644
--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -66,6 +66,15 @@ config GCC_PLUGIN_LATENT_ENTROPY
 	   * https://grsecurity.net/
 	   * https://pax.grsecurity.net/
 
+config GCC_PLUGIN_STACKINIT
+	bool "Initialize all stack variables to zero by default"
+	depends on GCC_PLUGINS
+	depends on !GCC_PLUGIN_STRUCTLEAK
+	help
+	  This plugin zero-initializes all stack variables. This is more
+	  comprehensive than GCC_PLUGIN_STRUCTLEAK, and attempts to
+	  duplicate the proposed -finit-local-vars gcc build flag.
+
 config GCC_PLUGIN_STRUCTLEAK
 	bool "Force initialization of variables containing userspace addresses"
 	# Currently STRUCTLEAK inserts initialization out of live scope of
diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 552d5efd7cb7..f690b4deeabd 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -76,6 +76,14 @@
 #include "c-common.h"
 #endif
 
+#if BUILDING_GCC_VERSION > 4005
+#include "c-tree.h"
+#else
+/* should come from c-tree.h if only it were installed for gcc 4.5... */
+#define C_TYPE_FIELDS_READONLY(TYPE) TREE_LANG_FLAG_1(TYPE)
+extern bool global_bindings_p (void);
+#endif
+
 #if BUILDING_GCC_VERSION <= 4008
 #include "tree-flow.h"
 #else
@@ -158,9 +166,6 @@ void dump_gimple_stmt(pretty_printer *, gimple, int, int);
 #define TYPE_NAME_POINTER(node) IDENTIFIER_POINTER(TYPE_NAME(node))
 #define TYPE_NAME_LENGTH(node) IDENTIFIER_LENGTH(TYPE_NAME(node))
 
-/* should come from c-tree.h if only it were installed for gcc 4.5... */
-#define C_TYPE_FIELDS_READONLY(TYPE) TREE_LANG_FLAG_1(TYPE)
-
 static inline tree build_const_char_string(int len, const char *str)
 {
 	tree cstr, elem, index, type;
diff --git a/scripts/gcc-plugins/stackinit_plugin.c b/scripts/gcc-plugins/stackinit_plugin.c
new file mode 100644
index 000000000000..41055cd7098e
--- /dev/null
+++ b/scripts/gcc-plugins/stackinit_plugin.c
@@ -0,0 +1,79 @@
+/* SPDX-License: GPLv2 */
+/*
+ * This will zero-initialize local stack variables. (Though structure
+ * padding may remain uninitialized in certain cases.)
+ *
+ * Implements Florian Weimer's "-finit-local-vars" gcc patch as a plugin:
+ * https://gcc.gnu.org/ml/gcc-patches/2014-06/msg00615.html
+ *
+ * Plugin skeleton code thanks to PaX Team.
+ *
+ * Options:
+ * -fplugin-arg-stackinit_plugin-disable
+ */
+
+#include "gcc-common.h"
+
+__visible int plugin_is_GPL_compatible;
+
+static struct plugin_info stackinit_plugin_info = {
+	.version	= "20190122",
+	.help		= "disable\tdo not activate plugin\n",
+};
+
+static void finish_decl(void *event_data, void *data)
+{
+	tree decl = (tree)event_data;
+	tree type;
+
+	if (TREE_CODE (decl) != VAR_DECL)
+		return;
+
+	if (DECL_EXTERNAL (decl))
+		return;
+
+	if (DECL_INITIAL (decl) != NULL_TREE)
+		return;
+
+	if (global_bindings_p ())
+		return;
+
+	type = TREE_TYPE (decl);
+	if (AGGREGATE_TYPE_P (type))
+		DECL_INITIAL (decl) = build_constructor (type, NULL);
+	else
+		DECL_INITIAL (decl) = fold_convert (type, integer_zero_node);
+}
+
+__visible int plugin_init(struct plugin_name_args *plugin_info, struct plugin_gcc_version *version)
+{
+	int i;
+	const char * const plugin_name = plugin_info->base_name;
+	const int argc = plugin_info->argc;
+	const struct plugin_argument * const argv = plugin_info->argv;
+	bool enable = true;
+
+	if (!plugin_default_version_check(version, &gcc_version)) {
+		error(G_("incompatible gcc/plugin versions"));
+		return 1;
+	}
+
+	if (strncmp(lang_hooks.name, "GNU C", 5) && !strncmp(lang_hooks.name, "GNU C+", 6)) {
+		inform(UNKNOWN_LOCATION, G_("%s supports C only, not %s"), plugin_name, lang_hooks.name);
+		enable = false;
+	}
+
+	for (i = 0; i < argc; ++i) {
+		if (!strcmp(argv[i].key, "disable")) {
+			enable = false;
+			continue;
+		}
+		error(G_("unknown option '-fplugin-arg-%s-%s'"), plugin_name, argv[i].key);
+	}
+
+	register_callback(plugin_name, PLUGIN_INFO, NULL, &stackinit_plugin_info);
+	if (enable)
+		register_callback(plugin_name, PLUGIN_FINISH_DECL, finish_decl, NULL);
+
+	return 0;
+}
-- 
2.17.1

