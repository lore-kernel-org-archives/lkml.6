Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvrDDIZjrthmG31tUjl/EB2HMi84TEhFrnd7AkO6zPIJ3BtGK5TRpOe5pDInWHeeof2/9IG
ARC-Seal: i=1; a=rsa-sha256; t=1520824098; cv=none;
        d=google.com; s=arc-20160816;
        b=z41eUph8u8FKZmzoKYIuTOuDTDH4Nlf6n+rYVgDbeoIsd/9Xnskd7joWA8l9zlRaOs
         fP/M7ZnUHidHy0wBiYzSSilRV1vJLicixpRn/6uXbnhqQv7jxH7oo6L7ewOBhAtuZHnT
         6wyNj9Megq9dBwRwuUc8a//yEdYUJcLKhrHwEeLw2DkCBvnV21B4bqUAgdAGPlgvmyol
         XjV6+5a2W3eF4gB0S4iK78HkT3FMpHrnPERT0gHgCkaSKeoM93SI7ajJQzUjOeSeei+Y
         8DBcZWOOFQWcy50rSldW0M/DWx0x0TGPmNcmLpTO9DJ+Hne6aJCsUXQUnEEo6cjp0v/7
         tDVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=9JEyCl2J1xlOliI/wCCUHwX6xMYZaks3LRrxHoTdx+M=;
        b=1KrHSrOzMj8FKcR1CiY6RE1JCWVPdTCDMATiNQJy/JqjrJjK0Nmx5XcWvGJJo/3/16
         oHzDNWo1fQVAzKKQ/1ZG5dR9aF+y/Hq/fsbwX091SmvpRGHF2/Rvq7eSpvHak34b0RDw
         N/NRVp/Cr3iudoal9EAmORBsbF45wPEYXvAb14pVB8j1qDj9toHjMTdipYYVmGJgB2Dt
         B3o9kmfKwPd3ZUecm62CyXYb15spxyvB/2xfgOodMQbZlPbHvwtRm0ew0MiiUM2KFJte
         T8IxMz2WF0Oy0LrgTBGrqR88g4HZXmonS+NiuRGyyA69II0+asgoIMx9jnaLu7s9Wsv7
         XxgQ==
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
 "Andi Kleen" <ak@linux.intel.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 gnomes@lxorguk.ukuu.org.uk,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Andy Lutomirski" <luto@amacapital.net>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Rik van Riel" <riel@redhat.com>,
 "Kees Cook" <keescook@google.com>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Jiri Kosina" <jikos@kernel.org>,
 thomas.lendacky@amd.com
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.526425712@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 33/76] x86/retpoline: Remove compile time warning
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699622880623785?=
X-GMAIL-MSGID: =?utf-8?q?1594699649621804477?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -182,8 +182,6 @@ ifdef CONFIG_RETPOLINE
     RETPOLINE_CFLAGS += $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
     ifneq ($(RETPOLINE_CFLAGS),)
         KBUILD_CFLAGS += $(RETPOLINE_CFLAGS) -DRETPOLINE
-    else
-        $(warning CONFIG_RETPOLINE=y, but not supported by the compiler. Toolchain update recommended.)
     endif
 endif
 
