Return-Path: <kernel-hardening-return-12265-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtyPA0ED9QYQQ30Sd+R++hPeiTaVWdjWcRdt9qdrj9UqmfWEgsZjLEqK42HG7Pv27TwYRaY
ARC-Seal: i=1; a=rsa-sha256; t=1520545266; cv=none;
        d=google.com; s=arc-20160816;
        b=ARklEcY9Kcfs5Sn9xgU30x3BIaNqMK3QadETgZBOdzs1lqlxiqP0tlPjYn1RjTbaUl
         AjrrLjRrd9XuWAW3vn9yHol8zsu6PDuk9lhxIiaqAQ76NErTUBu8hS6xG7XKGzSRsluR
         FJMSO6og7kMqGS5RsP0oOV5kDK0w8z+xWevC05yJK0FRh8dDZFccPZ/lfK72fNUSdKFP
         8krQpKVfeOSLW6mwmezOkJmw+q8jxQrwvE1JY3/AU0rJddn5VJIyfRP3YPreRh0FFvVO
         cK8so8R+TyE42eO8ERa2Xuz5mUrS3ctc4hljwGu/Eg8gRdrh/3JFAzYe4Lgcff2vOsdG
         AaLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=mXKp1jldFF0wj1CgXLNWuiL66o4SlunJLezhwmIPwLk=;
        b=wccGYy0MA8KEuImHGehZ70YHIOmsLEAhDq72uziFw5FNf4bcQNNGumLiEtEaIux88c
         MfLRNlh5bE2naPcDzo0TBfi731024bqli3triAbM2NUhNg4tlyknOWJgWyEyWpDDU8DM
         h/wWZT5thA8lBoUwEZj5FaGNv9Lz9jnc53eJFsPAw4maEVs9p7Q4q4sQr4WbGPu0Ce0L
         AAMjCVB9M/Drsduhm9JClCSKoDj1wEtwaKmRcy3z++wTSqve2aX7tisTpAQQVL/uE0zD
         raCpFOe77EA2HDyeWb1L1Gjp/QJ3W/qGfX2oGrgwfzBIhdm83S4YcN3ygYOTiLIqA5ve
         jADw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=NVYCcqt0;
       spf=pass (google.com: domain of kernel-hardening-return-12265-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12265-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=NVYCcqt0;
       spf=pass (google.com: domain of kernel-hardening-return-12265-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12265-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 8 Mar 2018 13:40:45 -0800
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Tobin C. Harding" <me@tobin.cc>, rostedt@goodmis.org,
	corbet@lwn.net, Chris Mason <clm@fb.com>,
	Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Borislav Petkov <bp@suse.de>, Randy Dunlap <rdunlap@infradead.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	linux-btrfs@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH] kernel.h: Skip single-eval logic on literals in min()/max()
Message-ID: <20180308214045.GA6787@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594407273404510633?=
X-GMAIL-MSGID: =?utf-8?q?1594407273404510633?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When max() is used in stack array size calculations from literal values
(e.g. "char foo[max(sizeof(struct1), sizeof(struct2))]", the compiler
thinks this is a dynamic calculation due to the single-eval logic, which
is not needed in the literal case. This change removes several accidental
stack VLAs from an x86 allmodconfig build:

$ diff -u before.txt after.txt | grep ^-
-drivers/input/touchscreen/cyttsp4_core.c:871:2: warning: ISO C90 forbids variable length array ‘ids’ [-Wvla]
-fs/btrfs/tree-checker.c:344:4: warning: ISO C90 forbids variable length array ‘namebuf’ [-Wvla]
-lib/vsprintf.c:747:2: warning: ISO C90 forbids variable length array ‘sym’ [-Wvla]
-net/ipv4/proc.c:403:2: warning: ISO C90 forbids variable length array ‘buff’ [-Wvla]
-net/ipv6/proc.c:198:2: warning: ISO C90 forbids variable length array ‘buff’ [-Wvla]
-net/ipv6/proc.c:218:2: warning: ISO C90 forbids variable length array ‘buff64’ [-Wvla]

Based on an earlier patch from Josh Poimboeuf.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/kernel.h | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 3fd291503576..e0b39d461582 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -787,37 +787,57 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
  * strict type-checking.. See the
  * "unnecessary" pointer comparison.
  */
-#define __min(t1, t2, min1, min2, x, y) ({		\
+#define __single_eval_min(t1, t2, min1, min2, x, y) ({	\
 	t1 min1 = (x);					\
 	t2 min2 = (y);					\
 	(void) (&min1 == &min2);			\
 	min1 < min2 ? min1 : min2; })
 
+/*
+ * In the case of builtin constant values, there is no need to do the
+ * double-evaluation protection, so the raw comparison can be made.
+ * This allows min()/max() to be used in stack array allocations and
+ * avoid the compiler thinking it is a dynamic value leading to an
+ * accidental VLA.
+ */
+#define __min(t1, t2, x, y)						\
+	__builtin_choose_expr(__builtin_constant_p(x) &&		\
+			      __builtin_constant_p(y) &&		\
+			      __builtin_types_compatible_p(t1, t2),	\
+			      (t1)(x) < (t2)(y) ? (t1)(x) : (t2)(y),	\
+			      __single_eval_min(t1, t2,			\
+						__UNIQUE_ID(max1_),	\
+						__UNIQUE_ID(max2_),	\
+						x, y))
+
 /**
  * min - return minimum of two values of the same or compatible types
  * @x: first value
  * @y: second value
  */
-#define min(x, y)					\
-	__min(typeof(x), typeof(y),			\
-	      __UNIQUE_ID(min1_), __UNIQUE_ID(min2_),	\
-	      x, y)
+#define min(x, y)	__min(typeof(x), typeof(y), x, y)
 
-#define __max(t1, t2, max1, max2, x, y) ({		\
+#define __single_eval_max(t1, t2, max1, max2, x, y) ({	\
 	t1 max1 = (x);					\
 	t2 max2 = (y);					\
 	(void) (&max1 == &max2);			\
 	max1 > max2 ? max1 : max2; })
 
+#define __max(t1, t2, x, y)						\
+	__builtin_choose_expr(__builtin_constant_p(x) &&		\
+			      __builtin_constant_p(y) &&		\
+			      __builtin_types_compatible_p(t1, t2),	\
+			      (t1)(x) > (t2)(y) ? (t1)(x) : (t2)(y),	\
+			      __single_eval_max(t1, t2,			\
+						__UNIQUE_ID(max1_),	\
+						__UNIQUE_ID(max2_),	\
+						x, y))
 /**
  * max - return maximum of two values of the same or compatible types
  * @x: first value
  * @y: second value
  */
-#define max(x, y)					\
-	__max(typeof(x), typeof(y),			\
-	      __UNIQUE_ID(max1_), __UNIQUE_ID(max2_),	\
-	      x, y)
+#define max(x, y)	__max(typeof(x), typeof(y), x, y)
 
 /**
  * min3 - return minimum of three values
@@ -871,7 +891,6 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
  */
 #define min_t(type, x, y)				\
 	__min(type, type,				\
-	      __UNIQUE_ID(min1_), __UNIQUE_ID(min2_),	\
 	      x, y)
 
 /**
@@ -882,7 +901,6 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
  */
 #define max_t(type, x, y)				\
 	__max(type, type,				\
-	      __UNIQUE_ID(min1_), __UNIQUE_ID(min2_),	\
 	      x, y)
 
 /**
-- 
2.7.4


-- 
Kees Cook
Pixel Security
