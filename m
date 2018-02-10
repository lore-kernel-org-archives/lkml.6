Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752497AbeBJVLQ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 16:11:16 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52099 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbeBJVLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 16:11:15 -0500
X-Google-Smtp-Source: AH8x2267buohl6t4jYkoxACCZ3wWp83wgJbRdESo8jUCWRMNgnHo4yu5IMqA17FtANxiN+SZPXkMVQ==
Date: Sun, 11 Feb 2018 00:11:10 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: [PATCH] kstrtox: make kstrtobool_from_user() very strict
Message-ID: <20180210211110.GA24324@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time module parameter parsing code accepted
0, 1, y, n, Y and N for boolean values. Gratituous but contained
to module code and thus tolerable.

Commit ef951599074ba4fad2d0efa0a977129b41e6d203
("lib: move strtobool() to kstrtobool()") promoted that ugly wart
to kstrtobool() and, more importantly, kstrtobool_from_user().

Later set of accepted values was expanded to "on" and "of".
Now there are 6+8=14(!) valid strings for a boolean.

This patch reduces set of accepted values to "0" and "1"
(with optional newline) in spirit with other kstrto*() functions.

I'm starting with kstrtobool_from_user() as it is explicitly designed
to be used for interacting with userspace. Currently there are 9 users
all debug code, so there is hope.

Please send before 4.16 so no real users start to depend on verbose behaviour.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 lib/kstrtox.c |   32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -368,19 +368,41 @@ int kstrtobool(const char *s, bool *res)
 EXPORT_SYMBOL(kstrtobool);
 
 /*
- * Since "base" would be a nonsense argument, this open-codes the
- * _from_user helper instead of using the helper macro below.
+ * Convert string to boolean:
+ *	  0 => false
+ *	  1 => true
+ *	0\n => false
+ *	1\n => true
+ *
+ * Return 0 on success or -E otherwise.
  */
 int kstrtobool_from_user(const char __user *s, size_t count, bool *res)
 {
-	/* Longest string needed to differentiate, newline, terminator */
-	char buf[4];
+	/* 0|1, newline, terminator */
+	char buf[3], *p;
+	bool val;
 
 	count = min(count, sizeof(buf) - 1);
 	if (copy_from_user(buf, s, count))
 		return -EFAULT;
 	buf[count] = '\0';
-	return kstrtobool(buf, res);
+
+	p = buf;
+	if (*p == '0')
+		val = false;
+	else if (*p == '1')
+		val = true;
+	else
+		return -EINVAL;
+	p++;
+
+	if (*p == '\n')
+		p++;
+	if (*p)
+		return -EINVAL;
+
+	*res = val;
+	return 0;
 }
 EXPORT_SYMBOL(kstrtobool_from_user);
 
