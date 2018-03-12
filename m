Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvhi5+7hJNK/8/MU8BqLaC3/q4mQ7IpcAPkJ1BAhQvSawDcyeUuJEas1S6a7HEukf184yHg
ARC-Seal: i=1; a=rsa-sha256; t=1520824095; cv=none;
        d=google.com; s=arc-20160816;
        b=u8cs+y9ve/dQi1hj81aJ4qb0qISzu8xfgOFef1uVEqywlHbsIzosAkGBayOu61/d+a
         XF+Qaxm7EtU5AVnaYHLNNalxcCprmElE2b+KuSMICgjxf59Jdf/XPthv4VUA4YSkR4b9
         e/BIJTNKkBHUmDTXt/3miRz42L338AXio3n3DPKqCx4t7wZJeN5s/TIodWIalygQkH0S
         scBBpO6eOZ2Xs3XdfVkcHrmqwUNkFArFGlhLuybgzr4ibZNMs2un5r3HyyFGmdneNZAO
         L0KFqtU4Dlgjl5fQTPMkattPEA96xlDF0b7R9djTpLUAtLAmXnF3u2q1Qme5p3awTVhh
         IUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=ZpH0k+4qImhTZBiTQC5lA4cn+d+cAkJzXBtknHODYwY=;
        b=cloQB+YfNzL1zoFYjJeamqAykT1PinsBkcZfBGm3LF1E5htzLo/W1GJU0Mq7xoDThx
         FbNDj1os/2sxe5z/OTdoqTMogagoVTrTSMXp5urW27MUexG70YND71BzUZgInNIhA+bb
         8zFgTEL2aYYcTO6dZhXaWkfMbciWfalNTdn4qZ7oMOVOG9srlXrR3pSY5yTekDt5Ad1J
         3uCG/hTRJT67k9mubhrUcLWKhC5YzefCAeROZjjy8AKyUB6CbjWS9MVufvCv2x80ubGj
         COwpbqb6ETwMitoqNCplaqorbczjlasqiBxXp2UlI36iKTtEnJo4qC1/YIK/9FKFzhZC
         CrcQ==
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
CC: akpm@linux-foundation.org, thomas.lendacky@amd.com,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Jiri Kosina" <jikos@kernel.org>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Kees Cook" <keescook@google.com>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Rik van Riel" <riel@redhat.com>,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Andy Lutomirski" <luto@amacapital.net>,
 "Peter Zijlstra" <peterz@infradead.org>,
 gnomes@lxorguk.ukuu.org.uk,
 "Ingo Molnar" <mingo@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Paul Turner" <pjt@google.com>,
 "Andi Kleen" <ak@linux.intel.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.713897520@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 28/76] x86/retpoline/hyperv: Convert assembler
 indirect jumps
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699633509049730?=
X-GMAIL-MSGID: =?utf-8?q?1594699646727727720?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16:
 - Drop changes to hv_do_fast_hypercall8()
 - Include earlier updates to the asm constraints
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hv/hv.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -29,6 +29,7 @@
 #include <linux/version.h>
 #include <linux/interrupt.h>
 #include <asm/hyperv.h>
+#include <asm/nospec-branch.h>
 #include "hyperv_vmbus.h"
 
 /* The one and only */
@@ -93,10 +94,13 @@ static u64 do_hypercall(u64 control, voi
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
 
@@ -114,11 +118,14 @@ static u64 do_hypercall(u64 control, voi
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
