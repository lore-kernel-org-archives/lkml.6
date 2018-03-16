Return-Path: <kernel-hardening-return-12659-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtTJmog8ceamgduI5lplLgDCHyv+9/un9kY7gxmLQx4nVWiLmxYc5Pmm3+l6AxEDcsi0+K3
ARC-Seal: i=1; a=rsa-sha256; t=1521174400; cv=none;
        d=google.com; s=arc-20160816;
        b=phYkhetylKzGYhEN5mFH7VXYIAlXAbrCE/kXlLmT9QLAw7nhEIkCDyo4sj4Xdci+YH
         BxWcslBmFD7Lat6qmQWxbsmROvEMIeogKyO7OAezF48lUwo92rOavH85FS2G+JVop3k8
         7eyPIe/KSoEkpQNFzjuxItOQ5pcslje4mlBgOSNPTzn6AYK5JywV1z3FCAF+x5oTZjxx
         BjP+LBkPtHXJAYKmajf8OmwOk288T+2h05NVpdUIh958E+5BaGnCMGgJDJrqpTD40sJM
         yHKp9nPO/1y/47nZHdBLC6HlwsMtqdzD6d3zhKRnhLQ0+wJHxsuFDLQbke1drv7VmUT/
         u4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=eNbhngV0sTnspfoX+8GgHF02vVphrEUurDkfyZCcFFU=;
        b=g394dAeSvPIGurEdYK6adGeOwnoteJktZw7h1/VSKnYvsaXTibN1Mss0n3I4GmR2BX
         5OA5+PgvC0T/98kd+jswwCQvBy+UI2P2RXCOc4EnYlw3nIaNtlvuHR+jt8+AgMBZzMD4
         FVBoWb39T/ZGmsBzBh8j8lLIwMKlvMh4CmFSPrRh4QbMGB+8rhQGD1Xeuy5pyJJdxTMp
         iWh1h9TdT9lpJLKVRXqXR5tzVbY9qvPElYED7Lp3WpH1ATISlABvBdOE/gHrDI8H7ydl
         yvV07pO5lix/Pen2Jdh0VtmHjy9nhLOVlvEsu/pu7sQY4C7nSiyZyXV2+4rRaaJzAbPk
         1Lcw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=JQDZayrv;
       spf=pass (google.com: domain of kernel-hardening-return-12659-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12659-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=JQDZayrv;
       spf=pass (google.com: domain of kernel-hardening-return-12659-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12659-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCH v5 1/2] kernel.h: Introduce const_max_t() for VLA removal
Date: Thu, 15 Mar 2018 21:25:58 -0700
Message-Id: <1521174359-46392-2-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521174359-46392-1-git-send-email-keescook@chromium.org>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595066967873848023?=
X-GMAIL-MSGID: =?utf-8?q?1595066967873848023?=
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
a new macro, const_max_t(), for use in these cases of stack array size
declaration, where the constant expressions are retained. Since this means
losing the double-evaluation protections of the max() macro, this macro is
designed to explicitly fail if used on non-constant arguments.

Older compilers will fail with the unhelpful message:

    error: first argument to ‘__builtin_choose_expr’ not a constant

Newer compilers will fail with a hopefully more helpful message:

    error: call to ‘__error_non_const_arg’ declared with attribute error: const_max_t() used with non-constant expression

To gain the ability to compare differing types, the desired type must
be explicitly declared, as with the existing max_t() macro. This is
needed when comparing different enum types and to allow things like:

    int foo[const_max_t(size_t, 6, sizeof(something))];

[1] https://lkml.org/lkml/2018/3/7/621
[2] https://lkml.org/lkml/2018/3/10/170

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/kernel.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 3fd291503576..e14531781568 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -820,6 +820,25 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
 	      x, y)
 
 /**
+ * const_max_t - return maximum of two compile-time constant expressions
+ * @type: type used for evaluation
+ * @x: first compile-time constant expression
+ * @y: second compile-time constant expression
+ *
+ * This has no multi-evaluation defenses, and must only ever be used with
+ * compile-time constant expressions (for example when calculating a stack
+ * array size).
+ */
+size_t __error_non_const_arg(void) \
+__compiletime_error("const_max_t() used with non-constant expression");
+#define const_max_t(type, x, y)					\
+	__builtin_choose_expr(__builtin_constant_p(x) &&	\
+			      __builtin_constant_p(y),		\
+			      (type)(x) > (type)(y) ?		\
+				(type)(x) : (type)(y),		\
+			      __error_non_const_arg())
+
+/**
  * min3 - return minimum of three values
  * @x: first value
  * @y: second value
-- 
2.7.4
