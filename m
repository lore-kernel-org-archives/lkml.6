Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EC6C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDA920836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDA920836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755339AbeFRT4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:56:46 -0400
Received: from s3.sipsolutions.net ([144.76.63.242]:57728 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754448AbeFRT4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:56:43 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fV0GV-0002ZI-C2; Mon, 18 Jun 2018 21:56:39 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3] bitfield: fix *_encode_bits()
Date:   Mon, 18 Jun 2018 21:56:18 +0200
Message-Id: <20180618195618.17536-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a bug in *_encode_bits() in using ~field_multiplier() for
the check whether or not the constant value fits into the field,
this is wrong and clearly ~field_mask() was intended. This was
triggering for me for both constant and non-constant values.

Additionally, make this case actually into an compile error.
Declaring the extern function that will never exist with just a
warning is pointless as then later we'll just get a link error.

While at it, also fix the indentation in those lines I'm touching.

Finally, as suggested by Andy Shevchenko, add some tests and for
that introduce also u8 helpers. The tests don't compile without
the fix, showing that it's necessary.

Fixes: 00b0c9b82663 ("Add primitives for manipulating bitfields both in host- and fixed-endian.")
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
v2: replace stray tab by space
v3: u8 helpers, tests

If you don't mind, I'd like to take this through the networking
tree(s) as a fix since I have some pending code that depends on
it.
---
 include/linux/bitfield.h |   7 +-
 lib/Kconfig.debug        |   7 ++
 lib/Makefile             |   1 +
 lib/test_bitfield.c      | 163 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 175 insertions(+), 3 deletions(-)
 create mode 100644 lib/test_bitfield.c

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index cf2588d81148..65a6981eef7b 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -104,7 +104,7 @@
 		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));	\
 	})
 
-extern void __compiletime_warning("value doesn't fit into mask")
+extern void __compiletime_error("value doesn't fit into mask")
 __field_overflow(void);
 extern void __compiletime_error("bad bitfield mask")
 __bad_mask(void);
@@ -121,8 +121,8 @@ static __always_inline u64 field_mask(u64 field)
 #define ____MAKE_OP(type,base,to,from)					\
 static __always_inline __##type type##_encode_bits(base v, base field)	\
 {									\
-        if (__builtin_constant_p(v) &&	(v & ~field_multiplier(field)))	\
-			    __field_overflow();				\
+	if (__builtin_constant_p(v) && (v & ~field_mask(field)))	\
+		__field_overflow();					\
 	return to((v & field_mask(field)) * field_multiplier(field));	\
 }									\
 static __always_inline __##type type##_replace_bits(__##type old,	\
