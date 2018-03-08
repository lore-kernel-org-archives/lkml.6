Return-Path: <kernel-hardening-return-12282-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvY01WdnqlVgfggBTG+saNTZLA8csEgV5euukPfUIxWGAoUNGAtjZ9h+gbO3+wVpRi0Ns78
ARC-Seal: i=1; a=rsa-sha256; t=1520552298; cv=none;
        d=google.com; s=arc-20160816;
        b=iuTPZ+hs3blsylk2OSXph5jKNJn8om/NXqt881n/MgR5bvyTZaRbih7duC7T3b9u1J
         5d2v76jif0qeeUVg28s0emb4dgN3w5y6L2S1Yt3ZAnMWEndleGwlDzovVz8sPXF3Vguj
         BpdZHT7IK3j8U1lzJu/QFQToPcZ9N1q9GS10eErclSDKGXYD+tvHIhqUXxRrB+0aFmO8
         fzo2st/D425i8sySp3BYISYeSH1K1SRi8lSO7N6tnXEsjRVuBEcIWFwse/BAPLWkgyb+
         /KuXIr4ts/vGNhDLok/SI5UaAOcQ+/LF9YNYYJbZv3XLx9xXSjLwfi3VYH+B2u4+ajET
         FFLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=hrGlkJyZPUh6nBPbxwRy5IRDCpqnrDZvhfL4E0wh7IQ=;
        b=nupqj8RnMa5eRKtQ52MFN1opi4bVET5KgwT7a50UwLssl0wpdIk3hyoRjojRTP+9+h
         OaRsRdY0/mgSWLHyyRnodU/r+AIXWXpy9xbLp1dyFUXvtDZDxKC5h3Vd6bROZbVehvRn
         +L78aRJiA3Apf9GUgOgo+0LLeYkH2th8eycsyt5EtpDJJOIEm+s+DFT4JRBlXgsXhlru
         Sh7sBXC+2BNNI+hHAhHVvXJZ4ZncQelo3psZMjkIybZZlS3mf8yYjwIy347uc2gjl6vc
         K4PZAIcK4dd8Y7Fbtth8LUUen6LvtJixPRwODdH4UGbY+I3mNI92DQnuJXuOvcsEDksb
         aVqg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=ntcbi7D7;
       spf=pass (google.com: domain of kernel-hardening-return-12282-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12282-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=ntcbi7D7;
       spf=pass (google.com: domain of kernel-hardening-return-12282-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12282-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 8 Mar 2018 15:37:58 -0800
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
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
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: [PATCH v2] kernel.h: Skip single-eval logic on literals in
 min()/max()
Message-ID: <20180308233758.GA22120@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594407273404510633?=
X-GMAIL-MSGID: =?utf-8?q?1594414647395026822?=
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
v2:
- fix copy/paste-o max1_/max2_ (ijc)
- clarify "compile-time" constant in comment (Rasmus)
- clean up formatting on min_t()/max_t()
---
 include/linux/kernel.h | 50 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 3fd291503576..108cdf7bd484 100644
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
+ * In the case of compile-time constant values, there is no need to do
+ * the double-evaluation protection, so the raw comparison can be made.
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
@@ -869,10 +889,7 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
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
@@ -880,10 +897,7 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
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
