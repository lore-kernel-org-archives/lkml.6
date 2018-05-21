Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753559AbeEURju (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:39:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45498 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753369AbeEURhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:37:38 -0400
From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
To: viro@ZenIV.linux.org.uk
Cc: jra@google.com, tytso@mit.edu, olaf@sgi.com, darrick.wong@oracle.com,
        kernel@lists.collabora.co.uk, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, jack@suse.cz, linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Subject: [PATCH v2 15/15] nls: utf8norm: Introduce test module for utf8norm implementation
Date: Mon, 21 May 2018 14:36:17 -0300
Message-Id: <20180521173617.31625-16-krisman@collabora.co.uk>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521173617.31625-1-krisman@collabora.co.uk>
References: <20180521173617.31625-1-krisman@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since RFC v2:
  - Merge with NLS

Changes since RFC v1:
  - Include comparison tests for matching strings with different lengths.
  - Include tests for characters included in unicode 8.0.0, 9.0.0 and 10.0.0.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
---
 fs/nls/Kconfig              |   5 +
 fs/nls/Makefile             |   1 +
 fs/nls/nls_utf8n-selftest.c | 307 ++++++++++++++++++++++++++++++++++++
 3 files changed, 313 insertions(+)
 create mode 100644 fs/nls/nls_utf8n-selftest.c

diff --git a/fs/nls/Kconfig b/fs/nls/Kconfig
index 39bf0ebd0643..23a333e503a4 100644
--- a/fs/nls/Kconfig
+++ b/fs/nls/Kconfig
@@ -624,4 +624,9 @@ config NLS_UTF8_NORMALIZATION
 	help
 	  Say Y here to enable utf8 normalization support.
 
+config NLS_UTF8_NORMALIZATION_SELFTEST
+	tristate "Test UTF-8 normalization support"
+	default n
+	depends on NLS_UTF8_NORMALIZATION
+
 endif # NLS
diff --git a/fs/nls/Makefile b/fs/nls/Makefile
index 3650bb58534b..0b86f6d7a484 100644
--- a/fs/nls/Makefile
+++ b/fs/nls/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_NLS_MAC_TURKISH)   += mac-turkish.o
 
 nls_utf8n-y += nls_utf8n-norm.o nls_utf8n-core.o
 obj-$(CONFIG_NLS_UTF8_NORMALIZATION) += nls_utf8n.o
