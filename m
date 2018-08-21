Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91725C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40037208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hp8LT5RI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40037208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeHUJn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:43:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37234 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbeHUJn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:43:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id h69-v6so44090pfd.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 23:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L0ERylun72Tqm2zZlFo9PYhuCGovtEAs12uinNgUg6M=;
        b=Hp8LT5RIMmnqlt1dyVIWjHI5TCHnP8i5ORPgKrp20DfU1nzckV/0kelgHu24JW7GcG
         aOy8147A00/kZGkOfELd9PRUyGF8JpYW83Fy5beSUBWkNLByqjmFWVBl6kyNS9Afu+u9
         cSIU/AKjxxlJaHtFZTKWTBKumgVVHERWGn50uNyGmhhuJt68qV9Qs8YgBKEocLO/gsac
         ZHIVSWWRwhp9BW/OR2rhe56KV1uVGOf3gIElpul69ovhN6hysHavNHnaQuLXo6aCX/hz
         3oTVenIOWvSdv74C4vmZGHCMp3PtoUGPpBSr+zRHt0AqGHkINTjSYR4R3gcSfNg2Yh5+
         id4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L0ERylun72Tqm2zZlFo9PYhuCGovtEAs12uinNgUg6M=;
        b=YMKuuE1sB69vxqelY0YwHQiOwSYhi5F4Bcl4tGE3JjOIXZiKJWO6esLBwxgB6WTlGV
         x0bteYldRBgJCrhbIcXGPdRFk3rBdOzPP5gtuv4fGRLkhXPPCp8f1McyzZvQFGvXDtrW
         jAawBYgZUFWNFKPhV18pB9nMWtr92Y8GL48uDtb13bXOHVXE/X2jNXvJB6WAyWdWJa3E
         5o3gjiwVNNumRcdO6IGBpELnB8vq36vWl91wxrOG6EMkLe/Lh+xO2N9lJMhOSPJnSGql
         xzWBBoHgGrX5SCZV90jA6guHnVk3kNBGmLFjVxuaqtOVRdg0+m24MJpy0PHO0OcO5Wgu
         kwfw==
X-Gm-Message-State: AOUpUlH7Yn9qVyhyD/JYAMQLI7Rn8KGrE4fprLUD2emyO0GORQLuGM+5
        lF5ANCXeUWNmnlpPGlI5faKoci6q
X-Google-Smtp-Source: AA+uWPwud7FoTtp5epzzD1F8zdLAkpPKsdl41wNPhGqBXgvxBKd7ZvJTP2eyQ4DF8mxDs9PWk9Dd7w==
X-Received: by 2002:a62:f0d:: with SMTP id x13-v6mr51160402pfi.123.1534832711576;
        Mon, 20 Aug 2018 23:25:11 -0700 (PDT)
Received: from localhost.localdomain ([39.7.47.210])
        by smtp.gmail.com with ESMTPSA id o3-v6sm14637835pgv.53.2018.08.20.23.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 23:25:10 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Martin Wilck <mwilck@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [RFC][PATCH] lib/string: introduce sysfs_strncpy() and sysfs_strlcpy()
Date:   Tue, 21 Aug 2018 15:24:59 +0900
Message-Id: <20180821062459.1807-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sysfs ->store() callbacks we usually need to remember that a
supplied sysfs input string might or might not contain whitespaces
and a trailing new-line symbol, which we need to take care of.
Examples:
	echo "newline" > /sys/.../attr
	echo -n "no_newine" > /sys/.../attr

That's why a typical sysfs ->store() should do something like
below when it copies a string:

	ssize_t FOO_store(struct device *dev, ....)
	{
		....
		strlcpy(value, buf, MAX_SZ);
		sz = strlen(value);
		if (sz > 0 && value[sz - 1] == '\n')
			value[sz - 1] = 0x00;
		...
	}

or use a sysfs-string friendly strcmp() function when comparing
a given string to a pre-defined one:

	ssize_t FOO_store(struct device *dev, ....)
	{
		...
		if (sysfs_streq(buf, "normal"))
			mode = m_normal;
		...
	}

Per Andrew Morton:
: There's a LOT of code which does basically-the-same-thing with sysfs
: input. And a lot of it misses things, such as leading whitespace.
: Passing all this through helpers would provide consistency as well
: as code-size reductions, improved reviewability, etc.

This patch introduces two such helpers - sysfs_strncpy() and
sysfs_strlcpy(), which, basically, do what strncpy() and strlcpy() do,
but additionally they remove leading and trailing white-spaces and
tailing new-line symbols. So a FOO_store() example which was posted
above may be rewritten to:

	ssize_t FOO_store(struct device *dev, ....)
	{
		....
		sysfs_strlcpy(value, buf, MAX_SZ);
		...
	}

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/string.h |  3 +++
 lib/string.c           | 51 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 4a5a0eb7df51..62b08bbc3ada 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -175,6 +175,9 @@ extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
 extern void argv_free(char **argv);
 
 extern bool sysfs_streq(const char *s1, const char *s2);
+extern char *sysfs_strncpy(char *dest, const char *src, size_t count);
+extern size_t sysfs_strlcpy(char *dest, const char *src, size_t size);
+
 extern int kstrtobool(const char *s, bool *res);
 static inline int strtobool(const char *s, bool *res)
 {
diff --git a/lib/string.c b/lib/string.c
index 2c0900a5d51a..e81b1be00796 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -631,6 +631,57 @@ bool sysfs_streq(const char *s1, const char *s2)
 }
 EXPORT_SYMBOL(sysfs_streq);
 
+/**
+ * sysfs_strncpy - Trim a length-limited C-string (wgutesoaces and a trailing
+ *                 newline symbol) and copy into a buffer
+ * @dest: Where to copy the string to
+ * @src: Where to copy the string from
+ * @count: The maximum number of bytes to copy
+ *
+ * A wrapper around strncpy().
+ *
+ */
+char *sysfs_strncpy(char *dest, const char *src, size_t count)
+{
+	char *c;
+
+	strncpy(dest, skip_spaces(src), count);
+
+	c = dest + count - 1;
+	while (c >= dest && (isspace(*c) || *c == '\n' || *c == '\0')) {
+		*c = '\0';
+		c--;
+	}
+	return dest;
+}
+EXPORT_SYMBOL(sysfs_strncpy);
+
+/**
+ * sysfs_strlcpy - Trim a C-string (whitespaces and a trailing newline symbol)
+ *                 and copy it into a sized buffer
+ * @dest: Where to copy the string to
+ * @src: Where to copy the string from
+ * @size: size of destination buffer
+ *
+ * A wrapper around strlcpy().
+ *
+ */
+size_t sysfs_strlcpy(char *dest, const char *src, size_t size)
+{
+	size_t ret;
+	char *c;
+
+	ret = strlcpy(dest, skip_spaces(src), size);
+
+	size = strlen(dest);
+	c = dest + size - 1;
+	while (c >= dest && (isspace(*c) || *c == '\n'))
+		c--;
+	*(c + 1) = '\0';
+	return ret;
+}
+EXPORT_SYMBOL(sysfs_strlcpy);
+
 /**
  * match_string - matches given string in an array
  * @array:	array of strings
-- 
2.18.0

