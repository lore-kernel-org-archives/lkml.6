Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C8AC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3796A2077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3796A2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeJNXL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:11:56 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36034 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727691AbeJNXLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:55 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLh-0004cf-Qk; Sun, 14 Oct 2018 16:30:34 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLa-0000iB-1v; Sun, 14 Oct 2018 16:30:26 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Chris Metcalf" <cmetcalf@ezchip.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.313579786@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 328/366] string: provide strscpy()
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Metcalf <cmetcalf@ezchip.com>

commit 30035e45753b708e7d47a98398500ca005e02b86 upstream.

The strscpy() API is intended to be used instead of strlcpy(),
and instead of most uses of strncpy().

- Unlike strlcpy(), it doesn't read from memory beyond (src + size).

- Unlike strlcpy() or strncpy(), the API provides an easy way to check
  for destination buffer overflow: an -E2BIG error return value.

- The provided implementation is robust in the face of the source
  buffer being asynchronously changed during the copy, unlike the
  current implementation of strlcpy().

- Unlike strncpy(), the destination buffer will be NUL-terminated
  if the string in the source buffer is too long.

- Also unlike strncpy(), the destination buffer will not be updated
  beyond the NUL termination, avoiding strncpy's behavior of zeroing
  the entire tail end of the destination buffer.  (A memset() after
  the strscpy() can be used if this behavior is desired.)

- The implementation should be reasonably performant on all
  platforms since it uses the asm/word-at-a-time.h API rather than
  simple byte copy.  Kernel-to-kernel string copy is not considered
  to be performance critical in any case.

Signed-off-by: Chris Metcalf <cmetcalf@ezchip.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/string.h |  3 ++
 lib/string.c           | 88 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -25,6 +25,9 @@ extern char * strncpy(char *,const char
 #ifndef __HAVE_ARCH_STRLCPY
 size_t strlcpy(char *, const char *, size_t);
 #endif
+#ifndef __HAVE_ARCH_STRSCPY
+ssize_t __must_check strscpy(char *, const char *, size_t);
+#endif
 #ifndef __HAVE_ARCH_STRCAT
 extern char * strcat(char *, const char *);
 #endif
--- a/lib/string.c
+++ b/lib/string.c
@@ -27,6 +27,10 @@
 #include <linux/bug.h>
 #include <linux/errno.h>
 
+#include <asm/byteorder.h>
+#include <asm/word-at-a-time.h>
+#include <asm/page.h>
+
 #ifndef __HAVE_ARCH_STRNICMP
 /**
  * strnicmp - Case insensitive, length-limited string comparison
@@ -160,6 +164,90 @@ size_t strlcpy(char *dest, const char *s
 EXPORT_SYMBOL(strlcpy);
 #endif
 
+#ifndef __HAVE_ARCH_STRSCPY
+/**
+ * strscpy - Copy a C-string into a sized buffer
+ * @dest: Where to copy the string to
+ * @src: Where to copy the string from
+ * @count: Size of destination buffer
+ *
+ * Copy the string, or as much of it as fits, into the dest buffer.
+ * The routine returns the number of characters copied (not including
+ * the trailing NUL) or -E2BIG if the destination buffer wasn't big enough.
+ * The behavior is undefined if the string buffers overlap.
+ * The destination buffer is always NUL terminated, unless it's zero-sized.
+ *
+ * Preferred to strlcpy() since the API doesn't require reading memory
+ * from the src string beyond the specified "count" bytes, and since
+ * the return value is easier to error-check than strlcpy()'s.
+ * In addition, the implementation is robust to the string changing out
+ * from underneath it, unlike the current strlcpy() implementation.
+ *
+ * Preferred to strncpy() since it always returns a valid string, and
+ * doesn't unnecessarily force the tail of the destination buffer to be
+ * zeroed.  If the zeroing is desired, it's likely cleaner to use strscpy()
+ * with an overflow test, then just memset() the tail of the dest buffer.
+ */
+ssize_t strscpy(char *dest, const char *src, size_t count)
+{
+	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
+	size_t max = count;
+	long res = 0;
+
+	if (count == 0)
+		return -E2BIG;
+
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+	/*
+	 * If src is unaligned, don't cross a page boundary,
+	 * since we don't know if the next page is mapped.
+	 */
+	if ((long)src & (sizeof(long) - 1)) {
+		size_t limit = PAGE_SIZE - ((long)src & (PAGE_SIZE - 1));
+		if (limit < max)
+			max = limit;
+	}
+#else
+	/* If src or dest is unaligned, don't do word-at-a-time. */
+	if (((long) dest | (long) src) & (sizeof(long) - 1))
+		max = 0;
+#endif
+
+	while (max >= sizeof(unsigned long)) {
+		unsigned long c, data;
+
+		c = *(unsigned long *)(src+res);
+		*(unsigned long *)(dest+res) = c;
+		if (has_zero(c, &data, &constants)) {
+			data = prep_zero_mask(c, data, &constants);
+			data = create_zero_mask(data);
+			return res + find_zero(data);
+		}
+		res += sizeof(unsigned long);
+		count -= sizeof(unsigned long);
+		max -= sizeof(unsigned long);
+	}
+
+	while (count) {
+		char c;
+
+		c = src[res];
+		dest[res] = c;
+		if (!c)
+			return res;
+		res++;
+		count--;
+	}
+
+	/* Hit buffer length without finding a NUL; force NUL-termination. */
+	if (res)
+		dest[res-1] = '\0';
+
+	return -E2BIG;
+}
+EXPORT_SYMBOL(strscpy);
+#endif
+
 #ifndef __HAVE_ARCH_STRCAT
 /**
  * strcat - Append one %NUL-terminated string to another

