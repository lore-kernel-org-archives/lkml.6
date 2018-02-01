Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x225wXdVJPav/dHFrON1PswFBFocwlBuZWEK5SOgNUUVW4AsZsm1WklbYEKI3WDv60I99Mq0n
ARC-Seal: i=1; a=rsa-sha256; t=1517496543; cv=none;
        d=google.com; s=arc-20160816;
        b=IHe4IYvPVLtwXYHyDjS9Jit7fN3yq/O3TbTi5hKredlPsHtOWYnvLKyZLIafBEEhGf
         TmUVx9/Cc5cMHuwWcdDUJLrXL6Z79KM3a70oBCyMyIOmzVrKkiXefS5N92EQDhGL1UJn
         BON56HhSYQQV1B8AcnyW08v05vUD6Ips0mvNNNzmubkRmWDfNtDkJOvLblp9vZfiKlTS
         yQVXDu9ioR/YZBpjEUM2fIsUD5/0GFWMGU7sEUcPJy1LHWSma3J+QAlBp69xLKhDLdZc
         xYS3yIP8DdNWeNJj1q7Ha5HG3DUOrIS4TsCtJ5vBpTgPKIiHJseX5zQzmwHWQuXoX3o9
         8xrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:dkim-signature:arc-authentication-results;
        bh=j991z6J6qwbocXwg61DcDM/7e1GE3Lm/GBqRP50biDc=;
        b=sfnRrHXPossjY4HAPUeaj5Zw3v5HPX5BGGeU8hKs8xCwYKXznWyHbVHDUG0SEAcgQu
         5fJkvGhidUgl1DFd9Fy9B745NNW4ZDWBld2KyoQWwT9XNmmzqheWNcmCbrMSlrYb60Sd
         pCWrCgrFUk+2Z+AptSQsBWfdiwnRn6MGISaiT0Vcj9FWTCawzZtj4hadPhTmoChonpLI
         zmrRMXjoWOOr9mvr4bVwNV7Pyxu9CuzfaGOgM5JqqxFbPSHEHPcksyzd7vlz9E8U1j8S
         rCvdFn4KRw7l4Kg+XFuNzFbBZIVZGSs6adTWFfZl6rdyS3gXbB7HM+flwSSCA4j91ydO
         QaWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=MYoHfJbo;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=MYoHfJbo;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Message-Id: <20180201143822.064129629@infradead.org>
User-Agent: quilt/0.63-1
Date: Thu, 01 Feb 2018 15:34:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@intel.com>,
 Ashok Raj <ashok.raj@intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Andi Kleen <ak@linux.intel.com>,
 Arjan Van De Ven <arjan.van.de.ven@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Asit Mallick <asit.k.mallick@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 6/7] x86: Annotate indirect jump in head_64.S
References: <20180201143421.088202488@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-objtool-retpoline-annotate.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591210454784148191?=
X-GMAIL-MSGID: =?utf-8?q?1591210454784148191?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The objtool retpoline validation found this indirect jump. Seeing how
it's on CPU bringup before we run userspace it should be safe, annotate
it.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/head_64.S |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -23,6 +23,7 @@
 #include <asm/nops.h>
 #include "../entry/calling.h"
 #include <asm/export.h>
+#include <asm/nospec-branch.h>
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/asm-offsets.h>
@@ -134,6 +135,7 @@ ENTRY(secondary_startup_64)
 
 	/* Ensure I am executing from virtual addresses */
 	movq	$1f, %rax
+	ANNOTATE_RETPOLINE_SAFE
 	jmp	*%rax
 1:
 	UNWIND_HINT_EMPTY
