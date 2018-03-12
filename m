Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELuBLRwulE97y88txRZc6rpPt7pfn1OEuK8wqzPEZ4QefYEDlaE50Qn+Af4H+3C81ALerhtl
ARC-Seal: i=1; a=rsa-sha256; t=1520824102; cv=none;
        d=google.com; s=arc-20160816;
        b=a0IJHLyJfwfEbHOq7GNI4aWEW48SDSLIXkhLfVlGxaIjSFo9PR+WmQnhC16+VffpSQ
         Y9hyXnG+9kvQCvYHFQ/2qvVcTfU7N6VXYkPD/Y1rXf+bQ2mBMzgUHWi3qQSLqbakSnlI
         MBLnxbGzBbFe/tOUW+/bRvF6yJmpVBk9hjBSHvH5x07PXHZYCaVbGQUsEtZxBOZYAOfI
         K+Sc2Ds3oF2ByvXL0mmXNmv95Bv2LM7u2f8KlA9yioiI7q03tQDIfdoYyPx44NXcSNL9
         TUMKDbmNh/KxJVJe9GnLKw6DE2cLa3tx1bs9bvzyicKGymQ78nSZvmxddsq/fF3QcpIV
         2ucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=GEYwXdDxBuK3hJhpxyCGOiX9Av0F6a4cMpGdkr6u0Hg=;
        b=JOe+UHAaKpL4FMp3QI/U5HUsO/QF3BK1PV0giXKmbbH1y2lU3D+MIITGWW6WGTQ3Kn
         IGzSCtu76gUXYMDX6AWBsRpIYA203GSMkJC3gqLqxrxCkLMgQ5zd4v0GN3TcgbnH7fZz
         QPbQEfOj6W7sE2+CehvTsjQi9I9he4bBFyIWVJtyZ8BTY/AeQ1UO/GX2ENCG2bctnVgJ
         Vkq+nsSq9fjW7uW9Gw3LFc8ppENvmRbKAqs5M5Ajp0k2ddYVEdA7Krv4HA1inioYRYf2
         JHJiX5c7qZiBu75iX0ex0rZW0zkzf1y8ePZiNbLe6zmb+1A+sc46Rsdve8KaW2aojr5f
         MJfQ==
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
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Jiri Kosina" <jikos@kernel.org>,
 "Tom Lendacky" <thomas.lendacky@amd.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Paul Turner" <pjt@google.com>,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Kees Cook" <keescook@google.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Jeff Law" <law@redhat.com>,
 "Andy Lutomirski" <luto@amacapital.net>,
 "Waiman Long" <longman@redhat.com>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.402692579@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 43/76] x86/retpoline: Remove the esp/rsp thunk
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699653695967264?=
X-GMAIL-MSGID: =?utf-8?q?1594699653695967264?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long <longman@redhat.com>

commit 1df37383a8aeabb9b418698f0bcdffea01f4b1b2 upstream.

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
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/lib/retpoline-export.c | 1 -
 arch/x86/lib/retpoline.S        | 1 -
 2 files changed, 2 deletions(-)

--- a/arch/x86/lib/retpoline-export.c
+++ b/arch/x86/lib/retpoline-export.c
@@ -21,5 +21,4 @@ INDIRECT_THUNK(dx)
 INDIRECT_THUNK(si)
 INDIRECT_THUNK(di)
 INDIRECT_THUNK(bp)
-INDIRECT_THUNK(sp)
 #endif /* CONFIG_RETPOLINE */
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -35,7 +35,6 @@ GENERATE_THUNK(_ASM_DX)
 GENERATE_THUNK(_ASM_SI)
 GENERATE_THUNK(_ASM_DI)
 GENERATE_THUNK(_ASM_BP)
-GENERATE_THUNK(_ASM_SP)
 #ifdef CONFIG_64BIT
 GENERATE_THUNK(r8)
 GENERATE_THUNK(r9)
