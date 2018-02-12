Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x226C5yatdHeD8M/5YISEFQM+JQehyG38lTxbBorv/DkzO2itGOtQb6Ql7RZUsxfmWAIZcFrf
ARC-Seal: i=1; a=rsa-sha256; t=1518439976; cv=none;
        d=google.com; s=arc-20160816;
        b=FAh8o9QZIBPQoNsnkeS8DY2/Bb5hDTseBlxzxPWPj3/IVqLAAOEImIp1VxM6mC8a3O
         XMYbx5lafMvaxHCyw9RyXZj/3/TzITfh8PIUcrP6FlGz5vtyhbzpAlFWZNKe9+Mb/n7A
         jLpmPlEG7Jt41jAtlKiYZhVHt9OJxPcWReUzpf6hoB2PIIjk4DVufA6pDuhnmkSO+dKW
         ugxItM9iGQCBbQo+tkb5a+RBDbW9GzcGX808JCPiJE7oCUM6qJvR1BVJKKZhDggPt8yF
         zwgcfCseJLEs9aSRK8zke3j+YHQ5r/2Zc9K/YocNDsLVRs9p5dAieb6YP4HglnE+WaGC
         BOjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:dkim-signature:arc-authentication-results;
        bh=ukBBv9QGGOPGiwmosgfvkbK4dpPKFnxVrRHzTsStnXI=;
        b=NsmWNJUjt6YnYzTYyXJ6oWhakN6Z39xuVuIKasBl4Tmh1JrFJIDX2mWiP/LJS5vZnG
         hbPt++CYcUS6a6TCQxH9VuAq7+6Qx5NPf3cxHwx6HAxgcHIcZ9QbnQzQNyj1D3VxQAlm
         Mwhml3fy+DHnjuaf4OhTSSL9BO98fpM53DuMFCofNqYPRH+7xkY4cNOn0AF5jlIByVR+
         ixrFrVZrodMbav4/MSve/rMkIvIVDHEG2nvnZi0SNf/fNWF9qQ2iZQSBXMMEsF829OmQ
         TVtECyYAQPYPghzuNejpWMSBTG/K11t5l72rjj1UoWW4e+Dvf6hPv5vmVToF0alLwtl8
         b2HQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=xjTwyZwN;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=xjTwyZwN;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Message-Id: <20180212125033.664379153@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 12 Feb 2018 13:49:03 +0100
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
Subject: [PATCH v2 8/8] x86,sme: Annotate indirect call
References: <20180212124855.882405399@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-retpoline-annotate-sme.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592199716448647320?=
X-GMAIL-MSGID: =?utf-8?q?1592199716448647320?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is boot code, we run this _way_ before userspace comes along to
poison our branch predictor.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@suse.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
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
