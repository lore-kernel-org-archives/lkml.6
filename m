Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELsV7KSLaNOvcAbb54Mu33MQDZAD6jW8/VYYROhsGqeQ9qTVzHrIuorwDo3uhtnSbA+WEtMi
ARC-Seal: i=1; a=rsa-sha256; t=1520824071; cv=none;
        d=google.com; s=arc-20160816;
        b=ROlpOHr9BfXg9xRIWsnEHbcVOWye5Nk+hew+xfGbiFUpkqRIP8OA5wfDJkM9XZzVUU
         KmGCuDBjaN8Je2SgD/ka/Sdc69l7cW80VdAIZh92DhsyMEYddJtzZXr3u69YUGarrMPL
         L/E1c9WYgoCoYnB7+xginLKqjWgw3s1b6cAzxZ7eamXjffWDmu4yMULX3rvnx2CSHaYV
         zTjs5XoC9+Yw5dnvdPDMMXUAdaj0WKqfrweku/x0frnVL8lXSJQEnpbvZ3HjgSNefQGk
         BFkRAcUfr43AAgq3zZ+5ZVu3tRRAMhltJ/o9DoDH8DD7C9WhCgC18mu7T0puVPOCJsCx
         Wv9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=a6auVPEYTX3I3iQhqkphXs/zieC4hPdzIUJfO1rRoxk=;
        b=vmzsdxEiXL2wR9wfCIV6VFY43BbCTnSm9kizJWe4/TWuTwU2SkC+286uw7ZBu7K93I
         L5x8hQriQDQ+qS4DnuUFKr5fvvpNd0B72TQixSgiEzZYpH1hryjnK3SHIP6fTciWXnBH
         BYbAN4ttEsXx4VEaW+e/K/jXbdtLNjkQmHPlUsY+tuQ6LsPPcmanCd6ovagQUH3gZgNg
         FXQCySQuF/dSVSZsPIHmxYK2zudbllKNJRvIz/v3QheA0D+G0Tvzjulwauqb8WpXsb+U
         P2CjQzuaAcc9NYghhepDv2HBIwAFrAg7g+Bq0xOatrL9Yz9E6N/ZZgP4n3EUp97vArFp
         aHFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Thomas Gleixner" <tglx@linutronix.de>,
 alan@linux.intel.com,
 "Dan Williams" <dan.j.williams@intel.com>,
 gregkh@linuxfoundation.org, linux-arch@vger.kernel.org,
 kernel-hardening@lists.openwall.com,
 "Kees Cook" <keescook@chromium.org>,
 "Al Viro" <viro@zeniv.linux.org.uk>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.968056966@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 75/76] x86/uaccess: Use __uaccess_begin_nospec() and
 uaccess_try_nospec
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699621289542728?=
X-GMAIL-MSGID: =?utf-8?q?1594699621289542728?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 304ec1b050310548db33063e567123fae8fd0301 upstream.

Quoting Linus:

    I do think that it would be a good idea to very expressly document
    the fact that it's not that the user access itself is unsafe. I do
    agree that things like "get_user()" want to be protected, but not
    because of any direct bugs or problems with get_user() and friends,
    but simply because get_user() is an excellent source of a pointer
    that is obviously controlled from a potentially attacking user
    space. So it's a prime candidate for then finding _subsequent_
    accesses that can then be used to perturb the cache.

