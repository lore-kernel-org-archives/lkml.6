Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELsQp6EvGgVaN/FmDvsQiAbYhGvGkvO4745a3E5DVXMLBVSg6J4iUxuzjr5pWHrIn7uc6t9f
ARC-Seal: i=1; a=rsa-sha256; t=1520824071; cv=none;
        d=google.com; s=arc-20160816;
        b=swvOmBnRJost+OrsXr/Rj54BqpM+LYBg2tnfnTBxEFUCTKQ6WBQPfnoTHGhBdZHDME
         CG+vx2HPYOUln+BaRy9l4o5qkdkN09wq+w6d7oJwlf57UCtZ3Dbj9FkzD/DFwOOOHddn
         xX+7qOak2PNRYpHamqUQNs0yk5QhUWZOpckSPgdAVBaEQrAgTe3znAbAKeY1wZ1UiVA8
         qt/9bsYCU6D+fLjmNxPdzVaKXIP7OHWJ3/CcrsMp+qka5/RUgi3ssRIcF7CbeeIE/ydr
         1QCd8JLmkmMVoviPDTbzuKFtuSalHlhZXUrPizlZUgl6eAyNGz/ocPQf7XpgppgfmJNt
         RShQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=nPbDrp6CgDJXvnKoo4s1CZWwIzLPFMDkqdpWyFOl54A=;
        b=oEqvxxIFeyVPLsKuIAf2rBSo/Q/cWGq2zxMD/Tls/X7miAL15sSkAiL5wCkWT13eww
         ozxbHuD6hnXQ2T7SKcsSiDLvKIlujcIrf2sRc2zV8NaJtjWOlBHsfZfPcCeSnXfRRmyb
         twyi1iqokGOdOedH18+JHT4apaLqzpgotaGE8ES9gi138KZtASc3pB/TVL47T2W3iJ2+
         WM6ZCnEDxGsWZUArFV/SCfegeWFhpMV7Vtv7F8QHHw06dy57d5NJwqKKwLrbeaqcMSKj
         Elg8WwJQUkKrWqHZ+iFp3eieLQVnXU17NUlxoTssmf27oLUM+ZzV1rAaEzftaJ0lrJpq
         AMtQ==
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
CC: akpm@linux-foundation.org, linux-arch@vger.kernel.org,
 gregkh@linuxfoundation.org,
 "Ingo Molnar" <mingo@redhat.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 alan@linux.intel.com,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Tom Lendacky" <thomas.lendacky@amd.com>,
 torvalds@linux-foundation.org, kernel-hardening@lists.openwall.com,
 "Kees Cook" <keescook@chromium.org>,
 "Al Viro" <viro@zeniv.linux.org.uk>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.943057352@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 74/76] x86/usercopy: Replace open coded stac/clac
 with __uaccess_{begin, end}
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699621638054310?=
X-GMAIL-MSGID: =?utf-8?q?1594699621638054310?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit b5c4ae4f35325d520b230bab6eb3310613b72ac1 upstream.

In preparation for converting some __uaccess_begin() instances to
__uacess_begin_nospec(), make sure all 'from user' uaccess paths are
using the _begin(), _end() helpers rather than open-coded stac() and
clac().

No functional changes.

Suggested-by: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: torvalds@linux-foundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727416438.33451.17309465232057176966.stgit@dwillia2-desk3.amr.corp.intel.com
[bwh: Backported to 3.16:
 - Convert several more functions to use __uaccess_begin_nospec(), that
   are just wrappers in mainline
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/lib/usercopy_32.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/lib/usercopy_32.c
+++ b/arch/x86/lib/usercopy_32.c
@@ -570,12 +570,12 @@ do {									\
 unsigned long __copy_to_user_ll(void __user *to, const void *from,
 				unsigned long n)
 {
-	stac();
+	__uaccess_begin();
 	if (movsl_is_ok(to, from, n))
 		__copy_user(to, from, n);
 	else
 		n = __copy_user_intel(to, from, n);
-	clac();
+	__uaccess_end();
 	return n;
 }
 EXPORT_SYMBOL(__copy_to_user_ll);
@@ -583,12 +583,12 @@ EXPORT_SYMBOL(__copy_to_user_ll);
 unsigned long __copy_from_user_ll(void *to, const void __user *from,
 					unsigned long n)
 {
-	stac();
+	__uaccess_begin();
 	if (movsl_is_ok(to, from, n))
 		__copy_user_zeroing(to, from, n);
 	else
 		n = __copy_user_zeroing_intel(to, from, n);
-	clac();
+	__uaccess_end();
 	return n;
 }
 EXPORT_SYMBOL(__copy_from_user_ll);
@@ -596,13 +596,13 @@ EXPORT_SYMBOL(__copy_from_user_ll);
 unsigned long __copy_from_user_ll_nozero(void *to, const void __user *from,
 					 unsigned long n)
 {
-	stac();
+	__uaccess_begin();
 	if (movsl_is_ok(to, from, n))
 		__copy_user(to, from, n);
 	else
 		n = __copy_user_intel((void __user *)to,
 				      (const void *)from, n);
-	clac();
+	__uaccess_end();
 	return n;
 }
 EXPORT_SYMBOL(__copy_from_user_ll_nozero);
@@ -610,7 +610,7 @@ EXPORT_SYMBOL(__copy_from_user_ll_nozero
 unsigned long __copy_from_user_ll_nocache(void *to, const void __user *from,
 					unsigned long n)
 {
-	stac();
+	__uaccess_begin();
 #ifdef CONFIG_X86_INTEL_USERCOPY
 	if (n > 64 && cpu_has_xmm2)
 		n = __copy_user_zeroing_intel_nocache(to, from, n);
@@ -619,7 +619,7 @@ unsigned long __copy_from_user_ll_nocach
 #else
 	__copy_user_zeroing(to, from, n);
 #endif
-	clac();
+	__uaccess_end();
 	return n;
 }
 EXPORT_SYMBOL(__copy_from_user_ll_nocache);
@@ -627,7 +627,7 @@ EXPORT_SYMBOL(__copy_from_user_ll_nocach
 unsigned long __copy_from_user_ll_nocache_nozero(void *to, const void __user *from,
 					unsigned long n)
 {
-	stac();
+	__uaccess_begin();
 #ifdef CONFIG_X86_INTEL_USERCOPY
 	if (n > 64 && cpu_has_xmm2)
 		n = __copy_user_intel_nocache(to, from, n);
@@ -636,7 +636,7 @@ unsigned long __copy_from_user_ll_nocach
 #else
 	__copy_user(to, from, n);
 #endif
-	clac();
+	__uaccess_end();
 	return n;
 }
 EXPORT_SYMBOL(__copy_from_user_ll_nocache_nozero);
