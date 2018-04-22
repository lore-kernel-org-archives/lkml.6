Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48qppwx16UHFe0azyjZvj17iJPYCU3sa5QCzudrH422NlExzQnBVP5tGigeuMl9L8ajIJMF
ARC-Seal: i=1; a=rsa-sha256; t=1524405384; cv=none;
        d=google.com; s=arc-20160816;
        b=cS/xNsOm/bLRc5tIvIvtg1dzCb6F8MJ/RUkgOWPmRMRPNljiwyT9AEUW94qXPYkWJ5
         eKGxSHXU09JU341mcjmBFsYSCAsElajnFWLkyr0P98Z7eRUcUFbdWOJ/keWgCAHdt1Vk
         tt83RArqcJ2RBOH/UNxmsuEsXPe6a8MeDF3HhofcMirzRksoTPk8k6YTb313Z8v6uz/b
         4qu2pwUnfKcdtmNbbfu309Qun+0iKOii1xNZa5YKU6W7F25+NTZm9e8KT8GafNmriaHf
         o/CNoOuIfDG9oTmWXNEQ7fQ3PB+ogI2IIR/+4BaqSCQ5FcafV9tkMaSffiQrrBYkdQxJ
         Ju+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yEX5yzA9soLTMCC+HbBFgiejyWWr8J1IAg68Uz8sw6k=;
        b=dc6O3vfUCeI/vbZDVUxYzS70DiJZVUpESBlpCsACK1H3aG8DBC8OLy18hTsv4MFLIL
         fNkyLSzyTYM+9DBgOH9t0PJL9CPlhkVsgqj32xnp/uODGbafkRgOM039RfLQxdWeCTFj
         MsJGD5nxwJ65ogMwq10DI2Kw2ZBJGgMuixcptbPFKuoJ1DUVOhIi6agS/u4+f/eu4m70
         3VudgO0kz+FtGZXGF/vHFwoM+UfJ4W6b/+M0HFC/rasDyxHOA1MU9cVdL8wBWrhUv4vK
         A5FVFSEKpT23gVsQJlpAOc61m5bmDv6MjPRg46jO1L39hu8+VeSDTlL7Fv2dCKg38YcT
         Z8Ig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.16 012/196] task_struct: only use anon struct under randstruct plugin
Date: Sun, 22 Apr 2018 15:50:32 +0200
Message-Id: <20180422135104.805503660@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454899762743687?=
X-GMAIL-MSGID: =?utf-8?q?1598454899762743687?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 2cfe0d3009418a132b93d78642a8059a38fe5944 upstream.

The original intent for always adding the anonymous struct in
task_struct was to make sure we had compiler coverage.

However, this caused pathological padding of 40 bytes at the start of
task_struct.  Instead, move the anonymous struct to being only used when
struct layout randomization is enabled.

Link: http://lkml.kernel.org/r/20180327213609.GA2964@beast
Fixes: 29e48ce87f1e ("task_struct: Allow randomized")
Signed-off-by: Kees Cook <keescook@chromium.org>
Reported-by: Peter Zijlstra <peterz@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/compiler-clang.h |    3 ---
 include/linux/compiler-gcc.h   |   12 +++---------
 2 files changed, 3 insertions(+), 12 deletions(-)

--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -17,9 +17,6 @@
  */
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
-#define randomized_struct_fields_start	struct {
-#define randomized_struct_fields_end	};
-
 /* all clang versions usable with the kernel support KASAN ABI version 5 */
 #define KASAN_ABI_VERSION 5
 
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -242,6 +242,9 @@
 #if defined(RANDSTRUCT_PLUGIN) && !defined(__CHECKER__)
 #define __randomize_layout __attribute__((randomize_layout))
 #define __no_randomize_layout __attribute__((no_randomize_layout))
+/* This anon struct can add padding, so only enable it under randstruct. */
+#define randomized_struct_fields_start	struct {
+#define randomized_struct_fields_end	} __randomize_layout;
 #endif
 
 #endif /* GCC_VERSION >= 40500 */
@@ -256,15 +259,6 @@
  */
 #define __visible	__attribute__((externally_visible))
 
-/*
- * RANDSTRUCT_PLUGIN wants to use an anonymous struct, but it is only
- * possible since GCC 4.6. To provide as much build testing coverage
- * as possible, this is used for all GCC 4.6+ builds, and not just on
- * RANDSTRUCT_PLUGIN builds.
- */
-#define randomized_struct_fields_start	struct {
-#define randomized_struct_fields_end	} __randomize_layout;
-
 #endif /* GCC_VERSION >= 40600 */
 
 
