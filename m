Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvsbB8IPEkR5DacIS1b2eoWUzdqmt7m+Lbohl3iajD1fY6vwOlSrafX2jsIwInPNeQVaQ2B
ARC-Seal: i=1; a=rsa-sha256; t=1521484047; cv=none;
        d=google.com; s=arc-20160816;
        b=EuT/5Ln3c7kUiNGFk4Yu2faiOvVDYF1s6f8/B1Fo1o/36joG+BHrj9bVXJx0aL0rfx
         6tUxEnAu9flk5RMMyR/GelRigZeVDH11AeKjiqJQKXztcYZh7UOcOQmaTQ3n/rXuvzhK
         8dKizCET17sOwGkLfa0H0kcTs6lrpTQMxYhankPlUAQArj5ffyOP7OkmjRF6c+5jGD5k
         ETUq1zSbLppElTbtbIGrP8ScHjFehUnd1oa4+a6pC3HDJGV2jCISKbH9DcgCh2d61QLD
         n//X3Ptk/7mxRAF+GX82tjRuphaS3R0RD0cxS/SrfkvfzK+SkfHhiXNXqAYRXb0emrqR
         TcXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AJlPsMAJRw1/CieF88d9OCESA4hO7uxNeCaOWz81zw8=;
        b=qqZVgCteJCDsarpn1s6W70TuEmLTxa+JRMwek8ADCuirkJtCwl6O8AUI18iPPUVy1v
         9w2yYmlGTImlrlGgS9Chv/LHk3sjwk4xa8t5ZeSe1OzxPNW3Y0cSxMschMbSOdXomnFU
         xvlFHFQqxwnOEMda5Y1ZuHslxZ8qn3+tRmCG4gS8smyEsmzMsOwXEh6iwVG0Yo7F0kIp
         3ogTs0WyKZG+OVMQr9W9OsbHionx2NifHnatJyileFxC58J5QyO3DFDBrj5AU6k2G/d5
         v3l/3A8yFWV+5VI2W63bIPA8aQ+8zKJ1dbUf6zPnQ2wDlxLKsBjEcnk6Mb0K2dBNjalh
         bTsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Andy Lutomirski <luto@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matt Fleming <matt@codeblueprint.co.uk>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Garnier <thgarnie@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-efi@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 211/241] x86/boot/32: Fix UP boot on Quark and possibly other platforms
Date: Mon, 19 Mar 2018 19:07:56 +0100
Message-Id: <20180319180759.909708500@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391656837516289?=
X-GMAIL-MSGID: =?utf-8?q?1595391656837516289?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit d2b6dc61a8dd3c429609b993778cb54e75a5c5f0 upstream.

This partially reverts commit:

  23b2a4ddebdd17f ("x86/boot/32: Defer resyncing initial_page_table until per-cpu is set up")

That commit had one definite bug and one potential bug.  The
definite bug is that setup_per_cpu_areas() uses a differnet generic
implementation on UP kernels, so initial_page_table never got
resynced.  This was fine for access to percpu data (it's in the
identity map on UP), but it breaks other users of
initial_page_table.  The potential bug is that helpers like
efi_init() would be called before the tables were synced.

Avoid both problems by just syncing the page tables in setup_arch()
*and* setup_per_cpu_areas().

Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Garnier <thgarnie@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/setup.c        |   15 +++++++++++++++
 arch/x86/kernel/setup_percpu.c |   10 +++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1200,6 +1200,21 @@ void __init setup_arch(char **cmdline_p)
 
 	kasan_init();
 
+#ifdef CONFIG_X86_32
+	/* sync back kernel address range */
+	clone_pgd_range(initial_page_table + KERNEL_PGD_BOUNDARY,
+			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
+			KERNEL_PGD_PTRS);
+
+	/*
+	 * sync back low identity map too.  It is used for example
+	 * in the 32-bit EFI stub.
+	 */
+	clone_pgd_range(initial_page_table,
+			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
+			min(KERNEL_PGD_PTRS, KERNEL_PGD_BOUNDARY));
+#endif
+
 	tboot_probe();
 
 	map_vsyscall();
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -290,11 +290,11 @@ void __init setup_per_cpu_areas(void)
 
 #ifdef CONFIG_X86_32
 	/*
-	 * Sync back kernel address range.  We want to make sure that
-	 * all kernel mappings, including percpu mappings, are available
-	 * in the smpboot asm.  We can't reliably pick up percpu
-	 * mappings using vmalloc_fault(), because exception dispatch
-	 * needs percpu data.
+	 * Sync back kernel address range again.  We already did this in
+	 * setup_arch(), but percpu data also needs to be available in
+	 * the smpboot asm.  We can't reliably pick up percpu mappings
+	 * using vmalloc_fault(), because exception dispatch needs
+	 * percpu data.
 	 */
 	clone_pgd_range(initial_page_table + KERNEL_PGD_BOUNDARY,
 			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
