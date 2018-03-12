Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELtBZ9ZOxtPIv8u3zLD/NvkGG19st80wDjAqcT5zwJCdGxKpUe44K6usL2hQnntl5XMSmCjf
ARC-Seal: i=1; a=rsa-sha256; t=1520824069; cv=none;
        d=google.com; s=arc-20160816;
        b=X1FnRC+5xmDO8cNQLcaIwtPhTwvLKDpU2Ggy7Cv0Ooa39bZl62TbETi5O20UTUFEuJ
         2alGaQuJrhJaEI8IQLr92XpV6rPvjhU8jxsdj3E1flDkOYyojaow6AtMfzoxVKZ5wl1u
         6Qo7w9PVzV7sim2xQ1bF84kZM0rhA0xLA/FBWwt2sXkh74TY7zGnIJhC2uNJEs1XnxWA
         RGxlMYGZuEQZt5ivt2Bog+WkqnH+uB2VlwVSouklcie71jiTXoWK+AOQeA7ZkIMQo45S
         ok+6Owau+QvYh1QooYMRgnc2jle+gj6c24TrD5BXBgrwx64/Zq1pv0aaE0HUg0ClqUjB
         wisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=WB7rCqSi+6F2x9YYzMwt6R26XcReKZzWtkrIqAuq8AM=;
        b=M+WAxd7ligTMy2+SZ6ZZtugHxetMpFTrJlIF+JCwoH62TwMp7lRbsBedljnlQPuIS0
         1mOGtQmSoiZETs4kHFHtchojAj4L+yb554dmafj677H/nFaJGnOshjJwVEFcU3dcDVLj
         8Aq5kwcjGxTt+3Nryxoy1XH6nEPGiGFIyua2qLhdRjzu1dSOLJBKLxHcnkxZgkWRxpN3
         XY/xUspilLVoTXqYLgkKoLPn6TMx+lEzOz27TECcy2sWQiXrj/zE9I8dS9YJ/191g/7h
         1NhVWSF4VUgBic2A5z6kys9kuS7NjSpUJSJN7xigp2dPH0BuPi+nJiI2juK5XpAGXeu0
         uEug==
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
 "Ashok Raj" <ashok.raj@intel.com>,
 "Asit Mallick" <asit.k.mallick@intel.com>,
 "Jun Nakajima" <jun.nakajima@intel.com>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Alok Kataria" <akataria@vmware.com>,
 "Jason Baron" <jbaron@akamai.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Greg KH" <gregkh@linuxfoundation.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Rusty Russell" <rusty@rustcorp.com.au>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Andrea Arcangeli" <aarcange@redhat.com>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Arjan Van De Ven" <arjan.van.de.ven@intel.com>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Juergen Gross" <jgross@suse.com>,
 "Dave Hansen" <dave.hansen@intel.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.859469371@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 091/104] x86/paravirt: Remove 'noreplace-paravirt'
 cmdline option
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699619255898843?=
X-GMAIL-MSGID: =?utf-8?q?1594699619255898843?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/kernel-parameters.txt |  2 --
 arch/x86/kernel/alternative.c       | 14 --------------
 2 files changed, 16 deletions(-)

--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1839,8 +1839,6 @@ bytes respectively. Such letter suffixes
 	norandmaps	Don't use address space randomization.  Equivalent to
 			echo 0 > /proc/sys/kernel/randomize_va_space
 
-	noreplace-paravirt	[X86,IA-64,PV_OPS] Don't patch paravirt_ops
-
 	noreplace-smp	[X86-32,SMP] Don't replace SMP instructions
 			with UP alternatives
 
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -39,17 +39,6 @@ static int __init setup_noreplace_smp(ch
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
@@ -583,9 +572,6 @@ void __init_or_module apply_paravirt(str
 	struct paravirt_patch_site *p;
 	char insnbuf[MAX_PATCH_LEN];
 
-	if (noreplace_paravirt)
-		return;
-
 	for (p = start; p < end; p++) {
 		unsigned int used;
 
