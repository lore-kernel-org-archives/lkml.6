Return-Path: <kernel-hardening-return-12337-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtzEno5nL3NZtA2MQtdgQflC+o91CeZVqwDuEMYh18bsHL7NUMDpN85gihdwyqDSF/8dF05
ARC-Seal: i=1; a=rsa-sha256; t=1520625961; cv=none;
        d=google.com; s=arc-20160816;
        b=DtsUzCqy8w9G5loh7dqtPCLvMnu5RsFIsQz9LLnDemk/zCmC6fEMzAO38v3/IIVchY
         4iaKI/K3U8VQgkTEIFqe9TQJQ3X72xysDMc+FX2yphFEiKis6UHc5+c9kApZ3arr3Dqr
         k1XCEj1jU4vCb91QLEEU4uzVYvMN1e1GvmAY0Eqa+atQ4+uyA3r7N/3/bsRdut/vSOU/
         9rrR5I8trpoF6qwIB0oPBsM99Tw8TtDgAz1Ksc6PjQkDgxa1NEExYes3v5D1PfOH8mbg
         9IaMUUSW0zTk2mYtM5c8FSgf8gaP7jd0RJBE7h5RX/gMt4x190aUVkmZOnx4+6yvUz+r
         QFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=nCGDQAdSc66uVjK1QcElvBqjZ8SIGAwtKuwtBzOYP5w=;
        b=UrU32WXx0OIbIZUJ2aqVI8U45d0Z0dos2IB/i5OSum0ZRPkYpV1BQ93XO33MV6apCY
         sx2W5REO6yzHTJRJUkktkq9FSnUN2C5pImxqqRD0m7/ePo5L+OUc3z7dYX68MLe/B2c8
         9eA9OAoJT1rZRUppi0+f6kWsJ+TGHoxMjlgz9+RtD1k7pwq1HT+Yl6bujSgaqeK04HnK
         NxXphotd0NjN8Iesq2Di755Ggiv3SbmGi5tMWi9oyVvqQlAUhlZNk5WcZQIzgf9aO+Dx
         6SgmVYIUmnmy1S6XQ+WeG44UJ724ipsr5cbFn1U7Hp4HqTpE0j0umaSTj5FqyfLgZLt4
         zdMA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=nhpIfFlY;
       spf=pass (google.com: domain of kernel-hardening-return-12337-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12337-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=nhpIfFlY;
       spf=pass (google.com: domain of kernel-hardening-return-12337-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12337-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 9 Mar 2018 12:05:36 -0800
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Tobin C. Harding" <me@tobin.cc>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>, Chris Mason <clm@fb.com>,
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
	Linux Btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: [PATCH v3] kernel.h: Skip single-eval logic on literals in
 min()/max()
Message-ID: <20180309200536.GA5670@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594491887701841138?=
X-GMAIL-MSGID: =?utf-8?q?1594491887701841138?=
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
v3:
- drop __builtin_types_compatible_p() (Rasmus, Linus)
v2:
- fix copy/paste-o max1_/max2_ (ijc)
- clarify "compile-time" constant in comment (Rasmus)
- clean up formatting on min_t()/max_t()
---
 include/linux/kernel.h | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 3fd291503576..a0fca4deb3ab 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -787,37 +787,55 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
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
+ * In the case of compile-time constant values, there is no need to do
+ * the double-evaluation protection, so the raw comparison can be made.
+ * This allows min()/max() to be used in stack array allocations and
+ * avoid the compiler thinking it is a dynamic value leading to an
+ * accidental VLA.
+ */
+#define __min(t1, t2, x, y)						\
+	__builtin_choose_expr(__builtin_constant_p(x) &&		\
+			      __builtin_constant_p(y),			\
+			      (t1)(x) < (t2)(y) ? (t1)(x) : (t2)(y),	\
+			      __single_eval_min(t1, t2,			\
+						__UNIQUE_ID(min1_),	\
+						__UNIQUE_ID(min2_),	\
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
+			      __builtin_constant_p(y),			\
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
@@ -869,10 +887,7 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
  * @x: first value
  * @y: second value
  */
-#define min_t(type, x, y)				\
-	__min(type, type,				\
-	      __UNIQUE_ID(min1_), __UNIQUE_ID(min2_),	\
-	      x, y)
+#define min_t(type, x, y)	 __min(type, type, x, y)
 
 /**
  * max_t - return maximum of two values, using the specified type
@@ -880,10 +895,7 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
  * @x: first value
  * @y: second value
  */
-#define max_t(type, x, y)				\
-	__max(type, type,				\
-	      __UNIQUE_ID(min1_), __UNIQUE_ID(min2_),	\
-	      x, y)
+#define max_t(type, x, y)	__max(type, type, x, y)
 
 /**
  * clamp_t - return a value clamped to a given range using a given type
-- 
2.7.4


-- 
Kees Cook
Pixel Security
