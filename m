Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226fyX7mCp+KxoDzNr28AJC70bZKzJmwouumtbG/6R7g0ruZmTr3/1DcQWAOx13MWwPt8siV
ARC-Seal: i=1; a=rsa-sha256; t=1519411287; cv=none;
        d=google.com; s=arc-20160816;
        b=cwjPgbfaHoHMjNf6fKjD/aZGPFSMd3ag4yl8n62JgyviITwo4r9WF9DvWIeNw/bMRB
         AdYGtrbvb/G0cQ7KV5uD61/4nFmVvD+Dg/IcC3Fg+dK29onz5frMuf235E4zgSGOIoel
         zSWT+NmEhqWjj6OuHpfVlxi+hC045gYgIhO7utrNHsuaw1Vh4fUyYADU2juqRKBOB0wP
         ICQcP//U4q3Vipkh2Hf9IGJoCl/7MjjBj7jtoUJpCwfvjtESzSi37g4g+fIVAeVTZFfx
         Ia9/5nygyHiPynP6PkHMnR3qqhwnNJQLyaZx0QczWjcQrqJTAC9Q8mvJCC+Xs/w8Xf1f
         XD5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=keKZfa0/yTQRKDzj+UDb+be0Tgy/vH89DnL+/r2fENw=;
        b=Td6+TMbhZgzw+MNtlP1RYdZzQAlH2Gh4g/iCGLYdTHdXKrEqNVyzHwQceBFFZ3liwS
         /OjBOW0lK8rowcDFjpbchhQd4j1TuJcedPaDPR6NkFrdwsfwV4oY6g7/fIang39EW1tl
         m4x/fYTYKL4OdUeAisVVGxKstCvFDVHvvGE3rrbotcaShizwdNLHBwbKI0HeqZRehVd9
         4TgSoUi6PUxEpjtnwfOoSCft7Q6IaRbapP6m6mjylmaxusXu3i1eIkfgSI9PX/SYd7J7
         5xu8G7Xo6ikD1+RM7XH+n//rZ8X1nbVXxHMyZbRyITVFlAN0ABjvLAuNDhHyKgjHBCz4
         5Jew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
	Dan Williams <dan.j.williams@intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.4 183/193] x86/paravirt: Remove noreplace-paravirt cmdline option
Date: Fri, 23 Feb 2018 19:26:56 +0100
Message-Id: <20180223170354.863131368@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218210250533759?=
X-GMAIL-MSGID: =?utf-8?q?1593218210250533759?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

(cherry picked from commit 12c69f1e94c89d40696e83804dd2f0965b5250cd)

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
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[jwang: chery pick to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/kernel-parameters.txt |    2 --
 arch/x86/kernel/alternative.c       |   14 --------------
 2 files changed, 16 deletions(-)

--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2565,8 +2565,6 @@ bytes respectively. Such letter suffixes
 	norandmaps	Don't use address space randomization.  Equivalent to
 			echo 0 > /proc/sys/kernel/randomize_va_space
 
-	noreplace-paravirt	[X86,IA-64,PV_OPS] Don't patch paravirt_ops
-
 	noreplace-smp	[X86-32,SMP] Don't replace SMP instructions
 			with UP alternatives
 
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -45,17 +45,6 @@ static int __init setup_noreplace_smp(ch
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
@@ -587,9 +576,6 @@ void __init_or_module apply_paravirt(str
 	struct paravirt_patch_site *p;
 	char insnbuf[MAX_PATCH_LEN];
 
-	if (noreplace_paravirt)
-		return;
-
 	for (p = start; p < end; p++) {
 		unsigned int used;
 
