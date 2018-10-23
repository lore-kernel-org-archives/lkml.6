Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB70FC46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FD920832
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vnG3dQSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69FD920832
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbeJXLaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:30:55 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:36287 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeJXLaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:30:55 -0400
Received: by mail-io1-f73.google.com with SMTP id u2-v6so2942954iol.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 20:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fwC39IK1QrbqdHu8gHei25YdQsZ+xum3N7/uNUvew/k=;
        b=vnG3dQSfab9YsW9WIqK69SwxOjduCCe8EgASXs0lMhlBnM36w+1n9NRbOPV63cHOMM
         LIQm4+Kxwssub1TzPq65acLXFMH+q9xtGztMMRJJQoYXKKkBPTkXlvOPKY1NS0EZVWq/
         nTxTIqwG4j5EHxMLTsSwC1SD+v8W+XLjZnAMQMMRm0yrfkN0tJNM/AO6sBGR1VqZ5isl
         OLqJqQ+ER8lMC7I9hTw1zFwd07lY/lYq57j7kDVez/j6w3yatKt+HQOQloRYfELoClXQ
         5g1qhstCHH+/Gyo4qdphBHuh+BorS0wMHF51juetAts2muF5IBXnCueIkvavmw9LuMNc
         140A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fwC39IK1QrbqdHu8gHei25YdQsZ+xum3N7/uNUvew/k=;
        b=UMJIj/DwezAG055a7dTdUDa7ZGPhZWjHXupSSTqP8j4cfbE7bc1x10LTmYMz2bZmDK
         k4EK3TCtx6ryVmispulRDeSitgS3ay+Uj/5STVCi2qGBNHGUc/xW8Ezhzll6eS/NWeJP
         odiiQDdePa+JjS2cUD05G0qOsmNoxfG5FuhVEWZC3yPZ3rdz2XiJ2tIJeWPaUgftoLfS
         cWSzc+TzIqowT4P91DjICxXmzaJltYnr5yxQdABgOJ7uTndUoqaxzzuDsuXBoTRNT+2b
         ihYqkHUawtpEbBc1sCLnL8TOTrYkBslz9OUStCKYHa+FKWDsOh0esvVCcPSNRSM9QT4X
         H1rQ==
X-Gm-Message-State: AGRZ1gJpB62vgPE5mJoJZgJREzhQE/C6Yk138NUfmMQC+D86emsxD1Bj
        KKMGUeUwsoS8P6yPI7gGL+GoLQdScwZhjppsuQvcew==
X-Google-Smtp-Source: AJdET5dA0ZRzHfa0OCAtKZdAOEYiEFWcFtBedumKB0nSnNLSOxPNEy+SuZF+yP9H67vuhhU3ASKhZ1seom68yjva08/xcw==
X-Received: by 2002:a24:8903:: with SMTP id s3-v6mr263747itd.26.1540339187758;
 Tue, 23 Oct 2018 16:59:47 -0700 (PDT)
Date:   Tue, 23 Oct 2018 16:57:40 -0700
In-Reply-To: <20181023235750.103146-1-brendanhiggins@google.com>
Message-Id: <20181023235750.103146-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181023235750.103146-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [RFC v2 04/14] kunit: test: add test_stream a std::stream like logger
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of the expectation and assertion infrastructure prints out fairly
complicated test failure messages, so add a C++ style log library for
for logging test results.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/test-stream.h |  49 ++++++++++++
 include/kunit/test.h        |   2 +
 kunit/Makefile              |   2 +-
 kunit/test-stream.c         | 153 ++++++++++++++++++++++++++++++++++++
 kunit/test.c                |   8 ++
 5 files changed, 213 insertions(+), 1 deletion(-)
 create mode 100644 include/kunit/test-stream.h
 create mode 100644 kunit/test-stream.c

diff --git a/include/kunit/test-stream.h b/include/kunit/test-stream.h
new file mode 100644
index 0000000000000..c5dfd95ef21bb
--- /dev/null
+++ b/include/kunit/test-stream.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * C++ stream style string formatter and printer used in KUnit for outputting
+ * KUnit messages.
+ *
+ * Copyright (C) 2018, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_TEST_STREAM_H
+#define _KUNIT_TEST_STREAM_H
+
+#include <linux/types.h>
+#include <kunit/string-stream.h>
+
+struct test;
+
+/**
+ * struct test_stream - a std::stream style string builder.
+ * @set_level: sets the level that this string should be printed at.
+ * @add: adds the formatted input to the internal buffer.
+ * @commit: prints out the internal buffer to the user.
+ * @clear: clears the internal buffer.
+ *
+ * A std::stream style string builder. Allows messages to be built up and
+ * printed all at once.
+ */
+struct test_stream {
+	void (*set_level)(struct test_stream *this, const char *level);
+	void (*add)(struct test_stream *this, const char *fmt, ...);
+	void (*append)(struct test_stream *this, struct test_stream *other);
+	void (*commit)(struct test_stream *this);
+	void (*clear)(struct test_stream *this);
+	/* private: internal use only. */
+	struct test *test;
+	spinlock_t lock; /* Guards level. */
+	const char *level;
+	struct string_stream *internal_stream;
+};
+
+/**
+ * test_new_stream() - constructs a new &struct test_stream.
+ * @test: The test context object.
+ *
+ * Constructs a new test managed &struct test_stream.
+ */
+struct test_stream *test_new_stream(struct test *test);
+
+#endif /* _KUNIT_TEST_STREAM_H */
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 1c116a20063da..68320fa2452de 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -11,6 +11,7 @@
 
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <kunit/test-stream.h>
 
 struct test_resource;
 
