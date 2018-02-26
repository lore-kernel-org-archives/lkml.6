Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtbmnxFiKKBs3Z8vFEC00H+NLNmjWdKGlr1Cs2mqIEBUJEc8oC4On0fiB7yCxvkDThEqFAt
ARC-Seal: i=1; a=rsa-sha256; t=1519676472; cv=none;
        d=google.com; s=arc-20160816;
        b=ZAQzRahuKwloI3AdzvkDUxbDAZaR7NYA0WmggLPuIfe89H6eJetpMX2nCS6lERyfPu
         QdLen3FreMVYBl6p+ceiv+jYbAdS/weZrgTjCE59NKUd1/zj5IqgIj6TaFvyXaYE0cnw
         j0Xfp9noAo+/YuruR+hEpy9ktdaMmjH6U5RimGCVr8lYjZ4njZThgNfgSC7wWNnTkrNf
         OjrVa5XL9pRy+eu/cRkgS2qrzBaeF6n6vFZRoT9m+n9s6wuFX91XXMcduHnA5vuU7kja
         pW3BxuxiPORnjUiQ83XsD6V/PGxb0KGZAwRFAT3adfS9uLykwuAoRXMXk7NfshqzwJkU
         PrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6tcQQ2MfE9B+kgeV934x4Z+DcG3eltidJVXlCVgQLbE=;
        b=SYMUrYXIPkEOKBeQeUiTA1ulNTB2MzXobVXYmOm+R0O2m4RdsBta4tmKX0Gw5iBe3Y
         5oAk5Cpx68Sj9EAYIfSpe6rzxfqqodM5ZZfv2OgEmSQZcIWQFhCq2I9OuzjDz0mp72Pt
         QyF+NbPwZa8HKq+CSsxttDzq1BmhliUwwBfwMYUnRQ+xnLGHLLIGRq+EHUGni037HCsn
         INrXi8Eog5aQU7QjGxihI3pqMcOqLKAsDpUBOb3cCXbLuDgcgZg1hQx263Sfx9Nih1Qo
         jOPEh4jAD4e1yxy2AWss+3o3f80Z/+1/NXF3NfbWk/PYd6VvkFV2xrTaYsNrRcPE53PT
         I0yw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jessica Yu <jeyu@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Martin Sebor <msebor@gcc.gnu.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Robert Richter <rric@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	oprofile-list@lists.sf.net,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 10/39] x86/oprofile: Fix bogus GCC-8 warning in nmi_setup()
Date: Mon, 26 Feb 2018 21:20:31 +0100
Message-Id: <20180226201644.124112415@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495973889701786?=
X-GMAIL-MSGID: =?utf-8?q?1593496277072936428?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 85c615eb52222bc5fab6c7190d146bc59fac289e upstream.

GCC-8 shows a warning for the x86 oprofile code that copies per-CPU
data from CPU 0 to all other CPUs, which when building a non-SMP
kernel turns into a memcpy() with identical source and destination
pointers:

 arch/x86/oprofile/nmi_int.c: In function 'mux_clone':
 arch/x86/oprofile/nmi_int.c:285:2: error: 'memcpy' source argument is the same as destination [-Werror=restrict]
   memcpy(per_cpu(cpu_msrs, cpu).multiplex,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          per_cpu(cpu_msrs, 0).multiplex,
          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          sizeof(struct op_msr) * model->num_virt_counters);
          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 arch/x86/oprofile/nmi_int.c: In function 'nmi_setup':
 arch/x86/oprofile/nmi_int.c:466:3: error: 'memcpy' source argument is the same as destination [-Werror=restrict]
 arch/x86/oprofile/nmi_int.c:470:3: error: 'memcpy' source argument is the same as destination [-Werror=restrict]

I have analyzed a number of such warnings now: some are valid and the
GCC warning is welcome. Others turned out to be false-positives, and
GCC was changed to not warn about those any more. This is a corner case
that is a false-positive but the GCC developers feel it's better to keep
warning about it.

In this case, it seems best to work around it by telling GCC
a little more clearly that this code path is never hit with
an IS_ENABLED() configuration check.

Cc:stable as we also want old kernels to build cleanly with GCC-8.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Sebor <msebor@gcc.gnu.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Richter <rric@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: oprofile-list@lists.sf.net
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180220205826.2008875-1-arnd@arndb.de
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84095
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/oprofile/nmi_int.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/oprofile/nmi_int.c
+++ b/arch/x86/oprofile/nmi_int.c
@@ -472,7 +472,7 @@ static int nmi_setup(void)
 		goto fail;
 
 	for_each_possible_cpu(cpu) {
-		if (!cpu)
+		if (!IS_ENABLED(CONFIG_SMP) || !cpu)
 			continue;
 
 		memcpy(per_cpu(cpu_msrs, cpu).counters,
