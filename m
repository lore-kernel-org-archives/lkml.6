Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FEFC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66641214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ghnaE7yD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66641214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbeHVOYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:24:42 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40472 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbeHVOYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:24:42 -0400
Received: by mail-lf1-f66.google.com with SMTP id y200-v6so1071181lfd.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 04:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=c4rBigiN+9LYl1QapVRbBlea3wXs8W+EEtTfW6rmMiM=;
        b=ghnaE7yD3MwwzPrZLVReVX71ia4eKJTU9XkvjrXPSgjdCYRbamN5xdfTRcJD+Lujlv
         KDqDvApBaMNHpSp8/coRdwdYssYE2mo05grYC6wM+Kufkh0DDZF524BzjuBqjre3bT6t
         5xzLrjEiGUQgbFTh4cKgyFydBTPysTILXQpCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c4rBigiN+9LYl1QapVRbBlea3wXs8W+EEtTfW6rmMiM=;
        b=FGhHzmojNCTHQmIZpyOrm3I1LpB/z597pu0rt/uVa2wJ8fGiAzxceMMyp5RDQHmsq/
         9sAaWT07rZKjR/2pO5ub1M16MG8ZrJPQWfk0p4WgqOz4l9FJS/T6vr+C8WL9s+jZtzgT
         Ov3LHCv9rdv0sRp4C7/pjP6IwIdrxjwK2eL+3nqm+x+LsFQuc6gHRFJDekCcOZ58V0Ni
         ViimBTq01wot7OC7wOrMfF5cCMPYQruLVJliw17YwRNVKgxeQLGYLFDSlCUYEgv99fny
         Su7G2R6MpWJooY9mcp+1czLiEycznFWJ0GKunmjj4RbSIHh9S/q3aVUudPbhELuRU/lH
         8k3Q==
X-Gm-Message-State: AOUpUlEWZeHcC34amfirbONJdGdngdcNWq32pZNsdCB2RvgIRYLB/cZS
        tU+5A19MZ15+Dd5fosYkHaiKPA==
X-Google-Smtp-Source: AA+uWPzNgmL08xWjX1S/sToSOvP2gagMEG/w+TwsafESj3Hjc1gK7zQwakx5Ye7eLCKN2HAiIT93qQ==
X-Received: by 2002:a19:9cca:: with SMTP id f193-v6mr36011594lfe.60.1534935614753;
        Wed, 22 Aug 2018 04:00:14 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y5-v6sm234273ljj.75.2018.08.22.04.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Aug 2018 04:00:14 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-nfs@vger.kernel.org
Subject: [PATCH 1/4] string: try to find const-laundering bugs
Date:   Wed, 22 Aug 2018 13:00:06 +0200
Message-Id: <20180822110009.17583-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This wraps strchr and friends in macros that ensure the return value has
type const char* if the passed-in string (which the return value points
into) also has type const char*. The (s)+0 thing is to force a const
char[] (e.g. a string literal) to decay to a const char* for the
__same_type comparison.

Not sure it's worth the churn necessary to eliminate the resulting
warnings, but maybe it'll find some actual bugs. It certainly spews
out lots of warnings all over the tree, but instead of trying to fix
them up before actually getting this patch in, I've made the use of
these macros opt-in so anybody can do a build with
KCFLAGS=-D__CONST_LAUNDER (or add a 'ccflags-y += ...' to some
sub-Makefile) and take a look at their subsystem of interest.

Note that the use of the identifier strchr in the macro strchr is not a
problem; the preprocessor rules say that the expanded strchr should be
left alone. But we do have to prevent macro expansion when actually
defining the strchr function, hence the lib/string.c part of this. For
the same reason, I'm not defining strchr when __HAVE_ARCH_STRCHR, since
then I'd have to go into all those arches and protect their definitions
similarly.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Patches 2,3,4 can be applied independently of each other and this one,
and just serve as examples of the kind of churn enabling these
unconditionally would give.

While playing with this, I haven't found any obvious bugs, but one
example where it's not immediately obvious whether there is a problem
is

	comma = strchr(dev_name, ',');
	if (comma != NULL && comma < end)
		*comma = 0;

