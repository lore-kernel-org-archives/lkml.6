Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvDAIWTXya5wvt7+7e6B+jsaKIU8wNqgaoLxTHDcKFQirOJihMdz7Q3UEo0OIE6Urn2pFvl
ARC-Seal: i=1; a=rsa-sha256; t=1520824090; cv=none;
        d=google.com; s=arc-20160816;
        b=R2vKR09dWMqcEjP3xaehYQG+HFilr6T0B4nBaPGIYHnWi3yWmjBgIN7CD6juVOHtLT
         aX2WpPbIUCD/cQAk9uu+Mi3OKIhxY3raovUVnBsajCrdDMh0JwzTqHZ8UzOVQalMfai1
         pxVAwd1wHKrl5uKLXoCAAnehm5cwOze1/mgltBLmfUVF+pwsaNHr2L94UFqcPc8IQFuV
         y0ozrKNfaTaWRyNu8naNncd7TmyeCDrEqBCwy3Cj1JNXF7CdR9i2BB1MmS1SfwydC2MG
         uCzWgM9xH9UtXqV6rTXqjy04iQG4AWm9n7yDootfqLHCJhvUuYk1yygCkAA1XMjxrlP+
         343w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=2Tcjsh6P7f9lEUgZ2bhosVZhrrPZtcykQSjEWlRqyW0=;
        b=0JfEesqYbx7ZmxnSFnNdvmV9Tn1ryrI/HYDy4c+IWjUrKOY2/A/BUQDMQvz1hcAmAl
         tsgC4Wd6TGlWTFif1lbQO95mhmEeYzewe/SkohKdmz8WkLjqbGqORtX+pI2vXtD4pFqc
         d+DASJqzR14NR5yEr06nahgGgPE2XT+w/qVM4RNIzReZSYSwOU4wTNhjHLVvobh9fAJO
         3NfMdAEQlJlHasvrbJq5Jj2NHMcUnWDrt/GzvZXX5UE06JyuALlgeSBzVZmXwzv6dHC7
         0uK8Tza+Vm3JWMo/+eA0rgQZnrOiGzXAmcO9mtefriow6LVkuaivsVQOq4JED3WNxI0h
         RbkQ==
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
 "Ingo Molnar" <mingo@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 gnomes@lxorguk.ukuu.org.uk,
 "Juergen Gross" <jgross@suse.com>,
 "Andy Lutomirski" <luto@amacapital.net>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 "Rik van Riel" <riel@redhat.com>,
 "Kees Cook" <keescook@google.com>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Jiri Kosina" <jikos@kernel.org>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 thomas.lendacky@amd.com,
 "Paul Turner" <pjt@google.com>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Tim Chen" <tim.c.chen@linux.intel.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.542837140@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 29/76] x86/retpoline/xen: Convert Xen hypercall
 indirect jumps
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699641637563018?=
X-GMAIL-MSGID: =?utf-8?q?1594699641637563018?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit ea08816d5b185ab3d09e95e393f265af54560350 upstream.

Convert indirect call in Xen hypercall to use non-speculative sequence,
when CONFIG_RETPOLINE is enabled.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Arjan van de Ven <arjan@linux.intel.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
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
Link: https://lkml.kernel.org/r/1515707194-20531-10-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/xen/hypercall.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -44,6 +44,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/smap.h>
+#include <asm/nospec-branch.h>
 
 #include <xen/interface/xen.h>
 #include <xen/interface/sched.h>
@@ -215,9 +216,9 @@ privcmd_call(unsigned call,
 	__HYPERCALL_5ARG(a1, a2, a3, a4, a5);
 
 	stac();
-	asm volatile("call *%[call]"
+	asm volatile(CALL_NOSPEC
 		     : __HYPERCALL_5PARAM
-		     : [call] "a" (&hypercall_page[call])
+		     : [thunk_target] "a" (&hypercall_page[call])
 		     : __HYPERCALL_CLOBBER5);
 	clac();
 
