Return-Path: <kernel-hardening-return-12777-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/Abesq417hqhfQxyCp2Y11YSRAc9dX/40gDmTtD7LjpC/M6lJBQ7Rgy6LPyglJRALGqhcJ
ARC-Seal: i=1; a=rsa-sha256; t=1522186593; cv=none;
        d=google.com; s=arc-20160816;
        b=JCJ4JOSxIW5JzMxhc+emrSk/KPX3Fwf88gqxGjHwOIHx7uC6d5m3wOX8Bixv+l0I/5
         Qx8+d6rTWdcjD1P8LY0Auo7Q84ojudPOYgPUqryXwc7mnTbzw/buDdls4UpmKEIbQVMI
         Pa6Bn/nLYovOL8TQMW3Op23GoWzlMcku0QzPn0mwXROEylcjHVp/L7P/j9RSkIiMZJRZ
         Ljv1+txseMQzmgrUJsrGWJ39WT5fIjOqr3W3t7Rjn6FB2vsrIpeWk7pr9RG6Ak+3RnvC
         HXlDqr1FcUQXC5NAKqNjXuYN7LsRmMrmUgi50lBdAzOP+99sMwj0qh72V10MEDJh9BDZ
         qSEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=aU11GN1LGHG2gbKyhtO+4MWlFf7ChucZzE4eqK/m1yE=;
        b=u4Is99wToE8RtdOKDc6HxfJxANnHBQUAKzb/58LtxZU36kHZubj01HDX/vnKJcLJa7
         5TRsLf2i/dy8iF8WC+HOPVnuzdycc4j3d+V8FdjUg7tHFB7w/RfSFsDXLdwIRsxjbIqK
         Em0BJXPZOafFKjDbAydHTucfLV2G7L8nysKc0z2ugIPnLpJAQ4KEmF5WSWE8xS886vTX
         V3GBMGclQKh7GXmcrmuyNBYK539RzZdFWv05fQ/ljG2T38HQPwqKXISU3BT1izzCzj/P
         N/oDxsb0oehgLfTn8ao6NprF2vXiirzGexZLXXwPDTFxeQjuzIeppmNmTCKyb4rpBBQC
         /MJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=kzcFeqz9;
       spf=pass (google.com: domain of kernel-hardening-return-12777-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12777-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=kzcFeqz9;
       spf=pass (google.com: domain of kernel-hardening-return-12777-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12777-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 27 Mar 2018 14:36:09 -0700
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH] task_struct: Only use anon struct under randstruct plugin
Message-ID: <20180327213609.GA2964@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596128328848013628?=
X-GMAIL-MSGID: =?utf-8?q?1596128328848013628?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The original intent for always adding the anonymous struct in task_struct
was to make sure we had compiler coverage. However, this caused
pathological padding of 40 bytes at the start of task_struct. Instead,
move the anonymous struct to being only used when struct layout
randomization is enabled.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Fixes: 29e48ce87f1e ("task_struct: Allow randomized")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/compiler-clang.h |  3 ---
 include/linux/compiler-gcc.h   | 12 +++---------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index d3f264a5b04d..ceb96ecab96e 100644
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
 
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index e2c7f4369eff..b4bf73f5e38f 100644
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
 
 
-- 
2.7.4


-- 
Kees Cook
Pixel Security
