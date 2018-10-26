Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D7AECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71E220834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="JE5Q8UFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71E220834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbeJ0IDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 04:03:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34530 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbeJ0IDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 04:03:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id w19-v6so2652912eds.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 16:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AGZCc/tmYS3UItgsRPysLSf7ln1lDlfq9vynCaof9qM=;
        b=JE5Q8UFFYtEWxposPwwPsljKtta8dl8GAeOwiGhD3o1MrJV9Mt1gHIRjVMskjJAiAq
         tbjr6RkeqWlVDNWL2pvochTZr0daYHOp20WwIT43YC7lfhORxVzVq08FghnjcBN3Ba/f
         H3oZHJQv3GHgfDUd23KRsx6w06qOezQwcEAzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AGZCc/tmYS3UItgsRPysLSf7ln1lDlfq9vynCaof9qM=;
        b=i+Kxtx+VQuvJKixbwI6NeAte+i9TqeNj0jwYiSmGX/TaV22x1kPDF+/Lh2jwhddAZA
         IAQ4QTOL1pFiAexK5KclLdiLN7VB9Z7Xuh9MbbipjbPtp5+bYSdDtic9KbQYKAv+/KIl
         AqPRBhBXyXvsCt+8Q37wBLIQODboCSaZEZzPbk2pUbVD5sd1E/a3SUoyIEw95tXtmMmP
         rtYqr+ngQz97zLPIbH/6OPqaikaV0/WqITGNxxS2iAXVv6TDbBlO5m1MumsBsKBBGFfw
         SppTB63FC5E4gOSjhPDmLvb0rKlPQhbNzMTcBQlblT/y88MIVAZxFCJIb8dbuscp4EdS
         1bMg==
X-Gm-Message-State: AGRZ1gLzUv6LY0s8fVZf5UIOchKB9tAZVsqAPVhHaqTeang2hvaRMUYj
        ubQzYRjivZJh7PPuR7M/I32Uk0BPefW5nA==
X-Google-Smtp-Source: AJdET5foQfF7vzTYH5LdArTM+DEFjF9IWCrnCDk1J/CgoUhkPaqvbPg5bMmvaToAmvgGGXA+k2VJAg==
X-Received: by 2002:a50:a706:: with SMTP id h6-v6mr4761544edc.290.1540596255146;
        Fri, 26 Oct 2018 16:24:15 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id o13-v6sm3986746edc.95.2018.10.26.16.24.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 16:24:14 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 2/7] lib/vsprintf.c: add fmtcheck utility
Date:   Sat, 27 Oct 2018 01:24:04 +0200
Message-Id: <20181026232409.16100-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181026232409.16100-1-linux@rasmusvillemoes.dk>
References: <20171108223020.24487-1-linux@rasmusvillemoes.dk>
 <20181026232409.16100-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a few places in the kernel where a *printf function is used with
a non-constant format string, making the ordinary static type checking
done by gcc et al. impossible. With extra instrumentation, some things
can still be caught at build time, but that still leaves a number of
places unchecked. So this patch adds a function for doing run-time
verification of a given format string against a template.

The fmtcheck() function takes two format string arguments and checks
whether they contain the same printf specifiers. If they do, the
first (the string-to-be-checked) string is returned. If not, the
second (the template) is returned - the resulting formatted string is
likely garbage, but this should still be better than using arguments of
the wrong type.

Regardless of which string is returned at run-time, the __format_arg
attribute allows the compiler to do type-checking if the fmtcheck()
function is used inside a *printf call, e.g.

  sprintf(buf, fmtcheck(what->ever, "%d %lx", 0), i, m)

This also serves as documentation for whoever creates the string found
at what->ever that it should contain these two specifiers.

We actually make fmtcheck() a macro that tries very hard to ensure the
template argument is a string literal - partly to help avoid mixing up
the two "const char*" arguments, partly because much of the point of
this sanity checking vanishes if the template is not a literal (e.g.,
the __format_arg annotation becomes useless).

We don't treat "%*.*s" and "%d %d %s" as equivalent, despite them
taking the same vararg types, since they're morally very distinct. In
fact, at least for now, we don't even treat "%d" and "%u" as
equivalent. We can relax that, possibly via FMTCHECK_* flags, but let's
first see which users there might be and what they'd want.

If either string contains a %p, we really should check the following
alphanumerics to see which (if any) extension is used and check that
they match as well. For now, just complain loudly, partly because I'm
lazy, partly because I don't know any in-tree code that might use
fmtcheck() with a %p in the template, and I can't really imagine
anyone would use a %pXX extension in a non-constant format string.

