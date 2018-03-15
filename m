Return-Path: <kernel-hardening-return-12639-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsfb45tb1D6a0DFS7vp5Wni6NF3xeU+yX6nUpV7OXeL8Jh3AUlcM5VZHtLt5tYwmJeYNBK2
ARC-Seal: i=1; a=rsa-sha256; t=1521143304; cv=none;
        d=google.com; s=arc-20160816;
        b=xt4W49bKg/V3Dge4sg19yEnSBEkwL2wj3XIo/6ZDpE+6cSljktdook1xNwoIf2oUHg
         +huUeBQGCdgJ6d4QrUisYu1qpnk4x84bBohB0BVOvDWT/3ozbKX7qGxGQzrQrYGX63/T
         qTUBvCb8tCEG8lxF3saHhnyOs9XRyiazE/0V02o/BUMsGcuAwfOuIqz3byXFqAzQcF+I
         JDtP5YasIHRx0mwSddu8CIQ+QJLRJ9rMN8NYvYoihMxIFe4iODMlIWsK6Kc+b0o2IX8L
         lACgRoYtNnJRZXZVnQfqKF+QYqe/DWsUBGsba5s0+i1D6CxQarOxXiErcjA2vfjFdTLQ
         OQ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=lj4zQ/k/yu01ARgkyBeTOKuSoVDiR5D4J5KvwtDC7qI=;
        b=cp4ccrwYhrfqU8bDDLKMvVeTJA6xqUUWPnPKh7NN8yseqUXocYQ+VOiK8vHQRIyZ1H
         OQw3IzPtjtdjLgn1YLgF/nV6IZSYibL31fVCUXwgd25b3oXVyIT6/wUMUStwmbsc61Sp
         +g0y+VQzbw7wTfdNmqJKBx62Qx71mLxCs09L+PFEKLqrJVxEU9WsHJDLAlbJ97NNBz8J
         lRPl/1x7yxl9NM/8WFMKacz8edKXAm2EBs040Mr12CLSauzxMlKkuprRvDkZxUyu9s54
         OwIwjo2jNc98AuoGlXpaljCDtqOnzUYxD9FEea7M3EKXL7OJg2VWS3pOVUX8BXSWczht
         Z4AA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=KKX74YJS;
       spf=pass (google.com: domain of kernel-hardening-return-12639-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12639-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=KKX74YJS;
       spf=pass (google.com: domain of kernel-hardening-return-12639-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12639-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	linux-input@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCH v4 1/2] kernel.h: Introduce const_max() for VLA removal
Date: Thu, 15 Mar 2018 12:47:45 -0700
Message-Id: <1521143266-31350-2-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521143266-31350-1-git-send-email-keescook@chromium.org>
References: <1521143266-31350-1-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034361293703830?=
X-GMAIL-MSGID: =?utf-8?q?1595034361293703830?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In the effort to remove all VLAs from the kernel[1], it is desirable to
build with -Wvla. However, this warning is overly pessimistic, in that
it is only happy with stack array sizes that are declared as constant
expressions, and not constant values. One case of this is the evaluation
of the max() macro which, due to its construction, ends up converting
constant expression arguments into a constant value result. Attempts
to adjust the behavior of max() ran afoul of version-dependent compiler
behavior[2].

To work around this and still gain -Wvla coverage, this patch introduces
a new macro, const_max(), for use in these cases of stack array size
declaration, where the constant expressions are retained. Since this means
losing the double-evaluation protections of the max() macro, this macro is
designed to explicitly fail if used on non-constant arguments.

Older compilers will fail with the unhelpful message:

    error: first argument to ‘__builtin_choose_expr’ not a constant

Newer compilers will fail with a hopefully more helpful message:

    error: call to ‘__error_not_const_arg’ declared with attribute error: const_max() used with non-compile-time constant arg

To gain the ability to compare differing types, the arguments are
explicitly cast to size_t. Without this, some compiler versions will
fail when comparing different enum types or similar constant expression
cases. With the casting, it's possible to do things like:

    int foo[const_max(6, sizeof(something))];

[1] https://lkml.org/lkml/2018/3/7/621
[2] https://lkml.org/lkml/2018/3/10/170

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/kernel.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 3fd291503576..012f588b5a25 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -820,6 +820,25 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
 	      x, y)
 
 /**
+ * const_max - return maximum of two positive compile-time constant values
+ * @x: first compile-time constant value
+ * @y: second compile-time constant value
+ *
+ * This has no type checking nor multi-evaluation defenses, and must
+ * only ever be used with positive compile-time constant values (for
+ * example when calculating a stack array size).
+ */
+size_t __error_not_const_arg(void) \
+__compiletime_error("const_max() used with non-compile-time constant arg");
+#define const_max(x, y)						\
+	__builtin_choose_expr(__builtin_constant_p(x) &&	\
+			      __builtin_constant_p(y),		\
+			      (size_t)(x) > (size_t)(y) ?	\
+					(size_t)(x) :		\
+					(size_t)(y),		\
+			      __error_not_const_arg())
+
+/**
  * min3 - return minimum of three values
  * @x: first value
  * @y: second value
-- 
2.7.4
