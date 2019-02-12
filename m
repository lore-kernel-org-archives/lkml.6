Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1507FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF92222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jUKZMflc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbfBLSGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:06:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33825 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730888AbfBLSEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:04:52 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so1676785plz.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 10:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c8Z/E+kxgD+z0/cifwI/un2AHISqXU3hmVOVyhbq5Wc=;
        b=jUKZMflc+75GZ3JYD2DqhqrO5LqlqKMrOaR34yGzfG+QqGbmLCBc2ai/tYtl6VEjbA
         U1irwlUD82/b77hC0ZRxrdEZkBx1tg4ao5SvuAYcpy7DZgMUp4Iy9Pcl8+AEgfZ01vVR
         tVn33A+O70EnPFGkO5IN5thNO9a+9KF2pYkps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c8Z/E+kxgD+z0/cifwI/un2AHISqXU3hmVOVyhbq5Wc=;
        b=PaM9Rb1qTdgD8eZDmNop96v/luJ6yS2Ihc0eoE6RLfGy+lZRRNkz1X/pfRfdEtVaFi
         +gyH+GjNy0ldT5I2WbAQ3r/eUPCvAD4fmMGZN0Vx1oc4eJHZ1AGm0As9H1zbT37He/0P
         S1iDzVjMaNNC4t3kG7rXhhJ6Tz4YuinHYmIsu0J4DAJ4lt6/3jla7XD4FzVoWGvOP8hc
         z6YdMVWcNah4CZ/77xkFOHtPxEWkexQ/i9aetXyIDeYI9C/z2IXmdJik+XRhw0hrJ2BS
         8IgtbxbZvGprGKJhUBVi9qbVu80C0ndedmUkp9xL5bdXdqElq8d7WwDsw3nBdwdM22s2
         P68g==
X-Gm-Message-State: AHQUAuYpWd4bpc/+O8UF3Sb7/mRWTKNjdZftOAhSjOsb+IO/eLEyZ1t2
        F/5s7vdtWYF7WeQDOGLmbp/DMQ==
X-Google-Smtp-Source: AHgI3IYI2XvZc28dhhsy9KZQtTc5bNfdQJZ1SllZ0uPWjMEGCtYeYK4ec6/ylIPzWJ/1S8baUjPisQ==
X-Received: by 2002:a17:902:3f81:: with SMTP id a1mr5195154pld.258.1549994691193;
        Tue, 12 Feb 2019 10:04:51 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id b29sm19364046pff.34.2019.02.12.10.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 10:04:49 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Jann Horn <jannh@google.com>,
        Alexander Potapenko <glider@google.com>,
        kernel-hardening@lists.openwall.com
Subject: [PATCH 2/2] lib: Introduce test_stackinit module
Date:   Tue, 12 Feb 2019 10:04:41 -0800
Message-Id: <20190212180441.15340-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212180441.15340-1-keescook@chromium.org>
References: <20190212180441.15340-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds test for stack initialization coverage. We have several build options
that control the level of stack variable initialization. This test lets us
visualize which options cover which cases, and provide tests for some of
the pathological padding conditions the compiler will sometimes fail to
initialize.

All options pass the explicit initialization cases and the partial
initializers (even with padding):

test_stackinit: u8_zero ok
test_stackinit: u16_zero ok
test_stackinit: u32_zero ok
test_stackinit: u64_zero ok
test_stackinit: char_array_zero ok
test_stackinit: small_hole_zero ok
test_stackinit: big_hole_zero ok
test_stackinit: trailing_hole_zero ok
test_stackinit: packed_zero ok
test_stackinit: small_hole_dynamic_partial ok
test_stackinit: big_hole_dynamic_partial ok
test_stackinit: trailing_hole_dynamic_partial ok
test_stackinit: packed_dynamic_partial ok
test_stackinit: small_hole_static_partial ok
test_stackinit: big_hole_static_partial ok
test_stackinit: trailing_hole_static_partial ok
test_stackinit: packed_static_partial ok
test_stackinit: packed_static_all ok
test_stackinit: packed_dynamic_all ok
test_stackinit: packed_runtime_all ok

The results of the other tests (which contain no explicit initialization),
change based on the build's configured compiler instrumentation.

No options:

