Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsz7tytXz/ZCXJkHAM9JqGRxgqRPfgaqVZz+ag+mkYFJPuyVUY+vXtnu9nP2YooJ3/TxgRb
ARC-Seal: i=1; a=rsa-sha256; t=1521483472; cv=none;
        d=google.com; s=arc-20160816;
        b=mGyYm6WmVcOge4dbnGrjU73dDUSd+aHbxXtM+a74wVh1Mi7ZvUShHW5kYgj6LEFZXa
         ryB2gYjH+GGpWE7wVF0jcwoe0iTMQHzjaIilFYWyjt88W+gUm+nQsuMLGORS4Z8AeXxM
         8mZcEVfdRRlhysFuBD/xjzLjcJWzds/M1XWPRPpOtRARhhr5cV8tJYChukyPXQ4+pQEO
         2dd2W8mtfBQlwv0NTDoXw6lC0js0WFBJvEybs9CA1f83fMGt2HEky4gGbAmbnNTZlESu
         RYFv689wDgshJ7sB0x6P2He7i9MSbaIdhvSs2l7LZrv7jWQ8lsbK3Am1FvzfaP2Rw0n0
         5x5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9nHWASNjxal146xv8zJydhEhcLE1YRgoGjmjlfZZC9I=;
        b=HeMu+nFiSd40WzHr3UrYFYV5bDmWbZfWxy+oe9tmEVQKF8fxkuc6I3QXQ3UQffSgM7
         rxP6YJ2afZ7lXdipu7e7RaB310OoizEzp9MZJOjFGsPAiUGSPFNHzAfLiHLE/knxI+DF
         ee9WhZ2f4cg8QZz1NKYmO37ESzxyzbS1kS7O8TGUKY//Ru9YgRNz2eURiMy1qFIlQNGA
         y6o53uKiuPjSOT+8o1eHAuNHdnCqJow2LOEroQsz3ej09Vh/CPm75NtpQFqGg5mlX2WJ
         BclarbsZ8BdjSBlEuYNeDiPvi9g4RanNEbhV777XHecgdGyIf4KSBwNOJnJ1hUtqeeas
         /Esw==
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
Subject: [PATCH 4.4 112/134] selftests/x86: Add tests for the STR and SLDT instructions
Date: Mon, 19 Mar 2018 19:06:35 +0100
Message-Id: <20180319171905.477378247@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391053287071016?=
X-GMAIL-MSGID: =?utf-8?q?1595391053287071016?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

commit a9e017d5619eb371460c8e516f4684def62bef3a upstream.

The STR and SLDT instructions are not valid when running on virtual-8086
mode and generate an invalid operand exception. These two instructions are
protected by the Intel User-Mode Instruction Prevention (UMIP) security
feature. In protected mode, if UMIP is enabled, these instructions generate
a general protection fault if called from CPL > 0. Linux traps the general
protection fault and emulates the instructions sgdt, sidt and smsw; but not
str and sldt.

These tests are added to verify that the emulation code does not emulate
these two instructions but the expected invalid operand exception is
seen.

Tests fallback to exit with INT3 in case emulation does happen.

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
Link: http://lkml.kernel.org/r/1509935277-22138-13-git-send-email-ricardo.neri-calderon@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/entry_from_vm86.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/x86/entry_from_vm86.c
+++ b/tools/testing/selftests/x86/entry_from_vm86.c
@@ -111,6 +111,11 @@ asm (
 	"smsw %ax\n\t"
 	"mov %ax, (2080)\n\t"
 	"int3\n\t"
+	"vmcode_umip_str:\n\t"
+	"str %eax\n\t"
+	"vmcode_umip_sldt:\n\t"
+	"sldt %eax\n\t"
+	"int3\n\t"
 	".size vmcode, . - vmcode\n\t"
 	"end_vmcode:\n\t"
 	".code32\n\t"
@@ -119,7 +124,8 @@ asm (
 
 extern unsigned char vmcode[], end_vmcode[];
 extern unsigned char vmcode_bound[], vmcode_sysenter[], vmcode_syscall[],
-	vmcode_sti[], vmcode_int3[], vmcode_int80[], vmcode_umip[];
+	vmcode_sti[], vmcode_int3[], vmcode_int80[], vmcode_umip[],
+	vmcode_umip_str[], vmcode_umip_sldt[];
 
 /* Returns false if the test was skipped. */
 static bool do_test(struct vm86plus_struct *v86, unsigned long eip,
@@ -226,6 +232,16 @@ void do_umip_tests(struct vm86plus_struc
 		printf("[FAIL]\tAll the results of SIDT should be the same.\n");
 	else
 		printf("[PASS]\tAll the results from SIDT are identical.\n");
+
+	sethandler(SIGILL, sighandler, 0);
+	do_test(vm86, vmcode_umip_str - vmcode, VM86_SIGNAL, 0,
+		"STR instruction");
+	clearhandler(SIGILL);
+
+	sethandler(SIGILL, sighandler, 0);
+	do_test(vm86, vmcode_umip_sldt - vmcode, VM86_SIGNAL, 0,
+		"SLDT instruction");
+	clearhandler(SIGILL);
 }
 
 int main(void)
