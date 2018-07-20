Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C57ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072CF20854
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072CF20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388201AbeGTNSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:18:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38020 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732150AbeGTNSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:18:14 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A7F14BD8;
        Fri, 20 Jul 2018 12:29:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Juergen Gross <jgross@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, acme@redhat.com,
        akataria@vmware.com, akpm@linux-foundation.org,
        andrea.parri@amarulasolutions.com, ard.biesheuvel@linaro.org,
        aryabinin@virtuozzo.com, astrachan@google.com,
        boris.ostrovsky@oracle.com, brijesh.singh@amd.com,
        caoj.fnst@cn.fujitsu.com, geert@linux-m68k.org,
        ghackmann@google.com, jan.kiszka@siemens.com,
        jarkko.sakkinen@linux.intel.com, jpoimboe@redhat.com,
        keescook@google.com, kirill.shutemov@linux.intel.com,
        kstewart@linuxfoundation.org, linux-efi@vger.kernel.org,
        linux-kbuild@vger.kernel.org, manojgupta@google.com,
        mawilcox@microsoft.com, michal.lkml@markovi.net, mjg59@google.com,
        mka@chromium.org, pombredanne@nexb.com, rientjes@google.com,
        rostedt@goodmis.org, sedat.dilek@gmail.com,
        thomas.lendacky@amd.com, tstellar@redhat.com, tweek@google.com,
        virtualization@lists.linux-foundation.org, will.deacon@arm.com,
        yamada.masahiro@socionext.com, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 05/66] compiler-gcc.h: Add __attribute__((gnu_inline)) to all inline declarations
Date:   Fri, 20 Jul 2018 14:13:22 +0200
Message-Id: <20180720121407.556231581@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121407.228772286@linuxfoundation.org>
References: <20180720121407.228772286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nick Desaulniers <ndesaulniers@google.com>

commit d03db2bc26f0e4a6849ad649a09c9c73fccdc656 upstream.

Functions marked extern inline do not emit an externally visible
function when the gnu89 C standard is used. Some KBUILD Makefiles
overwrite KBUILD_CFLAGS. This is an issue for GCC 5.1+ users as without
an explicit C standard specified, the default is gnu11. Since c99, the
semantics of extern inline have changed such that an externally visible
function is always emitted. This can lead to multiple definition errors
of extern inline functions at link time of compilation units whose build
files have removed an explicit C standard compiler flag for users of GCC
5.1+ or Clang.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: H. Peter Anvin <hpa@zytor.com>
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: acme@redhat.com
Cc: akataria@vmware.com
Cc: akpm@linux-foundation.org
Cc: andrea.parri@amarulasolutions.com
Cc: ard.biesheuvel@linaro.org
Cc: aryabinin@virtuozzo.com
Cc: astrachan@google.com
Cc: boris.ostrovsky@oracle.com
Cc: brijesh.singh@amd.com
Cc: caoj.fnst@cn.fujitsu.com
Cc: geert@linux-m68k.org
Cc: ghackmann@google.com
Cc: gregkh@linuxfoundation.org
Cc: jan.kiszka@siemens.com
Cc: jarkko.sakkinen@linux.intel.com
Cc: jpoimboe@redhat.com
Cc: keescook@google.com
Cc: kirill.shutemov@linux.intel.com
Cc: kstewart@linuxfoundation.org
Cc: linux-efi@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: manojgupta@google.com
Cc: mawilcox@microsoft.com
Cc: michal.lkml@markovi.net
Cc: mjg59@google.com
Cc: mka@chromium.org
Cc: pombredanne@nexb.com
Cc: rientjes@google.com
Cc: rostedt@goodmis.org
Cc: sedat.dilek@gmail.com
Cc: thomas.lendacky@amd.com
Cc: tstellar@redhat.com
Cc: tweek@google.com
Cc: virtualization@lists.linux-foundation.org
Cc: will.deacon@arm.com
Cc: yamada.masahiro@socionext.com
Link: http://lkml.kernel.org/r/20180621162324.36656-2-ndesaulniers@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/compiler-gcc.h |   29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -65,25 +65,40 @@
 #endif
 
 /*
+ * Feature detection for gnu_inline (gnu89 extern inline semantics). Either
+ * __GNUC_STDC_INLINE__ is defined (not using gnu89 extern inline semantics,
+ * and we opt in to the gnu89 semantics), or __GNUC_STDC_INLINE__ is not
+ * defined so the gnu89 semantics are the default.
+ */
+#ifdef __GNUC_STDC_INLINE__
+# define __gnu_inline	__attribute__((gnu_inline))
+#else
+# define __gnu_inline
+#endif
+
+/*
  * Force always-inline if the user requests it so via the .config,
  * or if gcc is too old.
  * GCC does not warn about unused static inline functions for
  * -Wunused-function.  This turns out to avoid the need for complex #ifdef
  * directives.  Suppress the warning in clang as well by using "unused"
  * function attribute, which is redundant but not harmful for gcc.
+ * Prefer gnu_inline, so that extern inline functions do not emit an
+ * externally visible function. This makes extern inline behave as per gnu89
+ * semantics rather than c99. This prevents multiple symbol definition errors
+ * of extern inline functions at link time.
+ * A lot of inline functions can cause havoc with function tracing.
  */
 #if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) ||		\
     !defined(CONFIG_OPTIMIZE_INLINING) || (__GNUC__ < 4)
-#define inline inline		__attribute__((always_inline,unused)) notrace
-#define __inline__ __inline__	__attribute__((always_inline,unused)) notrace
-#define __inline __inline	__attribute__((always_inline,unused)) notrace
+#define inline \
+	inline __attribute__((always_inline, unused)) notrace __gnu_inline
 #else
-/* A lot of inline functions can cause havoc with function tracing */
-#define inline inline		__attribute__((unused)) notrace
-#define __inline__ __inline__	__attribute__((unused)) notrace
-#define __inline __inline	__attribute__((unused)) notrace
+#define inline inline		__attribute__((unused)) notrace __gnu_inline
 #endif
 
+#define __inline__ inline
+#define __inline inline
 #define __always_inline	inline __attribute__((always_inline))
 #define  noinline	__attribute__((noinline))
 


