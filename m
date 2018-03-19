Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt7MymBlkn3RNX4LaAF42wczuqjy6SW2NxhMEOUn/kcwja5a6c7YJf79Hze+R2TuRK5FyD5
ARC-Seal: i=1; a=rsa-sha256; t=1521484147; cv=none;
        d=google.com; s=arc-20160816;
        b=mFiAuizHC8HjxmjkTBOOIPgdHBzBJ6R4VI0aUDtMpUfjjx5SKfprMqmOdkeeZAsOFy
         MQZsAMp1nRgOPxVghaFFQ9AL31TOnZQ3yiX1U0ksi2hBpN0WR50k54VPf05zKkNXQeNa
         TMMEcGJS67vOd/SqJ4vTZ1fzm7Xx4tgZQog0sgiiS+XXtCez75pUgeX6Ww6wZKahLKGC
         MOvYL/6XxwFfYuoxuCWlrhOLefth5ZWixHHlUKmi2UuSFn8qCUrCM2WPQJZckYbu3N46
         AVGY5mpFcxRzdjLudurYY7Gijz8oQ/TUqgfYkCjfnAkh0ORthS/aKLYbMoJFc0Hue/VV
         /3ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xVEwT1rDw53Elxf7JpX/tDNUevArs07WzgRVR4ApLwo=;
        b=pNj29cT7wig/PxaOkCGqqo3WS8ovCdP74G6u3IAGp8lwD1XgG0YmKx37sEb9/QL9e1
         S9JlEvaBib+ywmd0Mxz7dfzO14u6XQJmeH2cGmmGwhpnOXMU6lwH37nxOlsXBXFfvR+s
         lilwCvujdnXQipABa+l0coZp3tt9IjcM4atByaI5gC4mGuCmsPQduvNnubLzJecTn4Uf
         dSxJJCS0Y/Lip6cbWqd5VP40IfvM1hk2sUF1lvqAaXS5IEpNT9qWbdvFbxOjmyqarmbP
         29EEJOrkK3NOK3nm1YLi4mtg45JleLXJCnCCSt9gp0rWJGiRk6m9oKulSZ+OffIPQfm4
         cWBA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Borislav Petkov <bp@suse.de>,
	Brian Gerst <brgerst@gmail.com>,
	Chen Yucong <slaoub@gmail.com>,
	Chris Metcalf <cmetcalf@mellanox.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Huang Rui <ray.huang@amd.com>,
	Jiri Slaby <jslaby@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	ricardo.neri@intel.com,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 214/241] selftests/x86: Add tests for User-Mode Instruction Prevention
Date: Mon, 19 Mar 2018 19:07:59 +0100
Message-Id: <20180319180800.035896589@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391050324869540?=
X-GMAIL-MSGID: =?utf-8?q?1595391761982366986?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

commit 9390afebe1d3f5a0be18b1afdd0ce09d67cebf9e upstream.

Certain user space programs that run on virtual-8086 mode may utilize
instructions protected by the User-Mode Instruction Prevention (UMIP)
security feature present in new Intel processors: SGDT, SIDT and SMSW. In
such a case, a general protection fault is issued if UMIP is enabled. When
such a fault happens, the kernel traps it and emulates the results of
these instructions with dummy values. The purpose of this new
test is to verify whether the impacted instructions can be executed
without causing such #GP. If no #GP exceptions occur, we expect to exit
virtual-8086 mode from INT3.

The instructions protected by UMIP are executed in representative use
cases:

 a) displacement-only memory addressing
 b) register-indirect memory addressing
 c) results stored directly in operands