@@ -171,6 +172,7 @@ struct test {
 	void (*vprintk)(const struct test *test,
 			const char *level,
 			struct va_format *vaf);
+	void (*fail)(struct test *test, struct test_stream *stream);
 };
 
 int test_init_test(struct test *test, const char *name);
diff --git a/kunit/Makefile b/kunit/Makefile
index 7fc613a9b383b..5b4562ea7f322 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_KUNIT)		+= test.o string-stream.o
+obj-$(CONFIG_KUNIT)		+= test.o string-stream.o test-stream.o
diff --git a/kunit/test-stream.c b/kunit/test-stream.c
new file mode 100644
index 0000000000000..392966864a708
--- /dev/null
+++ b/kunit/test-stream.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * C++ stream style string formatter and printer used in KUnit for outputting
+ * KUnit messages.
+ *
+ * Copyright (C) 2018, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/test.h>
+#include <kunit/test-stream.h>
+#include <kunit/string-stream.h>
+
+static const char *test_stream_get_level(struct test_stream *this)
+{
+	unsigned long flags;
+	const char *level;
+
+	spin_lock_irqsave(&this->lock, flags);
+	level = this->level;
+	spin_unlock_irqrestore(&this->lock, flags);
+
+	return level;
+}
+
+static void test_stream_set_level(struct test_stream *this, const char *level)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&this->lock, flags);
+	this->level = level;
+	spin_unlock_irqrestore(&this->lock, flags);
+}
+
+static void test_stream_add(struct test_stream *this, const char *fmt, ...)
+{
+	va_list args;
+	struct string_stream *stream = this->internal_stream;
+
+	va_start(args, fmt);
+	if (stream->vadd(stream, fmt, args) < 0)
+		test_err(this->test, "Failed to allocate fragment: %s", fmt);
+
+	va_end(args);
+}
+
+static void test_stream_append(struct test_stream *this,
+			       struct test_stream *other)
+{
+	struct string_stream *other_stream = other->internal_stream;
+	const char *other_content;
+
+	other_content = other_stream->get_string(other_stream);
+
+	if (!other_content) {
+		test_err(this->test,
+			 "Failed to get string from second argument for appending.");
+		return;
+	}
+
+	this->add(this, other_content);
+}
+
+static void test_stream_clear(struct test_stream *this)
+{
+	this->internal_stream->clear(this->internal_stream);
+}
+
+static void test_stream_commit(struct test_stream *this)
+{
+	struct string_stream *stream = this->internal_stream;
+	struct string_stream_fragment *fragment;
+	const char *level;
+	char *buf;
+
+	level = test_stream_get_level(this);
+	if (!level) {
+		test_err(this->test,
+			 "Stream was committed without a specified log level.");
+		level = KERN_ERR;
+		this->set_level(this, level);
+	}
+
+	buf = stream->get_string(stream);
+	if (!buf) {
+		test_err(this->test,
+			 "Could not allocate buffer, dumping stream:");
+		list_for_each_entry(fragment, &stream->fragments, node) {
+			test_err(this->test, fragment->fragment);
+		}
+		goto cleanup;
+	}
+
+	test_printk(level, this->test, buf);
+	kfree(buf);
+
+cleanup:
+	this->clear(this);
+}
+
+static int test_stream_init(struct test_resource *res, void *context)
+{
+	struct test *test = context;
+	struct test_stream *stream;
+
+	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
+	if (!stream)
+		return -ENOMEM;
+	res->allocation = stream;
+	stream->test = test;
+	spin_lock_init(&stream->lock);
+	stream->internal_stream = new_string_stream();
+
+	if (!stream->internal_stream)
+		return -ENOMEM;
+
+	stream->set_level = test_stream_set_level;
+	stream->add = test_stream_add;
+	stream->append = test_stream_append;
+	stream->commit = test_stream_commit;
+	stream->clear = test_stream_clear;
+
+	return 0;
+}
+
+static void test_stream_free(struct test_resource *res)
+{
+	struct test_stream *stream = res->allocation;
+
+	if (!stream->internal_stream->is_empty(stream->internal_stream)) {
+		test_err(stream->test,
+			 "End of test case reached with uncommitted stream entries.");
+		stream->commit(stream);
+	}
+
+	destroy_string_stream(stream->internal_stream);
+	kfree(stream);
+}
+
+struct test_stream *test_new_stream(struct test *test)
+{
+	struct test_resource *res;
+
+	res = test_alloc_resource(test,
+				  test_stream_init,
+				  test_stream_free,
+				  test);
+
+	if (res)
+		return res->allocation;
+	else
+		return NULL;
+}
diff --git a/kunit/test.c b/kunit/test.c
index fd0a51245215e..f798183533c8d 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -63,12 +63,20 @@ static void test_vprintk(const struct test *test,
 			 "kunit %s: %pV", test->name, vaf);
 }
 
+static void test_fail(struct test *test, struct test_stream *stream)
+{
+	test_set_success(test, false);
+	stream->set_level(stream, KERN_ERR);
+	stream->commit(stream);
+}
+
 int test_init_test(struct test *test, const char *name)
 {
 	spin_lock_init(&test->lock);
 	INIT_LIST_HEAD(&test->resources);
 	test->name = name;
 	test->vprintk = test_vprintk;
+	test->fail = test_fail;
 
 	return 0;
 }
-- 
2.19.1.568.g152ad8e336-goog