in fs/nfs/super.c. dev_name is const char*, but it is modified through
comma. I haven't been able to track back through all the VFS callbacks
whether that's perfectly fine. At least a comment would be nice.

 include/linux/string.h | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/string.c           | 12 ++++++------
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 4a5a0eb7df51..06d260cdc4b7 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -449,4 +449,51 @@ static inline void memcpy_and_pad(void *dest, size_t dest_len,
 		memcpy(dest, src, dest_len);
 }
 
+#ifdef __CONST_LAUNDER
+
+#ifndef __HAVE_ARCH_STRCHR
+#define strchr(s, c) (						  \
+	__builtin_choose_expr(__same_type((s) + 0, const char *), \
+			      (const char *)strchr(s, c),	  \
+			      strchr(s, c)))
+#endif
+
+#ifndef __HAVE_ARCH_STRCHRNUL
+#define strchrnul(s, c) (					  \
+	__builtin_choose_expr(__same_type((s) + 0, const char *), \
+			      (const char *)strchrnul(s, c),	  \
+			      strchrnul(s, c)))
+#endif
+
+#ifndef __HAVE_ARCH_STRNCHR
+#define strnchr(s, n, c) (					  \
+	__builtin_choose_expr(__same_type((s) + 0, const char *), \
+			      (const char *)strnchr(s, n, c),	  \
+			      strnchr(s, n, c)))
+#endif
+
+#ifndef __HAVE_ARCH_STRRCHR
+#define strrchr(s, c) (						  \
+	__builtin_choose_expr(__same_type((s) + 0, const char *), \
+			      (const char *)strrchr(s, c),	  \
+			      strrchr(s, c)))
+#endif
+
+#ifndef __HAVE_ARCH_STRSTR
+#define strstr(s, t) (						  \
+	__builtin_choose_expr(__same_type((s) + 0, const char *), \
+			      (const char *)strstr(s, t),	  \
+			      strstr(s, t)))
+#endif
+
+#ifndef __HAVE_ARCH_STRNSTR
+#define strnstr(s, t, n) (					  \
+	__builtin_choose_expr(__same_type((s) + 0, const char *), \
+			      (const char *)strnstr(s, t, n),	  \
+			      strnstr(s, t, n)))
+#endif
+
+#endif /* __CONST_LAUNDER */
+
+
 #endif /* _LINUX_STRING_H_ */
diff --git a/lib/string.c b/lib/string.c
index 2c0900a5d51a..89871c6d57cf 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -367,7 +367,7 @@ EXPORT_SYMBOL(strncmp);
  * @s: The string to be searched
  * @c: The character to search for
  */
-char *strchr(const char *s, int c)
+char *(strchr)(const char *s, int c)
 {
 	for (; *s != (char)c; ++s)
 		if (*s == '\0')
@@ -386,7 +386,7 @@ EXPORT_SYMBOL(strchr);
  * Returns pointer to first occurrence of 'c' in s. If c is not found, then
  * return a pointer to the null byte at the end of s.
  */
-char *strchrnul(const char *s, int c)
+char *(strchrnul)(const char *s, int c)
 {
 	while (*s && *s != (char)c)
 		s++;
@@ -401,7 +401,7 @@ EXPORT_SYMBOL(strchrnul);
  * @s: The string to be searched
  * @c: The character to search for
  */
-char *strrchr(const char *s, int c)
+char *(strrchr)(const char *s, int c)
 {
 	const char *last = NULL;
 	do {
@@ -420,7 +420,7 @@ EXPORT_SYMBOL(strrchr);
  * @count: The number of characters to be searched
  * @c: The character to search for
  */
-char *strnchr(const char *s, size_t count, int c)
+char *(strnchr)(const char *s, size_t count, int c)
 {
 	for (; count-- && *s != '\0'; ++s)
 		if (*s == (char)c)
@@ -896,7 +896,7 @@ EXPORT_SYMBOL(memscan);
  * @s1: The string to be searched
  * @s2: The string to search for
  */
-char *strstr(const char *s1, const char *s2)
+char *(strstr)(const char *s1, const char *s2)
 {
 	size_t l1, l2;
 
@@ -922,7 +922,7 @@ EXPORT_SYMBOL(strstr);
  * @s2: The string to search for
  * @len: the maximum number of characters to search
  */
-char *strnstr(const char *s1, const char *s2, size_t len)
+char *(strnstr)(const char *s1, const char *s2, size_t len)
 {
 	size_t l2;
 
-- 
2.16.4