@@ -143,6 +143,7 @@ static __always_inline base type##_get_bits(__##type v, base field)	\
 	____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu)	\
 	____MAKE_OP(be##size,u##size,cpu_to_be##size,be##size##_to_cpu)	\
 	____MAKE_OP(u##size,u##size,,)
+____MAKE_OP(u8,u8,,)
 __MAKE_OP(16)
 __MAKE_OP(32)
 __MAKE_OP(64)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index eb885942eb0f..b0870377b4d1 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1799,6 +1799,13 @@ config TEST_BITMAP
 
 	  If unsure, say N.
 
+config TEST_BITFIELD
+	tristate "Test bitfield functions at runtime"
+	help
+	  Enable this option to test the bitfield functions at boot.
+
+	  If unsure, say N.
+
 config TEST_UUID
 	tristate "Test functions located in the uuid module at runtime"
 
diff --git a/lib/Makefile b/lib/Makefile
index 84c6dcb31fbb..02ab4c1a64d1 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
 obj-$(CONFIG_TEST_PRINTF) += test_printf.o
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
+obj-$(CONFIG_TEST_BITFIELD) += test_bitfield.o
 obj-$(CONFIG_TEST_UUID) += test_uuid.o
 obj-$(CONFIG_TEST_PARMAN) += test_parman.o
 obj-$(CONFIG_TEST_KMOD) += test_kmod.o
diff --git a/lib/test_bitfield.c b/lib/test_bitfield.c
new file mode 100644
index 000000000000..3b50067611d9
--- /dev/null
+++ b/lib/test_bitfield.c
@@ -0,0 +1,163 @@
+/*
+ * Test cases for bitfield helpers.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/bitfield.h>
+
+#define CHECK_ENC_GET_U(tp, v, field, res) do {				\
+		{							\
+			u##tp _res;					\
+									\
+			_res = u##tp##_encode_bits(v, field);		\
+			if (_res != res) {				\
+				pr_warn("u" #tp "_encode_bits(" #v ", " #field ") is 0x%llx != " #res "\n",\
+					(u64)_res);			\
+				return -EINVAL;				\
+			}						\
+			if (u##tp##_get_bits(_res, field) != v)		\
+				return -EINVAL;				\
+		}							\
+	} while (0)
+
+#define CHECK_ENC_GET_LE(tp, v, field, res) do {			\
+		{							\
+			__le##tp _res;					\
+									\
+			_res = le##tp##_encode_bits(v, field);		\
+			if (_res != cpu_to_le##tp(res)) {		\
+				pr_warn("le" #tp "_encode_bits(" #v ", " #field ") is 0x%llx != 0x%llx\n",\
+					(u64)le##tp##_to_cpu(_res),	\
+					(u64)(res));			\
+				return -EINVAL;				\
+			}						\
+			if (le##tp##_get_bits(_res, field) != v)	\
+				return -EINVAL;				\
+		}							\
+	} while (0)
+
+#define CHECK_ENC_GET_BE(tp, v, field, res) do {			\
+		{							\
+			__be##tp _res;					\
+									\
+			_res = be##tp##_encode_bits(v, field);		\
+			if (_res != cpu_to_be##tp(res)) {		\
+				pr_warn("be" #tp "_encode_bits(" #v ", " #field ") is 0x%llx != 0x%llx\n",\
+					(u64)be##tp##_to_cpu(_res),	\
+					(u64)(res));			\
+				return -EINVAL;				\
+			}						\
+			if (be##tp##_get_bits(_res, field) != v)	\
+				return -EINVAL;				\
+		}							\
+	} while (0)
+
+#define CHECK_ENC_GET(tp, v, field, res) do {				\
+		CHECK_ENC_GET_U(tp, v, field, res);			\
+		CHECK_ENC_GET_LE(tp, v, field, res);			\
+		CHECK_ENC_GET_BE(tp, v, field, res);			\
+	} while (0)
+
+static int test_constants(void)
+{
+	/*
+	 * NOTE
+	 * This whole function compiles (or at least should, if everything
+	 * is going according to plan) to nothing after optimisation.
+	 */
+
+	CHECK_ENC_GET(16,  1, 0x000f, 0x0001);
+	CHECK_ENC_GET(16,  3, 0x00f0, 0x0030);
+	CHECK_ENC_GET(16,  5, 0x0f00, 0x0500);
+	CHECK_ENC_GET(16,  7, 0xf000, 0x7000);
+	CHECK_ENC_GET(16, 14, 0x000f, 0x000e);
+	CHECK_ENC_GET(16, 15, 0x00f0, 0x00f0);
+/*
+ * This should fail compilation:
+ *	CHECK_ENC_GET(16, 16, 0x0f00, 0x1000);
+ */
+
+	CHECK_ENC_GET_U(8,  1, 0x0f, 0x01);
+	CHECK_ENC_GET_U(8,  3, 0xf0, 0x30);
+	CHECK_ENC_GET_U(8, 14, 0x0f, 0x0e);
+	CHECK_ENC_GET_U(8, 15, 0xf0, 0xf0);
+
+	CHECK_ENC_GET(32,  1, 0x00000f00, 0x00000100);
+	CHECK_ENC_GET(32,  3, 0x0000f000, 0x00003000);
+	CHECK_ENC_GET(32,  5, 0x000f0000, 0x00050000);
+	CHECK_ENC_GET(32,  7, 0x00f00000, 0x00700000);
+	CHECK_ENC_GET(32, 14, 0x0f000000, 0x0e000000);
+	CHECK_ENC_GET(32, 15, 0xf0000000, 0xf0000000);
+
+	CHECK_ENC_GET(64,  1, 0x00000f0000000000ull, 0x0000010000000000ull);
+	CHECK_ENC_GET(64,  3, 0x0000f00000000000ull, 0x0000300000000000ull);
+	CHECK_ENC_GET(64,  5, 0x000f000000000000ull, 0x0005000000000000ull);
+	CHECK_ENC_GET(64,  7, 0x00f0000000000000ull, 0x0070000000000000ull);
+	CHECK_ENC_GET(64, 14, 0x0f00000000000000ull, 0x0e00000000000000ull);
+	CHECK_ENC_GET(64, 15, 0xf000000000000000ull, 0xf000000000000000ull);
+
+	return 0;
+}
+
+#define CHECK(tp, mask) do {						\
+		u64 v;							\
+									\
+		for (v = 0; v < 1 << hweight32(mask); v++)		\
+			if (tp##_encode_bits(v, mask) != v << __ffs64(mask)) \
+				return -EINVAL;				\
+	} while (0)
+
+static int test_variables(void)
+{
+	CHECK(u8, 0x0f);
+	CHECK(u8, 0xf0);
+	CHECK(u8, 0x38);
+
+	CHECK(u16, 0x0038);
+	CHECK(u16, 0x0380);
+	CHECK(u16, 0x3800);
+	CHECK(u16, 0x8000);
+
+	CHECK(u32, 0x80000000);
+	CHECK(u32, 0x7f000000);
+	CHECK(u32, 0x07e00000);
+	CHECK(u32, 0x00018000);
+
+	CHECK(u64, 0x8000000000000000ull);
+	CHECK(u64, 0x7f00000000000000ull);
+	CHECK(u64, 0x0001800000000000ull);
+	CHECK(u64, 0x0000000080000000ull);
+	CHECK(u64, 0x000000007f000000ull);
+	CHECK(u64, 0x0000000018000000ull);
+	CHECK(u64, 0x0000001f8000000ull);
+
+	return 0;
+}
+
+static int __init test_bitfields(void)
+{
+	int ret = test_constants();
+
+	if (ret) {
+		pr_warn("constant tests failed!\n");
+		return ret;
+	}
+
+	ret = test_variables();
+	if (ret) {
+		pr_warn("variable tests failed!\n");
+		return ret;
+	}
+
+	pr_info("tests passed\n");
+
+	return 0;
+}
+module_init(test_bitfields)
+
+MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
+MODULE_LICENSE("GPL");
-- 
2.14.4