test_stackinit: small_hole_static_all FAIL (uninit bytes: 3)
test_stackinit: big_hole_static_all FAIL (uninit bytes: 61)
test_stackinit: trailing_hole_static_all FAIL (uninit bytes: 7)
test_stackinit: small_hole_dynamic_all FAIL (uninit bytes: 3)
test_stackinit: big_hole_dynamic_all FAIL (uninit bytes: 61)
test_stackinit: trailing_hole_dynamic_all FAIL (uninit bytes: 7)
test_stackinit: small_hole_runtime_partial FAIL (uninit bytes: 23)
test_stackinit: big_hole_runtime_partial FAIL (uninit bytes: 127)
test_stackinit: trailing_hole_runtime_partial FAIL (uninit bytes: 24)
test_stackinit: packed_runtime_partial FAIL (uninit bytes: 24)
test_stackinit: small_hole_runtime_all FAIL (uninit bytes: 3)
test_stackinit: big_hole_runtime_all FAIL (uninit bytes: 61)
test_stackinit: trailing_hole_runtime_all FAIL (uninit bytes: 7)
test_stackinit: u8_none FAIL (uninit bytes: 1)
test_stackinit: u16_none FAIL (uninit bytes: 2)
test_stackinit: u32_none FAIL (uninit bytes: 4)
test_stackinit: u64_none FAIL (uninit bytes: 8)
test_stackinit: char_array_none FAIL (uninit bytes: 16)
test_stackinit: switch_1_none FAIL (uninit bytes: 8)
test_stackinit: switch_2_none FAIL (uninit bytes: 8)
test_stackinit: small_hole_none FAIL (uninit bytes: 24)
test_stackinit: big_hole_none FAIL (uninit bytes: 128)
test_stackinit: trailing_hole_none FAIL (uninit bytes: 32)
test_stackinit: packed_none FAIL (uninit bytes: 32)
test_stackinit: user FAIL (uninit bytes: 32)
test_stackinit: failures: 25

CONFIG_GCC_PLUGIN_STRUCTLEAK_USER=y
This only tries to initialize structs with __user markings, so
only the difference from above is now the "user" test passes:

test_stackinit: small_hole_static_all FAIL (uninit bytes: 3)
test_stackinit: big_hole_static_all FAIL (uninit bytes: 61)
test_stackinit: trailing_hole_static_all FAIL (uninit bytes: 7)
test_stackinit: small_hole_dynamic_all FAIL (uninit bytes: 3)
test_stackinit: big_hole_dynamic_all FAIL (uninit bytes: 61)
test_stackinit: trailing_hole_dynamic_all FAIL (uninit bytes: 7)
test_stackinit: small_hole_runtime_partial FAIL (uninit bytes: 23)
test_stackinit: big_hole_runtime_partial FAIL (uninit bytes: 127)
test_stackinit: trailing_hole_runtime_partial FAIL (uninit bytes: 24)
test_stackinit: packed_runtime_partial FAIL (uninit bytes: 24)
test_stackinit: small_hole_runtime_all FAIL (uninit bytes: 3)
test_stackinit: big_hole_runtime_all FAIL (uninit bytes: 61)
test_stackinit: trailing_hole_runtime_all FAIL (uninit bytes: 7)
test_stackinit: u8_none FAIL (uninit bytes: 1)
test_stackinit: u16_none FAIL (uninit bytes: 2)
test_stackinit: u32_none FAIL (uninit bytes: 4)
test_stackinit: u64_none FAIL (uninit bytes: 8)
test_stackinit: char_array_none FAIL (uninit bytes: 16)
test_stackinit: switch_1_none FAIL (uninit bytes: 8)
test_stackinit: switch_2_none FAIL (uninit bytes: 8)
test_stackinit: small_hole_none FAIL (uninit bytes: 24)
test_stackinit: big_hole_none FAIL (uninit bytes: 128)
test_stackinit: trailing_hole_none FAIL (uninit bytes: 32)
test_stackinit: packed_none FAIL (uninit bytes: 32)
test_stackinit: user ok
test_stackinit: failures: 24

CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF=y
This initializes all structures passed by reference (scalars and strings
remain uninitialized):

