Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49MItKJEWYF/RMucEDsQl7BMNWKpAWkTK7yPesc0Y4tD8lDCUvA6rjzHaAHgvXpb+299yaL
ARC-Seal: i=1; a=rsa-sha256; t=1523980883; cv=none;
        d=google.com; s=arc-20160816;
        b=COKzdEBEMqEfD+ZXNwICnHzgHY1AzPfbB4aJkbORkl5XiFIvqkbDe/G+ZjlQcMsfmh
         XOxCo4uid7kI5ewML+Sl/WYTI4Z5uPZrzASJ5YoIqwaKuvbgYwAGrcnXXftzQPnufI83
         /UIiyfxm+B+yaBLu/3LGeuG5Ey9EDWSzfER819CapRfPbLYdui0ASj8K7KdTYG8CLawz
         7g4IsywFfhEXp4KM5ubrHgQOX7V2hFRVfkXBq+toUzVvtkRZx0jRpGHtxN9wt0iX9yWW
         udZTuo1t8Ki/876qWDzo+X74JVfwpAJB7wDDxBzvL8BPKB71WtJdkIhrrdx6TAWsLkXD
         20xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sZRmsWK9SMWC43KS7ylAtDFoP3tC4ed0xQF+J/gDzC4=;
        b=ZRm9FwWsyzjltYzJ1O3zuNrWUTAN8Fsbbm5ow2f1Za1pXo24a6ygnHLmoeDcNjaqES
         O919Qv1iniV/BxW3Ly6e3WsyRwYyXro2QFmEnB97GHlNTlUBSi8GpTciEVSBAWvi4ibW
         jdg/RZP4zTi7CbF3fxI0bL/uIw3ZQW2J0puCgzFOcBm/Y5MV/gcxPG1yG7jSpyAVB/XY
         rLrCIYftLhtecwcA2Z2zm8uf4m1cryiLUGLXVA/cIMbWGbPh1G1vMiwGUHiLZ1KDinaX
         9PNeEvqu/KhbM3DpcbC1yttKj0z6GFQl5o6jdGsSXP+3NZpfjxffDD2z2aRhvTyfNwVa
         F7Tg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Huacai Chen <chenhc@lemote.com>,
	James Hogan <jhogan@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Rich Felker <dalias@libc.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Russell King <linux@arm.linux.org.uk>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.16 39/68] zboot: fix stack protector in compressed boot phase
Date: Tue, 17 Apr 2018 17:57:52 +0200
Message-Id: <20180417155750.920900508@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009779318755042?=
X-GMAIL-MSGID: =?utf-8?q?1598009779318755042?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhc@lemote.com>

commit 7bbaf27d9c83037b6e60a818e57bdbedf6bc15be upstream.

Calling __stack_chk_guard_setup() in decompress_kernel() is too late
that stack checking always fails for decompress_kernel() itself.  So
remove __stack_chk_guard_setup() and initialize __stack_chk_guard before
we call decompress_kernel().

Original code comes from ARM but also used for MIPS and SH, so fix them
together.  If without this fix, compressed booting of these archs will
fail because stack checking is enabled by default (>=4.16).

Link: http://lkml.kernel.org/r/1522226933-29317-1-git-send-email-chenhc@lemote.com
Fixes: 8779657d29c0 ("stackprotector: Introduce CONFIG_CC_STACKPROTECTOR_STRONG")
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Acked-by: James Hogan <jhogan@kernel.org>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Rich Felker <dalias@libc.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/compressed/misc.c        |    9 +--------
 arch/mips/boot/compressed/decompress.c |    9 +--------
 arch/sh/boot/compressed/misc.c         |    9 +--------
 3 files changed, 3 insertions(+), 24 deletions(-)

--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -128,12 +128,7 @@ asmlinkage void __div0(void)
 	error("Attempting division by 0!");
 }
 
-unsigned long __stack_chk_guard;
-
-void __stack_chk_guard_setup(void)
-{
-	__stack_chk_guard = 0x000a0dff;
-}
+const unsigned long __stack_chk_guard = 0x000a0dff;
 
 void __stack_chk_fail(void)
 {
@@ -150,8 +145,6 @@ decompress_kernel(unsigned long output_s
 {
 	int ret;
 
-	__stack_chk_guard_setup();
-
 	output_data		= (unsigned char *)output_start;
 	free_mem_ptr		= free_mem_ptr_p;
 	free_mem_end_ptr	= free_mem_ptr_end_p;
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -76,12 +76,7 @@ void error(char *x)
 #include "../../../../lib/decompress_unxz.c"
 #endif
 
-unsigned long __stack_chk_guard;
-
-void __stack_chk_guard_setup(void)
-{
-	__stack_chk_guard = 0x000a0dff;
-}
+const unsigned long __stack_chk_guard = 0x000a0dff;
 
 void __stack_chk_fail(void)
 {
@@ -92,8 +87,6 @@ void decompress_kernel(unsigned long boo
 {
 	unsigned long zimage_start, zimage_size;
 
-	__stack_chk_guard_setup();
-
 	zimage_start = (unsigned long)(&__image_begin);
 	zimage_size = (unsigned long)(&__image_end) -
 	    (unsigned long)(&__image_begin);
--- a/arch/sh/boot/compressed/misc.c
+++ b/arch/sh/boot/compressed/misc.c
@@ -104,12 +104,7 @@ static void error(char *x)
 	while(1);	/* Halt */
 }
 
-unsigned long __stack_chk_guard;
-
-void __stack_chk_guard_setup(void)
-{
-	__stack_chk_guard = 0x000a0dff;
-}
+const unsigned long __stack_chk_guard = 0x000a0dff;
 
 void __stack_chk_fail(void)
 {
@@ -130,8 +125,6 @@ void decompress_kernel(void)
 {
 	unsigned long output_addr;
 
-	__stack_chk_guard_setup();
-
 #ifdef CONFIG_SUPERH64
 	output_addr = (CONFIG_MEMORY_START + 0x2000);
 #else
