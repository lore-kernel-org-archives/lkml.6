Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AIpwx4/UKFASPWoUgkbWDa8SNWp6+csm9P/HJ1DACABLjiLodYZ+D9anq3GSCq/aHZdc7ygakgzT
ARC-Seal: i=1; a=rsa-sha256; t=1523391204; cv=none;
        d=google.com; s=arc-20160816;
        b=yi2ExqYMk4KTs+TLW1GygLKIbG80chhTVYP52vY2v8SjR0wMyrq9E0MQ8rfBgr4vTR
         GjOvEs6uUHooA06Z+VJnXcC2eOr2ReTwA6Qd4mfcPnDKUWicGtpPBwkLe381XM+Cu6en
         anV+yidRg45uAjjSQ5vKh2Cba6Htul+NhP3N/JIvA2ycDc1/2/pSJ/vwqLSrBWH5Dyy6
         AEjROjvhZ4lGOstmZIOnX/bXTm3LWhb6YoROh8p9MAkeGhhD6ovvqDonojeLdKMW7rep
         +94I68teChxBvHu0ttspg4Tv56bfEu2qSvRfdEsN9gRNkfOOtsxdM/SLiHVy2dEVmTH6
         IUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:from:cc:to:subject:arc-authentication-results;
        bh=UB96DoK7XzVERBGQh3EPR/JVTN1i42EgnPkZRY6CclA=;
        b=OtMTa296aU3KASI/JbL3KqiueU89Dv1wzMx9Zml9kSB2fOWhu6E808nwhgDIstBeOD
         nmpD4r3E5taOuDwff1zwoXBpgODnP3BlYoeVXWn3yx0ditcbEGRf3cg4nuyGKsEQG4oF
         dR4/8LrcrkoFvutoV5HbeOBRsFuNMpsEmDFfbnc88+kWXu/foqP7Mwc8xFmGc1SmR177
         n/DXE/6Mk4yke5MC+8SELJwd7mCeV7utFB9bAYPWgvn5NIGZgJuGM4fkdBPNdIn5jEY3
         lKYGpS+KoWHBMekqDDPVG4xFZoG2f9v1lEYielIfoOhAjSThJyJPVS8LRfOytEq5t5W/
         /62A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,433,1517904000";
   d="scan'208";a="45838632"
Subject: [PATCH] x86, boot: initialize __default_kernel_pte_mask in KASLR code
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,thomas.lendacky@amd.com,efault@gmx.de,luto@kernel.org,arjan@linux.intel.com,bp@alien8.de,dan.j.williams@intel.com,dwmw2@infradead.org,gregkh@linuxfoundation.org,hughd@google.com,jpoimboe@redhat.com,jgross@suse.com,keescook@google.com,torvalds@linux-foundation.org,namit@vmware.com,peterz@infradead.org,tglx@linutronix.de,linux-mm@kvack.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Tue, 10 Apr 2018 13:10:11 -0700
Message-Id: <20180410201011.F823E22B@viggo.jf.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597391456307737450?=
X-GMAIL-MSGID: =?utf-8?q?1597391456307737450?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


The somewhat discrete arch/x86/boot/compressed code shares headers with
the main kernel, but needs its own copies of some variables.  The copy
of __default_kernel_pte_mask did not get initialized correctly and has
been reported to cause boot failures when KASLR is in use by Tom
Lendacky and Mike Galibrath.

I've oddly been unable to reproduce these, but the fix is simple and
confirmed to work by Tom and Mike.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Fixes: 64c80759408f ("x86/mm: Do not auto-massage page protections")
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
---

 b/arch/x86/boot/compressed/kaslr.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/x86/boot/compressed/kaslr.c~x86-boot-initialize-__default_kernel_pte_mask arch/x86/boot/compressed/kaslr.c
--- a/arch/x86/boot/compressed/kaslr.c~x86-boot-initialize-__default_kernel_pte_mask	2018-04-10 13:02:22.359914088 -0700
+++ b/arch/x86/boot/compressed/kaslr.c	2018-04-10 13:02:40.389914043 -0700
@@ -54,8 +54,8 @@ unsigned int ptrs_per_p4d __ro_after_ini
 
 extern unsigned long get_cmd_line_ptr(void);
 
-/* Used by PAGE_KERN* macros: */
-pteval_t __default_kernel_pte_mask __read_mostly;
+/* Used by PAGE_KERN* macros, do not mask off any bits by default: */
+pteval_t __default_kernel_pte_mask __read_mostly = ~0;
 
 /* Simplified build-specific string for starting entropy. */
 static const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
_