+obj-$(CONFIG_NLS_UTF8_NORMALIZATION_SELFTEST) += nls_utf8n-selftest.o
 
 $(obj)/nls_utf8n-norm.o: $(obj)/utf8data.h
 $(obj)/utf8data.h: $(srctree)/$(src)/ucd/*.txt $(objtree)/scripts/mkutf8data FORCE
diff --git a/fs/nls/nls_utf8n-selftest.c b/fs/nls/nls_utf8n-selftest.c
new file mode 100644
index 000000000000..5ee7f927f6fd
--- /dev/null
+++ b/fs/nls/nls_utf8n-selftest.c
@@ -0,0 +1,307 @@
+/*
+ * Kernel module for testing utf-8 support.
+ *
+ * Copyright 2017 Collabora Ltd.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/nls.h>
+
+#include "utf8n.h"
+
+unsigned int failed_tests;
+unsigned int total_tests;
+
+/* Tests will be based on this version. */
+#define latest_maj 10
+#define latest_min 0
+#define latest_rev 0
+
+#define _test(cond, func, line, fmt, ...) do {				\
+		total_tests++;						\
+		if (!cond) {						\
+			failed_tests++;					\
+			pr_err("test %s:%d Failed: %s%s",		\
+			       func, line, #cond, (fmt?":":"."));	\
+			if (fmt)					\
+				pr_err(fmt, ##__VA_ARGS__);		\
+		}							\
+	} while (0)
+#define test_f(cond, fmt, ...) _test(cond, __func__, __LINE__, fmt, ##__VA_ARGS__)
+#define test(cond) _test(cond, __func__, __LINE__, "")
+
+const static struct {
+	/* UTF-8 strings in this vector _must_ be NULL-terminated. */
+	unsigned char str[10];
+	unsigned char dec[10];
+} nfkdi_test_data[] = {
+	/* Trivial sequence */
+	{
+		/* "ABba" decomposes to itself */
+		.str = {0x41, 0x42, 0x62, 0x61, 0x00},
+		.dec = {0x41, 0x42, 0x62, 0x61, 0x00}
+	},
+	/* Simple equivalent sequences */
+	{
+		/* 'VULGAR FRACTION ONE QUARTER' decomposes to
+		   'NUMBER 1' + 'FRACTION SLASH' + 'NUMBER 4' */
+		.str = {0xc2, 0xbc, 0x00},
+		.dec = {0x31, 0xe2, 0x81, 0x84, 0x34, 0x00},
+	},
+	{
+		/* 'LATIN SMALL LETTER A WITH DIAERESIS' decomposes to
+		   'LETTER A' + 'COMBINING DIAERESIS' */
+		.str = {0xc3, 0xa4, 0x00},
+		.dec = {0x61, 0xcc, 0x88, 0x00},
+	},
+	{
+		/* 'LATIN SMALL LETTER LJ' decomposes to
+		   'LETTER L' + 'LETTER J' */
+		.str = {0xC7, 0x89, 0x00},
+		.dec = {0x6c, 0x6a, 0x00},
+	},
+	{
+		/* GREEK ANO TELEIA decomposes to MIDDLE DOT */
+		.str = {0xCE, 0x87, 0x00},
+		.dec = {0xC2, 0xB7, 0x00}
+	},
+	/* Canonical ordering */
+	{
+		/* A + 'COMBINING ACUTE ACCENT' + 'COMBINING OGONEK' decomposes
+		   to A + 'COMBINING OGONEK' + 'COMBINING ACUTE ACCENT' */
+		.str = {0x41, 0xcc, 0x81, 0xcc, 0xa8, 0x0},
+		.dec = {0x41, 0xcc, 0xa8, 0xcc, 0x81, 0x0},
+	},
+	{
+		/* 'LATIN SMALL LETTER A WITH DIAERESIS' + 'COMBINING OGONEK'
+		   decomposes to
+		   'LETTER A' + 'COMBINING OGONEK' + 'COMBINING DIAERESIS' */
+		.str = {0xc3, 0xa4, 0xCC, 0xA8, 0x00},
+
+		.dec = {0x61, 0xCC, 0xA8, 0xcc, 0x88, 0x00},
+	},
+
+};
+
+const static struct {
+	/* UTF-8 strings in this vector _must_ be NULL-terminated. */
+	unsigned char str[30];
+	unsigned char ncf[30];
+} nfkdicf_test_data[] = {
+	/* Trivial sequences */
+	{
+		/* "ABba" folds to lowercase */
+		.str = {0x41, 0x42, 0x62, 0x61, 0x00},
+		.ncf = {0x61, 0x62, 0x62, 0x61, 0x00},
+	},
+	{
+		/* All ASCII folds to lower-case */
+		.str = "ABCDEFGHIJKLMNOPRSTUVWXYZ0.1",
+		.ncf = "abcdefghijklmnoprstuvwxyz0.1",
+	},
+	{
+		/* LATIN SMALL LETTER SHARP S folds to
+		   LATIN SMALL LETTER S + LATIN SMALL LETTER S */
+		.str = {0xc3, 0x9f, 0x00},
+		.ncf = {0x73, 0x73, 0x00},
+	},
+	{
+		/* LATIN CAPITAL LETTER A WITH RING ABOVE folds to
+		   LATIN SMALL LETTER A + COMBINING RING ABOVE */
+		.str = {0xC3, 0x85, 0x00},
+		.ncf = {0x61, 0xcc, 0x8a, 0x00},
+	},
+	/* Introduced by UTF-8.0.0. */
+	/* Cherokee letters are interesting test-cases because they fold
+	   to upper-case.  Before 8.0.0, Cherokee lowercase were
+	   undefined, thus, the folding from LC is not stable between
+	   7.0.0 -> 8.0.0, but it is from UC. */
+	{
+		/* CHEROKEE SMALL LETTER A folds to CHEROKEE LETTER A */
+		.str = {0xea, 0xad, 0xb0, 0x00},
+		.ncf = {0xe1, 0x8e, 0xa0, 0x00},
+	},
+	{
+		/* CHEROKEE SMALL LETTER YE folds to CHEROKEE LETTER YE */
+		.str = {0xe1, 0x8f, 0xb8, 0x00},
+		.ncf = {0xe1, 0x8f, 0xb0, 0x00},
+	},
+	{
+		/* OLD HUNGARIAN CAPITAL LETTER AMB folds to
+		   OLD HUNGARIAN SMALL LETTER AMB */
+		.str = {0xf0, 0x90, 0xb2, 0x83, 0x00},
+		.ncf = {0xf0, 0x90, 0xb3, 0x83, 0x00},
+	},
+	/* Introduced by UTF-9.0.0. */
+	{
+		/* OSAGE CAPITAL LETTER CHA folds to
+		   OSAGE SMALL LETTER CHA */
+		.str = {0xf0, 0x90, 0x92, 0xb5, 0x00},
+		.ncf = {0xf0, 0x90, 0x93, 0x9d, 0x00},
+	},
+	{
+		/* LATIN CAPITAL LETTER SMALL CAPITAL I folds to
+		   LATIN LETTER SMALL CAPITAL I */
+		.str = {0xea, 0x9e, 0xae, 0x00},
+		.ncf = {0xc9, 0xaa, 0x00},
+	},
+};
+
+static void check_utf8_nfkdi(void)
+{
+	int i;
+	struct utf8cursor u8c;
+	const struct utf8data *data;
+
+	data = utf8nfkdi(UNICODE_AGE(latest_maj, latest_min, latest_rev));
+	if (!data) {
+		pr_err("%s: Unable to load Unicode %d.%d.%d. Skipping.\n",
+		       __func__, latest_maj, latest_min, latest_rev);
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(nfkdi_test_data); i++) {
+		int len = strlen(nfkdi_test_data[i].str);
+		int nlen = strlen(nfkdi_test_data[i].dec);
+		int j = 0;
+		unsigned char c;
+
+		test((utf8len(data, nfkdi_test_data[i].str) == nlen));
+		test((utf8nlen(data, nfkdi_test_data[i].str, len) == nlen));
+
+		if (utf8cursor(&u8c, data, nfkdi_test_data[i].str) < 0)
+			pr_err("can't create cursor\n");
+
+		while ((c = utf8byte(&u8c)) > 0) {
+			test_f((c == nfkdi_test_data[i].dec[j]),
+			       "Unexpected byte 0x%x should be 0x%x\n",
+			       c, nfkdi_test_data[i].dec[j]);
+			j++;
+		}
+
+		test((j == nlen));
+	}
+}
+
+static void check_utf8_nfkdicf(void)
+{
+	int i;
+	struct utf8cursor u8c;
+	const struct utf8data *data;
+
+	data = utf8nfkdicf(UNICODE_AGE(latest_maj, latest_min, latest_rev));
+	if (!data) {
+		pr_err("%s: Unable to load Unicode %d.%d.%d. Skipping.\n",
+		       __func__, latest_maj, latest_min, latest_rev);
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(nfkdicf_test_data); i++) {
+		int len = strlen(nfkdicf_test_data[i].str);
+		int nlen = strlen(nfkdicf_test_data[i].ncf);
+		int j = 0;
+		unsigned char c;
+
+		test((utf8len(data, nfkdicf_test_data[i].str) == nlen));
+		test((utf8nlen(data, nfkdicf_test_data[i].str, len) == nlen));
+
+		if (utf8cursor(&u8c, data, nfkdicf_test_data[i].str) < 0)
+			pr_err("can't create cursor\n");
+
+		while ((c = utf8byte(&u8c)) > 0) {
+			test_f((c == nfkdicf_test_data[i].ncf[j]),
+			       "Unexpected byte 0x%x should be 0x%x\n",
+			       c, nfkdicf_test_data[i].ncf[j]);
+			j++;
+		}
+
+		test((j == nlen));
+	}
+}
+
+static void check_utf8_comparisons(void)
+{
+	int i;
+	struct nls_table *table = load_nls_version("utf8n", "10.0.0");
+
+	if (IS_ERR(table)) {
+		pr_err("%s: Unable to load utf8norm %d.%d.%d. Skipping.\n",
+		       __func__, latest_maj, latest_min, latest_rev);
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(nfkdi_test_data); i++) {
+		const char *s1 = nfkdi_test_data[i].str;
+		const char *s2 = nfkdi_test_data[i].dec;
+
+		test_f(!nls_strncmp(table, s1, strlen(s1), s2, strlen(s2)),
+		       "%s %s comparison mismatch\n", s1, s2);
+	}
+	for (i = 0; i < ARRAY_SIZE(nfkdicf_test_data); i++) {
+		const char *s1 = nfkdicf_test_data[i].str;
+		const char *s2 = nfkdicf_test_data[i].ncf;
+
+		test_f(!nls_strncasecmp(table, s1, strlen(s1),
+					s2, strlen(s2)),
+		       "%s %s comparison mismatch\n", s1, s2);
+	}
+
+	unload_nls(table);
+}
+
+static void check_supported_versions(void)
+{
+	/* Unicode 7.0.0 should be supported. */
+	test(utf8version_is_supported(7, 0, 0));
+
+	/* Unicode 9.0.0 should be supported. */
+	test(utf8version_is_supported(9, 0, 0));
+
+	/* Unicode 10.0.0 (the latest version) should be supported. */
+	test(utf8version_is_supported(latest_maj, latest_min, latest_rev));
+
+	/* Next versions don't exist. */
+	test(!utf8version_is_supported(11, 0, 0));
+	test(!utf8version_is_supported(0, 0, 0));
+	test(!utf8version_is_supported(-1, -1, -1));
+}
+
+static int __init init_test_ucd(void)
+{
+	failed_tests = 0;
+	total_tests = 0;
+
+	check_supported_versions();
+	check_utf8_nfkdi();
+	check_utf8_nfkdicf();
+	check_utf8_comparisons();
+
+	if (!failed_tests)
+		pr_info("All %u tests passed\n", total_tests);
+	else
+		pr_err("%u out of %u tests failed\n", failed_tests,
+		       total_tests);
+	return 0;
+}
+
+static void __exit exit_test_ucd(void)
+{
+}
+
+module_init(init_test_ucd);
+module_exit(exit_test_ucd);
+
+MODULE_AUTHOR("Gabriel Krisman Bertazi <krisman@collabora.co.uk>");
+MODULE_LICENSE("GPL");
-- 
2.17.0
