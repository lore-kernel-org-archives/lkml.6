Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2252UXqKEAGarF1e4d1LHF6OVg7HC1u20yU9ElwaMl6BpC+XqTpGL/lpWdLneSKncVXTv52x
ARC-Seal: i=1; a=rsa-sha256; t=1517855067; cv=none;
        d=google.com; s=arc-20160816;
        b=vqTJhZkYehd+0GK6KGoqVIfkdhIiH57BUY5lDrLjTRDIQCrHCyfpsPM3VnDpgJYcsu
         J4AVuzu011dv/Fap5wJblBOjOYz573HwCwhLGPKBDwZHSRidw9CAbZiyvISt5P2fxQEd
         ffJDhoJVspxrVDnG5ajswqE/y2+snuOl+kzmmV/KWuv9zy8FpNfYTSSWZqEykiFCsCt9
         P8dWQ+mA5sG6SnBKwTp/bdZvlRVggZWuPN2QYbHDfwTWRK13pPSYXgaK1GtYta+dbPV6
         XrrRV5RT8HYWdq7wFdH5NfDQSuxS+ixRia6sNLIF+nocHgvjvnrS6ZlIrsfjsJUha8N+
         TZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5LFrGL3hViVR6YbViR/Td5evOcFa4raCNbnrNG8QQjM=;
        b=YV1wwU54mgkmAv9tCmCqB3zf6CtfRUOohSqISHbURc8vOnRLHUidDX34OemNTpjDnl
         8MxwREz5PAr32ezd/A0f4GsoyGnqzFjZS4bbKylRZn7kuygNcXhZyuantfNKqvIO4Wj2
         +m+WXUfTQSXiNN3GT7EAJWCQA54qwVxhd5sJTV99t17JJ33McPTnTu9uFl8bc82vW1zW
         6s9SWAhC2n1URiifZk4Z7FcAmqdKyyg3fJ/B6c3nqzBTA1/21xeN8MxpntfXC4wJV+Ss
         qlI/2q+J59uSLaWCvPJq2wNAFZHXfZWeBL3wicceoshpwzQHfcOXjFMrkVi9b918rs2A
         JviQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andi Kleen <ak@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Dave Hansen <dave.hansen@intel.com>,
	Asit Mallick <asit.k.mallick@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jason Baron <jbaron@akamai.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alok Kataria <akataria@vmware.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.14 51/64] x86/paravirt: Remove noreplace-paravirt cmdline option
Date: Mon,  5 Feb 2018 10:23:10 -0800
Message-Id: <20180205182140.667697807@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586394392397468?=
X-GMAIL-MSGID: =?utf-8?q?1591586394392397468?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf jpoimboe@redhat.com

commit 12c69f1e94c89d40696e83804dd2f0965b5250cd

The 'noreplace-paravirt' option disables paravirt patching, leaving the
original pv indirect calls in place.

That's highly incompatible with retpolines, unless we want to uglify
paravirt even further and convert the paravirt calls to retpolines.

As far as I can tell, the option doesn't seem to be useful for much
other than introducing surprising corner cases and making the kernel
vulnerable to Spectre v2.  It was probably a debug option from the early
paravirt days.  So just remove it.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Jun Nakajima <jun.nakajima@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alok Kataria <akataria@vmware.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Link: https://lkml.kernel.org/r/20180131041333.2x6blhxirc2kclrq@treble
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 Documentation/admin-guide/kernel-parameters.txt |    2 --
 arch/x86/kernel/alternative.c                   |   14 --------------
 2 files changed, 16 deletions(-)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2718,8 +2718,6 @@
 	norandmaps	Don't use address space randomization.  Equivalent to
 			echo 0 > /proc/sys/kernel/randomize_va_space
 
-	noreplace-paravirt	[X86,IA-64,PV_OPS] Don't patch paravirt_ops
-
 	noreplace-smp	[X86-32,SMP] Don't replace SMP instructions
 			with UP alternatives
 
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -46,17 +46,6 @@ static int __init setup_noreplace_smp(ch
 }
 __setup("noreplace-smp", setup_noreplace_smp);
 
-#ifdef CONFIG_PARAVIRT
-static int __initdata_or_module noreplace_paravirt = 0;
-
-static int __init setup_noreplace_paravirt(char *str)
-{
-	noreplace_paravirt = 1;
-	return 1;
-}
-__setup("noreplace-paravirt", setup_noreplace_paravirt);
-#endif
-
 #define DPRINTK(fmt, args...)						\
 do {									\
 	if (debug_alternative)						\
@@ -599,9 +588,6 @@ void __init_or_module apply_paravirt(str
 	struct paravirt_patch_site *p;
 	char insnbuf[MAX_PATCH_LEN];
 
-	if (noreplace_paravirt)
-		return;
-
 	for (p = start; p < end; p++) {
 		unsigned int used;
 
