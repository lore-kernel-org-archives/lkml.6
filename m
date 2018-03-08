Return-Path: <kernel-hardening-return-12228-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuhFJ9rbxLMbZLYsge5fNs8dr8uY/c4SQlGeHoq9FBR66w5dwn9aNH6MpCggCJWCLyZ1/Jv
ARC-Seal: i=1; a=rsa-sha256; t=1520479936; cv=none;
        d=google.com; s=arc-20160816;
        b=TJ7LyYFcyMUTl292yeFYn4TTSzBvMzmI1gAiFjHw1mEL5BTK0lwQz1T1NVCn7Eeqf3
         ahD0wAs9GoIw7QE9Dr/PO5hG7GcxE/J+QIp0C8Vevy338j4u1mcpIi7jhf+RGyFXCZ3s
         LuqOeKZ3pK1pKQt8yUWAaFd6nTqBSuBeJGOJeK4uUJK68bwaH4Fo/1d16ShIvnh2GpwN
         NG2+wPraGPnqW1IMQdoGaMpRFUBDD7sbHU1Q/DyBfFX0mVm2ggm8w+VJPiabqA9mYCen
         3XHJE2nihdl3OJGrcTAIhvHXAyjvR8XGDSJwLgBY461V5AqnY5oKsAxZmQRrHtAYGswJ
         vNGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=RNDM7GZdsDPxYnFcKPqvjTjxnD8widEXNa1zIpYjArk=;
        b=gSisNR04tztTLtCaJoTmJBcYuTxXibOhvH8AUkqeZF9WfiU9UU3J4GuAhnJXR6lZL2
         3s0ItFLhTOQOVbi7SYgxvAZesDV+NIpR0KT9FIYxZr5YCY8gPzbBeqLJnGAQZ/6xfWr2
         ZQWxWpvWe5GMqEVS5aRHfhiMxwtDLP4MliRRDJnJbfAe51LOFK4Xgl/P2LNaacOLGI0D
         8nJRWwYP836MCxxQV6cNkqPWvwzIPJWzTXXUwT5hBi+7Z2hVHUxR9bXpCiF1Dig+ya/P
         LI+GrXWwq5myjunuM/6TN+/OLO0qWIegQ9dJ4w/r3jyzvDNHY9SseSvCXQ5w+Uw2MXFO
         oHgg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=eCIUkMuB;
       spf=pass (google.com: domain of kernel-hardening-return-12228-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12228-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=eCIUkMuB;
       spf=pass (google.com: domain of kernel-hardening-return-12228-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12228-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	gustavo@embeddedor.com,
	rostedt@goodmis.org,
	Chris Mason <clm@fb.com>,
	Josef Bacik <jbacik@fb.com>,
	David Sterba <dsterba@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Borislav Petkov <bp@suse.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	"Tobin C. Harding" <me@tobin.cc>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	linux-btrfs@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCH v2 1/3] vsprintf: Remove accidental VLA usage
Date: Wed,  7 Mar 2018 19:30:45 -0800
Message-Id: <1520479847-39174-2-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520479847-39174-1-git-send-email-keescook@chromium.org>
References: <1520479847-39174-1-git-send-email-keescook@chromium.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594322119542311159?=
X-GMAIL-MSGID: =?utf-8?q?1594338769399316188?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In the quest to remove all stack VLAs from the kernel[1], this introduces
a new "simple max" macro, and changes the "sym" array size calculation to
use it. The value is actually a fixed size, but since the max() macro uses
some extensive tricks for safety, it ends up looking like a variable size
to the compiler.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/kernel.h | 11 +++++++++++
 lib/vsprintf.c         |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 3fd291503576..1da554e9997f 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -820,6 +820,17 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
 	      x, y)
 
 /**
+ * SIMPLE_MAX - return maximum of two values without any type checking
+ * @x: first value
+ * @y: second value
+ *
+ * This should only be used in stack array sizes, since the type-checking
+ * from max() confuses the compiler into thinking a VLA is being used.
+ */
+#define SIMPLE_MAX(x, y)	((size_t)(x) > (size_t)(y) ? (size_t)(x) \
+							   : (size_t)(y))
+
+/**
  * min3 - return minimum of three values
  * @x: first value
  * @y: second value
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d7a708f82559..50cce36e1cdc 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -744,8 +744,8 @@ char *resource_string(char *buf, char *end, struct resource *res,
 #define FLAG_BUF_SIZE		(2 * sizeof(res->flags))
 #define DECODED_BUF_SIZE	sizeof("[mem - 64bit pref window disabled]")
 #define RAW_BUF_SIZE		sizeof("[mem - flags 0x]")
-	char sym[max(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
-		     2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
+	char sym[SIMPLE_MAX(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
+			    2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
 
 	char *p = sym, *pend = sym + sizeof(sym);
 	int decode = (fmt[0] == 'R') ? 1 : 0;
-- 
2.7.4
