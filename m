Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x225Y/rMmMsB56MEyNSDaD8Ka0+LBwUFJx/h/cI1413+DCtHhy4hRg+wE4aoNJg7ugurpfhsv
ARC-Seal: i=1; a=rsa-sha256; t=1517496544; cv=none;
        d=google.com; s=arc-20160816;
        b=XPvpLcBuHHa4pg4lH+C4GOJksiWPgWwjeZ90MZry5kezD2JFIAUg+fJjG1VtjG7MNP
         S8LSRIlw13VAbemQI6zhcEHI81YYF4DQA89uiW/0VD8AJ1fXLLzwXYYI1mX4Hx4obQMS
         jLxQ6ztTT39dAHGZt9PVLgMHi+bmzKEt9hDbTXH5GOLRK478ir20ByM6vKrVKcNfUg0t
         gGUAK9w0K0e1DXTenUObiKD0HBbepoAxyjDZnXixtY7u1MqdyQ5q1x0DUoqeY+DXeyBM
         X0svNBgRnNgGS9toybddQr9RLMdAzH2lTDlc/IJPoN3SkDDU2TtPakk8JqH2fUhlfhuZ
         hjMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:dkim-signature:arc-authentication-results;
        bh=0Ex4p1z8Xg+Uo7+ggSuyyyQvO2m3dz6/bfCtl51DNfU=;
        b=AJiazZZNKxGqRbjZsgZ67+Mjgochgd9Ft3R1R35YgEKDUG38bVCGG0DEsaiMgr5dRp
         PsmlsJy/bD9PF6h+SPuy6F1EwyAVfihAUlWJYE3NqBFfn4vZUDYc8b8800ASFIgZ1w3k
         iQ2cQViIIPNrnjtXThcgzRpYvmF3COPBt/GTOMKFcyHxNJq2dIUxXdpUNs+8KHPquelv
         cNmPBDBuYzlfT2jIr7BKThOto7Kts40xx8n7P/zc8EcisVI5PjuB6goruvt3BsNo86UL
         3jLCktg488Ra9bYfkYpUZbNMAAgjTC2qfL8kc48E0vXYjDEESNeCtPzeTz1Qnb3Ars1O
         9qIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=aybqx3Wh;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=aybqx3Wh;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Message-Id: <20180201143822.117155629@infradead.org>
User-Agent: quilt/0.63-1
Date: Thu, 01 Feb 2018 15:34:28 +0100
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
 Tom Lendacky <thomas.lendacky@amd.com>,
 Borislav Petkov <bp@suse.de>
Subject: [PATCH 7/7] x86,sme: Annotate indirect call
References: <20180201143421.088202488@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-retpoline-annotate-sme.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591210456881503351?=
X-GMAIL-MSGID: =?utf-8?q?1591210456881503351?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is boot code, we run this _way_ before userspace comes along to
poison our branch predictor.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/mem_encrypt_boot.S |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/mm/mem_encrypt_boot.S
+++ b/arch/x86/mm/mem_encrypt_boot.S
@@ -15,6 +15,7 @@
 #include <asm/page.h>
 #include <asm/processor-flags.h>
 #include <asm/msr-index.h>
+#include <asm/nospec-branch.h>
 
 	.text
 	.code64
@@ -59,6 +60,7 @@ ENTRY(sme_encrypt_execute)
 	movq	%rax, %r8		/* Workarea encryption routine */
 	addq	$PAGE_SIZE, %r8		/* Workarea intermediate copy buffer */
 
+	ANNOTATE_RETPOLINE_SAFE
 	call	*%rax			/* Call the encryption routine */
 
 	pop	%r12