Unfortunately, it is not possible to check the results against a set of
expected values because no emulation will occur in systems that do not
have the UMIP feature. Instead, results are printed for verification. A
simple verification is done to ensure that results of all tests are
identical.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Chen Yucong <slaoub@gmail.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi V. Shankar <ravi.v.shankar@intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: ricardo.neri@intel.com
Link: http://lkml.kernel.org/r/1509935277-22138-12-git-send-email-ricardo.neri-calderon@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/entry_from_vm86.c |   73 +++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/x86/entry_from_vm86.c
+++ b/tools/testing/selftests/x86/entry_from_vm86.c
@@ -95,6 +95,22 @@ asm (
 	"int3\n\t"
 	"vmcode_int80:\n\t"
 	"int $0x80\n\t"
+	"vmcode_umip:\n\t"
+	/* addressing via displacements */
+	"smsw (2052)\n\t"
+	"sidt (2054)\n\t"
+	"sgdt (2060)\n\t"
+	/* addressing via registers */
+	"mov $2066, %bx\n\t"
+	"smsw (%bx)\n\t"
+	"mov $2068, %bx\n\t"
+	"sidt (%bx)\n\t"
+	"mov $2074, %bx\n\t"
+	"sgdt (%bx)\n\t"
+	/* register operands, only for smsw */
+	"smsw %ax\n\t"
+	"mov %ax, (2080)\n\t"
+	"int3\n\t"
 	".size vmcode, . - vmcode\n\t"
 	"end_vmcode:\n\t"
 	".code32\n\t"
@@ -103,7 +119,7 @@ asm (
 
 extern unsigned char vmcode[], end_vmcode[];
 extern unsigned char vmcode_bound[], vmcode_sysenter[], vmcode_syscall[],
-	vmcode_sti[], vmcode_int3[], vmcode_int80[];
+	vmcode_sti[], vmcode_int3[], vmcode_int80[], vmcode_umip[];
 
 /* Returns false if the test was skipped. */
 static bool do_test(struct vm86plus_struct *v86, unsigned long eip,
@@ -160,6 +176,58 @@ static bool do_test(struct vm86plus_stru
 	return true;
 }
 
+void do_umip_tests(struct vm86plus_struct *vm86, unsigned char *test_mem)
+{
+	struct table_desc {
+		unsigned short limit;
+		unsigned long base;
+	} __attribute__((packed));
+
+	/* Initialize variables with arbitrary values */
+	struct table_desc gdt1 = { .base = 0x3c3c3c3c, .limit = 0x9999 };
+	struct table_desc gdt2 = { .base = 0x1a1a1a1a, .limit = 0xaeae };
+	struct table_desc idt1 = { .base = 0x7b7b7b7b, .limit = 0xf1f1 };
+	struct table_desc idt2 = { .base = 0x89898989, .limit = 0x1313 };
+	unsigned short msw1 = 0x1414, msw2 = 0x2525, msw3 = 3737;
+
+	/* UMIP -- exit with INT3 unless kernel emulation did not trap #GP */
+	do_test(vm86, vmcode_umip - vmcode, VM86_TRAP, 3, "UMIP tests");
+
+	/* Results from displacement-only addressing */
+	msw1 = *(unsigned short *)(test_mem + 2052);
+	memcpy(&idt1, test_mem + 2054, sizeof(idt1));
+	memcpy(&gdt1, test_mem + 2060, sizeof(gdt1));
+
+	/* Results from register-indirect addressing */
+	msw2 = *(unsigned short *)(test_mem + 2066);
+	memcpy(&idt2, test_mem + 2068, sizeof(idt2));
+	memcpy(&gdt2, test_mem + 2074, sizeof(gdt2));
+
+	/* Results when using register operands */
+	msw3 = *(unsigned short *)(test_mem + 2080);
+
+	printf("[INFO]\tResult from SMSW:[0x%04x]\n", msw1);
+	printf("[INFO]\tResult from SIDT: limit[0x%04x]base[0x%08lx]\n",
+	       idt1.limit, idt1.base);
+	printf("[INFO]\tResult from SGDT: limit[0x%04x]base[0x%08lx]\n",
+	       gdt1.limit, gdt1.base);
+
+	if (msw1 != msw2 || msw1 != msw3)
+		printf("[FAIL]\tAll the results of SMSW should be the same.\n");
+	else
+		printf("[PASS]\tAll the results from SMSW are identical.\n");
+
+	if (memcmp(&gdt1, &gdt2, sizeof(gdt1)))
+		printf("[FAIL]\tAll the results of SGDT should be the same.\n");
+	else
+		printf("[PASS]\tAll the results from SGDT are identical.\n");
+
+	if (memcmp(&idt1, &idt2, sizeof(idt1)))
+		printf("[FAIL]\tAll the results of SIDT should be the same.\n");
+	else
+		printf("[PASS]\tAll the results from SIDT are identical.\n");
+}
+
 int main(void)
 {
 	struct vm86plus_struct v86;
@@ -218,6 +286,9 @@ int main(void)
 	v86.regs.eax = (unsigned int)-1;
 	do_test(&v86, vmcode_int80 - vmcode, VM86_INTx, 0x80, "int80");
 
+	/* UMIP -- should exit with INTx 0x80 unless UMIP was not disabled */
+	do_umip_tests(&v86, addr);
+
 	/* Execute a null pointer */
 	v86.regs.cs = 0;
 	v86.regs.ss = 0;
