Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226AWHBrW9v/QNFPa/h+eJfd1Co1/rOZ/uXDqKsusSt3c6fc9OsWeG+Y1sYp21mw2mBOtcXU
ARC-Seal: i=1; a=rsa-sha256; t=1517855036; cv=none;
        d=google.com; s=arc-20160816;
        b=TChwEZfBoaB2TkbJ7ZxY+m85YNpTd95tadc4HCPjFcEOnhsZuZtVgzhY0IZsgeZAM3
         CnM3XtajMlWSVqjDc0HIY0COHElnl9lmaVHDY5U/6ouVQzOPeezHYeLcXCmafBzLGj1q
         CObpzlgNZSxmddV8nknzM88UbPYwB79DSOPKeAH3ZOn8bnus+0P8DDW4u7+KNj9ZwEkF
         Euuz5xsvSqJZ4DJX1lqaetJCdiIJzlSZNhcWeH7wjb4cRgsHsWzEVJJeo4qunUhs1A88
         pG3kJkzAQb9ZsGqyn9PEpE3MU0CbMdX6eikPN+nbZcYGHnTzsDKJ6AVgW+EdWIjOJnLS
         EH7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=s+f0rP4uvCmLGItl42kBI9H46YA7g2CqQMo8ppfWFts=;
        b=dLE7Pt+P8zd49ehXZUZs04Jr+UjJN5q0tqLK6iqBKpUNTRo4xH2q/YSURm7idfZYVu
         rp//nGsSQNonVyvUEd4FVLL8JNYJ92Z1wx+OXAThuESKzR2E3RJLpKnRf5SDX2Z0fz0d
         K+YnoHNT6VglV7g8/qvm8LkFGaI8VgqIlbPaBCattm7NDeY82JLDrrdgo4YzcG7n86O3
         XvJuxsQBG4hfTMpsGzCEfJSIEEItIk2cZIOa2hA8jUrrw4cmwcTCovd/ZZjk24fDjcv1
         9ZtHVWdRnwmR0+qXChM9+UYl+AulMoQ443lOA2fmT4wnZqBgZwcJPVPO8NcaNFuzqyS4
         OMjw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jeff Law <law@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Kees Cook <keescook@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Kosina <jikos@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Paul Turner <pjt@google.com>,
	Greg Kroah-Hartman <gregkh@linux-foundation.org>
Subject: [PATCH 4.14 04/64] x86/retpoline: Remove the esp/rsp thunk
Date: Mon,  5 Feb 2018 10:22:23 -0800
Message-Id: <20180205182138.752985501@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586362326987501?=
X-GMAIL-MSGID: =?utf-8?q?1591586362326987501?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long longman@redhat.com

commit 1df37383a8aeabb9b418698f0bcdffea01f4b1b2

It doesn't make sense to have an indirect call thunk with esp/rsp as
retpoline code won't work correctly with the stack pointer register.
Removing it will help compiler writers to catch error in case such
a thunk call is emitted incorrectly.

Fixes: 76b043848fd2 ("x86/retpoline: Add initial retpoline support")
Suggested-by: Jeff Law <law@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Kees Cook <keescook@google.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Cc: Paul Turner <pjt@google.com>
Link: https://lkml.kernel.org/r/1516658974-27852-1-git-send-email-longman@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/include/asm/asm-prototypes.h |    1 -
 arch/x86/lib/retpoline.S              |    1 -
 2 files changed, 2 deletions(-)

--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -38,5 +38,4 @@ INDIRECT_THUNK(dx)
 INDIRECT_THUNK(si)
 INDIRECT_THUNK(di)
 INDIRECT_THUNK(bp)
-INDIRECT_THUNK(sp)
 #endif /* CONFIG_RETPOLINE */
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -36,7 +36,6 @@ GENERATE_THUNK(_ASM_DX)
 GENERATE_THUNK(_ASM_SI)
 GENERATE_THUNK(_ASM_DI)
 GENERATE_THUNK(_ASM_BP)
-GENERATE_THUNK(_ASM_SP)
 #ifdef CONFIG_64BIT
 GENERATE_THUNK(r8)
 GENERATE_THUNK(r9)