test_stackinit: small_hole_static_all ok
test_stackinit: big_hole_static_all ok
test_stackinit: trailing_hole_static_all ok
test_stackinit: small_hole_dynamic_all ok
test_stackinit: big_hole_dynamic_all ok
test_stackinit: trailing_hole_dynamic_all ok
test_stackinit: small_hole_runtime_partial ok
test_stackinit: big_hole_runtime_partial ok
test_stackinit: trailing_hole_runtime_partial ok
test_stackinit: packed_runtime_partial ok
test_stackinit: small_hole_runtime_all ok
test_stackinit: big_hole_runtime_all ok
test_stackinit: trailing_hole_runtime_all ok
test_stackinit: u8_none FAIL (uninit bytes: 1)
test_stackinit: u16_none FAIL (uninit bytes: 2)
test_stackinit: u32_none FAIL (uninit bytes: 4)
test_stackinit: u64_none FAIL (uninit bytes: 8)
test_stackinit: char_array_none FAIL (uninit bytes: 16)
test_stackinit: switch_1_none FAIL (uninit bytes: 8)
test_stackinit: switch_2_none FAIL (uninit bytes: 8)
test_stackinit: small_hole_none ok
test_stackinit: big_hole_none ok
test_stackinit: trailing_hole_none ok
test_stackinit: packed_none ok
test_stackinit: user ok
test_stackinit: failures: 7

CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL=y
This initializes all variables, so it matches above with the scalars
and arrays included:

test_stackinit: small_hole_static_all ok
test_stackinit: big_hole_static_all ok
test_stackinit: trailing_hole_static_all ok
test_stackinit: small_hole_dynamic_all ok
test_stackinit: big_hole_dynamic_all ok
test_stackinit: trailing_hole_dynamic_all ok
test_stackinit: small_hole_runtime_partial ok
test_stackinit: big_hole_runtime_partial ok
test_stackinit: trailing_hole_runtime_partial ok
test_stackinit: packed_runtime_partial ok
test_stackinit: small_hole_runtime_all ok
test_stackinit: big_hole_runtime_all ok
test_stackinit: trailing_hole_runtime_all ok
test_stackinit: u8_none ok
test_stackinit: u16_none ok
test_stackinit: u32_none ok
test_stackinit: u64_none ok
test_stackinit: char_array_none ok
test_stackinit: switch_1_none ok
test_stackinit: switch_2_none ok
test_stackinit: small_hole_none ok
test_stackinit: big_hole_none ok
test_stackinit: trailing_hole_none ok
test_stackinit: packed_none ok
test_stackinit: user ok
test_stackinit: all tests passed!

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/Kconfig.debug    |  10 ++
 lib/Makefile         |   1 +
 lib/test_stackinit.c | 378 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 389 insertions(+)
 create mode 100644 lib/test_stackinit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d4df5b24d75e..6f543a4bc704 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2001,6 +2001,16 @@ config TEST_OBJAGG
 
 	  If unsure, say N.
 
+config TEST_STACKINIT
+	tristate "Test level of stack variable initialization"
+	help
+	  Test if the kernel is zero-initializing stack variables and
+	  padding. Coverage is controlled by compiler flags,
+	  CONFIG_GCC_PLUGIN_STRUCTLEAK, CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF,
+	  or CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL.
+
+	  If unsure, say N.
+
 endif # RUNTIME_TESTING_MENU
 
 config MEMTEST
diff --git a/lib/Makefile b/lib/Makefile
index e1b59da71418..c81a66d4d00d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_TEST_KMOD) += test_kmod.o
 obj-$(CONFIG_TEST_DEBUG_VIRTUAL) += test_debug_virtual.o
 obj-$(CONFIG_TEST_MEMCAT_P) += test_memcat_p.o
 obj-$(CONFIG_TEST_OBJAGG) += test_objagg.o