__uaccess_begin_nospec() covers __get_user() and copy_from_iter() where the
limit check is far away from the user pointer de-reference. In those cases
a barrier_nospec() prevents speculation with a potential pointer to
privileged memory. uaccess_try_nospec covers get_user_try.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727416953.33451.10508284228526170604.stgit@dwillia2-desk3.amr.corp.intel.com
[bwh: Backported to 3.16:
 - Convert several more functions to use __uaccess_begin_nospec(), that
   are just wrappers in mainline
 - There's no 'case 8' in __copy_to_user_inatomic()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -433,7 +433,7 @@ do {									\
 ({									\
 	int __gu_err;							\
 	unsigned long __gu_val;						\
-	__uaccess_begin();						\
+	__uaccess_begin_nospec();					\
 	__get_user_size(__gu_val, (ptr), (size), __gu_err, -EFAULT);	\
 	__uaccess_end();						\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
@@ -541,7 +541,7 @@ struct __large_struct { unsigned long bu
  *	get_user_ex(...);
  * } get_user_catch(err)
  */
-#define get_user_try		uaccess_try
+#define get_user_try		uaccess_try_nospec
 #define get_user_catch(err)	uaccess_catch(err)
 
 #define get_user_ex(x, ptr)	do {					\
@@ -576,7 +576,7 @@ extern void __cmpxchg_wrong_size(void)
 	__typeof__(ptr) __uval = (uval);				\
 	__typeof__(*(ptr)) __old = (old);				\
 	__typeof__(*(ptr)) __new = (new);				\
-	__uaccess_begin();						\
+	__uaccess_begin_nospec();					\
 	switch (size) {							\
 	case 1:								\
 	{								\
--- a/arch/x86/include/asm/uaccess_32.h
+++ b/arch/x86/include/asm/uaccess_32.h
@@ -48,19 +48,19 @@ __copy_to_user_inatomic(void __user *to,
 
 		switch (n) {
 		case 1:
-			__uaccess_begin();
+			__uaccess_begin_nospec();
 			__put_user_size(*(u8 *)from, (u8 __user *)to,
 					1, ret, 1);
 			__uaccess_end();
 			return ret;
 		case 2:
-			__uaccess_begin();
+			__uaccess_begin_nospec();
 			__put_user_size(*(u16 *)from, (u16 __user *)to,
 					2, ret, 2);
 			__uaccess_end();
 			return ret;
 		case 4:
-			__uaccess_begin();
+			__uaccess_begin_nospec();
 			__put_user_size(*(u32 *)from, (u32 __user *)to,
 					4, ret, 4);
 			__uaccess_end();
@@ -104,17 +104,17 @@ __copy_from_user_inatomic(void *to, cons
 
 		switch (n) {
 		case 1:
-			__uaccess_begin();
+			__uaccess_begin_nospec();
 			__get_user_size(*(u8 *)to, from, 1, ret, 1);
 			__uaccess_end();
 			return ret;
 		case 2:
-			__uaccess_begin();
+			__uaccess_begin_nospec();
 			__get_user_size(*(u16 *)to, from, 2, ret, 2);
 			__uaccess_end();
 			return ret;
 		case 4:
-			__uaccess_begin();
+			__uaccess_begin_nospec();
 			__get_user_size(*(u32 *)to, from, 4, ret, 4);
 			__uaccess_end();
 			return ret;
@@ -154,17 +154,17 @@ __copy_from_user(void *to, const void __
 
 		switch (n) {
 		case 1:
-			__uaccess_begin();
+			__uaccess_begin_nospec();
 			__get_user_size(*(u8 *)to, from, 1, ret, 1);
 			__uaccess_end();
 			return ret;
 		case 2:
-			__uaccess_begin();
+			__uaccess_begin_nospec();
 			__get_user_size(*(u16 *)to, from, 2, ret, 2);
 			__uaccess_end();
 			return ret;
 		case 4:
-			__uaccess_begin();
+			__uaccess_begin_nospec();
 			__get_user_size(*(u32 *)to, from, 4, ret, 4);
 			__uaccess_end();
 			return ret;
@@ -182,17 +182,17 @@ static __always_inline unsigned long __c
 
 		switch (n) {
 		case 1:
-			__uaccess_begin();
+			__uaccess_begin_nospec();
 			__get_user_size(*(u8 *)to, from, 1, ret, 1);
 			__uaccess_end();
 			return ret;
 		case 2:
-			__uaccess_begin();
+			__uaccess_begin_nospec();
 			__get_user_size(*(u16 *)to, from, 2, ret, 2);
 			__uaccess_end();
 			return ret;
 		case 4:
-			__uaccess_begin();
+			__uaccess_begin_nospec();
 			__get_user_size(*(u32 *)to, from, 4, ret, 4);
 			__uaccess_end();
 			return ret;
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -57,31 +57,31 @@ int __copy_from_user_nocheck(void *dst,
 		return copy_user_generic(dst, (__force void *)src, size);
 	switch (size) {
 	case 1:
-		__uaccess_begin();
+		__uaccess_begin_nospec();
 		__get_user_asm(*(u8 *)dst, (u8 __user *)src,
 			      ret, "b", "b", "=q", 1);
 		__uaccess_end();
 		return ret;
 	case 2:
-		__uaccess_begin();
+		__uaccess_begin_nospec();
 		__get_user_asm(*(u16 *)dst, (u16 __user *)src,
 			      ret, "w", "w", "=r", 2);
 		__uaccess_end();
 		return ret;
 	case 4:
-		__uaccess_begin();
+		__uaccess_begin_nospec();
 		__get_user_asm(*(u32 *)dst, (u32 __user *)src,
 			      ret, "l", "k", "=r", 4);
 		__uaccess_end();
 		return ret;
 	case 8:
-		__uaccess_begin();
+		__uaccess_begin_nospec();
 		__get_user_asm(*(u64 *)dst, (u64 __user *)src,
 			      ret, "q", "", "=r", 8);
 		__uaccess_end();
 		return ret;
 	case 10:
-		__uaccess_begin();
+		__uaccess_begin_nospec();
 		__get_user_asm(*(u64 *)dst, (u64 __user *)src,
 			       ret, "q", "", "=r", 10);
 		if (likely(!ret))
@@ -91,7 +91,7 @@ int __copy_from_user_nocheck(void *dst,
 		__uaccess_end();
 		return ret;
 	case 16:
-		__uaccess_begin();
+		__uaccess_begin_nospec();
 		__get_user_asm(*(u64 *)dst, (u64 __user *)src,
 			       ret, "q", "", "=r", 16);
 		if (likely(!ret))
@@ -190,7 +190,7 @@ int __copy_in_user(void __user *dst, con
 	switch (size) {
 	case 1: {
 		u8 tmp;
-		__uaccess_begin();
+		__uaccess_begin_nospec();
 		__get_user_asm(tmp, (u8 __user *)src,
 			       ret, "b", "b", "=q", 1);
 		if (likely(!ret))
@@ -201,7 +201,7 @@ int __copy_in_user(void __user *dst, con
 	}
 	case 2: {
 		u16 tmp;
-		__uaccess_begin();
+		__uaccess_begin_nospec();
 		__get_user_asm(tmp, (u16 __user *)src,
 			       ret, "w", "w", "=r", 2);
 		if (likely(!ret))
@@ -213,7 +213,7 @@ int __copy_in_user(void __user *dst, con
 
 	case 4: {
 		u32 tmp;
-		__uaccess_begin();
+		__uaccess_begin_nospec();
 		__get_user_asm(tmp, (u32 __user *)src,
 			       ret, "l", "k", "=r", 4);
 		if (likely(!ret))
@@ -224,7 +224,7 @@ int __copy_in_user(void __user *dst, con
 	}
 	case 8: {
 		u64 tmp;
-		__uaccess_begin();
+		__uaccess_begin_nospec();
 		__get_user_asm(tmp, (u64 __user *)src,
 			       ret, "q", "", "=r", 8);
 		if (likely(!ret))
--- a/arch/x86/lib/usercopy_32.c
+++ b/arch/x86/lib/usercopy_32.c
@@ -570,7 +570,7 @@ do {									\
 unsigned long __copy_to_user_ll(void __user *to, const void *from,
 				unsigned long n)
 {
-	__uaccess_begin();
+	__uaccess_begin_nospec();
 	if (movsl_is_ok(to, from, n))
 		__copy_user(to, from, n);
 	else
@@ -583,7 +583,7 @@ EXPORT_SYMBOL(__copy_to_user_ll);
 unsigned long __copy_from_user_ll(void *to, const void __user *from,
 					unsigned long n)
 {
-	__uaccess_begin();
+	__uaccess_begin_nospec();
 	if (movsl_is_ok(to, from, n))
 		__copy_user_zeroing(to, from, n);
 	else
@@ -596,7 +596,7 @@ EXPORT_SYMBOL(__copy_from_user_ll);
 unsigned long __copy_from_user_ll_nozero(void *to, const void __user *from,
 					 unsigned long n)
 {
-	__uaccess_begin();
+	__uaccess_begin_nospec();
 	if (movsl_is_ok(to, from, n))
 		__copy_user(to, from, n);
 	else
@@ -610,7 +610,7 @@ EXPORT_SYMBOL(__copy_from_user_ll_nozero
 unsigned long __copy_from_user_ll_nocache(void *to, const void __user *from,
 					unsigned long n)
 {
-	__uaccess_begin();
+	__uaccess_begin_nospec();
 #ifdef CONFIG_X86_INTEL_USERCOPY
 	if (n > 64 && cpu_has_xmm2)
 		n = __copy_user_zeroing_intel_nocache(to, from, n);
@@ -627,7 +627,7 @@ EXPORT_SYMBOL(__copy_from_user_ll_nocach
 unsigned long __copy_from_user_ll_nocache_nozero(void *to, const void __user *from,
 					unsigned long n)
 {
-	__uaccess_begin();
+	__uaccess_begin_nospec();
 #ifdef CONFIG_X86_INTEL_USERCOPY
 	if (n > 64 && cpu_has_xmm2)
 		n = __copy_user_intel_nocache(to, from, n);
