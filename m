Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x22439rMAVvuKe08atVvZjg6dcBEhNQ2Oe9/xlLArp5E0E5Wus78xaNhz2JGD6vFDcZC+xhrG
ARC-Seal: i=1; a=rsa-sha256; t=1517513813; cv=none;
        d=google.com; s=arc-20160816;
        b=G/VKmjYCrAvlBpTyDgtgPagLpNnL8jMhLauqEtVz0Ama1mRyMB23fnAQokBZs+RXIV
         xGwRL3ZrmmOOnDJebEf8mv8okE2msPlmgNsTJ8doqe9bVKNohuoWrDoNtKgHmN9qci7h
         V4KgPH93VVbm9zz3GEaukoPB/WAlObZdUG75Pr+5cktCKwQDzSBWpmuPUArhfZ6Vgte3
         RcxsqF8RmiNgVj3Ydh7OnvlXpkUTVLD2+kaQzhy89w7ucvj1irN87J7twCjaBQ7GkxkL
         +nG0OuNP1hlciuVbJGi1KeGwrEZF/VI8XKaSqKeZHGUUSrLU8HBP6BXr4C2Iy4koQ8MT
         pYhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=GtmKN+KOJTnfRLVl81LDXTg/Mdla3OhSKq8WLfrQqe0=;
        b=cdhuUGS//4xQm/squIunSkAVdINmTqdNEjWOa/0rqW6XojyoLx/IqJVbrjPQhAMlff
         3nvEgTVMPwGpuBz+gWamdbno50hGwOBEB0lSubTIuSBKXMBL/iISTvxMLpWQma2PPkko
         VsTSWEh0CPRjNc+JSw969zFKkkVrLdJTK+qUjF91cuo4mE2Kn0ZuNTREPQGBRsMm8rRS
         3GYA6s99D+Mo4vFWUClsdZrNn4lPQvAMJgHW1jqvWIIyP4lXlfDHna2EJSaWzjQ/YP6z
         +sOWL/3o2Za8rjIiB0u86H07ZZx2MMGseCv0hun4A1tsbayoK6zoE684W+lqDt5lmJr0
         1nPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=GjhfuqQc;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=GjhfuqQc;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Thu, 1 Feb 2018 20:36:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
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
	Asit Mallick <asit.k.mallick@intel.com>
Subject: Re: [PATCH 0/7] objtool: retpoline validation
Message-ID: <20180201193644.GM2295@hirez.programming.kicks-ass.net>
References: <20180201143421.088202488@infradead.org>
 <20180201152856.okzhqvdlledykzps@treble>
 <20180201153235.GZ2249@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201153235.GZ2249@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591210454988302775?=
X-GMAIL-MSGID: =?utf-8?q?1591228564658165481?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 04:32:35PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 01, 2018 at 09:28:56AM -0600, Josh Poimboeuf wrote:
> > On Thu, Feb 01, 2018 at 03:34:21PM +0100, Peter Zijlstra wrote:
> > > There are the retpoline validation patches; they work with the __noretpoline
> > > thing from David.
> > 
> > Have you run this through 0-day bot yet? 
> 
> Yes, it complains a _lot_ because no retpoline supported compiler.

I think I finally got something that works there... Damn I hate
makefiles..


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