I'm making this optional, but default y, since I don't suppose
fmtcheck() will ever appear in a hot path.

The BSDs (and libbsd on linux) contain a fmtcheck() function; I took the
name and return semantics from that.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/kernel.h | 18 ++++++++++++
 lib/Kconfig.debug      |  9 ++++++
 lib/vsprintf.c         | 65 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d6aac75b51ba..8e9154e100c3 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -495,6 +495,24 @@ char *kvasprintf(gfp_t gfp, const char *fmt, va_list args);
 extern __printf(2, 0)
 const char *kvasprintf_const(gfp_t gfp, const char *fmt, va_list args);
 
+#define FMTCHECK_SILENT        0x01
+#define FMTCHECK_NO_EXTRA_ARGS 0x02
+#ifdef CONFIG_FMTCHECK
+__format_arg(2)
+const char *_fmtcheck(const char *fmt, const char *tmpl, unsigned flags);
+#else
+static inline __format_arg(2) const char *
+_fmtcheck(const char *fmt, const char *tmpl, unsigned flags)
+{
+	return fmt;
+}
+#endif
+/*
+ * Use of fmtcheck is pointless if the template is not a string
+ * literal, so try to enforce that.
+ */
+#define fmtcheck(fmt, tmpl, flags) _fmtcheck(fmt, "" tmpl "", flags)
+
 extern __scanf(2, 3)
 int sscanf(const char *, const char *, ...);
 extern __scanf(2, 0)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4966c4fbe7f7..adfd431c6876 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1037,6 +1037,15 @@ config DEBUG_PREEMPT
 	  if kernel code uses it in a preemption-unsafe way. Also, the kernel
 	  will detect preemption count underflows.
 
+config FMTCHECK
+	bool "Runtime format string checking"
+	default y
+	help
+	  If you say Y here, the kernel performs runtime sanity checks
+	  of non-constant format strings against builtin templates,
+	  issuing a warning and using the template as a fallback in
+	  case of mismatch.
+
 menu "Lock Debugging (spinlocks, mutexes, etc...)"
 
 config LOCK_DEBUGGING_SUPPORT
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d5b3a3f95c01..81b7cda71158 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -3201,3 +3201,68 @@ int sscanf(const char *buf, const char *fmt, ...)
 	return i;
 }
 EXPORT_SYMBOL(sscanf);
+
+#ifdef CONFIG_FMTCHECK
+static int
+next_interesting_spec(const char **s, struct printf_spec *spec)
+{
+	int len;
+
+	while (1) {
+		len = format_decode(*s, spec);
+		if (!len)
+			return 0;
+		*s += len;
+		if (spec->type == FORMAT_TYPE_NONE ||
+		    spec->type == FORMAT_TYPE_PERCENT_CHAR)
+			continue;
+		return len;
+	}
+}
+
+const char *
+_fmtcheck(const char *fmt, const char *tmpl, unsigned flags)
+{
+	const char *f = fmt;
+	const char *t = tmpl;
+	struct printf_spec fspec = {0}, tspec = {0};
+	int flen, tlen;
+	int warn = !(flags & FMTCHECK_SILENT);
+
+	while (1) {
+		flen = next_interesting_spec(&f, &fspec);
+		tlen = next_interesting_spec(&t, &tspec);
+		if (!flen) {
+			/*
+			 * The given format string doesn't have any
+			 * more specifiers. It's ok from a type-safety
+			 * POV for the template to have extra, but
+			 * optionally warn about it (e.g., a single %d
+			 * may be required).
+			 */
+			if (tlen && (flags & FMTCHECK_NO_EXTRA_ARGS) && warn)
+				WARN_ONCE(warn, "template '%s' expects more arguments than '%s'\n",
+					tmpl, fmt);
+			return fmt;
+		}
+		if (!tlen) {
+			WARN_ONCE(warn, "format string '%s' expects more arguments than template '%s'",
+				  fmt, tmpl);
+			return tmpl;
+		}
+		WARN_ONCE(warn && (fspec.type == FORMAT_TYPE_PTR || tspec.type == FORMAT_TYPE_PTR),
+			  "don't use %%p in non-constant format strings");
+		/*
+		 * Should we also care about flags, field width,
+		 * precision? Should we even care about base?
+		 */
+		if (fspec.type != tspec.type ||
+		    fspec.base != tspec.base) {
+			WARN_ONCE(warn, "format string '%s' incompatible with template '%s'",
+				  fmt, tmpl);
+			return tmpl;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(_fmtcheck);
+#endif
-- 
2.19.1.6.gbde171bbf5

