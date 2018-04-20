Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AIpwx48ZnA4vGNLp9AllCjQB3BvCV4+mGYGXxDvsXKoCWzha7cmad0AVbsD6xetsi/ZQLw8D4cg8
ARC-Seal: i=1; a=rsa-sha256; t=1524263056; cv=none;
        d=google.com; s=arc-20160816;
        b=kDrfuIj5e3RAlwJfTigKyLRu6e1EVVFgdY60HbckcJi6/P/pgNeTmpzfUNL4fdDu0M
         KKWvCJtZro8QGJ58MlYzPL6tMiDVjJc1ODb2ppYYjNGya/CtP2RMR524ZYtnwvzcLj/O
         XZ2SuBI7nK3GxX6NX+0VbEQyUnDD2nsG16GbxUwRA3k1PSGh9NA929PJfodSS2rWkq9i
         yfwIj+6Dg2MRz+FAcTG3fhkf3xT7JQ18BEL0RU2zdU18oVKHiY19Vm3FPpQOLecZTpvM
         brqwikFVkvBnWt55EgMPI2EimU6v/RUR0nHr9bPkHoBwxMkLevtMNIRMvNPpP8iEFZpB
         Lofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:in-reply-to:references:date:from:cc:to:subject
         :arc-authentication-results;
        bh=cRwneappTf1zk/B3gJ8PFeXKVIOJ37EW016nXcF7XN8=;
        b=aPU5XYx8bLIcYRdZgpKid3FE6xM7RRwljObANMlTRiTALExy1bB8qNzA9+z0VW+IJZ
         Yc95vJUet+RZolIsT7SOah95fv2luB+qJ+zYFjg2f7HXOUe4XxjiJ0Ym4CMdiuJtTs/n
         YPH1ZQeTxQTlft6fS4pVQuixXjS2DPTT6nYX7z6DcVP/lQd1BylIkhCWjhrY7+ByZ/18
         AHfqGhBYCsCjYiSIG1KPBt4AEDOvTm1n40cQhR3+mW1t22u0io4oUmbLT+2DgM5Fh8pv
         +IwCx5f56vRWV5vwv9CuppzZnIFgtuJxt9+7rvKY/RE0NDwaetUjdRnPdoZcs8s29dt8
         BfsA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,303,1520924400";
   d="scan'208";a="39172346"
Subject: [PATCH 3/5] x86, pti: reduce amount of kernel text allowed to be Global
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,Dave Hansen <dave.hansen@linux.intel.com>,keescook@google.com,aarcange@redhat.com,luto@kernel.org,arjan@linux.intel.com,bp@alien8.de,dan.j.williams@intel.com,dwmw2@infradead.org,gregkh@linuxfoundation.org,hughd@google.com,jpoimboe@redhat.com,jgross@suse.com,torvalds@linux-foundation.org,namit@vmware.com,peterz@infradead.org,tglx@linutronix.de
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 20 Apr 2018 15:20:23 -0700
References: <20180420222018.E7646EE1@viggo.jf.intel.com>
In-Reply-To: <20180420222018.E7646EE1@viggo.jf.intel.com>
Message-Id: <20180420222023.1C8B2B20@viggo.jf.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598305659134036697?=
X-GMAIL-MSGID: =?utf-8?q?1598305659134036697?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Kees reported to me that I made too much of the kernel image global.
It was far more than just text:

	I think this is too much set global: _end is after data,
	bss, and brk, and all kinds of other stuff that could
	hold secrets. I think this should match what
	mark_rodata_ro() is doing.

This does exactly that.  We use __end_rodata_hpage_align as our
marker both because it is huge-page-aligned and it does not contain
any sections we expect to hold secrets.

Kees's logic was that r/o data is in the kernel image anyway and,
in the case of traditional distributions, can be freely downloaded
from the web, so there's no reason to hide it.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reported-by: Kees Cook <keescook@google.com>
Fixes: 8c06c7740 (x86/pti: Leave kernel text global for !PCID)
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

 b/arch/x86/mm/pti.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff -puN arch/x86/mm/pti.c~pti-glb-too-much-mapped arch/x86/mm/pti.c
--- a/arch/x86/mm/pti.c~pti-glb-too-much-mapped	2018-04-20 14:10:02.164749166 -0700
+++ b/arch/x86/mm/pti.c	2018-04-20 14:10:02.168749166 -0700
@@ -430,12 +430,24 @@ static inline bool pti_kernel_image_glob
  */
 void pti_clone_kernel_text(void)
 {
+	/*
+	 * rodata is part of the kernel image and is normally
+	 * readable on the filesystem or on the web.  But, do not
+	 * clone the areas past rodata, they might contain secrets.
+	 */
 	unsigned long start = PFN_ALIGN(_text);
-	unsigned long end = ALIGN((unsigned long)_end, PMD_PAGE_SIZE);
+	unsigned long end = (unsigned long)__end_rodata_hpage_align;
 
 	if (!pti_kernel_image_global_ok())
 		return;
 
+	pr_debug("mapping partial kernel image into user address space\n");
+
+	/*
+	 * Note that this will undo _some_ of the work that
+	 * pti_set_kernel_image_nonglobal() did to clear the
+	 * global bit.
+	 */
 	pti_clone_pmds(start, end, _PAGE_RW);
 }
 
@@ -458,8 +470,6 @@ void pti_set_kernel_image_nonglobal(void
 	if (pti_kernel_image_global_ok())
 		return;
 
-	pr_debug("set kernel image non-global\n");
-
 	set_memory_nonglobal(start, (end - start) >> PAGE_SHIFT);
 }
 
_
