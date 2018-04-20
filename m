Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AIpwx4+HVA6B1+HwwT8Axuaq/uk1oiZf1Y2D79DvQVImlPQGa4l9ZXtDB6X/g4QRXahexvdEwsCl
ARC-Seal: i=1; a=rsa-sha256; t=1524263052; cv=none;
        d=google.com; s=arc-20160816;
        b=eGQ85iS6x/vTFa8UwANUkXGVsU1tpQJLoKz6VpEapF/3+g4Al673qFb3yNKNEznGmU
         7ilbAntITucrj2Ts0krBjVI38xgDXqXl+5v1m6Ht90Z1hLYDIjlrh+Z5yyyN+mJuashT
         AQrOee93YebX9p+Xf5w4KwOPwTgkq46ItFI5XcfNJIPqhBrQnZiCy9zdookLxCrKREfb
         FRVenKTrsC9Xsr5JKvbgXrCmTGc/QCjjiJGY/HriRy5TsGrSPAjKWcFKF8XCcVPPHpDR
         GLPNZl0/pAK2ap3jVBbla8NySKRtHxen4lDwjntfCRv+k9NnfArhDrq3nv0zphupWwwV
         7r9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:in-reply-to:references:date:from:cc:to:subject
         :arc-authentication-results;
        bh=nr+8jwQga9j8iSg/qVaZrRV7bX7fcfNgoGBvn0UDfu8=;
        b=i5Fm7AjBx4IlTFYYoXTqs2sCVxjKhMcKKZPEXrbKlEmpLaXT0kRBnTMJMHaSn6rT79
         HoBbLrNVp7yRRWoxG5JlLGk9v7H3u51xYMyzrdcRcBd5NSkZ5+ljG1VQj7GsUakpqVuR
         9unXR6BUWmjX95OctPXtEHJ80E1NjTS7Z4NO8l8zM5HCOB1vgAj4zR3yTlUx94TMXyDx
         yayykq8/tkj2zPicn8xZ7DKH/Z0XaQCD2aXtIgov+sHutq48DHA6dVDGeFwF26sOpssk
         4+5df8+Fy97j6XIcZcDlS1jQx7wvZQcB4LJHAqNYnkUuuMY5Iy85e8SDcOOGfYWJx3Rz
         zYfw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,303,1520924400";
   d="scan'208";a="193162638"
Subject: [PATCH 1/5] x86, pti: fix boot problems from Global-bit setting
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,Dave Hansen <dave.hansen@linux.intel.com>,mceier@gmail.com,aaro.koskinen@nokia.com,aarcange@redhat.com,luto@kernel.org,arjan@linux.intel.com,bp@alien8.de,dan.j.williams@intel.com,dwmw2@infradead.org,gregkh@linuxfoundation.org,hughd@google.com,jpoimboe@redhat.com,jgross@suse.com,keescook@google.com,torvalds@linux-foundation.org,namit@vmware.com,peterz@infradead.org,tglx@linutronix.de
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 20 Apr 2018 15:20:19 -0700
References: <20180420222018.E7646EE1@viggo.jf.intel.com>
In-Reply-To: <20180420222018.E7646EE1@viggo.jf.intel.com>
Message-Id: <20180420222019.20C4A410@viggo.jf.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598305654028969695?=
X-GMAIL-MSGID: =?utf-8?q?1598305654028969695?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Part of the global bit _setting_ patches also includes clearing the
Global bit when we do not want it.  That is done with
set_memory_nonglobal(), which uses change_page_attr_clear() in
pageattr.c under the covers.

The TLB flushing code inside pageattr.c has has checks like
BUG_ON(irqs_disabled()), looking for interrupt disabling that might
cause deadlocks.  But, these also trip in early boot on certain
preempt configurations.  Just copy the existing BUG_ON() sequence from
cpa_flush_range() to the other two sites and check for early boot.

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
--- a/arch/x86/mm/pageattr.c~pti-glb-boot-problem-fix	2018-04-20 14:10:01.086749169 -0700
+++ b/arch/x86/mm/pageattr.c	2018-04-20 14:10:01.090749169 -0700
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
