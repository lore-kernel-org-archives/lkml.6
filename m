Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AIpwx4+Re0h911xzM6eUPq+9F/uBVKsLCFd+3/vjUBoKxHLs0PyOSkWBehm5hhFHatVMJKYzBhzN
ARC-Seal: i=1; a=rsa-sha256; t=1523999803; cv=none;
        d=google.com; s=arc-20160816;
        b=KRt9Zh+7DGH2zTJCCh4kFFjZALus+qVo1GdWRuNcItD/eETGz7/GZKH/5DWiKaUDmu
         Pn6iEigrUQqiCkufJLJjI4acRVVta1hTLMoUxYFVsUKWOXFqp+O6sNnHxTmOIomCkhp1
         GcKaV3IAIPlQlWqFRY62houYEYAcbU3gKRY4/KrovHpTp5KbOqBQaYgvG3u4kOM1aXzT
         1vdZLaDVi1IV2f2ZFWQ6FimRDFCuVGU+sOzNQOoQllmYP9q5JrA2kowHZ80P6Q3QrS7o
         agRwX/5wzu9O2dnWveyuSDqN7n/OYiBpzjUyxEZcckTuBOFQyUzaP+xi1Hr1z0HXaUN0
         3WFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:from:cc:to:subject:arc-authentication-results;
        bh=eYtIb8pn51KryZ976App67e1S8flkH3zr63SlTSZeq4=;
        b=AHKR63A5m46FyEbCZgGbHuUmI8TAcrvP/RZKL7SboKbtC970qUvwKQV9PVQn5EbQ0e
         gPDA60VYYckNXF+2w58fu2Pbjh8n6GreNRdA5feTIzJWsyGzmi/mmDFKThERm3enIoqQ
         2WDkGEdFnDHMGLxeuxxpTEEPuXLst/eD48FzDGOtcoxiO74vVhNRpOxABvGXz6MSs7kx
         kZ2bBonDe63z6cq/pbOD+VSFPsbULeGMJry/PxKrnbGu/2OtKXKB38t0iOAzE77cF37O
         bwQhYOuqOn0gQOFBfesf+pl8dBLiuc2+7Yo8Rll35FDVgrTOH2TLB42cGs8MqhzZLVtm
         3e4g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,464,1517904000";
   d="scan'208";a="35019219"
Subject: [PATCH 1/2] x86, pti: fix boot problems from Global-bit setting
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,Dave Hansen <dave.hansen@linux.intel.com>,mceier@gmail.com,aaro.koskinen@nokia.com,aarcange@redhat.com,luto@kernel.org,arjan@linux.intel.com,bp@alien8.de,dan.j.williams@intel.com,dwmw2@infradead.org,gregkh@linuxfoundation.org,hughd@google.com,jpoimboe@redhat.com,jgross@suse.com,keescook@google.com,torvalds@linux-foundation.org,namit@vmware.com,peterz@infradead.org,tglx@linutronix.de
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Tue, 17 Apr 2018 14:13:02 -0700
Message-Id: <20180417211302.421F6442@viggo.jf.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598029618240044266?=
X-GMAIL-MSGID: =?utf-8?q?1598029618240044266?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


These are _very_ lightly tested.  I'm throwing them out there for
folks are looking for a fix.

---

From: Dave Hansen <dave.hansen@linux.intel.com>

Part of the global bit _setting_ patches also includes clearing the
Global bit when we do not want it.  That is done with
set_memory_nonglobal(), which uses change_page_attr_clear() in
pageattr.c under the covers.  However, it's pretty clear that
change_page_attr_clear() has not been heavily used early in boot, or
on kernel text.

It has checks like BUG_ON(irqs_disabled()), looking for interrupt
disabling but that also trip in early boot on certain preempt
configurations.  Just copy the existing BUG_ON() sequence to check for
early boot.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Fixes: 39114b7a7 (x86/pti: Never implicitly clear _PAGE_GLOBAL for kernel image)
Reported-by: Mariusz Ceier <mceier@gmail.com>
Reported-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
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

 b/arch/x86/mm/pageattr.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/x86/mm/pageattr.c~pti-glb-boot-problem-fix arch/x86/mm/pageattr.c
--- a/arch/x86/mm/pageattr.c~pti-glb-boot-problem-fix	2018-04-17 14:10:13.553395577 -0700
+++ b/arch/x86/mm/pageattr.c	2018-04-17 14:10:13.559395577 -0700
@@ -172,7 +172,7 @@ static void __cpa_flush_all(void *arg)
 
 static void cpa_flush_all(unsigned long cache)
 {
-	BUG_ON(irqs_disabled());
+	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 
 	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
 }
@@ -236,7 +236,7 @@ static void cpa_flush_array(unsigned lon
 	unsigned long do_wbinvd = cache && numpages >= 1024; /* 4M threshold */
 #endif
 
-	BUG_ON(irqs_disabled());
+	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 
 	on_each_cpu(__cpa_flush_all, (void *) do_wbinvd, 1);
 
_