+obj-$(CONFIG_TEST_STACKINIT) += test_stackinit.o
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
diff --git a/lib/test_stackinit.c b/lib/test_stackinit.c
new file mode 100644
index 000000000000..13115b6f2b88
--- /dev/null
+++ b/lib/test_stackinit.c
@@ -0,0 +1,378 @@
+// SPDX-Licenses: GPLv2
+/*
+ * Test cases for compiler-based stack variable zeroing via future
+ * compiler flags or CONFIG_GCC_PLUGIN_STRUCTLEAK*.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/string.h>
+
+/* Exfiltration buffer. */
+#define MAX_VAR_SIZE	128
+static char check_buf[MAX_VAR_SIZE];
+
+/* Character array to trigger stack protector in all functions. */
+#define VAR_BUFFER	 32
+
+/* Volatile mask to convince compiler to copy memory with 0xff. */
+static volatile u8 forced_mask = 0xff;
+
+/* Location and size tracking to validate fill and test are colocated. */
+static void *fill_start, *target_start;
+static size_t fill_size, target_size;
+
+static bool range_contains(char *haystack_start, size_t haystack_size,
+			   char *needle_start, size_t needle_size)
+{
+	if (needle_start >= haystack_start &&
+	    needle_start + needle_size <= haystack_start + haystack_size)
+		return true;
+	return false;
+}
+
+#define DO_NOTHING_TYPE_SCALAR(var_type)	var_type
+#define DO_NOTHING_TYPE_STRING(var_type)	void
+#define DO_NOTHING_TYPE_STRUCT(var_type)	void
+
+#define DO_NOTHING_RETURN_SCALAR(ptr)		*(ptr)
+#define DO_NOTHING_RETURN_STRING(ptr)		/**/
+#define DO_NOTHING_RETURN_STRUCT(ptr)		/**/
+
+#define DO_NOTHING_CALL_SCALAR(var, name)			\
+		(var) = do_nothing_ ## name(&(var))
+#define DO_NOTHING_CALL_STRING(var, name)			\
+		do_nothing_ ## name(var)
+#define DO_NOTHING_CALL_STRUCT(var, name)			\
+		do_nothing_ ## name(&(var))
+
+#define FETCH_ARG_SCALAR(var)		&var
+#define FETCH_ARG_STRING(var)		var
+#define FETCH_ARG_STRUCT(var)		&var
+
+#define FILL_SIZE_STRING		16
+
+#define INIT_CLONE_SCALAR		/**/
+#define INIT_CLONE_STRING		[FILL_SIZE_STRING]
+#define INIT_CLONE_STRUCT		/**/
+
+#define INIT_SCALAR_none		/**/
+#define INIT_SCALAR_zero		= 0
+
+#define INIT_STRING_none		[FILL_SIZE_STRING] /**/
+#define INIT_STRING_zero		[FILL_SIZE_STRING] = { }
+
+#define INIT_STRUCT_none		/**/
+#define INIT_STRUCT_zero		= { }
+#define INIT_STRUCT_static_partial	= { .two = 0, }
+#define INIT_STRUCT_static_all		= { .one = arg->one,		\
+					    .two = arg->two,		\
+					    .three = arg->three,	\
+					    .four = arg->four,		\
+					}
+#define INIT_STRUCT_dynamic_partial	= { .two = arg->two, }
+#define INIT_STRUCT_dynamic_all		= { .one = arg->one,		\
+					    .two = arg->two,		\
+					    .three = arg->three,	\
+					    .four = arg->four,		\
+					}
+#define INIT_STRUCT_runtime_partial	;				\
+					var.two = 0
+#define INIT_STRUCT_runtime_all		;				\
+					var.one = 0;			\
+					var.two = 0;			\
+					var.three = 0;			\
+					memset(&var.four, 0,		\
+					       sizeof(var.four))
+
+/*
+ * @name: unique string name for the test
+ * @var_type: type to be tested for zeroing initialization
+ * @which: is this a SCALAR, STRING, or STRUCT type?
+ * @init_level: what kind of initialization is performed
+ */
+#define DEFINE_TEST_DRIVER(name, var_type, which)		\
+/* Returns 0 on success, 1 on failure. */			\
+static noinline __init int test_ ## name (void)			\
+{								\
+	var_type zero INIT_CLONE_ ## which;			\
+	int ignored;						\
+	u8 sum = 0, i;						\
+								\
+	/* Notice when a new test is larger than expected. */	\
+	BUILD_BUG_ON(sizeof(zero) > MAX_VAR_SIZE);		\
+								\
+	/* Fill clone type with zero for per-field init. */	\
+	memset(&zero, 0x00, sizeof(zero));			\
+	/* Fill stack with 0xFF. */				\
+	ignored = leaf_ ##name((unsigned long)&ignored, 1,	\
+				FETCH_ARG_ ## which(zero));	\
+	/* Clear entire check buffer for later bit tests. */	\
+	memset(check_buf, 0x00, sizeof(check_buf));		\
+	/* Extract stack-defined variable contents. */		\
+	ignored = leaf_ ##name((unsigned long)&ignored, 0,	\
+				FETCH_ARG_ ## which(zero));	\
+								\
+	/* Validate that compiler lined up fill and target. */	\
+	if (!range_contains(fill_start, fill_size,		\
+			    target_start, target_size)) {	\
+		pr_err(#name ": stack fill missed target!?\n");	\
+		pr_err(#name ": fill %zu wide\n", fill_size);	\
+		pr_err(#name ": target offset by %d\n",	\
+			(int)((ssize_t)(uintptr_t)fill_start -	\
+			(ssize_t)(uintptr_t)target_start));	\
+		return 1;					\
+	}							\
+								\
+	/* Look for any set bits in the check region. */	\
+	for (i = 0; i < sizeof(check_buf); i++)			\
+		sum += (check_buf[i] != 0);			\
+								\
+	if (sum == 0)						\
+		pr_info(#name " ok\n");				\
+	else							\
+		pr_warn(#name " FAIL (uninit bytes: %d)\n",	\
+			sum);					\
+								\
+	return (sum != 0);					\
+}
+#define DEFINE_TEST(name, var_type, which, init_level)		\
+/* no-op to force compiler into ignoring "uninitialized" vars */\
+static noinline __init DO_NOTHING_TYPE_ ## which(var_type)	\
+do_nothing_ ## name(var_type *ptr)				\
+{								\
+	/* Will always be true, but compiler doesn't know. */	\
+	if ((unsigned long)ptr > 0x2)				\
+		return DO_NOTHING_RETURN_ ## which(ptr);	\
+	else							\
+		return DO_NOTHING_RETURN_ ## which(ptr + 1);	\
+}								\
+static noinline __init int leaf_ ## name(unsigned long sp,	\
+					 bool fill,		\
+					 var_type *arg)		\
+{								\
+	char buf[VAR_BUFFER];					\
+	var_type var INIT_ ## which ## _ ## init_level;		\
+								\
+	target_start = &var;					\
+	target_size = sizeof(var);				\
+	/*							\
+	 * Keep this buffer around to make sure we've got a	\
+	 * stack frame of SOME kind...				\
+	 */							\
+	memset(buf, (char)(sp && 0xff), sizeof(buf));		\
+	/* Fill variable with 0xFF. */				\
+	if (fill) {						\
+		fill_start = &var;				\
+		fill_size = sizeof(var);			\
+		memset(fill_start,				\
+		       (char)((sp && 0xff) | forced_mask),	\
+		       fill_size);				\
+	}							\
+								\
+	/* Silence "never initialized" warnings. */		\
+	DO_NOTHING_CALL_ ## which(var, name);			\
+								\
+	/* Exfiltrate "var". */					\
+	memcpy(check_buf, target_start, target_size);		\
+								\
+	return (int)buf[0] | (int)buf[sizeof(buf) - 1];		\
+}								\
+DEFINE_TEST_DRIVER(name, var_type, which)
+
+/* Structure with no padding. */
+struct test_packed {
+	unsigned long one;
+	unsigned long two;
+	unsigned long three;
+	unsigned long four;
+};
+
+/* Simple structure with padding likely to be covered by compiler. */
+struct test_small_hole {
+	size_t one;
+	char two;
+	/* 3 byte padding hole here. */
+	int three;
+	unsigned long four;
+};
+
+/* Try to trigger unhandled padding in a structure. */
+struct test_aligned {
+	u32 internal1;
+	u64 internal2;
+} __aligned(64);
+
+struct test_big_hole {
+	u8 one;
+	u8 two;
+	u8 three;
+	/* 61 byte padding hole here. */
+	struct test_aligned four;
+} __aligned(64);
+
+struct test_trailing_hole {
+	char *one;
+	char *two;
+	char *three;
+	char four;
+	/* "sizeof(unsigned long) - 1" byte padding hole here. */
+};
+
+/* Test if STRUCTLEAK is clearing structs with __user fields. */
+struct test_user {
+	u8 one;
+	unsigned long two;
+	char __user *three;
+	unsigned long four;
+};
+
+#define DEFINE_SCALAR_TEST(name, init)				\
+		DEFINE_TEST(name ## _ ## init, name, SCALAR, init)
+
+#define DEFINE_SCALAR_TESTS(init)				\
+		DEFINE_SCALAR_TEST(u8, init);			\
+		DEFINE_SCALAR_TEST(u16, init);			\
+		DEFINE_SCALAR_TEST(u32, init);			\
+		DEFINE_SCALAR_TEST(u64, init);			\
+		DEFINE_TEST(char_array_ ## init, unsigned char, STRING, init)
+
+#define DEFINE_STRUCT_TEST(name, init)				\
+		DEFINE_TEST(name ## _ ## init,			\
+			    struct test_ ## name, STRUCT, init)
+
+#define DEFINE_STRUCT_TESTS(init)				\
+		DEFINE_STRUCT_TEST(small_hole, init);		\
+		DEFINE_STRUCT_TEST(big_hole, init);		\
+		DEFINE_STRUCT_TEST(trailing_hole, init);	\
+		DEFINE_STRUCT_TEST(packed, init)
+
+/* These should be fully initialized all the time! */
+DEFINE_SCALAR_TESTS(zero);
+DEFINE_STRUCT_TESTS(zero);
+/* Static initialization: padding may be left uninitialized. */
+DEFINE_STRUCT_TESTS(static_partial);
+DEFINE_STRUCT_TESTS(static_all);
+/* Dynamic initialization: padding may be left uninitialized. */
+DEFINE_STRUCT_TESTS(dynamic_partial);
+DEFINE_STRUCT_TESTS(dynamic_all);
+/* Runtime initialization: padding may be left uninitialized. */
+DEFINE_STRUCT_TESTS(runtime_partial);
+DEFINE_STRUCT_TESTS(runtime_all);
+/* No initialization without compiler instrumentation. */
+DEFINE_SCALAR_TESTS(none);
+DEFINE_STRUCT_TESTS(none);
+DEFINE_TEST(user, struct test_user, STRUCT, none);
+
+/*
+ * Check two uses through a variable declaration outside either path,
+ * which was noticed as a special case in porting earlier stack init
+ * compiler logic.
+ */
+static int noinline __leaf_switch_none(int path, bool fill)
+{
+	switch (path) {
+		uint64_t var;
+
+	case 1:
+		target_start = &var;
+		target_size = sizeof(var);
+		if (fill) {
+			fill_start = &var;
+			fill_size = sizeof(var);
+
+			memset(fill_start, forced_mask | 0x55, fill_size);
+		}
+		memcpy(check_buf, target_start, target_size);
+		break;
+	case 2:
+		target_start = &var;
+		target_size = sizeof(var);
+		if (fill) {
+			fill_start = &var;
+			fill_size = sizeof(var);
+
+			memset(fill_start, forced_mask | 0xaa, fill_size);
+		}
+		memcpy(check_buf, target_start, target_size);
+		break;
+	default:
+		var = 5;
+		return var & forced_mask;
+	}
+	return 0;
+}
+
+static noinline __init int leaf_switch_1_none(unsigned long sp, bool fill,
+					      uint64_t *arg)
+{
+	return __leaf_switch_none(1, fill);
+}
+
+static noinline __init int leaf_switch_2_none(unsigned long sp, bool fill,
+					      uint64_t *arg)
+{
+	return __leaf_switch_none(2, fill);
+}
+
+DEFINE_TEST_DRIVER(switch_1_none, uint64_t, SCALAR);
+DEFINE_TEST_DRIVER(switch_2_none, uint64_t, SCALAR);
+
+static int __init test_stackinit_init(void)
+{
+	unsigned int failures = 0;
+
+#define test_scalars(init)	do {				\
+		failures += test_u8_ ## init ();		\
+		failures += test_u16_ ## init ();		\
+		failures += test_u32_ ## init ();		\
+		failures += test_u64_ ## init ();		\
+		failures += test_char_array_ ## init ();	\
+	} while (0)
+
+#define test_structs(init)	do {				\
+		failures += test_small_hole_ ## init ();	\
+		failures += test_big_hole_ ## init ();		\
+		failures += test_trailing_hole_ ## init ();	\
+		failures += test_packed_ ## init ();		\
+	} while (0)
+
+	/* These are explicitly initialized and should always pass. */
+	test_scalars(zero);
+	test_structs(zero);
+	/* Padding here appears to be accidentally always initialized? */
+	test_structs(dynamic_partial);
+	/* Padding initialization depends on compiler behaviors. */
+	test_structs(static_partial);
+	test_structs(static_all);
+	test_structs(dynamic_all);
+	test_structs(runtime_partial);
+	test_structs(runtime_all);
+
+	/* STRUCTLEAK_BYREF_ALL should cover everything from here down. */
+	test_scalars(none);
+	failures += test_switch_1_none();
+	failures += test_switch_2_none();
+
+	/* STRUCTLEAK_BYREF should cover from here down. */
+	test_structs(none);
+
+	/* STRUCTLEAK will only cover this. */
+	failures += test_user();
+
+	if (failures == 0)
+		pr_info("all tests passed!\n");
+	else
+		pr_err("failures: %u\n", failures);
+
+	return failures ? -EINVAL : 0;
+}
+module_init(test_stackinit_init);
+
+static void __exit test_stackinit_exit(void)
+{ }
+module_exit(test_stackinit_exit);
+
+MODULE_LICENSE("GPL");
-- 
2.17.1

