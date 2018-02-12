Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x224B4LpnZJPqdz9pogfZmIRcy6/o0V+mL0rzDlhI0mEZ84k5DR2hnfs6wsWiW3kMesRdm/wa
ARC-Seal: i=1; a=rsa-sha256; t=1518439975; cv=none;
        d=google.com; s=arc-20160816;
        b=D9vmPP0Y5B8LsYAs6Hur9V969K2I5SE8MrFs4uwx8ET7X4xaLKyg8HnuZ18mndND+z
         Xvoo2B2FQgur+Y4JSvLzwINrxhU/TXM2lDTaiu+nYVHj91lgDb8GxQF+2nruqkjN5cOi
         8l5NhFLMwYQmjz8jx6wg1jJD6ELl1UMdjwUxIto+yeo6ATQmbiWsQFNsvJCITBMRfDeK
         LtByXFcz89XckIMsQmK4vPgIT2p5QPc5BZdt7c31YBrOx/mrjOTHnULwnHrZWpj5oTht
         /f4pUe+PXd0pA9RrS4im+mN3cGd2Vvxj9T6jfvdxrO2JmthbJISLnLoT9Ze+aFiDvuHe
         dTNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:dkim-signature:arc-authentication-results;
        bh=OvTCFuUbH5hJR8rYO1YXUXqrXGLom+guliE2WJLkWZk=;
        b=F7NU4OnAVs6OSKvilF3zBas2nN3QndTyoQsMwaAo8lzuC6FBpO4c8f1Hi7ip7/+w9f
         u5+0tYh7crsmzxnpuzLr669VkFlaKSqgRZr1dJiyrMrUF9/VGE1t2jq1I1Csl538vd4D
         nOVyspwhrtvn0Si0l159F6yF4sRtMspv5LHH4jfkYsIyANZteOGiIk8l5CwT79gOsBgO
         518izIz7CA5EkG9uPRxyVtPzncCLigyb4tX6e+NJMVUqH1JFkA8LD6HlNicdNoWR/AeJ
         X4zcWa1Zd0AepjKWLZaWi6HcO4+YLEqK9UXW0K5oVee1Sgs0oYhLa3IsQdgaB2GxAjLG
         LPlw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=bLsefkG4;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=bLsefkG4;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Message-Id: <20180212125033.448828374@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 12 Feb 2018 13:48:59 +0100
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
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 4/8] objtool: Retpoline validation tweaks
References: <20180212124855.882405399@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-objtool-config.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592199715849356959?=
X-GMAIL-MSGID: =?utf-8?q?1592199715849356959?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Disable retpoline validation if your compiler sucks, and otherwise
select the validation stuff for RETPOLINE (most builds would already
have it set due to ORC).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Makefile               |    5 +++++
 arch/x86/Kconfig       |    1 +
 scripts/Makefile.build |    2 ++
 3 files changed, 8 insertions(+)

--- a/Makefile
+++ b/Makefile
@@ -486,6 +486,11 @@ KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG
 KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
 endif
 
+ifneq ($(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register),)
+  CC_HAS_RETPOLINE := 1
+endif
+export CC_HAS_RETPOLINE
+
 ifeq ($(config-targets),1)
 # ===========================================================================
 # *config targets only - make sure prerequisites are updated, and descend
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -432,6 +432,7 @@ config GOLDFISH
 config RETPOLINE
 	bool "Avoid speculative indirect branches in kernel"
 	default y
+	select STACK_VALIDATION
 	help
 	  Compile kernel with the retpoline compiler options to guard against
 	  kernel-to-user data leaks by avoiding speculative indirect
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -267,8 +267,10 @@ else
 objtool_args += $(call cc-ifversion, -lt, 0405, --no-unreachable)
 endif
 ifdef CONFIG_RETPOLINE
+ifdef CC_HAS_RETPOLINE
   objtool_args += --retpoline
 endif
+endif
 
 
 ifdef CONFIG_MODVERSIONS
