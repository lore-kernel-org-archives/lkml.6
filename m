Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELuV5pq3CpquxE95K/y10bPksOJdFIfj96APluyKm5raSkXzE8I6VIW5tvIDzk/YwrXcuGAm
ARC-Seal: i=1; a=rsa-sha256; t=1520824071; cv=none;
        d=google.com; s=arc-20160816;
        b=c1bDeFY33LWa/nYXDQ6Lp8a9bUyG6LPhWgNf33sHHOUgZcTXMgI++SxvYOt+E6t+BK
         DTmPwhfsS8CxIg34l2NTnu7xjp7rjE9Xv8nGtojbED7nX6j3k0TMRfC26A3diyO9HovE
         SjmjiSbEkZpGXbyrh2aLgR3cItJQquCEW7pgtjQQdZJxvaPfnMA32RcD/Vndl34Hxzho
         0Wy/wA0ZytcSJKF2/go7zisUciHtw2+MDybOij+8+s9iYQpxqj5eX9nmeg+M4Ws/cZnt
         g633P64FiIGoKcy4tv8Q9I9N6/0voAKB0n27Z1QXXYXBLSK/NpYw0Suux2W9aN0GSArl
         1HfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=RI+YyaC9qrOFVH98jegAbkYTH4P6teHu31M5eAcmn5M=;
        b=qWOBEMIllGkWE376jhm/ce/dn4Nspn02YqXBFYoRwR5c92ffBrckHVWIXt7VIav7g8
         cNxT56onBTce3RIOJFoAg1DzVcaeXSSmLai0G5Rcfpnp4wsKyYb2ANWUUhKsflcwJJ8L
         F4pQ66XG9ipy3/3J7yaGULcZ6HZgw3kpg52AWflMx7ocvbnOwJSScH2xwAm2X7QL4DTF
         gjFlvIXPVpFHsxTsOcFflLowvIEGa6dB9lqlpe3AE9CxllsUbySeA9DoWW4ehM3AgtNo
         tnCPMFRaJEOSBQesa7AWnEjgKImwach6cbYOqvax0cOMAZ4s+dKBW58faEeGP0Sib+d+
         erUg==
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
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Ashok Raj" <ashok.raj@intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Jun Nakajima" <jun.nakajima@intel.com>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Arjan Van De Ven" <arjan.van.de.ven@intel.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Greg KH" <gregkh@linuxfoundation.org>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Andrea Arcangeli" <aarcange@redhat.com>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Jason Baron" <jbaron@akamai.com>,
 "Juergen Gross" <jgross@suse.com>,
 "Alok Kataria" <akataria@vmware.com>,
 "Asit Mallick" <asit.k.mallick@intel.com>,
 "Rusty Russell" <rusty@rustcorp.com.au>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.572149529@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 61/76] x86/paravirt: Remove 'noreplace-paravirt'
 cmdline option
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699619255898843?=
X-GMAIL-MSGID: =?utf-8?q?1594699621640830967?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit 12c69f1e94c89d40696e83804dd2f0965b5250cd upstream.

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
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/kernel-parameters.txt |  2 --
 arch/x86/kernel/alternative.c       | 14 --------------
 2 files changed, 16 deletions(-)

--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2271,8 +2271,6 @@ bytes respectively. Such letter suffixes
 	norandmaps	Don't use address space randomization.  Equivalent to
 			echo 0 > /proc/sys/kernel/randomize_va_space
 
-	noreplace-paravirt	[X86,IA-64,PV_OPS] Don't patch paravirt_ops
-
 	noreplace-smp	[X86-32,SMP] Don't replace SMP instructions
 			with UP alternatives
 
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -41,17 +41,6 @@ static int __init setup_noreplace_smp(ch
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
@@ -574,9 +563,6 @@ void __init_or_module apply_paravirt(str
 	struct paravirt_patch_site *p;
 	char insnbuf[MAX_PATCH_LEN];
 
-	if (noreplace_paravirt)
-		return;
-
 	for (p = start; p < end; p++) {
 		unsigned int used;
 
