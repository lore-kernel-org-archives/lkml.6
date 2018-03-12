Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELs5tIv9kbEXEAHgeh4TLMP6ohlhfmzw23vco/q3+sty58mMAgOburH75DlaK0MRFVVzFwMX
ARC-Seal: i=1; a=rsa-sha256; t=1520824082; cv=none;
        d=google.com; s=arc-20160816;
        b=k5Ma2A/4b/4KmmTiAULiZRLUrDbZJVBSRFPCeSa0dpdnwQoGU+5RNhnYBbVMMlmuud
         erj+dPJMa3nR4NG7S5BJjeO/EcO6D93LrPIKraxWKYLuwWSuhB7+bAad/B2pNm9UuFO0
         XitpfGXn0zfpNUmkK310TKr4NKVpHnjp+QpNXvawAMPgV9otvl6J8MotWUQ9EY/iy9XY
         hC86bbZOfcjU/n02n9P8giPWXnhALFaXIYUBo/BlNXWmgEohxA96xG9JjqzitSlOUX7p
         J38GONpxQPKJrBXBERlxq+MrbRmo89Sag+LDH6p+8z+fw0w9z8I1R07lphBMC4izBq9/
         gEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=Kl1yfYd7ImOgSW1RRzgHdIdVvO2oadMf1xIl06KEth8=;
        b=WVuG6F74GItkaj/cpwmxPzL0JJ8AcGfbV80/ZekItV4+j6pPJwnPjY5aXN4NvwbYmA
         LCaWSk2o7+eJHZkRASjo0nMn0B3kUjwOVHDpdvi1CYn71z1QURArlHD3Lbt/RD9Ns//o
         hJDJOrbECGAg3Lh7zvrPqtTj1+Pdmv46y5hzcVvTuxz4v7u5Dn4OUW7XiTzW8RRzNqgj
         dxv/+JhM7FrPVV0fu/TzYla7ThT9BFKWklP1KXS85AAFMbvR2h+9FKJ/KJNw13vZaMob
         0sDMWJkYD4auuwai/5R9oezUsig0z/IzITFOyj6gkr7prvRpydGKDLwvIljNhpLX9XSb
         Bbrg==
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
 "Andy Lutomirski" <luto@amacapital.net>,
 "Kees Cook" <keescook@google.com>,
 thomas.lendacky@amd.com,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Jiri Kosina" <jikos@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Ingo Molnar" <mingo@kernel.org>,
 "Rik van Riel" <riel@redhat.com>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Paul Turner" <pjt@google.com>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 gnomes@lxorguk.ukuu.org.uk,
 "Peter Zijlstra" <peterz@infradead.org>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.970786514@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 062/104] x86/retpoline/hyperv: Convert assembler
 indirect jumps
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699633509049730?=
X-GMAIL-MSGID: =?utf-8?q?1594699633509049730?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit e70e5892b28c18f517f29ab6e83bd57705104b31 upstream.

Convert all indirect jumps in hyperv inline asm code to use non-speculative
sequences when CONFIG_RETPOLINE is enabled.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Arjan van de Ven <arjan@linux.intel.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: Rik van Riel <riel@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: thomas.lendacky@amd.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kees Cook <keescook@google.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Cc: Paul Turner <pjt@google.com>
Link: https://lkml.kernel.org/r/1515707194-20531-9-git-send-email-dwmw@amazon.co.uk
[bwh: Backported to 3.2:
 - Drop changes to hv_do_fast_hypercall8()
 - Include earlier updates to the asm constraints
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hv/hv.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -27,6 +27,7 @@
 #include <linux/vmalloc.h>
 #include <linux/hyperv.h>
 #include <asm/hyperv.h>
+#include <asm/nospec-branch.h>
 #include "hyperv_vmbus.h"
 
 /* The one and only */
@@ -113,10 +114,13 @@ static u64 do_hypercall(u64 control, voi
 	u64 output_address = (output) ? virt_to_phys(output) : 0;
 	void *hypercall_page = hv_context.hypercall_page;
 
-	__asm__ __volatile__("mov %0, %%r8" : : "r" (output_address) : "r8");
-	__asm__ __volatile__("call *%3" : "=a" (hv_status) :
-			     "c" (control), "d" (input_address),
-			     "m" (hypercall_page));
+	__asm__ __volatile__("mov %4, %%r8\n"
+			     CALL_NOSPEC
+			     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
+			       "+c" (control), "+d" (input_address)
+			     :  "r" (output_address),
+				THUNK_TARGET(hypercall_page)
+			     : "cc", "memory", "r8", "r9", "r10", "r11");
 
 	return hv_status;
 
@@ -134,11 +138,14 @@ static u64 do_hypercall(u64 control, voi
 	u32 output_address_lo = output_address & 0xFFFFFFFF;
 	void *hypercall_page = hv_context.hypercall_page;
 
-	__asm__ __volatile__ ("call *%8" : "=d"(hv_status_hi),
-			      "=a"(hv_status_lo) : "d" (control_hi),
-			      "a" (control_lo), "b" (input_address_hi),
-			      "c" (input_address_lo), "D"(output_address_hi),
-			      "S"(output_address_lo), "m" (hypercall_page));
+	__asm__ __volatile__(CALL_NOSPEC
+			     : "=d" (hv_status_hi), "=a" (hv_status_lo),
+			       "+c" (input_address_lo), ASM_CALL_CONSTRAINT
+			     : "d" (control_hi), "a" (control_lo),
+			       "b" (input_address_hi),
+			       "D"(output_address_hi), "S"(output_address_lo),
+			       THUNK_TARGET(hypercall_page)
+			     : "cc", "memory");
 
 	return hv_status_lo | ((u64)hv_status_hi << 32);
 #endif /* !x86_64 */
