Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvsSPRGFIemgcfprpKGAftVR7LkA7UwrzjHy8rjxg1CxIg1mAsNRaqAtjnrixal2iA+23v0
ARC-Seal: i=1; a=rsa-sha256; t=1520824073; cv=none;
        d=google.com; s=arc-20160816;
        b=VxepXWch3yzvUcTObRr5ezbl22p+8N4InKQ3yAqS7mghcL3YjZONYd4BXxCOEHcDXI
         JvnnHavA54qGbPlPssVJ/FcJV9/z/bgkCnQwfYG77aEXusELHXzTg9fMw2SsGshV24Ji
         B39Ky7PWd6AhscdnHD2idWIecDyfuIc9iyb19aeT2PPwnPsOJGugpTYwJ0PZcOzyZKSe
         ZxgEICsS5nDRqIRN+c7bxwwEUILiOPJbgY3AXBX3FLHrQzdw9PhY8xMOEU/v+msTWgF/
         mVH0R3s98yarHmoVlGCKcjLTd+OARGoSPdPHZFwipciC+r7ISfRxJYed3juLEa1NboM3
         NhJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=IbmckErkBiNIbKL7spTbyvJjQtxgGAsC65GvrUK/x9M=;
        b=NW7dbbWQiv5GKgm4DI9yIcWK8OWWdqyMv0f2eNv3PyRnpJEfqKgbmqSUCDqr4Ds2kB
         Ig9vrPei9xT0KMqZEr39Iq+nxB+BIxdsZPdelTmQmMwg5b1jRwPGMrHHIEMiZ3ozcKlN
         Zz1xRc31hZip+I7F/ns/7FT6c1FX0GOPEf2EE/L7tOSdS9fMDwcDL7cfm5dtFz8+n/fH
         Oz+X+d+ICVKNHF+/aYRmNLlRtKUuv1p5LVGM7wtbRowgz51NZJgRcEo8NW8SnIjrVCyo
         L6ckcrC/vhiXaFbrXpB8xVIESxv3emuPXKbooTpRP7VwVVvZ06hnLTOmOxdhDpJ1cJAM
         I//g==
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
 "Dave Hansen" <dave.hansen@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Jiri Kosina" <jikos@kernel.org>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Andy Lutomirski" <luto@amacapital.net>,
 "Kees Cook" <keescook@google.com>,
 thomas.lendacky@amd.com,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 gnomes@lxorguk.ukuu.org.uk,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Rik van Riel" <riel@redhat.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.936669399@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 067/104] x86/retpoline: Remove compile time warning
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699622880623785?=
X-GMAIL-MSGID: =?utf-8?q?1594699622880623785?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit b8b9ce4b5aec8de9e23cabb0a26b78641f9ab1d6 upstream.

Remove the compile time warning when CONFIG_RETPOLINE=y and the compiler
does not have retpoline support. Linus rationale for this is:

  It's wrong because it will just make people turn off RETPOLINE, and the
  asm updates - and return stack clearing - that are independent of the
  compiler are likely the most important parts because they are likely the
  ones easiest to target.

  And it's annoying because most people won't be able to do anything about
  it. The number of people building their own compiler? Very small. So if
  their distro hasn't got a compiler yet (and pretty much nobody does), the
  warning is just annoying crap.

  It is already properly reported as part of the sysfs interface. The
  compile-time warning only encourages bad things.

Fixes: 76b043848fd2 ("x86/retpoline: Add initial retpoline support")
Requested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: Rik van Riel <riel@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: thomas.lendacky@amd.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kees Cook <keescook@google.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Link: https://lkml.kernel.org/r/CA+55aFzWgquv4i6Mab6bASqYXg3ErV3XDFEYf=GEcCDQg5uAtw@mail.gmail.com
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/Makefile | 2 --
 1 file changed, 2 deletions(-)

--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -122,8 +122,6 @@ ifdef CONFIG_RETPOLINE
     RETPOLINE_CFLAGS += $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
     ifneq ($(RETPOLINE_CFLAGS),)
         KBUILD_CFLAGS += $(RETPOLINE_CFLAGS) -DRETPOLINE
-    else
-        $(warning CONFIG_RETPOLINE=y, but not supported by the compiler. Toolchain update recommended.)
     endif
 endif
 
